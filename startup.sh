#!/bin/bash

/opt/firebird/bin/gsec -modify SYSDBA -pw `echo $SYSDBAPASS`

echo "TempBlockSize = $TMPBLOCKSIZE" >> /opt/firebird/firebird.conf 
echo "TempCacheLimit = $TMPCACHELIMIT" >> /opt/firebird/firebird.conf
echo "RemoteServicePort = $FIREBIRD_PORT" >> /opt/firebird/firebird.conf 
echo "RemoteAuxPort = $REMOTE_AUX_PORT" >> /opt/firebird/firebird.conf

/opt/firebird/bin/fbguard