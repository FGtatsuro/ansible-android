require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"

# On OSX, Homebrew creates proper symlinks automatically.
describe command('android list target'), :if => os[:family] == 'darwin' do
  its(:exit_status) { should eq 0 }
end

describe command('emulator -help-all'), :if => os[:family] == 'darwin'  do
  its(:exit_status) { should eq 0 }
end

describe command('adb version'), :if => os[:family] == 'darwin' do
  its(:exit_status) { should eq 0 }
end

describe command("#{ENV['ANDROID_HOME']}/tools/android list target"), :if => ['debian', 'alpine'].include?(os[:family]) do
  its(:exit_status) { should eq 0 }
end

describe command("#{ENV['ANDROID_HOME']}/tools/emulator -help-all"), :if => ['debian', 'alpine'].include?(os[:family]) do
  its(:exit_status) { should eq 0 }
end

describe command("#{ENV['ANDROID_HOME']}/platform-tools/adb version"), :if => ['debian', 'alpine'].include?(os[:family]) do
  its(:exit_status) { should eq 0 }
end
