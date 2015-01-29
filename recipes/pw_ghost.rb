# Recipe for patching ghost vulnerability

#::Chef::Recipe.send(:include, VersionHelper) 
Chef::Log.info <<-EOS
  Ghost Patched? #{tagged?("ghost_patched")}
EOS

unless tagged?("ghost_patched")
  tag_method = method(:tag)
  if platform_family?('rhel')
    version_check = check_version("2.12-1.149")
    if version_check == 1
      #need to update
      package "glibc" do
        version "2.12-1.149.el6_6.5"
        action [:install, :upgrade]
      end
      
      execute "shutdown -r 2 &"
    end

    if version_check == -1
      Chef::Log.fatal "Could not get version of glibc. Did not continue"
    else
      ruby_block "complete" do
        block { tag_method.call "ghost_patched" }
      end

    end

  else
    Chef::Log.info "Unsupported platform: #{node.platform}"
  end
end



