# pixnet-sso

by Manic <http://tech.manic.tw>

## LINKS:

* [github](https://github.com/manic/pixnet-sso)
* [rubygems](http://rubygems.org/gems/pixnet-sso)

## DESCRIPTION:

Clients for PIXNET SSO, Rails Gem

## INSTALLATION:

    gem install pixnet-sso 

## ENABLE PIXNET SSO:

### GENERATE CONFIG/MODEL:

Execute `rails g pixnet_sso:install`, and follow the question it asks you.

It will generate `config/initializers/pixnet-sso.rb`, edit it to insert your SSO key pair of PIXNET.

### LOAD SCIRPTS IN YOUR LAYOUT:

Add `<%= pixnet_sso_scripts %>` in your `layout/application.html.erb` to enable PIXNET SSO.

### ADD CONTROLLER METHODS IN YOUR APPLCATION

Add code in your `app/controllers/application_controller`:

    include Pixnet::SSO::ControllerMethods
    include Pixnet::SSO::OpenidControllerMethods #if you enabled openid

## LICENSE:

Apache License 2.0

Copyright (c) 2011, PIXNET

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.