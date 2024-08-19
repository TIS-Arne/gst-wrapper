project('gst-wrapper', 'vala', 'c', 'cpp', version : '1.17.0.1', license : 'LGPL')

vapi_dir = join_paths(meson.current_source_dir(), 'vapi')
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')

plugins_install_dir = join_paths(get_option('libdir'), 'gstreamer-1.0')

cc = meson.get_compiler('c')

gst_version = meson.project_version()

api_version = '1.0'

gst_args_cmd = run_command('pkg-config', '--cflags', 'gstreamer-1.0')
gst_args = gst_args_cmd.stdout().strip()

gst_dep = [
    cc.find_library('gstreamer-1.0'),
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
]

gst_inc = include_directories('/usr/include/gstreamer-1.0')

gstbase_dep = [
    cc.find_library('gstbase-1.0')]

gstvideo_dep = [
    cc.find_library('gstvideo-1.0')]

subdir('wrapper')

# if get_option('enable_cvconvert')
#     subdir('tiscvconvert')
# endif
