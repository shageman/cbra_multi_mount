rm -rf cbra_multi_mount

rails new cbra_multi_mount \
  --skip-yarn                \
  --skip-keeps               \
  --skip-action-mailer       \
  --skip-active-record       \
  --skip-active-storage      \
  --skip-action-cable        \
  --skip-sprockets           \
  --skip-spring              \
  --skip-listen              \
  --skip-coffee              \
  --skip-javascript          \
  --skip-turbolinks          \
  --skip-test                \
  --skip-system-test         \
  --skip-bootsnap            \
  --no-rc

cd cbra_multi_mount

rails plugin new components/admin \
  --full                          \
  --mountable                     \
  --skip-gemfile                  \
  --skip-bundle                   \
  --skip-git                      \
  --skip-yarn                     \
  --skip-keeps                    \
  --skip-action-mailer            \
  --skip-active-record            \
  --skip-active-storage           \
  --skip-action-cable             \
  --skip-sprockets                \
  --skip-spring                   \
  --skip-listen                   \
  --skip-coffee                   \
  --skip-javascript               \
  --skip-turbolinks               \
  --skip-test                     \
  --skip-system-test              \
  --skip-bootsnap                 \
  --no-rc                         \
  --dummy-path=spec/dummy

gsed -i '/spec\.homepage/d' components/admin/admin.gemspec
gsed -i '/spec\.description/d' components/admin/admin.gemspec
gsed -i '/spec\.license/d' components/admin/admin.gemspec
gsed -i 's/TODO: //g' components/admin/admin.gemspec

rm -rf components/admin/app/mailers/admin/application_mailer.rb
rm -rf components/admin/app/models/admin/application_record.rb

bundle

cd components/admin

rails generate controller things index

echo '
<h1>Got Things</h1>
' > app/views/admin/things/index.html.erb

cd ../..

rails generate controller dashboard index

echo '
<h1>CBRA Multi Mount Dashboard</h1>

<%= link_to "admin1", admin1.things_index_path %>
<%= link_to "admin2", admin2.things_index_path %>
' > app/views/dashboard/index.html.erb

echo '
Rails.application.routes.draw do
  get "dashboard/index"

  mount Admin::Engine, at: "admin1", as: "admin1"
  mount Admin::Engine, at: "admin2", as: "admin2"

  root to: "dashboard#index"
end
' > config/routes.rb

rake routes
rails s