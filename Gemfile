source :rubygems

gem 'rails', '3.0.0'

gem 'compass'
gem 'paste', :git => 'git://github.com/alexcrichton/paste.git'
gem 'cancan'
gem 'bluecloth'
# gem 'mini_fb'
# gem 'json' # required by mini_fb
gem 'will_paginate', :git => 'git://github.com/huerlisi/will_paginate.git', :branch => 'rails3'

gem 'pdfkit'

group :development, :test do
  gem 'heroku'
  gem 'taps'

  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'rspec-rails', '>=2.0.0.beta.20'

  gem 'wirble'
  gem 'bullet', '>= 2.0.0.rc'
end

group :test do
  gem 'spork'
end

group :production do
  gem 'pg'
end
