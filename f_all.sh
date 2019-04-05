echo 'fastboot $* getvar product 2>&1 | grep "^product: *whyred$"
#if [ $? -ne 0 ] ; then echo "Missmatching image and device"; exit 1; fi

CURRENT_ANTI_VER=4
anti=`fastboot getvar anti 2>&1 | grep anti: | cut -f 2 -d " "`
if [ -z "$anti" ];then
    anti=0
fi
if [ $anti -eq $CURRENT_ANTI_VER ]; then
    # reflash
    fastboot $* flash antirbpass `dirname $0`/images/dummy.img || exit 1
elif [ $anti -gt $CURRENT_ANTI_VER ]; then
    # downgrade
    echo "downgrade not allowed!!!"
    exit 1
fi

fastboot $* flash xbl  `dirname $0`/images/xbl.elf

fastboot $* flash xblbak   `dirname $0`/images/xbl.elf
fastboot $* flash tz   `dirname $0`/images/tz.mbn
fastboot $* flash tzbak   `dirname $0`/images/tz.mbn
fastboot $* flash rpm   `dirname $0`/images/rpm.mbn
fastboot $* flash rpmbak   `dirname $0`/images/rpm.mbn
fastboot $* flash hyp   `dirname $0`/images/hyp.mbn
fastboot $* flash hypbak   `dirname $0`/images/hyp.mbn
fastboot $* flash pmic   `dirname $0`/images/pmic.elf
fastboot $* flash pmicbak   `dirname $0`/images/pmic.elf
fastboot $* flash keymaster   `dirname $0`/images/keymaster.mbn
fastboot $* flash keymasterbak   `dirname $0`/images/keymaster.mbn
fastboot $* flash cmnlib   `dirname $0`/images/cmnlib.mbn
fastboot $* flash cmnlibbak   `dirname $0`/images/cmnlib.mbn
fastboot $* flash cmnlib64   `dirname $0`/images/cmnlib64.mbn
fastboot $* flash cmnlib64bak   `dirname $0`/images/cmnlib64.mbn
fastboot $* flash mdtpsecapp   `dirname $0`/images/mdtpsecapp.mbn
fastboot $* flash mdtpsecappbak   `dirname $0`/images/mdtpsecapp.mbn

fastboot $* flash modem   `dirname $0`/images/NON-HLOS.bin
fastboot $* flash dsp   `dirname $0`/images/dspso.bin
fastboot $* flash bluetooth   `dirname $0`/images/BTFM.bin
fastboot $* flash storsec   `dirname $0`/images/storsec.mbn
fastboot $* flash storsecbak   `dirname $0`/images/storsec.mbn
fastboot $* flash devcfg   `dirname $0`/images/devcfg.mbn
fastboot $* flash devcfgbak   `dirname $0`/images/devcfg.mbn
fastboot $* flash abl   `dirname $0`/images/abl.elf
fastboot $* flash ablbak   `dirname $0`/images/abl.elf

fastboot $* flash boot   `dirname $0`/images/boot.img
fastboot $* flash recovery   `dirname $0`/images/recovery.img
fastboot $* flash system   `dirname $0`/images/system.img
fastboot $* flash vendor   `dirname $0`/images/vendor.img
fastboot $* flash userdata   `dirname $0`/images/userdata.img
fastboot $* flash mdtp   `dirname $0`/images/mdtp.img
fastboot $* flash cache   `dirname $0`/images/cache.img
fastboot $* flash splash   `dirname $0`/images/splash.img

fastboot $* erase ddr

fastboot $* flash cust `dirname $0`/images/cust.img

#fastboot $* erase config

fastboot $* reboot'
fastboot continue
