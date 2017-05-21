{%- from 'telegraf/settings.sls' import telegraf with context -%}

telegraf_user:
  user.present:
    - name: telegraf
    - groups:
      - docker
    - require:
      - pkg: telegraf
      - sls: docker
    - listen_in:
        - service: telegraf

/etc/telegraf/telegraf.d/docker.conf:
  file.managed:
    - makedirs: True
    - source: salt://telegraf/templates/docker.conf.toml
    - template: jinja
    - listen_in:
        - service: telegraf
