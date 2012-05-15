class rvm::compass {
  include rvm

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
}
