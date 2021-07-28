FROM moriyasnj/ffmpeg-openh264

ENV NGINX_VERSION=1.20.1 \
NGINX_RTMP_MODULE_VERSION=1.2.2

RUN apt-get update && apt-get install -y \
&& apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev unzip git \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& wget https://github.com/arut/nginx-rtmp-module/archive/refs/tags/v${NGINX_RTMP_MODULE_VERSION}.tar.gz \
&& tar -zxvf v${NGINX_RTMP_MODULE_VERSION}.tar.gz \
&& wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
&& tar -zxvf nginx-${NGINX_VERSION}.tar.gz \
&& cd nginx-${NGINX_VERSION} \
&& ./configure --add-module=../nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} --without-http_gzip_module \
&& make \
&& make install \
&& cd - \
&& rm -f v${NGINX_RTMP_MODULE_VERSION}.tar.gz \
&& rm -rf nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} \
&& rm -f nginx-${NGINX_VERSION}.tar.gz \
&& rm -rf nginx-${NGINX_VERSION}
