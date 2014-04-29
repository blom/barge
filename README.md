Barge
=====

Ruby library for version 2 of
[DigitalOcean's API](https://developers.digitalocean.com/).

### Installation

``` sh
gem install barge
```

Ruby 1.9 and up is required. See the
[.travis.yml](https://github.com/blom/barge/blob/master/.travis.yml) file for
a list of supported rubies.

### Initialize

``` ruby
barge = Barge::Client.new(access_token: 'token')
```

*or*

``` ruby
barge = Barge::Client.new do |config|
  config.access_token = 'token'
end
```

Resources
---------

### Droplet

You can also call e.g. `#destroy` below directly by providing a droplet id:

``` ruby
barge.droplet.destroy(droplet_id)
```

##### Create droplet

``` ruby
barge.droplet.create(options)
```

##### Show all droplets

``` ruby
barge.droplet.all
```

##### Find droplet

``` ruby
 barge.droplet.find(droplet_id)
```

##### Show droplet properties

``` ruby
droplet = barge.droplet.find(droplet_id)
droplet.properties # all
droplet.name       # droplet's name
```

##### Destroy droplet

``` ruby
droplet = barge.droplet.find(droplet_id)
droplet.destroy
```

##### Rename droplet

``` ruby
droplet = barge.droplet.find(droplet_id)
droplet.rename('new_name')
```

### Image

Coming.

### Domain

Coming.

### Key

Coming.

### Region

Coming.

### Size

Coming.
