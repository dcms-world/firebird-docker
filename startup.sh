#!/bin/bash

/opt/firebird/bin/gsec -modify SYSDBA -pw `echo $SYSDBAPASS`

echo "ServerMode        = ${SERVERMODE}"       > /opt/firebird/firebird.conf 
echo "WireCrypt         = ${WIRECRYPT}"       >> /opt/firebird/firebird.conf
echo "AuthServer        = ${AUTHSERVER}"      >> /opt/firebird/firebird.conf
echo "AuthClient        = ${AUTHCLIENT}"      >> /opt/firebird/firebird.conf
echo "UserManager       = ${USERMANAGER}"     >> /opt/firebird/firebird.conf
echo "TempBlockSize     = ${TMPBLOCKSIZE}"    >> /opt/firebird/firebird.conf
echo "TempCacheLimit    = ${TMPCACHELIMIT}"   >> /opt/firebird/firebird.conf
echo "RemoteAuxPort     = ${REMOTE_AUX_PORT}" >> /opt/firebird/firebird.conf 
echo "RemoteServicePort = $FIREBIRD_PORT"     >> /opt/firebird/firebird.conf

/opt/firebird/bin/fbguard
