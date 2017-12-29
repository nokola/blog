---
title: "2x-4x Faster Living Noise"
date: 2009-11-04T10:15:00.0000000
draft: false
featured_image: ""
---

<p>I wasn't quite satisfied with almost 50% CPU for v1 of the Living Noise here, so made some improvements.</p>
<p>The new version runs at 15-20% in low quality and about 30% in high quality..could be better but I tried... :)</p>
<p>The new version replaces the old one here: <a href="http://nokola.com/livingnoise">http://nokola.com/livingnoise</a></p>
<p>If you don't see the "High Quality" checkbox, please refresh/delete your browser cache.</p>
<p>The source code is updated as well: <a href="http://nokola.com/sources/livingnoise.zip">http://nokola.com/sources/livingnoise.zip</a></p>
<h2>Summary of Optimizations</h2>
<ul>
<li>Changed to static threads and event signaling instead of creating threads on every frame</li>
<li>Added table lookup instead of division and shifts for blur (this improved perf about 30%)</li>
<li>Added "skip step": since most of the screen is black, if the blur finds black pixel, it jumps 8 pixels ahead and if it finds another black pixel, assumes that the line strip was black and does not do anything. To avoid having dots "stick" on the screen, the algorithm uses a sliding window on every Blur() to ensure that all pixels on the screen are verified at some point. (that was significant perf improvement as well)</li>
<li>Added artificial frame cap to 90 FPS</li>
</ul>
<p>Hope you like it!</p>
<p>&nbsp;</p>