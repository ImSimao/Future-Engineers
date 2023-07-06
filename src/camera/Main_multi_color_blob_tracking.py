# Multi Color Blob Tracking Example
#
# This example shows off multi color blob tracking using the OpenMV Cam.

import sensor, image, time, math, pyb


# Color Tracking Thresholds (L Min, L Max, A Min, A Max, B Min, B Max)
# The below thresholds track in general red/green things. You may wish to tune them...
green_blobs = [
     #(31, 46, -21, -7, -17, 6), #Green
     #(47, 82, -128, -36, -128, 127),  #Green Led
     #(0, 100, -38, -12, -128, 127) # Green Lonje 1
    (0, 100, -128, -14, -128, 127)
   ] # generic_blue_thresholds


red_blobs = [
    #(18, 52, 35, 56, 10, 32), #Red
    #(0, 100, 41, 71, -128, 127), #Red Led
    #(28, 41, 28, 45, -128, 127), #Red Lonje
    #(12, 73, 17, 45, -128, 127), # Red Lonje 1
    #(24, 36, 13, 32, -2, 26), #Red
    #(29, 59, 40, 84, -32, 16),
    #(19, 37, 51, 14, 37, -49)
    #(17, 39, 38, 127, -26, 127)
    #(17, 39, 17, 127, -26, 127)
    (50, 23, 47, 62, -80, 31),
    (44, 0, 12, 59, -11, 11)
    ] # generic_blue_thresholds


# You may pass up to 16 thresholds above. However, it's not really possible to segment any
# scene with 16 thresholds before color thresholds start to overlap heavily.

sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.skip_frames(time = 2000)
sensor.set_auto_gain(False) # must be turned off for color tracking
sensor.set_auto_whitebal(False) # must be turned off for color tracking
sensor.set_vflip(True)
sensor.set_hmirror(True)
clock = time.clock()


p0 = pyb.Pin("P0", pyb.Pin.OUT_PP)
p1 = pyb.Pin("P1", pyb.Pin.OUT_PP)
p2 = pyb.Pin("P2", pyb.Pin.OUT_PP)
p3 = pyb.Pin("P3", pyb.Pin.OUT_PP)

# Only blobs that with more pixels than "pixel_threshold" and more area than "area_threshold" are
# returned by "find_blobs" below. Change "pixels_threshold" and "area_threshold" if you change the
# camera resolution. Don't set "merge=True" becuase that will merge blobs which we don't want here.

while(True):
    clock.tick()
    img = sensor.snapshot()

    blob_detected = False
    largest_blob = False
    is_red_blob = False

    for blob in img.find_blobs(green_blobs, pixels_threshold=500, area_threshold=500, merge=True):
        if (blob.cy() < img.height()/3):
            continue

        if (blob.h() < 33 or blob.w() < 15):
            continue

        # These values depend on the blob not being circular - otherwise they will be shaky.
        if largest_blob is False or blob.cy() > largest_blob.cy():
            largest_blob = blob

        img.draw_edges(blob.min_corners(), color=(255,0,0))
        img.draw_line(blob.major_axis_line(), color=(0,255,0))
        img.draw_line(blob.minor_axis_line(), color=(0,0,255))
        # These values are stable all the time.
        img.draw_rectangle(blob.rect())
        img.draw_cross(blob.cx(), blob.cy())
        # Note - the blob rotation is unique to 0-180 only.
        img.draw_keypoints([(blob.cx(), blob.cy(), int(math.degrees(blob.rotation())))], size=20)
        blob_detected=True

    for blob in img.find_blobs(red_blobs, pixels_threshold=500, area_threshold=500, merge=True):
        if (blob.cy() < img.height()/3):
            continue

        if (blob.h() < 33 or blob.w() < 15):
            continue

        # These values depend on the blob not being circular - otherwise they will be shaky.
        if largest_blob is False or blob.cy() > largest_blob.cy():
            largest_blob = blob
            is_red_blob = True

        img.draw_edges(blob.min_corners(), color=(255,0,0))
        img.draw_line(blob.major_axis_line(), color=(0,255,0))
        img.draw_line(blob.minor_axis_line(), color=(0,0,255))
        # These values are stable all the time.
        img.draw_rectangle(blob.rect())
        img.draw_cross(blob.cx(), blob.cy())
        # Note - the blob rotation is unique to 0-180 only.
        img.draw_keypoints([(blob.cx(), blob.cy(), int(math.degrees(blob.rotation())))], size=20)
        blob_detected=True

    if blob_detected is False:
        p0.low()
        p1.low()
        p2.low()
        p3.low()

    else:
        if is_red_blob is True:
            p0.high()
        else:
            p0.low()

        if largest_blob.cx() > img.width()/3*2:
            p1.high()
            p2.low()
            p3.low()
        elif largest_blob.cx() < img.width()/3:
            p1.low()
            p2.low()
            p3.high()
        else:
            p1.low()
            p2.high()
            p3.low()
