# # encoding: utf-8

# Inspec test for recipe national_parks_cookbook::mongo

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'mongodb-1' do
  impact 1.0
  title 'Verify the mongodb service is enabled and is running.'

  describe service 'mongodb' do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'mongodb-2' do
  impact 1.0
  title 'Verify mongodb is listening on its configured port.'

  describe port(27017) do
    it { should be_listening }
  end
end

control 'mongodb-3' do
  impact 1.0
  title 'Verify the mongo client can connect to the mongodb server.'

  describe command('mongo --quiet --eval "db.serverStatus().uptime" | tr -d \'\n\'') do
    its('stdout') { should be > '0' }
  end
end
