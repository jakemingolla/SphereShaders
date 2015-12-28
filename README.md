# Sphere Shaders


**Jake Mingolla**

**December 2015**

**Category: Computer Graphics**

**Languages: Processing/Java & GLSL**


### About


### Screenshots
![yNoise](http://i.imgur.com/asTyeW5.gif)
The above gif demonstrates the effect of changing the noise with a fixed interval. The pseudo-sphere begins to arc in a sinusoidal pattern in relation to the Y axis.

![zNoiseAndSpacing](http://i.imgur.com/YpLKrvq.gif)
In the above gif, the spacing of the pseudo-sphere is increased in order to show how the geometry shader handles individual faces through quads. Then, the Z noise is increased to show the rippling effect with high spacing.

![explode](http://i.imgur.com/Mkrv0Fj.gif)
This gif first shows the effect of the explode parameter, as a sphere with no spacing increases outwards towards screen. Then the point light is enabled and it follows the cursor (Note: cursor not shown in this gif)

![detail](http://i.imgur.com/3S8NciM.gif)
The above gif shows the effect of increasing the detail on a pseudo-shpere with a relatively pronounced X noise and interval. The detail parameter controls how many levels of triangle strips are created during sphere creation with 10 being the default minimum and 500 being the default maximum.

I chose a minimum of 10 levels in order to avoid degenerate cases with extreme levels of noise and intervals with few faces to make them up, but this can be lowered in the source code. My setup could not handle a detail parameter over 760, so I moved the detail value down to compensate.

Also note the presence of compression artifacts in the center of the image - the color gradient is far smoother but the screen capture program I used introduced lots of compression.

![detailThenSpacing](http://i.imgur.com/dYC1lOJ.gif)
In the above gif, first the detail is increased from minimum to maximum value, then the spacing is reduced to the lowest possible setting. This shows the progression from a low poly pseudo-sphere to an extremely smooth rendering. Note that the noise and interval settings remained constant throughout this gif to show these settings in isolation.

![pointLight](http://i.imgur.com/pGbP2RD.gif)
This gif shows the effect of the point light mode. The lighting follows the mouse cursor across the pseudo-shpere to provide a smooth lighting gradient. Note that this is handled entirely through the basic-lighting.vert shader.

![ripple](http://i.imgur.com/ZFqygkQ.gif)
This gif shows a slowly rippling pseudo-sphere with lots of Z noise and a short Z interval with relatively little interaction in the X and Y spaces.


### Dependencies
- [Processing](https://processing.org/) version 1.5.1
- [GLGraphics](http://glgraphics.sourceforge.net/) version 1.0
- [controlP5](http://www.sojamo.de/libraries/controlP5/) version 1.5.2

### Notes
- Screen recordings where done through [byzanz-record](http://manpages.ubuntu.com/manpages/wily/man1/byzanz-record.1.html). I would highly recommend it to capture .gif files from a display.