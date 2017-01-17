FROM nginx:1.10-alpine

MAINTAINER zsx <thinkernel@gmail.com>

RUN set -x \
    && apk add --update --no-cache bash curl

COPY html /usr/share/nginx/html
COPY proxy.conf /etc/nginx/conf.d/default.conf
COPY nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh

ADD https://ajax.googleapis.com/ajax/libs/angularjs/1.3.15/angular.min.js /usr/share/nginx/html/js/angular.min.js
ADD https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js     /usr/share/nginx/html/js/jquery.min.js
ADD https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js   /usr/share/nginx/html/js/bootstrap.min.js
RUN chmod +r /usr/share/nginx/html/js/*.js

RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/nginx-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
