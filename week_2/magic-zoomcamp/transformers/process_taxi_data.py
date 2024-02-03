if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your transformation logic here
    # rename columns
    column_renamings = {
        'VendorID': 'vendor_id',
        'RatecodeID': 'ratecode_id',
        'PULocationID': 'pu_location_id',
        'DOLocationID': 'do_location_id'
    }
    data.rename(columns=column_renamings, inplace=True)

    # add pickup date column
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    # remove rides without passengers or with zero trip distance
    data = data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0.0)]

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
    assert 'vendor_id' in output.columns, '`vendor_id` is not in columns'
    assert (output['passenger_count'] <= 0).sum() == 0, 'There are rides without passengers'
    assert (output['trip_distance'] == 0.0).sum() == 0, 'There are rides with zero distance'
