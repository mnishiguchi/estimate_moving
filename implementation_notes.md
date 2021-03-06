# Implementation notes

## Set up gems

#### rspec

```bash
$ rails generate rspec:install
```

Then, configure in `spec/rails_helper.rb` as an as-needed basis. (E.g., `shoulda/matchers`, `capybara/poltergeist`, devise, etc)

#### guard

```bash
$ guard init
```

#### simple form

```bash
$ rails generate simple_form:install --bootstrap

# Inside your views, use the 'simple_form_for' with one of the Bootstrap form
# classes, '.form-horizontal' or '.form-inline', as the following:
#
#   = simple_form_for(@user, html: { class: 'form-horizontal' }) do |form|
```

#### devise

- [wiki](http://devise.plataformatec.com.br/#the-devise-wiki)

```
$ rails generate devise:install
$ rails generate devise User
$ rails generate devise:views
```

Edit the migration file for `confirmable` etc.

```
$ rails db:migrate
```

[Create a username field in the users table](https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address#create-a-username-field-in-the-users-table)(optional)


Devise - ActionView::Template::Error (Missing host to link to! Please provide the :host parameter, set default_url_options[:host], or set :only_path to true):

- Make sure that you configure mailer for all three environments in `config/environments/*`.


Devise - Add confirmable to users later

- [Add confirmable to user](https://github.com/plataformatec/devise/wiki/How-To:-Add-:confirmable-to-Users)

---

## Set up database

```
rails g model Moving name description:text user:references
rails g model HouseholdItem name description:text moving:references
rails g model Tag name
rails g model ItemTag household_item:references tag:references
```

![](erd.jpg)

---

## Troubleshooting / ideas

#### Query for grandchildren, through a many to many relationship

I want to obtain all the tags that have a household item belonging to a specific moving, through a many to many relationship.

```rb
Tag.joins(household_items: :moving)
   .where(movings: {id: id})
   .select('DISTINCT tags.name')
   .order('tags.name')
```

```rb
# This works but it requires n queries.
household_items.map { |item| item.tags }.flatten.map(&:name).uniq
```

[Select values through many to many relationship in active record using “where”](http://stackoverflow.com/a/21563632/3837223)


#### Showing error messages in flash

```rb
flash.now[:danger] = @household_item.errors.full_messages.to_sentence
```


#### Get the referer url of a previous page

```rb
request.referer
```


#### Jumping to an anchor after redirect

```rb
redirect_to moving_url(@moving, anchor: 'add_item')
```


#### Adding custom params to query string in a form

```slim
= simple_form_for([moving, household_item], :url => { :type => "Hello" } ...
```

```
http://localhost:3000/movings/1/household_items?type=Hello
```


#### Modal data is not updated after create/updated
- Check `strong params` whitelist.


#### FactoryGirl error: “Email has already been taken.”

- Use DatabaseCleaner


#### ActiveRecord/Store vs PostgreSQL json vs PostgreSQL hstore
- [ActiveRecord/Store](http://api.rubyonrails.org/classes/ActiveRecord/Store.html)

#### ActiveRecord - converting a query result hash

Create an array of hashes

```rb
DefaultVolume.all.map(&:attributes)
```

Create a hash from an array of key-value arrays

```rb
Hash[DefaultVolume.pluck(:name, :volume)]
```

```rb
DefaultVolume.pluck(:name, :volume).to_h
```

#### Load seed file in test

```rb
load "#{Rails.root}/db/seeds.rb"
```

or

```rb
Rails.application.load_seed
```

#### Problems I had when setting up minitest-rails-capybara
- could not install minitest-rails-capybara due to conflict with quiet_assets
- error raised due to conflict with minitest-reporters
  + https://github.com/kern/minitest-reporters/issues/142
