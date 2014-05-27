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
=========

General
-------

### Hashie::Mash

[Hashie::Mash](https://github.com/intridea/hashie) is used so that attributes
can be accessed using dot notation:

``` ruby
droplet = barge.droplet.show(droplet_id)
droplet.name       # => "foo"
droplet.image.id   # => 123
droplet.size!.cpus # => 1
```

Notice that `size!` and not `size` was used. This is because `size` already is
a method, and Hashie::Mash will not override it. You can also use square
brackets:

``` ruby
droplet[:size][:cpus]   # => 1
droplet['size']['cpus'] # => 1
```

### success?

You can use `success?` to check if a successful HTTP status code was returned:

``` ruby
barge.droplet.create(options).success? # => true
```

Droplet
-------

### Create droplet

``` ruby
barge.droplet.create(options)
```

### Show all droplets

``` ruby
barge.droplet.all
```

### Show droplet

``` ruby
barge.droplet.show(droplet_id)
```

### Destroy droplet

``` ruby
barge.droplet.destroy(droplet_id)
```

### Rename droplet

``` ruby
barge.droplet.rename(droplet_id, 'new name')
```

### Reboot droplet

``` ruby
barge.droplet.reboot(droplet_id)
```

### Shutdown droplet

``` ruby
barge.droplet.shutdown(droplet_id)
```

### Power off droplet

``` ruby
barge.droplet.power_off(droplet_id)
```

### Power cycle droplet

``` ruby
barge.droplet.power_cycle(droplet_id)
```

### Power on droplet

``` ruby
barge.droplet.power_on(droplet_id)
```

### Resize droplet

``` ruby
barge.droplet.resize(droplet_id, 'size slug')
```

### Rebuild droplet

``` ruby
barge.droplet.rebuild(droplet_id, image_id)
```

### Restore droplet

``` ruby
barge.droplet.restore(droplet_id, image_id)
```

### Reset a droplet's password

``` ruby
barge.droplet.password_reset(droplet_id)
```

Image
-----

Coming.

Domain
------

Coming.

Key
---

Coming.

Region
------

Coming.

Size
----

Coming.
