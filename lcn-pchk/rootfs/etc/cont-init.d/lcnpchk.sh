#!/usr/bin/with-contenv bashio
# ==============================================================================
# LCN-PCHK setup
# ==============================================================================

bashio::log.info "PCHK setup..."


# default values
HOST_ID=4
SYNC_TIME="auto"
TIMEOUT=1800

if $(bashio::config.exists 'host_id'); then HOST_ID=$(bashio::config 'host_id'); fi
if $(bashio::config.exists 'sync_time'); then SYNC_TIME=$(bashio::config 'sync_time'); fi
if $(bashio::config.exists 'timeout'); then TIMEOUT=$(bashio::config 'timeout'); fi


LICENSE_KEYS=""
for key in $(bashio::config 'license_keys'); do
  LICENSE_KEYS="${LICENSE_KEYS}
    <LicenseKey xsi:type=\"AutoKey\">${key}</LicenseKey>"
done
LICENSE_KEYS="${LICENSE_KEYS//&/&amp;}"


SYNC_TIME_URL=""
if [[ $SYNC_TIME = "auto" ]];
  then 
    SYNC_TIME_TYPE="SyncAutoDetect";
elif [[ $SYNC_TIME = "disabled" ]];
  then
    SYNC_TIME_TYPE="SyncDisabled";
elif [[ $SYNC_TIME = "system" ]];
  then
    SYNC_TIME_TYPE="SyncSystemTime";
else
  SYNC_TIME_TYPE="SyncNtpTime";
  SYNC_TIME_URL=$(bashio::config 'sync_time');
fi


echo "<?xml version=\"1.0\" encoding=\"UTF-8\" ?> 
 <LcnPchkConfiguration xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"lcnpchkconfig.xsd\">
  <Header>
   <Version major=\"1\" minor=\"0\" /> 
    <Generator>LCN-PCHK 3.2</Generator> 
   </Header>
  <Global>
   <Language>de</Language> 
  </Global>
  <LicenseInformation>
   <Licensee>$(bashio::config 'licensee')</Licensee> 
   <LicenseKeys>$LICENSE_KEYS
   </LicenseKeys>
  </LicenseInformation>
  <LcnRealTimeClockSync xsi:type=\"${SYNC_TIME_TYPE}\" rtcForce=\"false\">${SYNC_TIME_URL}</LcnRealTimeClockSync>
  <Communication>
   <LCNPort throttling="true" useCTS="true" checkDSR="true" checkCDDelay="8" resetRTSDelay="1">$(bashio::config 'device')</LCNPort> 
   <HostPort>TCP/IP</HostPort> 
   <TCPPortNum>4114</TCPPortNum> 
   <TCPInactivityTimeout>$TIMEOUT</TCPInactivityTimeout> 
   <User>$(bashio::config 'user'):$(bashio::config 'password' | md5sum | awk '{print $1}')</User> 
   <HostId>$HOST_ID</HostId> 
   <RemoteConfigurationXmlRpcPort>4220</RemoteConfigurationXmlRpcPort> 
  </Communication>
 </LcnPchkConfiguration>" > /data/lcnpchk.xml
