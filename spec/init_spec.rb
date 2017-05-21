# for serverspec documentation: http://serverspec.org/
require_relative 'spec_helper'

pkgs = ['telegraf']
files = ['/etc/telegraf/telegraf.conf',
         '/etc/telegraf/telegraf.d/docker.conf',
         '/etc/telegraf/telegraf.d/system.conf']

pkgs.each do |pkg|
  describe package("#{pkg}") do
    it { should be_installed }
  end
end

files.each do |file|
  describe file("#{file}") do
    it { should be_file }
  end
end

describe service('telegraf') do
  it { should be_running }
  it { should be_enabled }
end

# let telegraf send first update
sleep(30)

describe command('wget --no-check-certificate -qO- "https://localhost:8086/query?q=select+*+from+cpu+limit+1&db=telegraf" | grep -q dev-vagrant-usc1a-pr-10.0.1.15') do
  its(:exit_status) { should eq 0 }
end
