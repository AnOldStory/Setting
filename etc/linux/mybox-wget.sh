#!/bin/bash

wget -qO - $1 | grep gsSaveFileLink | cut -d '"' -f 2 | xargs wget
