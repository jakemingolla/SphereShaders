# Sphere Shaders


**Jake Mingolla**

**December 2015**

**Category: Computer Graphics**

**Languages: Processing/Java & GLSL**


### About

This project creates a sandbox for pseudo-sphere rendering with support for sinusoidal transformations, vertex spacing, changing color palettes, and level of detail adjustments. There are also modes to enable "explosion" mode in which the pseudo-sphere is slowly expanded/contracted as well as "pointlight" mode in which the mouse cursor overrides the direct lighting.

The sinusoidal transformations are implemented in the sphere-wave.geom geometry shader and take in uniform values set by the sliders. For each of the X, Y and Z axes, the interval and noise control the sine transformation. A shorter interval reduces the period of the wave and creates more concentrated waves whereas a longer wave creates a more gradual rate of change. The noise value controls the amplitude of the wave as a scalar.

The color palette controlling sliders dictate the levels of red, green, and blue of the GLModel holding the vertex list. This RGB tint is passed in to the basic-lighting.frag fragment shader.

The detail and radius values control the level of detail of the sphere. Changing these causes the sphere to 

On my setup of a non-overclocked Intel i5-4690k and Nvidia GTX 980 the rendering can maintain 60 FPS throughout the simulation. Rapidly changing the level of detail slider at the maximum radius causes to a slight dip to ~40 FPS due to the sudden poor cache performance due to the vertex and normal lists being dumped.

For a full understanding of how the transformations are applied, the file data/sphere-wave.geom implements all aspects of both the sinusoidal transformations as well as the explode and spacing values.


### Screenshots

# NOTE: These .gif files are quite large (about 5 mb each) and may require ~15 seconds to finish loading on a slow connection. For a README without embedded images and only links, look ***HERE PLACEHOLDER ***.

![yNoise](https://raw.githubusercontent.com/jakemingolla/SphereShaders/master/public/optimized/ynoise.gif)
The above gif demonstrates the effect of changing the noise with a fixed interval. The pseudo-sphere begins to arc in a sinusoidal pattern in relation to the Y axis.

![zNoiseAndSpacing](https://raw.githubusercontent.com/jakemingolla/SphereShaders/master/public/optimized/spacingThenZNoise.gif)
In the above gif, the spacing of the pseudo-sphere is increased in order to show how the geometry shader handles individual faces through quads. Then, the Z noise is increased to show the rippling effect with high spacing.

![explode](https://raw.githubusercontent.com/jakemingolla/SphereShaders/master/public/optimized/explode.gif)
This gif first shows the effect of the explode parameter as a sphere with no spacing increases outwards towards screen. Then the point light is enabled and it follows the cursor (Note: cursor not shown in this gif)

![detail](https://raw.githubusercontent.com/jakemingolla/SphereShaders/master/public/optimized/detail.gif)
The above gif shows the effect of increasing the detail on a pseudo-shpere with a relatively pronounced X noise and interval. The detail parameter controls how many levels of triangle strips are created during sphere creation with 10 being the default minimum and 500 being the default maximum.

I chose a minimum of 10 levels in order to avoid degenerate cases with extreme levels of noise and intervals with few faces to make them up, but this can be lowered in the source code. My setup could not handle a detail parameter over 760, so I moved the detail value down to compensate.

Also note the presence of compression artifacts in the center of the image - the color gradient is far smoother but the screen capture program I used introduced lots of compression.

>![detailThenSpacing](https://raw.githubusercontent.com/jakemingolla/SphereShaders/master/public/optimized/detailThenSmooth.gif)
In the above gif, first the detail is increased from minimum to maximum value, then the spacing is reduced to the lowest possible setting. This shows the progression from a low poly pseudo-sphere to an extremely smooth rendering. Note that the noise and interval settings remained constant throughout this gif to show these settings in isolation.

![pointLight](https://raw.githubusercontent.com/jakemingolla/SphereShaders/master/public/optimized/pointlight.gif)
This gif shows the effect of the point light mode. The lighting follows the mouse cursor across the pseudo-shpere to provide a smooth lighting gradient. Note that this is handled entirely through the basic-lighting.frag shader.

![ripple](https://raw.githubusercontent.com/jakemingolla/SphereShaders/master/public/optimized/back.gif)
This gif shows a slowly rippling pseudo-sphere with lots of Z noise and a short Z interval with relatively little interaction in the X and Y spaces.


### Dependencies
- [Processing](https://processing.org/) version 1.5.1
- [GLGraphics](http://glgraphics.sourceforge.net/) version 1.0
- [controlP5](http://www.sojamo.de/libraries/controlP5/) version 1.5.2

### Notes
- Screen recordings where done through [byzanz-record](http://manpages.ubuntu.com/manpages/wily/man1/byzanz-record.1.html). I would highly recommend it to capture .gif files from a display.