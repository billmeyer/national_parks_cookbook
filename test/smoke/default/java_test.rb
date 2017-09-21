# # encoding: utf-8

# Inspec test for recipe national_parks_cookbook::java

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'java-1' do
  impact 1.0
  title 'Verify the default JDK is not version 1.7.x.'

  describe command 'java -version 2>&1 | head -1' do
    its('stdout') { should_not match(/version "1.7.0/) }
  end
end

control 'java-2' do
  impact 1.0
  title 'Verify the default JDK is version 1.8.x.'

  describe command 'java -version 2>&1 | head -1' do
    its('stdout') { should match(/version "1.8.0/) }
  end
end
