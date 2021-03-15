# common library
import pandas as pd
import numpy as np
import time
from stable_baselines.common.vec_env import DummyVecEnv
# preprocessor
from preprocessing.preprocessors import *
# config
from config.config import *
# model
from model.models import *
import os


def run_model() -> None:
    """Train the model."""


    # read and preprocess data
    preprocessed_path = "done_data_IJRB.csv"

    if os.path.exists(preprocessed_path):
        data = pd.read_csv(preprocessed_path, index_col=0)
    else:
        data = preprocess_data()
        data = add_turbulence(data)
        data.to_csv(preprocessed_path)
    # data = preprocess_data()
    # data = add_turbulence(data)
    # data.to_csv(preprocessed_path)

    
    print(data.head())
    print(data.size)

    # 2017/08/01 is the date that validation starts
    # 2017/11/01 is the date that real trading starts
    # unique_trade_date needs to start from 2017/08/31 for validation purpose
    unique_trade_date = data[(data.datadate > 20170831)&(data.datadate <= 20190531)].datadate.unique()
    print(unique_trade_date)

    # rebalance_window is the number of months to retrain the model
    # validation_window is the number of months to validation the model and select for trading
    rebalance_window = 63
    validation_window = 63
    
    ## Ensemble Strategy
    run_ensemble_strategy(df=data, 
                          unique_trade_date= unique_trade_date,
                          rebalance_window = rebalance_window,
                          validation_window=validation_window)

    #_logger.info(f"saving model version: {_version}")

if __name__ == "__main__":
    run_model()