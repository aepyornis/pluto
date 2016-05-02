from functools import reduce, partial
import numpy as np
import pandas as pd
import psycopg2
conn = psycopg2.connect("dbname=pluto user=michael")
cur = conn.cursor()

versions = ('03c', '04c','05d', '06c', '07c', '09v2', '10v2', '11v2', '12v2', '13v2', '14v2', '15v1')


def select(query):
    """
    Executes the query and returns the data as a list of tuples.
    """
    cur.execute(query)
    return cur.fetchall()


def make_query(ver, cols):
    return "select " + ", ".join(cols) + " from pluto_" + ver


def db_to_df(ver, cols):
    """
    Creates a DataFrame for the pluto version with the given columns.
    """
    return pd.DataFrame(select(make_query(ver, cols)), columns=cols)


def zonetype(df):
    """
    Adds a new column, zonetype, containing the first letter of zonedist1.
    """
    df['zonetype'] = df['zonedist1'].str.slice(start=0, stop=1)
    return df


def group_by_cd_zonetype(df):
    """
    Groups the dataframe by CD and Zonetype, sums up the other fields, and swaps the axis.
    """
    return df.groupby(['cd', 'zonetype']).sum().unstack(1)

    
def calc_percents(df):
    """
    Calculates the R and M zoning percents. 
    Assumes the only original numeric column was lotarea.
    """
    df['totalarea'] = df.sum(1)
    df['R_pct'] = df[('lotarea', 'R')] / df['totalarea']
    df['M_pct'] = df[('lotarea', 'M')] / df['totalarea']
    return df


def rename_pct_cols(df, ver):
    """
    Renames the percent columns to be prefaced with the version.
    i.e. R_pct becomes 15v1_R_pct
    """
    return df.rename(columns={'R_pct': ver + '_R_pct', 'M_pct': ver + '_M_pct'})


def keep_only(df, ver, cols):
    """
    Changes the multi-index to single index and drops all columns except the ones passed in.
    The version is appended to the front of the col.
    """
    df.columns = df.columns.droplevel(1)
    dropCols = set(df.columns).difference([ (ver + '_' + c) for c in cols ])
    return df.drop(dropCols, axis=1)



def df_for_ver(ver):
    """
    Returns a processed DataFrame for the pluto version.
    """
    rename = partial(rename_pct_cols, ver=ver)
    keep_only_ = partial(keep_only, ver=ver, cols=['R_pct', 'M_pct'])
    funcs = (zonetype, group_by_cd_zonetype, calc_percents, rename, keep_only_)

    return reduce(lambda x,y: y(x), funcs, db_to_df(ver, ['zonedist1', 'lotarea', 'cd']))


# df -> df
def inner_join(df1, df2):
    """
    Joins two pluto DataFrames together, similar to a sql 'inner join'
    """
    return pd.merge(df1, df2, how='inner', left_index=True, right_index=True)
    


def zoning_timeseries(vers):
    dfs = reduce(lambda x, y: x + (y,), vers, tuple())
    return reduce(inner_join, dfs[1:], dfs[0])



        


