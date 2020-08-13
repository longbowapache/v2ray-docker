FROM alpine:latest

ENV V2RAY_PATH /usr/bin/v2ray
ENV PATH=${V2RAY_PATH}:${PATH}
ENV TZ=Asia/Shanghai

WORKDIR ${V2RAY_PATH}

COPY update_rules.sh ${V2RAY_PATH}
COPY download_v2ray.sh ${V2RAY_PATH}
COPY entrypoint.sh /


RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk add tzdata curl bash \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && download_v2ray.sh \
    && curl -L -o go.sh -s https://install.direct/go.sh \
    && chmod +x go.sh \
    && go.sh --local v2ray.zip \
    && rm v2ray.zip \
    && rm go.sh \
    && rm download_v2ray.sh \
    && chmod +x update_rules.sh \
    && chmod +x /entrypoint.sh \
    && update_rules.sh ${V2RAY_PATH} \
    && apk del bash 

ENTRYPOINT ["/entrypoint.sh"]
