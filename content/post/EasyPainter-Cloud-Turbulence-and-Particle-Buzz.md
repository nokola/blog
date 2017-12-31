---
title: "EasyPainter: Cloud Turbulence and Particle Buzz"
date: 2010-04-02T02:52:04.0000000
draft: false
featured_image: ""
---

<p>Two new effects for <a href="http://nokola.com/easypainter">EasyPainter</a> with source code!</p>  <p><strong>Cloud Turbulence</strong>: works great on clouds, but not much anything else I tried (OK on metal – makes it look like liquid).</p>  <p>Before:</p>  <p><a href="/CloudsBefore.jpg"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="CloudsBefore" border="0" alt="CloudsBefore" src="/CloudsBefore_thumb.jpg" width="644" height="459" /></a> </p>  <p>After:</p>  <p><a href="/CloudsAfter.jpg"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="CloudsAfter" border="0" alt="CloudsAfter" src="/CloudsAfter_thumb.jpg" width="644" height="423" /></a> </p>  <p></p>  <p><strong>Particle Buzz</strong></p>  <p>This effect has a lot of potential, since it’s the first displacement effect in EasyPainter based on image. Currently, it just uses random noise (Random.Next(256) for the R,G,B and 255 for the A channels).</p>  <p><a href="/buzz_before.jpg"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="buzz_before" border="0" alt="buzz_before" src="/buzz_before_thumb.jpg" width="644" height="484" /></a> </p>  <p><a href="/buzz_after.jpg"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="buzz_after" border="0" alt="buzz_after" src="/buzz_after_thumb.jpg" width="644" height="484" /></a> </p>  <p>Using other images (such as pencil strokes, grass, etc) for displacement yields very nice results! I’m still experimenting :)</p>  <h2>Source Code</h2>  <p><strong>Particle Buzz. </strong>The noise is a 256x256 texture initialized to random values and remember to set this.DdxUvDdyUvRegisterIndex = 1; when initializing the shader in code behind.</p>  <p></p>  <p>sampler2D Noise : register(S1); </p>  <p>/// &lt;summary&gt;Width of the input.&lt;/summary&gt;   <br />/// &lt;minValue&gt;2&lt;/minValue&gt;    <br />/// &lt;maxValue&gt;100&lt;/maxValue&gt;    <br />/// &lt;defaultValue&gt;30&lt;/defaultValue&gt;    <br />float Shake : register(C0); </p>  <p>/// &lt;summary&gt;Input size&lt;/summary&gt;   <br />/// &lt;type&gt;Size&lt;/type&gt;    <br />/// &lt;minValue&gt;10,10&lt;/minValue&gt;    <br />/// &lt;maxValue&gt;100,100&lt;/maxValue&gt;    <br />/// &lt;defaultValue&gt;#01000000&lt;/defaultValue&gt;    <br />float4 dxdyShift : register(c1); </p>  <p>/// &lt;summary&gt;Input size&lt;/summary&gt;   <br />/// &lt;type&gt;Size&lt;/type&gt;    <br />/// &lt;defaultValue&gt;1024,768&lt;/defaultValue&gt;    <br />float2 ImageSize : register(C2); </p>  <p>//--------------------------------------------------------------------------------------   <br />// Sampler Inputs (Brushes, including ImplicitInput)    <br />//-------------------------------------------------------------------------------------- </p>  <p>sampler2D Input : register(S0); </p>  <p>float4 main(float2 uv : TEXCOORD) : COLOR   <br />{    <br />&#160;&#160;&#160; float2 dx = dxdyShift.xy;    <br />&#160;&#160;&#160; float2 dy = dxdyShift.zw;    <br />&#160;&#160;&#160; float4 noiseValue = tex2D(Noise, frac(2*uv*(ImageSize/256.0)));    <br />&#160;&#160;&#160; noiseValue -= 0.5;    <br />&#160;&#160;&#160; noiseValue *= Shake;    <br />&#160;&#160;&#160; return tex2D(Input, saturate(uv+(dx+dy)*noiseValue.rb));    <br />} </p>  <p><strong>Cloud Turbulence</strong></p>  <p>Needs this.DdxUvDdyUvRegisterIndex = 1; too.</p>  <p>/// &lt;summary&gt;Width of the input.&lt;/summary&gt;   <br />/// &lt;minValue&gt;2&lt;/minValue&gt;    <br />/// &lt;maxValue&gt;100&lt;/maxValue&gt;    <br />/// &lt;defaultValue&gt;30&lt;/defaultValue&gt;    <br />float Shake : register(C0); </p>  <p>/// &lt;summary&gt;Input size&lt;/summary&gt;   <br />/// &lt;type&gt;Size&lt;/type&gt;    <br />/// &lt;minValue&gt;10,10&lt;/minValue&gt;    <br />/// &lt;maxValue&gt;100,100&lt;/maxValue&gt;    <br />/// &lt;defaultValue&gt;#01000000&lt;/defaultValue&gt;    <br />float4 dxdyShift : register(c1); </p>  <p>sampler2D Input : register(S0); </p>  <p>float4 main(float2 uv : TEXCOORD) : COLOR   <br />{    <br />&#160;&#160;&#160; //pixel step vectors    <br />&#160;&#160;&#160; float2 dx = dxdyShift.xy;    <br />&#160;&#160;&#160; float2 dy = dxdyShift.zw;    <br />&#160;&#160;&#160; float4 noiseValue = tex2D(Input, uv);    <br />&#160;&#160;&#160; noiseValue.rg = float2((noiseValue.r + noiseValue.b/4), noiseValue.g + noiseValue.r/2);    <br />&#160;&#160;&#160; noiseValue -= 0.5;    <br />&#160;&#160;&#160; noiseValue *= Shake;    <br />&#160;&#160;&#160; return tex2D(Input, saturate(uv+(dx+dy)*noiseValue.rg));    <br />}</p>  <p>Hope you like it! :)</p>