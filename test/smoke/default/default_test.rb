# # encoding: utf-8

# Inspec test for recipe bender_is_great::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe user('root') do
  it { should exist }
end
describe group('root') do
  it { should exist }
end

describe package('apache2') do
  it { should be_installed }
end
describe service('apache2') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe apache_conf('/etc/apache2/ports.conf') do
  its('Listen') { should eq ["0.0.0.0:80", "443", "443"] }
end

dir = '/var/www/html/bender_is_great'
describe directory(dir) do
  it { should exist }
  it { should be_directory }
  its('mode') { should cmp '0755' }
end
describe file("#{dir}/index.html") do
  it { should exist }
  it { should be_file }
end

describe port(80) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should include '0.0.0.0' }
end
