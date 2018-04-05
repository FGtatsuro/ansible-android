require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"

[
  "tools/android",
  "tools/emulator",
  "platform-tools/adb"
].each do |content|
  describe file("#{ENV['ANDROID_HOME']}/#{content}"), :if => ['debian'].include?(os[:family]) do
    it { should exist }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end

# On Linux, we also check extra components.
describe command("#{ENV['ANDROID_HOME']}/tools/android list target"), :if => ['debian'].include?(os[:family]) do
  its(:exit_status) { should eq 0 }
end

describe command("#{ENV['ANDROID_HOME']}/tools/emulator -help-all"), :if => ['debian'].include?(os[:family]) do
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

describe file('/dev/kvm'), :if => ['debian'].include?(os[:family]) do
  it { should be_character_device }
  it { should be_mode 664 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'kvm' }
end

# user 'testuser' is created before spec testing on Travis.
describe user('testuser'), :if => ['debian'].include?(os[:family]) do
  it { should belong_to_group 'kvm' }
end
