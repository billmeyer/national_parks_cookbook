# # encoding: utf-8

# Inspec test for recipe national_parks_cookbook::tomcat

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'tomcat-1' do
  impact 1.0
  title 'Verify the tomcat8 service is enabled and is running.'

  describe service 'tomcat8' do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'tomcat-2' do
  impact 1.0
  title 'Verify tomcat8 is listening on its configured port.'

  describe port(8080) do
    it { should be_listening }
  end

  describe port(8009) do
    it { should be_listening }
  end
end

control 'tomcat-3' do
  impact 1.0
  title 'Verify the default tomcat8 web page is served correctly.'

  describe command 'curl localhost:8080' do
    its('stdout') { should match(/Congratulations!/) }
  end
end
