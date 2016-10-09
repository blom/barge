Barge
=====

[![Gem Version](https://img.shields.io/gem/v/barge.svg)][gem]
[![Build Status](https://img.shields.io/travis/blom/barge/master.svg)][travis]
[![Coverage Status](https://img.shields.io/coveralls/blom/barge.svg)][coveralls]
[![Code Climate](https://img.shields.io/codeclimate/github/blom/barge.svg)][codeclimate]
[![Dependency Status](https://img.shields.io/gemnasium/blom/barge.svg)][gemnasium]

[gem]: https://rubygems.org/gems/barge
[travis]: https://travis-ci.org/blom/barge
[coveralls]: https://coveralls.io/r/blom/barge
[codeclimate]: https://codeclimate.com/github/blom/barge
[gemnasium]: https://gemnasium.com/blom/barge

Ruby library for [version 2 of DigitalOcean's
API](https://developers.digitalocean.com/documentation/v2/).

### Installation

``` sh
gem install barge
```

Ruby 1.9.3 and up is required. See the [.travis.yml](.travis.yml) file for a
list of supported rubies.

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
droplet.droplet.name       # => "foo"
droplet.droplet.image.id   # => 123
droplet.droplet.size!.slug # => "512mb"
```

Notice that `size!` and not `size` was used. This is because `size` already is
a method, and Hashie::Mash will not override it. You can also use square
brackets:

``` ruby
droplet[:droplet][:size][:slug]    # => "512mb"
droplet['droplet']['size']['slug'] # => "512mb"
```

See the [API documentation on responses][api-responses] if you are wondering
why attributes are contained within a `droplet` key.

[api-responses]: https://developers.digitalocean.com/documentation/v2/#responses

### #success?

You can use `#success?` to check if a successful HTTP status code was returned:

``` ruby
barge.droplet.create(options).success? # => true
```

### #response

Barge uses [Faraday][faraday]. You can use `#response` to get to the [response
object][faraday-response]:

``` ruby
barge.droplet.show(droplet_id).response # => Faraday::Response
```

[faraday]: https://github.com/lostisland/faraday
[faraday-response]: http://rubydoc.info/gems/faraday/Faraday/Response

Pagination
----------

For [paginated resources][api-links], a maximum of 200 objects are returned by
default (the maximum allowed by the API).

### Limit objects per page and/or get a specific page

``` ruby
barge.image.all(per_page: 10, page: 2)
```

[api-links]: https://developers.digitalocean.com/documentation/v2/#links

### Check if a response is paginated

``` ruby
barge.action.all.paginated? # => true
barge.region.all.paginated? # => false
```

### Get the previous page number

``` ruby
barge.image.all(per_page: 5, page: 2).prev_page # => 1
```

### Get the next page number

``` ruby
barge.image.all(per_page: 5, page: 2).next_page # => 3
```

### Get the last page number

``` ruby
barge.image.all(per_page: 5, page: 2).last_page # => 8
```

Account
-------

### Show account information

``` ruby
barge.account.show
```

Action
------

### Show all actions

``` ruby
barge.action.all
```

### Show action

``` ruby
barge.action.show(action_id)
```

Droplet
-------

### Create droplet

``` ruby
barge.droplet.create(options)
```

See the [API documentation][droplet-create] for options.

[droplet-create]: https://developers.digitalocean.com/documentation/v2/#create-a-new-droplet

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

### Show droplet kernels

``` ruby
barge.droplet.kernels(droplet_id)
```

### Show droplet snapshots

``` ruby
barge.droplet.snapshots(droplet_id)
```

### Create snapshot

``` ruby
barge.droplet.snapshot(droplet_id, name: 'image name')
```

### Destroy droplet

``` ruby
barge.droplet.destroy(droplet_id)
```

### Rename droplet

``` ruby
barge.droplet.rename(droplet_id, name: 'new name')
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
barge.droplet.resize(droplet_id, size: 'size slug')
```

Where *size slug* is for example `1024mb`.

### Rebuild droplet

``` ruby
barge.droplet.rebuild(droplet_id, image: image_id)
```

### Restore droplet

``` ruby
barge.droplet.restore(droplet_id, image: image_id)
```

### Reset a droplet's password

``` ruby
barge.droplet.password_reset(droplet_id)
```

### Change a droplet's kernel

``` ruby
barge.droplet.change_kernel(droplet_id, kernel: kernel_id)
```

### Enable IPv6 for a droplet

``` ruby
barge.droplet.enable_ipv6(droplet_id)
```

### Disable backups for a droplet

``` ruby
barge.droplet.disable_backups(droplet_id)
```

### Enable private networking for a droplet

``` ruby
barge.droplet.enable_private_networking(droplet_id)
```

### Show droplet actions

``` ruby
barge.droplet.actions(droplet_id)
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
barge.image.all(private: true)
barge.image.all(type: :application)
barge.image.all(type: :distribution)
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

[image-update]: https://developers.digitalocean.com/documentation/v2/#update-an-image

### Destroy image

``` ruby
barge.image.destroy(image_id)
```

### Transfer image

``` ruby
barge.image.transfer(image_id, region: 'region slug')
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

[domain-create]: https://developers.digitalocean.com/documentation/v2/#create-a-new-domain

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

[domain-create-record]: https://developers.digitalocean.com/documentation/v2/#create-a-new-domain-record

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

[key-create]: https://developers.digitalocean.com/documentation/v2/#create-a-new-key

### Show all keys

``` ruby
barge.key.all
```

### Show key

``` ruby
barge.key.show(key_id_or_fingerprint)
```

### Update key

``` ruby
barge.key.update(key_id_or_fingerprint, options)
```

See the [API documentation][key-update] for options.

[key-update]: https://developers.digitalocean.com/documentation/v2/#update-a-key

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

Floating IP
-----------

### Show all floating IPs

``` ruby
barge.floating_ip.all
```

### Create floating IP

``` ruby
barge.floating_ip.create(droplet_id: droplet_id)
barge.floating_ip.create(region: region)
```

### Show floating IP

``` ruby
barge.floating_ip.show(ip_address)
```

### Destroy floating IP

``` ruby
barge.floating_ip.destroy(ip_address)
```

### Assign a floating IP to a droplet

``` ruby
barge.floating_ip.assign(ip_address, droplet_id: droplet_id)
```

### Unassign a floating IP

``` ruby
barge.floating_ip.unassign(ip_address)
```

Volume (aka Block Storage)
-----------

### Show all volumes

``` ruby
barge.volume.all
barge.volume.all(region: 'nyc1')
```

### Create volume

``` ruby
barge.volume.create(
  size_gigabytes: 10,
  name: "Example",
  description: "Block store for examples",
  region: "nyc1"
)
```

### Show volume

``` ruby
barge.volume.show(volume_id)
```

### Destroy volume

``` ruby
barge.volume.destroy(volume_id)
```
