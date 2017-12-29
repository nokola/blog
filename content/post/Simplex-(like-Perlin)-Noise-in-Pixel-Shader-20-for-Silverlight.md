---
title: "Simplex Noise (like Perlin Noise) in Pixel Shader 2.0 for Silverlight and WPF"
date: 2010-02-11T00:49:00.0000000
draft: false
featured_image: ""
---

<p>Yay! 2D and 3D noise in pixel shaders!</p>
<p>After tackling the Hue shader I decided to move to something even more interesting, Simplex noise.</p>
<p>You've probably heard of Perlin Noise, if not see Rene's post with realtime 3D noise <a href="http://www.dotnetkicks.com/silverlight/An_Oscar_Algorithm_Silverlight_Real_time_3D_Perlin_Noise">here</a>&nbsp;and also check out my <a href="http://nokola.com/livingnoise">Living Noise</a> sample and <a href="http://nokola.com/blog/post/2009/11/01/Large-Scale-Special-Effects-in-Silverlight-Living-Noise.aspx">Living Noise blog post </a>.</p>
<p>The "Noise" can be used to make effects such as fire, water, marbles, smooth motion, hand-drawn UI, space travel effects, nebulas and a lot more!</p>
<p>Simplex noise has similar characteristics to Perlin noise - it's continuous, smooth and its first derivative is smooth too. The nice thing about the Simplex, is that its&nbsp;much easier to compute and thus can be implemented in Pixel shaders.</p>
<p>Another advantage of the Simplex noise over Perlin noise is that the permutation bitmaps compress very well (8KB total), making the whole XAP about 30KB total, including the sample JPEG.&nbsp; In comparison Perlin noise's bitmaps compress to about 350KB on my box.</p>
<p>Note you can also generate the maps almost instantly on the fly, eliminating the "size argument" when comparing Perlin and Simplex.</p>
<p>The source code download contains both&nbsp;2D and 3D&nbsp;Pixel shader Simplex noise implementation. The 3D implementation still lacks some features - read on below.</p>
<p>Here is the live sample:</p>
<iframe src="/sample.aspx?xap=NoiseSL" width="500px" height="380px" style="border: 0px solid" frameborder="0"></iframe>
<p><a href="http://nokola.com/sources/NoiseSL.zip">Download Source Code</a></p>
<p>The sample is based on <a href="http://developer.amd.com/Assets/Tatarchuk-Noise(GDC07-D3D_Day).pdf">this public powerpoint presentation</a> by Natalya Tatarchu (AMD), who is the hero of today and I believe she made a lot of people happy with her&nbsp;great implementation of&nbsp;the Simplex noise! :)</p>
<p>I also re-visited <a href="http://mrl.nyu.edu/~perlin/">Ken Perlin's homepage</a> to remind myself of the noise a couple of times.</p>
<h2>2D noise</h2>
<p>This was (relatively) easy, since the reference implementation readily fits into PS 2.0 shaders, with lots of instructions available to experiement.</p>
<p>To overlay couple of noises on top of each other, I had to use the shader several times.</p>
<p>The biggest issue was generating the maps - I had to make sure to set the alpha to 255, otherwise weird things may happen (due to alpha premultiplication).</p>
<h2>3D Noise</h2>
<p>The 3d noise was more challenging - the implementation I have does not fit in PS 2.0 (84 instructions total, and PS 2.0 is 64 max).</p>
<p>I had to split the function in the middle, and make 2 shaders that build on top of each other. This means that the second shader works with the output from the first. There are several challenges:</p>
<p>1. There is color and shader information to be passed around, which means that either I have to pass the original image every time to the shader, or I have to compress the color space</p>
<p>I chose to compress the color space, and make it (R, S, G+B) where S is the shader value from the previous pass and RGB are the original image components. In the source code, I skipped the G+B part altogether ending with (R, S, 0) (monochrome source image), but you may change it to fix the issue.</p>
<p>If you do, please let me know, since I'm not planning to do it for now!</p>
<p>Note: in .NET 4.0 the 3D Noise shader fits into the PS 3.0 instruction limits. I left the original function in the source for people who want to use it with WPF.</p>
<p>Lot of writing! Hope you enjoy it!</p>
<p>&nbsp;</p>