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

errors = []
location = "'" + config['s3']['path'] + "/{0}/{1}/'"
tables = config['hive']['tables']
replace_partition = config['replace']
cleanup_tables = config['hive']['cleanup_tables']
print("Parse dates")
dates = config['dates']
if len(dates) == 0:
  dates = [dt.datetime.today().strftime('%Y-%m-%d')]


def add_partition(table, day):
    try:
        cur.execute(
            ("ALTER TABLE {0} ADD PARTITION (dt = '{1}') location " + location).format(table, day)
        )
        print('NEW PARTITION FOR: ' + table + ' | ' + day)
    except Exception as e:
        errors.append(e)

def drop_partition(table, day):
    try:
        cur.execute(
            """ALTER TABLE {0} DROP IF EXISTS PARTITION (dt = '{1}')""".format(table, day)
        )
        print('DROPPED PARTITION FOR: ' + table + ' | ' + day)
    except Exception as e:
        errors.append(e)

def drop_old_partitions(table, months_ago):
    drop_date = (date.today() - relativedelta(months=months_ago)).strftime("%Y-%m-%d")
    try:
        cur.execute(
            "ALTER TABLE {0} DROP PARTITION (dt < '{1}')".format(table, drop_date)
        )
        print('DROPPED PARTITIONS FOR: ' + table + ' older than ' + drop_date)
    except Exception as e:
        errors.append(e)

hive_conn = connect(host=config['hive']['host'], port=config['hive']['port'], auth_mechanism='PLAIN')
cur = hive_conn.cursor()

print("Creating partitions ...")
for date in dates:
    for table in tables:
        if replace_partition == True:
            drop_partition(table, date)
            add_partition(table, date)
        else:
            add_partition(table, date)

for table in cleanup_tables:
    drop_old_partitions(table["name"], table["months_ago"])

if len(errors) > 0:
    for err in errors:
        print err
    raise "Errors encountered during partitioning"
