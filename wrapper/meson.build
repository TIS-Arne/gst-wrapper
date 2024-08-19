

plugin_c_args = ['-DHAVE_CONFIG_H']

cdata = configuration_data()
cdata.set_quoted('PACKAGE_VERSION', gst_version)
cdata.set_quoted('PACKAGE', 'gst-template-plugin')
cdata.set_quoted('GST_LICENSE', 'LGPL')
cdata.set_quoted('GST_API_VERSION', api_version)
cdata.set_quoted('GST_PACKAGE_NAME', 'GStreamer template Plug-ins')
cdata.set_quoted('GST_PACKAGE_ORIGIN', 'https://gstreamer.freedesktop.org')
configure_file(output : 'config.h', configuration : cdata)


vala_dep = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gdk-3.0'),
  dependency('gtk+-3.0'),
  dependency('gee-0.8'),
  dependency('gstreamer-1.0'),
  dependency('gstreamer-base-1.0'),
  dependency('gstreamer-video-1.0'),
  dependency('gstreamer-wayland-1.0'),
  dependency('wayland-client')
]

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')

gstgtkvideosinkwrapper_sources = [
  'gstgtkvideosinkwrapper.vala',
  'gst.vapi',
  'gtk3-wayland.vapi'
#   '../vapi/gstreamer-1.0.vapi',
#   '../vapi/gstreamer-base-1.0.vapi',
#   '../vapi/gstreamer-video-1.0.vapi'
]

gstgtkvideosinkwrapper = library('gstgtkvideosinkwrapper',
  gstgtkvideosinkwrapper_sources,
  dependencies : [vala_dep, gst_dep, gstbase_dep, gstvideo_dep],
  install : true,
  install_dir : plugins_install_dir,
  include_directories: gst_inc,
  )
