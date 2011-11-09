# pixnet-sso

by Manic <http://tech.manic.tw>

## LINKS:

* [github](https://github.com/manic/pixnet-sso)
* [rubygems](http://rubygems.org/gems/pixnet-sso)

## DESCRIPTION:

Clients for PIXNET SSO

## INSTALLATION:

    gem install pixnet-sso 

## CONFIG:

Create a `config/initializers/pixnet-sso.rb` that looks like:

    PIXNET::SSO.config do |config|
        config.user_model = 'User'
        config.sso_key = ENV['SSO_KEY']
        config.sso_secret = ENV['SSO_SECRET']
    end

And set your PIXNET SSO key pair to your ENV.

## LOAD SCIRPTS IN YOUR LAYOUT:

Add `<%= pixnet_sso_scripts %>` in your `layout/application.html.erb` to enable PIXNET SSO.

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