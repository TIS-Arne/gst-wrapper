[CCode(cheader_filename = "gst/gst.h")]
namespace Gst {
  [CCode(cname="GST_LOG", cheader_filename = "gst/gst.h")]
  public extern void gst_log (string format, ...);

  [CCode(cname="GST_LOG_OBJECT", cheader_filename = "gst/gst.h", simple_generics = true)]
  [PrintfFormat]
  public extern void gst_log_obj<T>(T obj, string format, ...);
}
