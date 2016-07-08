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
$ rails db:migrate
```

[Create a username field in the users table](https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address#create-a-username-field-in-the-users-table)

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

#### Adding a key-value pair for a form


```slim
= simple_form_for([moving, household_item], :url => { :type => "Hello" } ...
```

```
http://localhost:3000/movings/1/household_items?type=Hello
```

#### Read data from a file

```rb
module HouseholdItemsHelper

  def item_hash
    # Read a file.
    file = File.read(File.dirname(__FILE__) + '/household_items.json')

    # Convert JSON to Ruby Hash.
    data_hash = JSON.parse(file)
  end
end
```

#### jQuery ui-autocomplete

- [https://github.com/joliss/jquery-ui-rails](https://github.com/joliss/jquery-ui-rails)
- [https://jqueryui.com/autocomplete/](https://jqueryui.com/autocomplete/)

#### Charts/graphs

- [http://www.highcharts.com/](http://www.highcharts.com/)

####   [ActiveRecord::Enum](http://edgeapi.rubyonrails.org/classes/ActiveRecord/Enum.html)

#### Modal data is not updated after create/updated
- Check `strong params` whitelist.


#### FactoryGirl error: “Email has already been taken.”

- Use DatabaseCleaner

---

## References
