from functools import reduce, partial
import numpy as np
import pandas as pd
import psycopg2
conn = psycopg2.connect("dbname=pluto user=michael")
cur = conn.cursor()

versions = ('03c', '04c','05d', '06c', '07c', '09v2', '10v2', '11v2', '12v2', '13v2', '14v2', '15v1')


def select(query):
    cur.execute(query)
    return cur.fetchall()


def make_query(ver, cols):
    return "select " + ", ".join(cols) + " from pluto_" + ver


def db_to_df(ver, cols):
    return pd.DataFrame(select(make_query(ver, cols)), columns=cols)


def zonetype(df):
    df['zonetype'] = df['zonedist1'].str.slice(start=0, stop=1)
    return df


def group_by_cd_zonetype(df):
    return df.groupby(['cd', 'zonetype']).sum().unstack(1)

    
def calc_percents(df):
    df['totalarea'] = df.sum(1)
    df['R_pct'] = df[('lotarea', 'R')] / df['totalarea']
    df['M_pct'] = df[('lotarea', 'M')] / df['totalarea']
    return df


def rename_pct_cols(df, ver):
    return df.rename(columns={'R_pct': ver + '_R_pct', 'M_pct': ver + '_M_pct'})


def keep_only(df, ver, cols):
    """
    Changes multi-index to single index and drops all columns except the one provided.
    The version is appended to the front of the col.
    """
    df.columns = df.columns.droplevel(1)
    dropCols = set(df.columns).difference([ (ver + '_' + c) for c in cols ])
    return df.drop(dropCols, axis=1)



def df_for_ver(ver):
    rename = partial(rename_pct_cols, ver=ver)
    keep_only_ = partial(keep_only, ver=ver, cols=['R_pct', 'M_pct'])
    funcs = (zonetype, group_by_cd_zonetype, calc_percents, rename, keep_only_)

    return reduce(lambda x,y: y(x), funcs, db_to_df(ver, ['zonedist1', 'lotarea', 'cd']))


# df -> df
def inner_join(df):
    pass


def zoning_timeseries(vers):
    dfs = reduce(lambda x, y: x + (y,), vers, tuple())
    return reduce(inner_join, dfs[1:], dfs[0])



        

