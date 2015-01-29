
require './libraries/glibc_version'

describe 'check_versions' do
  it 'should return 0 if the minimum version is installed' do
    run_command = double(:stdout => "2.12,1.149.el6_6.5")
    shellout = double(:run_command => run_command)
    Mixlib::ShellOut.stub(:new).and_return(shellout)
    expect(check_version("2.12-1.149")).to eql 0
  end

  it 'should return 1 if the installed value is less than the min' do
    run_command = double(:stdout => "2.12,1.140.el6_6.5")
    shellout = double(:run_command => run_command)
    Mixlib::ShellOut.stub(:new).and_return(shellout)
    expect(check_version("2.12-1.149")).to eql 1
  end

  it 'should return 0 if the installed version is > than minimum' do
    run_command = double(:stdout => "2.12,1.189.el6_6.5")
    shellout = double(:run_command => run_command)
    Mixlib::ShellOut.stub(:new).and_return(shellout)
    expect(check_version("2.12-1.149")).to eql 0
  end

  it 'should return -1 if something goes wrong' do
    run_command = double(:stdout => "")
    shellout = double(:run_command => run_command)
    Mixlib::ShellOut.stub(:new).and_return(shellout)
    expect(check_version("2.12-1.149")).to eql -1
  end
end
