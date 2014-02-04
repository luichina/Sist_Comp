#!/bin/sh

## SCRIPT QUE SE ENCARGA DE HACER PING A LOS SERVIDORES ##

# PING A SOLUCIONESLML.COM.AR
TIMESTAMP=`date "+%Y-%m-%d-%T"`

PING1=`ping -c1 solucioneslml.sytes.net | head -2 | tail -1`
PING2=`ping -c1 solucioneslml.com.ar | head -2 | tail -1`
PING3=ups
PING4=`ping -c1 192.168.1.101 | head -2 | tail -1`

#output=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "SELECT * FROM redalert"`
#echo $output

## CHEQUEAMOS EL HOST DEFINIDO EN LA BASE CON ID=1 ##
if [ -z "$PING1" ]; then
    update=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "UPDATE redalert SET ping_status=0, response_time=null, last_check='$TIMESTAMP' WHERE id=1"`
    insert=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "INSERT estado SET id=1, ping_status=0, response_time=null, check_date='$TIMESTAMP'"`
else
    PING1=`ping -c1 solucioneslml.sytes.net | head -2 | tail -1 | awk '{print $(NF-1)}' | cut -d= -f2`
    update=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "UPDATE redalert SET ping_status=1, response_time='$PING1', last_check='$TIMESTAMP' WHERE id=1"`
    insert=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "INSERT estado SET id=1, ping_status=1, response_time='$PING1', check_date='$TIMESTAMP'"`
fi

## CHEQUEAMOS EL HOST DEFINIDO EN LA BASE CON ID=2 ##
if [ -z "$PING2" ]; then
    update=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "UPDATE redalert SET ping_status=0, response_time=null, last_check='$TIMESTAMP' WHERE id=2"`
    insert=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "INSERT estado SET id=2, ping_status=0, response_time=null, check_date='$TIMESTAMP'"`
else
    PING2=`ping -c1 solucioneslml.com.ar | head -2 | tail -1 | awk '{print $(NF-1)}' | cut -d= -f2`
    update=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "UPDATE redalert SET ping_status=1, response_time='$PING2', last_check='$TIMESTAMP' WHERE id=2"`
    insert=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "INSERT estado SET id=2, ping_status=1, response_time='$PING2', check_date='$TIMESTAMP'"`
fi

## CHEQUEAMOS EL HOST DEFINIDO EN LA BASE CON ID=4 ##
if [ -z "$PING4" ]; then
    update=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "UPDATE redalert SET ping_status=0, response_time=null, last_check='$TIMESTAMP' WHERE id=4"`
    insert=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "INSERT estado SET id=4, ping_status=0, response_time=null, check_date='$TIMESTAMP'"`
else
    PING4=`ping -c1 192.168.1.101 | head -2 | tail -1 | awk '{print $(NF-1)}' | cut -d= -f2`
    update=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "UPDATE redalert SET ping_status=1, response_time='$PING4', last_check='$TIMESTAMP' WHERE id=4"`
    insert=`mysql -h solucioneslml.sytes.net -u root -pgh45ty imx -s -N -e "INSERT estado SET id=4, ping_status=1, response_time='$PING4', check_date='$TIMESTAMP'"`
fi
