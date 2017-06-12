#!/usr/bin/env python
import os
import toml
import sys
import datetime as dt
from dateutil.relativedelta import relativedelta
import argparse
import operator
from impala.dbapi import connect

print("Start script")

with open("/opt/partition/config.toml") as conffile:
    config = toml.loads(conffile.read())

print("Parsed config")
print(config)

errors = []
s3_path = config['s3']['path']
tables = config['hive']['tables']
table_suffix = config['hive'].get('table_suffix', "")
replace_partition = config['replace']
cleanup_tables = config['hive']['cleanup_tables']
aggregate_tables = config['hive']['aggregate_tables']
print("Parse dates")
dates = config['dates']
if len(dates) == 0:
  dates = [dt.datetime.today().strftime('%Y-%m-%d')]


def add_partition(table, day):
    """Adds a day's partition to a specified table"""
    try:
        cur.execute(
            ("ALTER TABLE {1}{3} ADD PARTITION (dt = '{2}') location '{0}/{1}/{2}/'").format(s3_path, table, day, table_suffix)
        )
        print('NEW PARTITION FOR: {} | {}'.format(table, day))
    except Exception as e:
        errors.append(("add_partition", table, day, e))

def add_partition_secondary_key(table, day, key, path):
    """Adds a day's partition to a specified table with compound partitioning key, using specified path as source"""
    try:
        cur.execute(
            ("ALTER TABLE {3}{5} ADD PARTITION (dt = '{2}', {4} = '{1}') location '{0}/{1}/{2}/'").format(s3_path, path, day, table, key, table_suffix)
        )
        print('NEW PARTITION FOR: {} | {} | {} = {}'.format(table, day, key, path))
    except Exception as e:
        errors.append(("add_partition", table, day, key, path, e))

def drop_partition(table, day):
    """Drops a day's partition from a specified table. If key and path are specified it can be used for compound indexed partitions"""
    try:
        cur.execute(
            """ALTER TABLE {0}{2} DROP IF EXISTS PARTITION (dt = '{1}')""".format(table, day, table_suffix)
        )
        print('DROPPED PARTITION FOR: {} | {}'.format(table, day))
    except Exception as e:
        errors.append(("drop_partition", table, day, e))

def drop_partition_secondary_key(table, day, key, path):
    """Drops a day's partition from a specified table. If key and path are specified it can be used for compound indexed partitions"""
    try:
        cur.execute(
            """ALTER TABLE {0}{2} DROP IF EXISTS PARTITION (dt = '{1}', {3} = '{4}')""".format(table, day, table_suffix,  key, path)
        )
        print('DROPPED PARTITION FOR: {} | {} | {} = {}'.format(table, day, key, path))
    except Exception as e:
        errors.append(("drop_partition", table, day, e))

def drop_partitions_older_than(table, months_ago):
    """Drops all partitions older than `months_ago` months from a specified table. Currently compound keys are not supported"""
    drop_date = (dt.datetime.today() - relativedelta(months=months_ago)).strftime("%Y-%m-%d")
    try:
        cur.execute(
            "ALTER TABLE {0}{2} DROP PARTITION (dt < '{1}')".format(table, drop_date, table_suffix)
        )
        print('DROPPED PARTITIONS FOR: ' + table + ' older than ' + drop_date)
    except Exception as e:
        errors.append(("drop_partitions_older_than", table, e))

hive_conn = connect(host=config['hive']['host'], port=config['hive']['port'], auth_mechanism='PLAIN')
cur = hive_conn.cursor()

print("Creating partitions ...")
for date in dates:
    for table in tables:
        if replace_partition == True:
            drop_partition(table, date)
        add_partition(table, date)
    for table in aggregate_tables:
        for path in table["paths"]:
            if replace_partition == True:
                drop_partition_secondary_key(table["name"], date, table["key"], path)
            add_partition_secondary_key(table["name"], date, table["key"], path)


print("Cleaning old partitions ...")
for table in cleanup_tables:
    drop_partitions_older_than(table["name"], table["months_ago"])

if len(errors) > 0:
    for err in errors:
        print(err)
    raise Exception("Errors encountered during partitioning")
