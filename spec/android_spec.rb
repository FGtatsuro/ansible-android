require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"

describe package('python-dev'), :if => ['debian', 'alpine'].include?(os[:family]) do
  it { should be_installed }
end

describe package('build-essential'), :if => os[:family] == 'debian' do
  it { should be_installed }
end

describe package('build-base'), :if => os[:family] == 'alpine' do
  it { should be_installed }
end

describe command('which python') do
  its(:exit_status) { should eq 0 }
end
