Barge
=====

[![Gem Version](http://img.shields.io/gem/v/barge.svg)][gem]
[![Build Status](http://img.shields.io/travis/boats/barge.svg)][travis]
[![Coverage Status](http://img.shields.io/coveralls/boats/barge.svg)][coveralls]
[![Code Climate](http://img.shields.io/codeclimate/github/boats/barge.svg)][codeclimate]
[![Dependency Status](http://img.shields.io/gemnasium/boats/barge.svg)][gemnasium]

[gem]: http://rubygems.org/gems/barge
[travis]: https://travis-ci.org/boats/barge
[coveralls]: https://coveralls.io/r/boats/barge
[codeclimate]: https://codeclimate.com/github/boats/barge
[gemnasium]: https://gemnasium.com/boats/barge

Ruby library for [version 2 of DigitalOcean's
API](https://github.com/digitaloceancloud/api-v2-docs).

**Please note that version 2 of DigitalOcean's API is in beta, and is still
being developed. Everything is subject to change.**

### Installation

``` sh
gem install barge
```

Ruby 1.9 and up is required. See the [.travis.yml](.travis.yml) file for a list
of supported rubies.

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
droplet.name        # => "foo"
droplet.image.id    # => 123
droplet.size!.vcpus # => 1
```

Notice that `size!` and not `size` was used. This is because `size` already is
a method, and Hashie::Mash will not override it. You can also use square
brackets:

``` ruby
droplet[:size][:vcpus]   # => 1
droplet['size']['vcpus'] # => 1
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

See the [API documentation][droplet-create] for options.

[droplet-create]: https://github.com/digitaloceancloud/api-v2-docs#droplet-create-a-new-droplet-post

### Show all droplets

``` ruby
barge.droplet.all
```

### Show droplet

``` ruby
barge.droplet.show(droplet_id)
```

### Show droplet backups

``` ruby
barge.droplet.backups(droplet_id)
```

### Show droplet snapshots

``` ruby
barge.droplet.snapshots(droplet_id)
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

Where *size slug* is for example `1024mb`.

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

### Show droplet action

``` ruby
barge.droplet.show_action(droplet_id, action_id)
```

Image
-----

### Show all images

``` ruby
barge.image.all
```

### Show image

By ID:

``` ruby
barge.image.show(image_id)
```

By image slug (public images):

``` ruby
barge.image.show('image slug')
```

Where *image slug* is for example `ubuntu-13-10-x64`.

### Update image

``` ruby
barge.image.update(image_id, options)
```

See the [API documentation][image-update] for options.

[image-update]: https://github.com/digitaloceancloud/api-v2-docs#images-update-an-image-put

### Destroy image

``` ruby
barge.image.destroy(image_id)
```

### Transfer image

``` ruby
barge.image.transfer(image_id, 'region slug')
```

Where *region slug* is for example `sfo1`.

### Show image action

``` ruby
barge.image.show_action(image_id, action_id)
```

Domain
------

### Create domain

``` ruby
barge.domain.create(options)
```

See the [API documentation][domain-create] for options.

[domain-create]: https://github.com/digitaloceancloud/api-v2-docs#domains-create-a-new-domain-post

### Show all domains

``` ruby
barge.domain.all
```

### Show domain

``` ruby
barge.domain.show(domain_name)
```

### Destroy domain

``` ruby
barge.domain.destroy(domain_name)
```

### Create domain record

``` ruby
barge.domain.create_record(domain_name, options)
```

See the [API documentation][domain-create-record] for options.

[domain-create-record]: https://github.com/digitaloceancloud/api-v2-docs#domain-records-create-a-new-domain-record-post

### Show all domain records

``` ruby
barge.domain.records
```

### Show domain record

``` ruby
barge.domain.show_record(domain_name, record_id)
```

### Update domain record

``` ruby
barge.domain.update_record(domain_name, record_id, options)
```

### Destroy domain record

``` ruby
barge.domain.destroy_record(domain_name, record_id)
```

Key
---

### Create key

``` ruby
barge.key.create(options)
```

See the [API documentation][key-create] for options.

[key-create]: https://github.com/digitaloceancloud/api-v2-docs#keys-create-a-new-key-post

### Show all keys

``` ruby
barge.key.all
```

### Show key

``` ruby
barge.key.show(key_id_or_fingerprint)
```

### Destroy key

``` ruby
barge.key.destroy(key_id)
```

Region
------

### Show all regions

``` ruby
barge.region.all
```

Size
----

### Show all sizes

``` ruby
barge.size.all
```
