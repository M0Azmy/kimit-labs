#!/bin/bash

echo "enabling debugging"
set -x
echo " enablED debugging"
ls

echo " *************************************** "
echo " disabling debugging "
set +x
echo " disablED debugging"

echo " ***********************************"
echo " testing "
ls
