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
        require => Rvm_gemset['ruby-1.9.2-p290@compass'];
    }
    # New version of rubygems-bundler breaks compass - unsure older version
    rvm_gem {
      'ruby-1.9.2-p290@compass/rubygems-bundler':
        ensure => '0.9.2',
        require => Rvm_gemset['ruby-1.9.2-p290@compass'];
    }
  }
}
