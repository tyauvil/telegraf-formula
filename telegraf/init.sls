{%- from 'telegraf/settings.sls' import telegraf with context -%}

influxdata_repo:
  pkgrepo.managed:
    - name: deb https://repos.influxdata.com/ubuntu {{ grains['oscodename'] }} stable
    - file: /etc/apt/sources.list.d/influxdata.list
    - keyid: 2582E0C5
    - keyserver: {{ telegraf.keyserver }}

/etc/telegraf/telegraf.d:
  file.directory:
    - makedirs: True

/etc/telegraf/telegraf.conf:
  file.managed:
    - makedirs: True
    - source: salt://telegraf/templates/telegraf.conf.toml
    - template: jinja
    - context:
        env: {{ grains['env'] }}
        region: {{ grains['region'] }}
        service: {{ grains['service'] }}
        id: {{ grains['id'] }}
        username: {{ telegraf.username }}
        password: {{ telegraf.password }}
        influxdb_host: {{ telegraf.influxdb_host }}
        influxdb_port: {{ telegraf.influxdb_port }}
        database: {{ telegraf.database }}
        statsd_database: {{ telegraf.statsd_database }}
        user_agent: {{ telegraf.user_agent }}
    - listen_in:
        - service: telegraf

/etc/telegraf/telegraf.d/system.conf:
  file.managed:
    - makedirs: True
    - source: salt://telegraf/templates/system.conf.toml
    - template: jinja
    - listen_in:
        - service: telegraf

telegraf:
  pkg.installed:
    - version: {{ telegraf.version }}
  service.running:
    - enable: True
    - require:
      - file: /etc/telegraf/telegraf.conf
