import gi

gi.require_version("Gtk", "3.0")
gi.require_version("Gst", "1.0")

from gi.repository import Gtk, Gst


Gst.init()
Gtk.init()

window = Gtk.Window()

pipeline = Gst.parse_launch("videotestsrc ! gtkvideosinkwrapper name=sink")
sink = pipeline.get_by_name("sink")
box = Gtk.Box()
window.add(box)
widget = sink.get_property("widget")
box.pack_start(widget, True, True, 0)
window.show_all()
window.connect("destroy", lambda *x: Gtk.main_quit())

pipeline.set_state(Gst.State.PLAYING)
Gtk.main()
pipeline.set_state(Gst.State.NULL)
pipeline.get_state(10 * Gst.SECOND)
