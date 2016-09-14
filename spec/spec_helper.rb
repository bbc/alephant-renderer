$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'pry'
require 'json'

require 'alephant/renderer'
require 'alephant/renderer/error/invalid_path'
require 'alephant/renderer/views'
require 'alephant/renderer/views/json'
require 'alephant/renderer/views/envelope'
require 'alephant/renderer/views/html'
require 'alephant/renderer/view_mapper'
require 'alephant/renderer/response'
