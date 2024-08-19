const Gst.PluginDesc gst_plugin_desc = {
    Gst.VERSION_MAJOR, Gst.VERSION_MINOR,
    "gtkvideosinkwrapper",
    "Gtk Video Sink Wrapper plugin",
    plugin_init,
    "0.1",
    "LGPL",
    "http://",
    "Package?",
    "Origin?"
};

public static bool plugin_init(Gst.Plugin p)
{
    Gst.Element.register (p,"gtkvideosinkwrapper", Gst.Rank.NONE, typeof(Gst.GtkWrapper.VideoSinkWrapper));
    return true;
}

namespace Gst.GtkWrapper
{
    public class VideoSinkWrapper : Gst.Bin
    {
        protected Gst.Element sink;
        protected Gst.GhostPad pad;
        protected Gst.Video.Overlay overlay;
        public Gtk.Widget widget {get; private set;}
        uint *handle;

        class construct {
            set_static_metadata ("gtkvideosinkwrapper", "Generic", "Wrapper", "arne.caspari@theimagingsource.com");
        }

        construct {
            var args = new string[0];
            unowned string[] vargs = args;
            Gtk.init(ref vargs);
            sink = Gst.ElementFactory.make("waylandsink", null);
            this.add(sink);
            pad = new Gst.GhostPad(null, sink.sinkpads.first().data);
            this.add_pad(pad);
            widget = new Gtk.EventBox();
            widget.visible = true;
            widget.app_paintable = true;
            widget.vexpand = true;
            handle = null;
            widget.realize.connect (() => {
                Gdk.WaylandWindow window = widget.get_window() as Gdk.WaylandWindow;
                handle = (uint*) (window.get_wl_surface());
            });
            widget.draw.connect ( () => {
                Gtk.Allocation alloc = Gtk.Allocation();
                widget.get_allocation(out alloc);
                overlay.set_render_rectangle(alloc.x, alloc.y, alloc.width, alloc.height);
                return false;
            });            
            sink.bus.set_sync_handler((bus,message) => {
                if(Gst.Video.is_video_overlay_prepare_window_handle_message (message)) {
                    overlay = message.src as Gst.Video.Overlay;
                    assert (overlay != null);
                    if (handle != null) {
                        Gtk.Allocation alloc = Gtk.Allocation();
                        widget.get_allocation(out alloc);
                        overlay.set_window_handle (handle);
                        overlay.set_render_rectangle(alloc.x, alloc.y, alloc.width, alloc.height);
                    }  
                    return Gst.BusSyncReply.DROP;
                } else if (Gst.Wayland.is_wl_display_handle_need_context_message(message)) {
                    Gst.Element element = message.src as Gst.Element;
                    Gdk.WaylandDisplay gdk_display = widget.get_display() as Gdk.WaylandDisplay;
                    unowned Wl.Display display = gdk_display.get_wl_display();
                    Gst.Context context = Gst.Wayland.display_handle_context_new(display);
                    element.set_context(context);
                    return Gst.BusSyncReply.DROP;
                }
                return Gst.BusSyncReply.PASS;
            });
        }
    }
}
