FROM alpine:3.17 AS verify
RUN apk add --no-cache curl tar xz

RUN ROOTFS=$(curl -sfOJL -w "al2023-container-2023.6.20241010.0-x86_64.tar.xz" "https://amazon-linux-docker-sources.s3.amazonaws.com/al2023/2023.6.20241010.0/al2023-container-2023.6.20241010.0-x86_64.tar.xz") \
  && echo 'ad73836aba6dd83287a8730bdb21f10a57f7231c4a933797788350fcfb8c2d6d  al2023-container-2023.6.20241010.0-x86_64.tar.xz' >> /tmp/al2023-container-2023.6.20241010.0-x86_64.tar.xz.sha256 \
  && cat /tmp/al2023-container-2023.6.20241010.0-x86_64.tar.xz.sha256 \
  && sha256sum -c /tmp/al2023-container-2023.6.20241010.0-x86_64.tar.xz.sha256 \
  && mkdir /rootfs \
  && tar -C /rootfs --extract --file "${ROOTFS}"

FROM scratch AS root
COPY --from=verify /rootfs/ /

CMD ["/bin/bash"]
