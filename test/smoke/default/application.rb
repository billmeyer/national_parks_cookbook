# # encoding: utf-8

# Inspec test for recipe national_parks::application

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'national-parks-app-checkout-1' do
  impact 1.0
  title 'Verify national parks war deployed'
  desc 'The National Parks app is deployed as a WAR file.  To confirm the war deploys correctly, look for specific content in the default page.'
  describe command 'curl http://localhost:8080/national-parks/' do
    its('stdout') { should match /<title>Map of National Parks<\/title>/ }
  end
end

control 'national-parks-app-checkout-2' do
  impact 1.0
  title 'Verify Tomcat is rendering dynamic pages correctly'
  desc 'The National Parks app has a custom jsp page that can be used to confirm Tomcat is rendering pages correctly.'
  describe command 'curl http://localhost:8080/national-parks/snoop.jsp' do
    its('stdout') { should match /<H1>JSP Snoop page<\/H1>/ }
  end
end
