desc 'Build all library for project'
task :run_project do
  value = `bundle install --with=development`
  value = `npm install`
  value = `rails db:drop`
  value = `rails db:create`
  value = `rails db:migrate`
  value = `rails db:seed`
end
