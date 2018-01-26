def perform_async(*args)
  client_push('class' => self, 'args' => args)
end

def perform_in(interval, *args)
  int = interval.to_f
  ts = (int < 1_000_000_000 ? Time.now.to_f + int : int)
  client_push('class' => self, 'args' => args, 'at' => ts)
end
alias_method :perform_at, :perform_in

def get_sidekiq_options
  self.sidekiq_options_hash ||= DEFAULT_OPTIONS
end

##
#
#:queue - 
#:retry -
#:timeout -
#:backtrace -
#

def sidekiq_options(opts={})
  self.sidekiq_options_hash = get_sidekiq_options.merge(stringify_keys(opts || {}))
end

DEFAULT_OPTIONS = { 'retry' => true, 'queue' => 'default' }

def get_sidekiq_options #:nodoc:
  self.sidekiq_options_hash ||= DEFAULT_OPTIONS
end

