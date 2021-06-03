# "     srs_flv_parser          parse flv file, print detail info."
# "     srs_flv_injecter        inject keyframes information to metadata."
# "     srs_publish             publish program using srs-librtmp"
# "     srs_h264_raw_publish    publish raw h.264 stream to SSR by srs-librtmp"
# "     srs_audio_raw_publish   publish raw audio stream to SSR by srs-librtmp"
# "     srs_aac_raw_publish     publish raw aac stream to SSR by srs-librtmp"
# "     srs_play                play program using srs-librtmp"
# "     srs_ingest_flv          ingest flv file and publish to RTMP server."
# "     srs_ingest_mp4          ingest mp4 file and publish to RTMP server."
# "     srs_ingest_rtmp         ingest RTMP and publish to RTMP server."
# "     srs_detect_rtmp         detect RTMP stream info."
# "     srs_bandwidth_check     bandwidth check/test tool."
# "     srs_rtmp_dump           dump rtmp stream to flv file."
# "Remark: about simple/complex handshake, see: http://blog.csdn.net/win_lin/article/details/13006803"

set(TOOLS
    "srs_flv_parser"
    "srs_flv_injecter"
    "srs_publish"
    "srs_play"
    "srs_ingest_flv"
    "srs_ingest_rtmp"
    "srs_detect_rtmp"
    "srs_bandwidth_check"
    "srs_h264_raw_publish"
    "srs_audio_raw_publish"
    "srs_aac_raw_publish"
    "srs_rtmp_dump"
    "srs_ingest_mp4"
)

foreach(tool ${TOOLS})
    add_executable(${tool} ${tool}.c)
    target_link_libraries(${tool} srs-librtmp -lssl -lcrypto)
endforeach(tool)
