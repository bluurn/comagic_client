# Comagic client

## Installation
1. Put this line to your Gemfile:
          gem 'comagic_client'
2. Run in your console:
          bundle install
## Usage

1) Login:

```ruby
  creds     = %w{email@example.com P455W0RD}
  connector = ComagicClient.new *creds
  connector.login
```

2) Get sites:

```ruby
  # Get all sites
  puts connector.site
  # Get all sites site by customer_id
  puts connector.site customer_id: 1337
```

3) Get ad campaigns (acs):

```ruby
    # Get all acs without site_id and customer_id specified
    puts connector.ac
    # Get all acs with site_id specified
    puts connector.ac  site_id: 1337
    # Get all acs with customer_id specified
    puts connector.ac  customer_id: 31337
    # Get all acs with site_id and customer_id specified
    puts connector.ac site_id: 1337, customer_id: 3l337
```

4) Get tags:

```ruby
    # Get all tags with no customer_id specified
    puts connector.tag
    # Get all tags with customer_id specified
    puts connector.tag customer_id: 31337
```

5) Get communications:

```ruby
    # Get all communications with customer_id, site_id, date_from and date_till
    puts connector.communication site_id: 1337, customer_id: 3l33t, date_from: '2014-12-01', date_till: '2014-12-31'
    # Get all communications with site_id, date_from and date_till
    puts connector.communication site_id: 1337, date_from: '2014-12-01', date_till: '2014-12-31'
```

6) Get stats:

```ruby
    # Get stat for site with customer_id, site_id, date_from and date_till
    puts connector.stat site_id: 1337, customer_id: 31337, date_from: '2014-12-01', date_till: '2014-12-31'
    # Get stat for site with site_id, date_from and date_till
    puts connector.stat site_id: 1337, date_from: '2014-12-01', date_till: '2014-12-31'
```

7) Get goals:

```ruby
    # Get goal for site with customer_id, site_id, date_from and date_till
    puts connector.goal site_id: 1337, customer_id: 31337, date_from: '2014-12-01', date_till: '2014-12-31'
    # Get goal for site with site_id, date_from and date_till
    puts connector.goal site_id: 1337, date_from: '2014-12-01', date_till: '2014-12-31'
```

8) Get calls:

```ruby
    # Get calls for site with customer_id, date_from and date_till
    puts connector.call customer_id: 31337, date_from: '2014-12-01', date_till: '2014-12-31'
    # Get calls for site with date_from and date_till
    puts connector.call  date_from: '2014-12-01', date_till: '2014-12-31'
```

9) Get chats:

```ruby
    puts connector.chat
```

10) Get chat messages:

```ruby
    puts connector.chat_message chat_id: 7855
```

11) Get offline messages:

```ruby
    puts connector.offline_message
```

12) Get person by visitor

```ruby
    puts connector.person_by_visitor customer_id: 31337, id: 777
```

13) Get visitors by person

```ruby
    puts connector.visitors_by_person customer_id: 31337, id: 666
```

14) Get visitor by id:

```ruby
    puts connector.visitor customer_id: 31337, visitor_id: 777
```

15) Get cdr_in by period:

```ruby
    puts connector.get_cdr_in date_from: '2014-12-01', date_till: '2014-12-31'
```

16) Get cdr_out by period:

```ruby
    puts connector.get_cdr_out date_from: '2014-12-01', date_till: '2014-12-31'
```

17) Create site:

```ruby
    puts "create site"
    data = {}
    data[:args] = { 
      domain: 'example.com',
      offline_email: 'qw@er.ty', 
      user_phone: '84955555555'
    }
    puts connector.create_site data
```

18) Logout:

```ruby
    connector.logout
```
