define nltk (
  $ensure     = present,
  $virtualenv = undef,
) {
  $pip_name = $virtualenv ? {
    undef   => 'nltk',
    default => "${virtualenv} - nltk",
  }

  python::pip { $pip_name:
    ensure     => $ensure,
    pkgname    => 'nltk',
    virtualenv => $virtualenv,
  }
}
