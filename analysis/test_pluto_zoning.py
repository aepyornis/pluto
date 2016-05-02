import pytest
from unittest.mock import patch
import numpy as np
import pandas as pd
import pluto_zoning as pz

@pytest.fixture
def grouped():
    d = {'zonetype': ['M', 'C', 'R', 'M', 'R']}
    d['cd'] = [101,103,104,101,101]
    d['lotarea'] = [7,20,50,3,10]
    return pz.group_by_cd_zonetype(pd.DataFrame(d))


@pytest.fixture
def pcts(grouped):
    return pz.calc_percents(grouped)


@pytest.fixture
def init_df():
    d = {'zonedist1': ['M1', 'C3', 'R6', 'M2', 'R1']}
    d['cd'] = [101,103,104,101,101]
    d['lotarea'] = [7,20,50,3,10]
    return pd.DataFrame(d)


@pytest.fixture
def final_df(pcts):
    df = pz.rename_pct_cols(pcts, '15v1')
    return pz.keep_only(df, '15v1', ['R_pct', 'M_pct'])
    

def test_make_query():
    assert pz.make_query('04c', ['zonedist1', 'owner']) == "select zonedist1, owner from pluto_04c"


@patch('pluto_zoning.make_query', return_value="SELECT * FROM generate_series(0,4)")
def test_db_to_df(mock_make_query):
    df = pz.db_to_df('x', ['col1'])
    assert type(df) is pd.DataFrame
    vals = df.values
    assert vals[0] == 0
    assert vals[1] == 1
    assert vals[4] == 4
    assert df.columns[0] == 'col1'


def test_zonetype():
    df = pd.DataFrame({'zonedist1': ['M1', 'C2', 'R3']})
    df_ = pz.zonetype(df)

    assert df_.loc[0, 'zonetype'] == 'M'
    assert df_.loc[1, 'zonetype'] == 'C'
    assert df_.loc[2, 'zonetype'] == 'R'


def test_group_by_cd_zonetype(grouped):
    assert type(grouped.columns) is pd.MultiIndex
    assert ('lotarea', 'M') in grouped.columns
    assert ('lotarea', 'C') in grouped.columns
    assert grouped[('lotarea', 'M')][101] == 10
    assert np.isnan(grouped[('lotarea', 'M')][103])
    assert grouped[('lotarea', 'R')][104] == 50


def test_calc_percents(pcts):
    df = pcts
    assert 'totalarea' in df.columns
    assert 'R_pct' in df.columns
    assert 'M_pct' in df.columns
    assert df['R_pct'][101] == .5
    assert df['M_pct'][101] == .5
    assert df['totalarea'][101] == 20
    assert df['totalarea'][104] == 50
    assert df['R_pct'][104] == 1.0


def test_rename_pct_columns(pcts):
    df = pz.rename_pct_cols(pcts, '15v1')
    assert '15v1_R_pct' in df.columns
    assert '15v1_M_pct' in df.columns
    assert 'R_pct' not in df.columns
    assert 'M_pct' not in df.columns


def test_keep_only(pcts):
    df = pz.rename_pct_cols(pcts, '15v1')
    df_ = pz.keep_only(df, '15v1', ['R_pct', 'M_pct'])
    
    assert type(df_.columns) is pd.Index
    assert '15v1_R_pct' in df_.columns
    assert '15v1_M_pct' in df_.columns
    assert 'totalarea' not in df_.columns
    assert 'lotarea' not in df_.columns


@patch('pluto_zoning.db_to_df')
def test_df_for_ver(mock, init_df, final_df):
    mock.return_value = init_df
    assert pz.df_for_ver('15v1').equals(final_df)



def test_inner_join():
    df1 = pd.DataFrame({"v1_R": [1,3,6], "v1_C": [7,3,1]}, index=[101,102,103])
    df2 = pd.DataFrame({"v2_R": [10,11,12], "v2_C": [20,19,18]}, index=[101,102,103])
    
    joined_data = {"v2_R": [10,11,12], "v2_C": [20,19,18], "v1_R": [1,3,6], "v1_C": [7,3,1]}
    joined = pd.DataFrame(joined_data, index=[101,102,103])

    assert pz.inner_join(df1,df2).equals(joined)

    
