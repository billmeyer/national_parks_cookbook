# # encoding: utf-8

# Inspec test for recipe national_parks_cookbook::uninstall

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'uninstall-1' do
  impact 1.0
  title 'Verify the packages we use are not installed.'

  describe package 'maven' do
    it { should_not be_installed }
  end
end
