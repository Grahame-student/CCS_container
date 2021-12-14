FROM ubuntu:18.04

ENV INSTALLER_URL=https://software-dl.ti.com/ccs/esd/CCSv11/CCS_11_0_0/exports/CCS11.0.0.00012_web_linux-x64.tar.gz
ENV INSTALLER_TAR=CCS11.0.0.00012_web_linux-x64.tar.gz
ENV INSTALLER_PATH=CCS11.0.0.00012_linux-x64/ccs_setup_11.0.0.00012.bin
ENV INSTALLER_BIN = ccs_setup_11.0.0.00012.bin


RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt update && \
    apt -y upgrade && \
    apt install -y apt-utils && \
    apt install -y autoconf libtool build-essential libc6-i386 libusb-0.1-4 libgconf-2-4 && \
    apt install -y software-properties-common python2.7 libpython2.7 && \
    apt install -y byobu curl git git-lfs htop man unzip vim wget
RUN mkdir /root/Downloads
RUN curl -L ${INSTALLER_URL} --output /root/Downloads/${INSTALLER_TAR} --silent && \
    tar xf /root/Downloads/${INSTALLER_TAR} --directory /root/Downloads/
RUN ls -l /root/Downloads
RUN chmod +x /root/Downloads/${INSTALLER_PATH} && \
    /root/Downloads/${INSTALLER_PATH} --mode unattended --enable-components PF_MSP430 --prefix /opt/ti/ccs1100
RUN rm /root/Downloads/${INSTALLER_PATH}
RUN rm /root/Downloads/${INSTALLER_TAR}
RUN mkdir -p /home/build/workspace && \
    /opt/ti/ccs1100/ccs/eclipse/eclipse -noSplash -data /home/build/workspace -application com.ti.common.core.initialize -rtsc.productDiscoveryPath "/opt/ti/ccs1100;/opt/ti/"
CMD ["/bin/bash"]
