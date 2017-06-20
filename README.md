# bender_is_great

![Bender](http://images2.wikia.nocookie.net/__cb20101105224425/villains/images/thumb/5/51/Bender.jpg/332px-Bender.jpg)

### Description
This cookbook is meant to show the Web Team the glorious glories of Chef through
the mutual love of Bender.  By the end of the converge, you will be able to view
a webpage with the almighty Bender, because Bender is great!  Destroy All Humans!

(still in progress.... tehehe)

### Usage
* ##### First run:
  * Download the and install latest ChefDK at ```https://chef.io```
  * Pull the latest version of this repository into your cookbooks folder inside of your chef-repo.
  * Run ```kitchen converge``` inside the ```bender_is_great``` folder within your terminal.
  * Sit back and watch Chef do its magic.

* ##### Second run:
  * Chef scans your system for idempotency during a converge, meaning it will verify to see each resource is in its desired state.
  * If a resource is in its desired state, Chef will skip that resource and move onto the next one.
  * Your second ```kitchen converge``` command should complete exponentially faster.

### Attributes
All attributes are currently set to their default inside the ```attributes/default.rb``` file.  Feel free to play around with these attributes to see how Chef manipulates resources with attributes assigned to them.
* ```node['bender_is_great']['html_title']``` will change the webpage's header title.
* ```node['bender_is_great']['image_url']``` will accept a url to an image.
* ```node['bender_is_great']['completion_message']``` accepts a string and displays it as a message.

### Unit Tests
All Unit tests are performed by ChefSpec, and can be viewed inside the ```spec/unit/recipes/``` folder.  ChefSpec scans each recipe with its respective spec file.
* ```spec/unit/recipes/default_spec.rb``` scans ```recipes/default.rb```
* ```spec/unit/recipes/bender_spec.rb``` scans ```recipes/bender.rb```

ChefSpec doesn't check for network connections, security, etc.  Its purpose is to verify each recipe is going to do exacyly what you tell it to do.  As illustrated below, here is a snippet of our ```default.rb``` recipe and our ```default_spec.rb``` spec file.

```
# recipes/default.rb

case node['platform']
when 'ubuntu'
  include_recipe 'apt'
when 'centos'
  include_recipe 'yum'
else
  log 'This is the worst kind of discrimination there is: the kind against me!' do
    message <<-EOD
    The platform #{node['platform']} isn't supported.  Please choose between
    centos or ubuntu.
    EOD
    level :warn
  end
end

# spec/unit/recipes/default_spec.rb

it "does not discriminate against Bender's desired OS" do
  expect(chef_run).to_not write_log('This is the worst kind of discrimination there is: the kind against me!').with(
    level: :info
  )
end
```

### .kitchen.yml
This is our configuration file for spinning up machines with Chef.  Feel free to change between platforms to see how Chef will install each resource depending on the desired platforms.  By default, we are using ubuntu.

```
platforms:
  - name: ubuntu-16.04
  # - name: centos-7.3
```

### metadata.rb
This is our primary cookbook dependency file.  You can include other community-built or your own cookbooks as dependencies to utilize customized resources within your recipes.  We currently have 2 dependencies on community-built cookbooks:

```
depends 'apt'
depends 'yum'
```

There are a ton of fully tested and working cookbooks located [HERE](https://supermarket.chef.io/dashboard) at the Chef Supermarket.
