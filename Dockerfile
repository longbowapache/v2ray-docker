FROM alpine:latest

ENV VERSION 4.27.0
ENV V2RAY_PATH /opt/v2ray/
ENV V2RAY_ZIP_FILE v2ray-linux-arm64-v8a.zip
ENV PATH=${V2RAY_PATH}:${PATH}
ENV TZ=Asia/Shanghai

WORKDIR ${V2RAY_PATH}

COPY update_rules.sh ${WORKDIR}
COPY entrypoint.sh /


RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk add zip tzdata \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && wget -q https://github.com/v2ray/v2ray-core/releases/download/v${VERSION}/${V2RAY_ZIP_FILE} \
    && unzip ${V2RAY_ZIP_FILE} \
    && chmod +x v2ray v2ctl \
    && rm *.zip \
    && chmod +x update_rules.sh \
    && chmod +x /entrypoint.sh \
    && apk del tzdata zip \
    && echo "0 3 * * * update_rules.sh ${V2RAY_PATH} >> /tmp/update_rules.log 2>&1" >> /var/spool/cron/crontabs/root

ENTRYPOINT ["/entrypoint.sh"]