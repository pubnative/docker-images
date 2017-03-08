#!/usr/bin/env python
import os
import toml
import sys
import datetime as dt
import argparse
import operator
from impala.dbapi import connect

print("Start script")

with open("/opt/partition/config.toml") as conffile:
    config = toml.loads(conffile.read())

print("Parsed config")

location = "'" + config['s3']['path'] + "/{0}/{1}/'"
tables = config['hive']['tables']
replace_partition = config['replace']
errors = []
print("Parse dates")
dates = config['dates']
if len(dates) == 0:
  dates = [dt.datetime.today().strftime('%Y-%m-%d')]


def addPartition(table, day):
    try:
        cur.execute(
        ("ALTER TABLE {0} ADD PARTITION (dt = '{1}') location " + location).format(table, day)
        )
        print('NEW PARTITION FOR: ' + table + ' | ' + day)
    except Exception as e:
        print(e)

def dropPartition(table, day):
    try:
        cur.execute(
        """ALTER TABLE {0} DROP IF EXISTS PARTITION (dt = '{1}')""".format(table, day)
        )
        print('DROPPED PARTITION FOR: ' + table + ' | ' + day)
    except Exception as e:
        print(e)

hive_conn = connect(host=config['hive']['host'], port=config['hive']['port'], auth_mechanism='PLAIN')
cur = hive_conn.cursor()

print("Creating partitions ...")
for date in dates:
    for table in tables:
        if replace_partition == True:
            dropPartition(table, date)
            addPartition(table, date)
        else:
            addPartition(table, date)

#TODO return status code 1 if there are was some errors
