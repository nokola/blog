---
title: "Super Cool Silverlight Game (Not Mine) + Source"
date: 2009-12-10T03:37:00.0000000
draft: false
featured_image: ""
---

<p>This is <strong>mind blowing</strong>!!</p>
<p>A desktop-like RPG Chinese game in Silverlight: <a href="http://silverfuture.cn/">http://silverfuture.cn/</a>&nbsp;</p>
<p>It's 10.7 MB but worth the wait! It's in Chinese.</p>
<p>I'm sure in future versions it can be much less (e.g. Shock is 17 MB, but 680KB in order to play with the rest being downloaded as you play)</p>
<p>And!! The source code is here: <a href="http://code.msdn.microsoft.com/QXGameEngine">http://code.msdn.microsoft.com/QXGameEngine</a></p>
<p>Some notable things (other than the graphics, implementation and overall coolness):</p>
<p>1. The map is made of PNG's&nbsp;sized 400x300, it is pre-drawn. The big level, looks quite nice and takes 144 PNGs. Size is 1.75MB! Not bad...&nbsp;This approach looks quite feasible :)</p>
<p>2. Effects and animation are done with separate images. You could also do it with one image and clipping regions..I think it might be faster with one image if BitmapCache is enabled</p>
<p>Edit: last but not least, this game is moderately light on the CPU. Even better, from the source code it doesn't seem to be using BitmapCache!!! Which is great news - it can probably be even lighter!</p>
<p>Overall pretty cool!!!</p>