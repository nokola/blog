---
title: "Realtime Bump Mapping in Silverlight"
date: 2009-12-06T04:07:00.0000000
draft: false
featured_image: ""
---

<p>Ah yes! Bump mapping is an effect that makes "plain" textures - such as stone wall, appear bumpy under a light.</p>
<p>Even for a 2D game, bump mapping has a lot of uses. For example, if you're building a space shooter, it would be 10000 times cooler if lights from explosions illuminate the ship, showing it's ridged surfaces.</p>
<p>I've seen the effect used in games in the main menu as well, where the light of the cursor illuminated a rough surface. This is what we're doing today:</p>
<iframe src="/sample.aspx?xap=BumpMapping" width="1024px" height="768px"></iframe>
<p><a href="http://nokola.com/sources/BumpMapping.zip">Download Source Code</a></p>
<p>Notice how the light reflects properly off the bumpy surface as you move the mouse around.</p>
<p>I haven't optimized the effect (just a tiny bit <img title="Embarassed" src="http://nokola.com/blog/editors/tiny_mce3/plugins/emotions/img/smiley-embarassed.gif" border="0" alt="Embarassed" />), but it still runs at 1024x768, with 3 lights on 1 CPU thread. You can add more (e.g with images of lightbugs)&nbsp;if you'd like or take it full screen - I think it can handle it!</p>
<p>I found a really good old tutorial on bump mapping while digging through my files today. It's from a person named Sqrt(-1) and unfortunately I didn't find his current website to point you there.</p>
<p>Anyway, here's another website that shows how to do this effect: <a href="http://tfpsly.free.fr/Docs/TomHammersley/bumpmap.htm">http://tfpsly.free.fr/Docs/TomHammersley/bumpmap.htm</a></p>
<p>In my implementation the effect of the lights is limited to twice their radius, which pretty much gives the same effect as if you don't limit it. This reduces the effect's complexity to O(L1+L2+...LN) where Lx is the surface&nbsp;area of each light.</p>
<p>That's why you can scale large, especially with smaller lights.&nbsp;</p>
<p><b>Edit: </b>One possible optimization is to pre-calculate the normals for each x,y - this doubles the memory size for the bitmap but saves a lot of computations!</p>
<p>Hope you like it! Please comment!</p>