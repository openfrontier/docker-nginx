FROM nginx:1.10-alpine

MAINTAINER zsx <thinkernel@gmail.com>

RUN set -x \
    && apk add --update --no-cache bash curl

COPY nginx-index.html /usr/share/nginx/html/index.html
COPY proxy.conf /etc/nginx/conf.d/default.conf
COPY nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh
RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/nginx-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
