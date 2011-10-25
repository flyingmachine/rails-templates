gem("rspec-rails", :group => "test")
gem("haml-rails")
gem("factory_girl_rails")
gem("cucumber-rails")
gem("capybara")

remove_file 'public/index.html'
remove_file 'rm public/images/rails.png'
run 'cp config/database.yml config/database.example'
run "echo 'config/database.yml' >> .gitignore"

generate 'rspec:install'
inject_into_file 'spec/spec_helper.rb', "\nrequire 'factory_girl'", :after => "require 'rspec/rails'"

inject_into_file 'config/application.rb', :after => "config.filter_parameters += [:password]" do
  <<-eos
    
    # Customize generators
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => true, :views => false
      g.stylesheets false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  eos
end

directory("~/web_sites/rails-templates/sass-twitter-bootstrap/lib", "app/assets/stylesheets")

git :init
git :add => "."
git :commit => "-a -m 'create initial application'"
