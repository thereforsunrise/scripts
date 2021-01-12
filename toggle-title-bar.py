#!/usr/bin/env ruby

require 'i3ipc'
require 'pp'

i3 = I3Ipc::Connection.new

pp i3.tree.nodes

i3.close

# import i3ipc
# impon
# i3 = i3ipc.Connection()

# print i3.get_tree()

# sys.exit
# border = i3.get_tree().find_focused().get_property("border")

# if border == "normal":
#   i3.command("border 1pixel")
# else:
#   i3.command("border normal")
