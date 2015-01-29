
require 'mixlib/shellout'

#module VersionHelper
  #note: minimun must be in format: 1.1-1.1
  #Return values:
  #  0 = meets the minimum version (no action required)
  #  1 = vulnerable needs to be updated
  #  -1 = Something went really wrong
  def check_version(minimum)
    m_version, m_release = minimum.split('-')
    begin
      ins_ver_cmd = Mixlib::ShellOut.new("rpm -q --qf '%{V},%{R}\n' glibc")
      ins_version = ins_ver_cmd.run_command.stdout
      i_version, i_release_raw = ins_version.split(',')
      i_release = i_release_raw.split('.el')[0]

      i_v_array = i_version.split('.') #installed version
      m_v_array = m_version.split('.') #minimum version
      i_v_array.each_index do |index|
        if i_v_array[index].to_i < m_v_array[index].to_i
          return 1
        end
      end

      #If it gets here it means the versions are the same need to check release
      i_r_array = i_release.split('.')
      m_r_array = m_release.split('.')
      i_r_array.each_index do |index|
        if i_r_array[index].to_i < m_r_array[index].to_i
          return 1
        end
      end

      return 0
    rescue
      return -1
    end

  end
#end
