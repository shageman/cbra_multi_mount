# CBRA Multi Mount Discussion

This sample app discusses the possibility of mounting and engine twice within a Rails app.

This app is part of the discussion in the *Component-based Rails Applications* book. Get more info at [cbra.info](http://www.cbra.info).

## Rails 5.1 and newer

As the current version of the `cbra_multi_mount` app shows, it is now possible to mount an engine twice and have it work properly with routes and path helpers.

The app is available at http://cbra-multi-mount.herokuapp.com/

This is Rails' behavior for Rails 5.1 and up.


## Older than Rails 5.1

*To see this old behavior, check out version https://github.com/shageman/cbra_multi_mount/tree/8bb794e61e0e8e9ebf437b0a2be8e750c41ea7d8 of this app*

~~The app is available at http://cbra-multi-mount.herokuapp.com/~~

The homepage shows the first routing problem: path helpers are broken. Mounting an engine twice sets up all routes, i.e., both of these links work http://cbra-multi-mount.herokuapp.com/admin1/things and http://cbra-multi-mount.herokuapp.com/admin2/things. The links on the homepage illustrate that for the path helpers, the last resgistered path wins: http://cbra-multi-mount.herokuapp.com/

        ± |master ✓| → rake routes
                 Prefix Verb URI Pattern                Controller#Action
        dashboard_index GET  /dashboard/index(.:format) dashboard#index
                 admin1      /admin1                    Admin::Engine
                 admin2      /admin2                    Admin::Engine
                   root GET  /                          dashboard#index
        
        Routes for Admin::Engine:
            things GET    /things(.:format)          admin/things#index
                   POST   /things(.:format)          admin/things#create
         new_thing GET    /things/new(.:format)      admin/things#new
        edit_thing GET    /things/:id/edit(.:format) admin/things#edit
             thing GET    /things/:id(.:format)      admin/things#show
                   PATCH  /things/:id(.:format)      admin/things#update
                   PUT    /things/:id(.:format)      admin/things#update
                   DELETE /things/:id(.:format)      admin/things#destroy
                   
