# estimate_moving

- A web application that calculates total volume of your household items.
- Perfect for preparing house moving.
- Easy to use on mobile devices as well as on larger devices.

---

## Planning

#### Wireframe

![](images/erd_planning.jpg)
![](images/wf_movings_index.jpg)
![](images/wf_movings_show.jpg)
![](images/wf_household_items_new.jpg)

#### User story

```yaml
Bronze:
  - Minimum Viable Product (MVP)
  - The bare necessities to be functional and meet requirements.
  - Does it meet the business requirements in order to start an effective feedback loop?

Silver:
  - Improve user experience
  - What can we push to the next iteration? Where can we add value?

Gold:
  - Nice-to-haves.
  - Next steps to maximize return on investment (ROI).
```

#### Bronze
- I want a table that displays all my household items.
- I want to be able to create multiple moving projects.
- I want to create/edit/delete household items from my moving projects.
- I want to obtain the total volume of each moving project.
- I want to add tags to household items.

#### Silver
- I want to see my moving data for each moving project as graphs/charts under each tag.
- I want to have my own account to manage my moving projects.
- I want my account to be private (invisible from other users).
- I want to create/edit/delete my moving projects from my account.

#### Gold
- I want to log in via Facebook or twitter.
- I want to be able to duplicate moving project as necessary.
- I want to be able to sort my table by tag, volume and name.
- I want to be able to filter my table by a search term.

---

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
# Bad example
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

---

## References
