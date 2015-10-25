# See comments at end of file
# See cyber-dojo-model.pdf

class Dojo

  def languages; @languages ||= Languages.new(self, env_root); end
  def exercises; @exercises ||= Exercises.new(self, env_root); end
  def katas    ; @katas     ||=     Katas.new(self, env_root); end
  def caches   ; @caches    ||=    Caches.new(self, env_root); end

  def runner  ; @runner   ||= env_object.new      ; end
  def disk    ; @disk     ||= env_object.new      ; end
  def git     ; @git      ||= env_object.new      ; end
  def one_self; @one_self ||= env_object.new(disk); end

  private

  def env_root
    root = ENV['CYBER_DOJO_' + name_of(caller).upcase + '_ROOT']
    root + (root.end_with?('/') ? '' : '/')
  end

  def env_object
    var = 'CYBER_DOJO_' + name_of(caller).upcase + '_CLASS'
    Object.const_get(ENV[var])
  end

  def name_of(caller)
    (caller[0] =~ /`([^']*)'/ && $1)
  end

end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# External paths/class-names can be set via environment variables.
# See config/application.rb (config.before_configuration)
#
# The main reason for this arrangement is testability.
# For example, I can run controller tests by setting the
# environment variables, then run the test which issue
# a GET/POST, let the call work its way through the rails stack,
# eventually reaching Dojo.rb where it creates
# Disk/Runner/Git/OneSelf objects as named in the ENV[]
# I cannot see how how I do this using Parameterize-From-Above
# since I know of no way to 'tunnel' the parameters 'through'
# the rails stack.
#
# It also allows me to do polymorphic testing, viz to rerun
# the *same* test under different environments.
# For example, I could run a test with all the externals mocked
# out (a true unit test) and then run the same test again with
# the true externals in place (an integration/system test).
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
