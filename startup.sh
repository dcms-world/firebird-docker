#!/bin/bash

/opt/firebird/bin/gsec -modify SYSDBA -pw `echo $SYSDBAPASS`

/opt/firebird/bin/fbguard
