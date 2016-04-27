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

describe command('which aapt'), :if => os[:family] == 'darwin' do
  its(:exit_status) { should eq 0 }
end

# On Linux, we also check extra components.
describe command("#{ENV['ANDROID_HOME']}/tools/android list target"), :if => ['debian'].include?(os[:family]) do
  its(:exit_status) { should eq 0 }
end

describe command("#{ENV['ANDROID_HOME']}/tools/emulator-x86 -help-all"), :if => ['debian'].include?(os[:family]) do
  its(:exit_status) { should eq 0 }
end

describe command("#{ENV['ANDROID_HOME']}/platform-tools/adb version"), :if => ['debian'].include?(os[:family]) do
  its(:exit_status) { should eq 0 }
end

describe file("#{ENV['ANDROID_HOME']}/build-tools/23.0.1/aapt"), :if => ['debian'].include?(os[:family]) do
  it { should exist }
end

describe file("#{ENV['ANDROID_HOME']}/extras/android/m2repository/source.properties"), :if => ['debian'].include?(os[:family]) do
  it { should exist }
end

describe file("#{ENV['ANDROID_HOME']}/platforms/android-17/android.jar"), :if => ['debian'].include?(os[:family]) do
  it { should exist }
end

describe file("#{ENV['ANDROID_HOME']}/system-images/android-17/default/x86/system.img"), :if => ['debian', 'alpine'].include?(os[:family]) do
  it { should exist }
end

# Check re-install: re-install removes previous installed components.
describe file("#{ENV['ANDROID_HOME']}/platforms/android-22/android.jar"), :if => ['debian'].include?(os[:family]) do
  it { should_not exist }
end
