FROM alpine:edge

RUN apk update && apk upgrade && \
    apk add -U --no-cache bash make && \
    rm -rf /var/cache/apk/*


RUN     echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
        >> /etc/apk/repositories \
        && apk --no-cache update upgrade

# Install TeX Live and associated packages. After retrieving texlive-texmf for
# the first time comment out wget to avoid downloading with each image build.
RUN     apk --no-cache add icu-libs make poppler texlive-full xz zziplib \
	&& wget http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2016/texlive-20160523b-texmf.tar.xz \
    && tar -xJf texlive-20160523b-texmf.tar.xz \
    && cp -r texlive-20160523-texmf/texmf-dist /usr/share \
    && rm -rf texlive* \
	&& apk fix texlive \
	&& ln -s /usr/bin/mktexlsr /usr/bin/mktexlsr.pl


ENTRYPOINT ["/bin/bash"]