FROM ubuntu:18.04

RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt update && \
    apt -y upgrade && \
    apt install -y apt-utils && \
    apt install -y autoconf libtool build-essential libc6-i386 libusb-0.1-4 libgconf-2-4 && \
    apt install -y software-properties-common python2.7 libpython2.7 && \
    apt install -y byobu curl git git-lfs htop man unzip vim wget
RUN mkdir /root/Downloads
RUN curl -L http://software-dl.ti.com/ccs/esd/CCSv9/CCS_9_3_0/exports/CCS9.3.0.00012_linux-x64.tar.gz --output /root/Downloads/CCS9.3.0.00012_linux-x64.tar.gz --silent && \
    tar xf /root/Downloads/CCS9.3.0.00012_linux-x64.tar.gz --directory /root/Downloads/
RUN chmod +x /root/Downloads/CCS9.3.0.00012_linux-x64/ccs_setup_9.3.0.00012.bin && \
    /root/Downloads/CCS9.3.0.00012_linux-x64/ccs_setup_9.3.0.00012.bin --mode unattended --enable-components PF_MSP432,PF_CC2X --prefix /opt/ti/ccs930
RUN rm /root/Downloads/CCS9.3.0.00012_linux-x64/ccs_setup_9.3.0.00012.bin
RUN curl -L http://software-dl.ti.com/simplelink/esd/simplelink_msp432_sdk/2.40.00.10/simplelink_msp432p4_sdk_2_40_00_10.run --output /root/Downloads/simplelink_msp432p4_sdk_2_40_00_10.run --silent && \
    chmod +x /root/Downloads/simplelink_msp432p4_sdk_2_40_00_10.run
RUN /root/Downloads/simplelink_msp432p4_sdk_2_40_00_10.run --mode unattended --prefix /opt/ti/
RUN rm /root/Downloads/simplelink_msp432p4_sdk_2_40_00_10.run
RUN curl -L http://software-dl.ti.com/simplelink/esd/simplelink_msp432_sdk/3.40.01.02/simplelink_msp432p4_sdk_3_40_01_02.run --output /root/Downloads/simplelink_msp432p4_sdk_3_40_01_02.run --silent && \
    chmod +x /root/Downloads/simplelink_msp432p4_sdk_3_40_01_02.run
RUN /root/Downloads/simplelink_msp432p4_sdk_3_40_01_02.run --mode unattended --prefix /opt/ti/
RUN rm /root/Downloads/simplelink_msp432p4_sdk_3_40_01_02.run
RUN curl -L http://software-dl.ti.com/simplelink/esd/simplelink_msp432e4_sdk/2.10.00.17/simplelink_msp432e4_sdk_2_10_00_17.run --output /root/Downloads/simplelink_msp432e4_sdk_2_10_00_17.run --silent && \
    chmod +x /root/Downloads/simplelink_msp432e4_sdk_2_10_00_17.run
RUN /root/Downloads/simplelink_msp432e4_sdk_2_10_00_17.run --mode unattended --prefix /opt/ti/
RUN rm /root/Downloads/simplelink_msp432e4_sdk_2_10_00_17.run
RUN curl -L http://software-dl.ti.com/simplelink/esd/simplelink_msp432e4_sdk/3.10.00.11/simplelink_msp432e4_sdk_3_10_00_11.run --output /root/Downloads/simplelink_msp432e4_sdk_3_10_00_11.run --silent && \
    chmod +x /root/Downloads/simplelink_msp432e4_sdk_3_10_00_11.run
RUN /root/Downloads/simplelink_msp432e4_sdk_3_10_00_11.run --mode unattended --prefix /opt/ti/
RUN rm /root/Downloads/simplelink_msp432e4_sdk_3_10_00_11.run
RUN mkdir -p /home/build/workspace && \
    /opt/ti/ccs930/ccs/eclipse/eclipse -noSplash -data /home/build/workspace -application com.ti.common.core.initialize -rtsc.productDiscoveryPath "/opt/ti/ccs930;/opt/ti/"
CMD ["/bin/bash"]
