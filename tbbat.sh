#!/bin/bash

int_capacity=$(cat /sys/class/power_supply/BAT0/energy_full) 
int_charge=$(cat /sys/class/power_supply/BAT0/energy_now) 
ext_capacity=$(cat /sys/class/power_supply/BAT1/energy_full) 
ext_charge=$(cat /sys/class/power_supply/BAT1/energy_now) 

total_charge=$((int_charge + ext_charge))
total_capacity=$((int_capacity + ext_capacity))

percent=$((total_charge * 100 / total_capacity))
echo $percent%
