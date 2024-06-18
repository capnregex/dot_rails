
gem 'draper' # Decorators
gem 'kaminari' # Pagination
gem 'view_component'
gem 'simple_form' # Simpler Form Helpers
gem 'ransack' # Simple Query Helper

gem_group :development, :test do
  gem 'rspec-rails'
  # gem 'awesome_print'
  # gem 'dotenv-rails'
  gem 'factory_bot_rails'
  # gem 'minitest'
end

gem_group :development do
  # gem 'better_errors'
  # gem 'binding_of_caller'
  # gem 'annotate'
end

generate 'simple_form:install'
generate 'rspec:install'
generate 'draper:install'

generator_config = <<GENERATORS

    config.generators do |g|
      g.helper false
      g.scaffold_stylesheet false
      g.controller_specs false
      g.helper_specs false
      g.request_specs false
      g.routing_specs false
      g.view_specs false
      g.decorator test_framework: nil
    end
GENERATORS

inject_into_file "config/application.rb", optimize_indentation(generator_config, 4), after: /config.load_defaults .*\n/, verbose: false

comment_lines 'config/application.rb', /config.generators.system_tests/

generate 'scaffold', 'people', 'name'
route "root to: 'people#index'"

rails_command('db:drop')
rails_command('db:create')
rails_command('db:migrate')

after_bundle do
  # git :init
  git add: '.'
  git commit: %Q{ -m 'Initial commit' }
end 

# environment 'config.action_mailer.default_url_options = {host: "http://yourwebsite.example.com"}', env: 'production'

