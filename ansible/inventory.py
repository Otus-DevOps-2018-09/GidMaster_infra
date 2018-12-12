#!/usr/bin/env python

import re
import json
import os
import os.path
import argparse
import subprocess
import sys

class Inventory:

    def __init__(self):
        self.directory = os.getcwd()
        self.inventory = {}
        self.app_external_ip = []
        self.db_external_ip = []
        self.dbPattern = re.compile(r'db_external_ip = ([\d\.]+)')
        self.appPattern = re.compile(r'app_external_ip = ([\d\.]+)')



    def getInfo(self):
        os.chdir('../terraform/stage/')
        output = subprocess.check_output(
                ['terraform', 'output'],
                stderr=subprocess.STDOUT,  # get all output
                universal_newlines=True  # return string not bytes
                )
        output = output.splitlines()
        for line in output:
            if self.dbPattern.match(line):
                self.db_external_ip.append(self.dbPattern.search(line).group(1))
            elif self.appPattern.match(line):
                self.app_external_ip.append(self.appPattern.search(line).group(1))

    def returnList(self):
        listJSON = {"app":{"hosts": []},"db":{"hosts": []}}
        for host in self.app_external_ip:
            listJSON["app"]["hosts"].append(host)
        for host in self.db_external_ip:
            listJSON["db"]["hosts"].append(host) 

        return json.dumps(listJSON, sort_keys=True, indent=10)

    def returnHost(self, host):
        return {}

def main():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--list', '-l',
                        action = 'store_true',
                        help='List of interesting hosts in JSON format')
    group.add_argument('--host', '-a',
                        help='information about current host')
    ARGUMENTS = parser.parse_args()
    inventory = Inventory()
    inventory.getInfo()
    if ARGUMENTS.list:
        print(inventory.returnList())
    elif ARGUMENTS.host:
        print(inventory.returnHost(ARGUMENTS.host))
    else:
        print("{'error': 'wrong Arguments'}")

if __name__ == "__main__":
    main()

