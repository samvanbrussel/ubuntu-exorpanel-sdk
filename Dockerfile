ARG ExorPanelSdkVersion="1.0.5"
ARG ExorPanelSdkLocation="/opt/exorintos/${ExorPanelSdkVersion}"



FROM ubuntu
LABEL maintainer="sam.vanbrussel@linqed.be"

ARG ExorPanelSdkVersion
ARG ExorPanelSdkLocation

RUN apt update \
    && apt upgrade -y \
    && apt install python -y \
    && rm -rf /var/lib/apt/lists/*

ADD http://download.exorembedded.net:8080/Public/ExorPanels/SDK/un60-hsxx-sdk-${ExorPanelSdkVersion}.sh .
RUN chmod +x ./un60-hsxx-sdk-${ExorPanelSdkVersion}.sh && (echo ${ExorPanelSdkLocation}; echo "y") | ./un60-hsxx-sdk-${ExorPanelSdkVersion}.sh



FROM ubuntu
LABEL maintainer="sam.vanbrussel@linqed.be"

ARG ExorPanelSdkVersion
ARG ExorPanelSdkLocation

COPY --from=0 ${ExorPanelSdkLocation} ${ExorPanelSdkLocation}

ENV ExorPanelSdkLocation=${ExorPanelSdkLocation}
ENV ExorPanelSdkVersion=${ExorPanelSdkVersion}