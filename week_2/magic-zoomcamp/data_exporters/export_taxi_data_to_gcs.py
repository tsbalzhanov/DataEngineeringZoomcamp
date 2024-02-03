from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigKey, ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame

import os
import pyarrow as pa
import pyarrow.parquet as pq


if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a Google Cloud Storage bucket.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
    """
    config_path = os.path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'dev'
    config = ConfigFileLoader(config_path, config_profile)
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = config[ConfigKey.GOOGLE_SERVICE_ACC_KEY_FILEPATH]

    bucket_name = 'tsbalzhanov-dtc-week-2'
    gcs_data_path = f'{bucket_name}/taxi_data'
    gcs_fs = pa.fs.GcsFileSystem()

    pa_table = pa.Table.from_pandas(df)
    pq.write_to_dataset(pa_table, root_path=gcs_data_path, partition_cols=['lpep_pickup_date'], filesystem=gcs_fs)
