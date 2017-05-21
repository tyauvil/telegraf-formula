{% set p    = pillar.get('telegraf', {}) %}
{% set pc   = p.get('config', {}) %}
{% set g    = grains.get('telegraf', {}) %}
{% set gc   = g.get('config', {}) %}

{%- set telegraf = {} %}
{%- do telegraf.update({
  'version':              p.get('version', '1.2.1-1'),
  'keyserver':            p.get('keyserver', 'keyserver.ubuntu.com'),
  'influxdb_host':        p.get('influxdb_host', '127.0.0.1'),
  'influxdb_port':        p.get('influxdb_port', '8086'),
  'database':             p.get('database', 'telegraf'),
  'statsd_database':      p.get('statsd_database', 'statsd'),
  'statsd_enabled':       p.get('statsd_enabled', False ),
  'insecure_skip_verify': p.get('insecure_skip_verify', False ),
  'parse_data_dog_tags':  p.get('parse_data_dog_tags', True),
  'username':             p.get('username', 'user'),
  'password':             p.get('password', 'password'),
  'user_agent':           p.get('user_agent', 'telegraf'),
  }) %}
