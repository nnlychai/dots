# Dither and desaturate images
# Inspired by https://flower.codes/2022/03/23/backwards-compatibility.html
#
# @usage
# dither image.png
# dither_bw image.png

function dither -a image -a bw
    if test $bw
        convert $image -verbose -format GIF -interlace GIF -resize 640\> -colorspace gray -colors 4 -ordered-dither 8x8 -set filename:f "%[t]_dithered" "%[filename:f].gif"
    else
        convert $image -verbose -format GIF -interlace GIF -resize 640\> -ordered-dither 8x8 -set filename:f "%[t]_dithered" "%[filename:f].gif"
    end
end
