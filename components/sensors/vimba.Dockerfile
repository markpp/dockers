# Vimba camera SDK
ARG VIMBA_TARBALL=Vimba_v3.1_Linux.tgz
ARG VIMBA_SDK="https://www.alliedvision.com/fileadmin/content/software/software/Vimba/${VIMBA_TARBALL}"
ADD ${VIMBA_SDK} /
RUN tar --wildcards -xzf ${VIMBA_TARBALL} 'Vimba*/Vimba*/*/x86_64bit'
ARG VIMBA_SDK_PREFIX=Vimba_3_1
ENV GENICAM_GENTL64_PATH=:/${VIMBA_SDK_PREFIX}/VimbaGigETL/CTI/x86_64bit
