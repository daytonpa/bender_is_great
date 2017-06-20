#
# Cookbook:: bender_is_great
# Attibutes:: default
#

default['bender_is_great'].tap do |bender|
  bender['user'] = 'root'
  bender['group'] = 'root'

  # bender.html attributes
  bender['html_title'] = 'Bender is Great!'
  bender['image_url'] = 'http://www.reactiongifs.us/wp-content/uploads/2016/04/remember_me_futurama.gif'
  bender['completion_message'] = 'REMEMBER ME!'
end
