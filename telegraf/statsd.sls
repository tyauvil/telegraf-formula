{%- from 'telegraf/settings.sls' import telegraf with context -%}

/etc/telegraf/telegraf.d/statsd.conf:
  file.managed:
    - makedirs: True
    - source: salt://telegraf/templates/statsd.conf.toml
    - template: jinja
    - listen_in:
        - service: telegraf
