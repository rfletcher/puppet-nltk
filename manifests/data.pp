define nltk::data (
  $virtualenv = undef,
) {
  $category = $name ? {
    'abc'                        => 'corpora',
    'alpino'                     => 'corpora',
    'basque_grammars'            => 'grammars',
    'biocreative_ppi'            => 'corpora',
    'book_grammars'              => 'grammars',
    'brown'                      => 'corpora',
    'brown_tei'                  => 'corpora',
    'cess_cat'                   => 'corpora',
    'cess_esp'                   => 'corpora',
    'chat80'                     => 'corpora',
    'city_database'              => 'corpora',
    'cmudict'                    => 'corpora',
    'conll2000'                  => 'corpora',
    'conll2002'                  => 'corpora',
    'dependency_treebank'        => 'corpora',
    'europarl_raw'               => 'corpora',
    'floresta'                   => 'corpora',
    'gazetteers'                 => 'corpora',
    'genesis'                    => 'corpora',
    'gutenberg'                  => 'corpora',
    'hmm_treebank_pos_tagger'    => 'taggers',
    'ieer'                       => 'corpora',
    'inaugural'                  => 'corpora',
    'indian'                     => 'corpora',
    'kimmo'                      => 'corpora',
    'large_grammars'             => 'grammars',
    'lin_thesaurus'              => 'corpora',
    'mac_morpho'                 => 'corpora',
    'maxent_ne_chunker'          => 'chunkers',
    'maxent_treebank_pos_tagger' => 'taggers',
    'movie_reviews'              => 'corpora',
    'names'                      => 'corpora',
    'nps_chat'                   => 'corpora',
    'paradigms'                  => 'corpora',
    'pil'                        => 'corpora',
    'pl196x'                     => 'corpora',
    'ppattach'                   => 'corpora',
    'problem_reports'            => 'corpora',
    'ptb'                        => 'corpora',
    'punkt'                      => 'tokenizers',
    'qc'                         => 'corpora',
    'reuters'                    => 'corpora',
    'rslp'                       => 'stemmers',
    'rte'                        => 'corpora',
    'sample_grammars'            => 'grammars',
    'senseval'                   => 'corpora',
    'shakespeare'                => 'corpora',
    'sinica_treebank'            => 'corpora',
    'smultron'                   => 'corpora',
    'spanish_grammars'           => 'grammars',
    'state_union'                => 'corpora',
    'stopwords'                  => 'corpora',
    'swadesh'                    => 'corpora',
    'switchboard'                => 'corpora',
    'timit'                      => 'corpora',
    'toolbox'                    => 'corpora',
    'treebank'                   => 'corpora',
    'udhr'                       => 'corpora',
    'udhr2'                      => 'corpora',
    'unicode_samples'            => 'corpora',
    'verbnet'                    => 'corpora',
    'webtext'                    => 'corpora',
    'wordnet'                    => 'corpora',
    'wordnet_ic'                 => 'corpora',
    'words'                      => 'corpora',
    'ycoe'                       => 'corpora',
    default => fail( 'unrecognized corpus name' ),
  }

  if $virtualenv == undef {
    $base_dir    = '/usr/local/share'
    $environment = undef
    $pip_name    = 'nltk'
  } else {
    $base_dir    = "${virtualenv}/local/share"
    $environment = "PYTHON_VIRTUALENV=${virtualenv}"
    $pip_name    = "${virtualenv} - nltk"
  }

  exec { "nltk::data ${name}":
    command     => "python -m nltk.downloader -d ${base_dir} ${name}",
    creates     => "${base_dir}/${category}/${name}",
    environment => $environment,
    path        => $virtualenv ? { undef => ['/usr/bin'], default => ["${virtualenv}/bin"], },
    require     => Python::Pip[$pip_name],
  }
}
