#######################################################################
#
# Standard repositories to use for Quattor configuration based on
# Quattor release.
#
#######################################################################
 
unique template repository/config/quattor;
 
include { 'quattor/functions/repository' };

# Ordered list of repository to load
# QUATTOR_REPOSITORY_RELEASE allows to define the Quattor release repository to use, in case
# there is no repository specific to the release
variable QUATTOR_REPOSITORY_RELEASE ?= QUATTOR_RELEASE;
variable QUATTOR_REPOSITORY_LIST ?= if ( is_defined(QUATTOR_RELEASE) ) {
                                      if ( match(QUATTOR_RELEASE,'13\.1') && (QUATTOR_RELEASE != '13.12') ) {
                                        repos = list('quattor_'+QUATTOR_REPOSITORY_RELEASE,'quattor_externals','quattor_components');
                                      } else {
                                        repos = list('quattor_'+QUATTOR_REPOSITORY_RELEASE,'quattor_externals');
                                      };
                                      debug("Repositories added for Quattor release "+QUATTOR_RELEASE+": "+to_string(repos));
                                      repos;
                                    } else {
                                      error("Quattor release undefined: not supported anymore, define QUATTOR_RELEASE to a version >= 13.1");
                                    };

'/software/repositories' = add_repositories(QUATTOR_REPOSITORY_LIST);