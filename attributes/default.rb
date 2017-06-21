#
# Cookbook:: bender_is_great
# Attibutes:: default
#

default['bender_is_great'].tap do |bender|
  bender['user'] = 'root'
  bender['group'] = 'root'
  bender['system_user'] = true

  # bender.html
  bender['author'] = 'Patrick Dayton'
  bender['html_title'] = 'Bender is Great!'
  bender['image_url'] = 'http://www.reactiongifs.us/wp-content/uploads/2016/04/remember_me_futurama.gif'
  bender['completion_message'] = 'REMEMBER ME!'

  # some bender_is_great shenanigans
  bender['server_alias'] = 'bender_is_great'
  bender['doc_root'] = '/var/www/html'
  bender['main_page'] = 'bender_is_great.html'

  # ports.conf shenanigans
  bender['ip_address'] = '0.0.0.0'
  bender['port'] = '80'
  bender['listen_address'] = node['bender_is_great']['ip_address'] + ':' + node['bender_is_great']['port']
end
