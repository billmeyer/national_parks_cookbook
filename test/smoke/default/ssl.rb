# # encoding: utf-8

# Inspec test for recipe national_parks::ssl

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(443) do
  it { should be_listening }
end
