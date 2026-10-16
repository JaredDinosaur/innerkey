#!/bin/bash

verbose=0
while getopts "v" flag; do
    if [[ $flag == "v" ]]; then
        verbose=1
    fi
done

echo "Machine ID: $(cat /sys/class/dmi/id/product_name)"
echo "Machine Name: $(cat /sys/class/dmi/id/product_version)"
echo "Looking for Windows product key..."

sudo strings /sys/firmware/acpi/tables/MSDM &>/dev/null
if [[ $? == 0 ]]; then
    if [[ $verbose == 0 ]]; then
        echo "Windows product key found: $(sudo strings /sys/firmware/acpi/tables/MSDM | tail -1)"
    else
        echo "Windows product key information:"
        sudo strings /sys/firmware/acpi/tables/MSDM
    fi
    echo "You can check which version of Windows the key is for here: https://mskey.in/pid-key-checker-for-office-windows-license-key/"
else
    echo "No Windows product key was found in your machine's firmware."
fi
