#!/usr/bin/env bash

useradd prometheus

wget https://github.com/prometheus/prometheus/releases/download/v1.7.1/prometheus-1.7.1.linux-amd64.tar.gz

cd /opt && tar -zxvf /root/prometheus-1.7.1.linux-amd64.tar.gz && ln -s prometheus-1.7.1.linux-amd64 prometheus

chown prometheus:prometheus /opt/prometheus-1.7.1.linux-amd64/ -R

cat >/etc/systemd/system/prometheus.service <<EOL
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target

[Service]
User=prometheus
Restart=on-failure
ExecStart=/opt/prometheus/prometheus \
  -config.file=/opt/prometheus/prometheus.yml \
  -storage.local.path=/opt/prometheus/data

[Install]
WantedBy=multi-user.target
EOL

ln -s /opt/prometheus/prometheus.yml /etc

systemctl daemon-reload

systemctl start prometheus

systemctl enable prometheus

exit 0