class rvm::gemsets::compass {
  include rvm
  if $rvm_installed == "true" {
    rvm_system_ruby {
      'ruby-1.9.2-p290':
        ensure => 'present',
        default_use => true;
      'ruby-1.8.7-p357':
        ensure => 'present',
        default_use => false;
    }
    
    rvm_gemset {
      "ruby-1.9.2-p290@compass":
        ensure => present,
        require => Rvm_system_ruby['ruby-1.9.2-p290'];
    }
    
    rvm_gem {
      'ruby-1.9.2-p290@compass/compass':
        notify => Exec["/usr/local/rvm/gems/ruby-1.9.2-p290@global/bin/rubygems-bundler-uninstaller"],
        require => Rvm_gemset['ruby-1.9.2-p290@compass'];
    }
    # New version of rubygems-bundler breaks compass - run uninstaller to fix:
    # http://stackoverflow.com/questions/10610254/cant-install-compass-via-rvm
    exec {"/usr/local/rvm/gems/ruby-1.9.2-p290@global/bin/rubygems-bundler-uninstaller" :
      refreshonly => true,
      require => Rvm_gem['ruby-1.9.2-p290@compass/compass'],
    }
  }
}
