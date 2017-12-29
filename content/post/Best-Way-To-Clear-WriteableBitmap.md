---
title: "Best Way To Clear WriteableBitmap?"
date: 2009-11-11T02:28:00.0000000
draft: false
featured_image: ""
---

<p>If you're doing a lot of custom drawing using WriteableBitmap (e.g. full screen game), it will be extremely important to be able to clear the WriteableBitmap or "screen" quickly.</p>
<p>Lets assume you want to clear the screen to specific color.</p>
<p>What is the best way to do it?</p>
<p>Here is a short comparison of&nbsp;few methods to clear a 512x512 bitmap:</p>
<ul>
<li><strong>Clear with for loop:&nbsp;1000 FPS</strong></li>
<li><strong>Clear with Array.Copy: 4100 FPS</strong></li>
<li><strong>Clear with Array.Clear: 11000 FPS</strong></li>
</ul>
<p>1. Clear with for() loop. This method is the most straight-forward, and also the slowest:</p>
<p>[code:c#]</p>
<p>public static void ClearForLoop(int[] pixels, int len, int color)<br />{<br />&nbsp;&nbsp;&nbsp; for (int i = 0; i &lt; len; i++)<br />&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pixels[i] = color;<br />&nbsp;&nbsp;&nbsp; }<br />}</p>
<p>[/code]</p>
<p>2. Clear by using Array.Copy. This method is not only fast, but it also allows to "clear" to <strong>an image </strong>(not just color), which is great if you have a pre-defined background or something like that.</p>
<p>[code:c#]</p>
<p>public static void ClearArrayCopy(int[] pixels, int[] clearTo, int len)<br />{<br />&nbsp;&nbsp;&nbsp; Array.Copy(clearTo, 0, pixels, 0, len);<br />}<br />[/code]</p>
<p>This method assumes that you have already pre-initialized the "clear" bitmap (just do it once! :) with the color/image:</p>
<p>[code:c#]</p>
<p>// note: do this ONCE!, NOT on every frame! obvious, but worth mentioning just in case</p>
<p>int[] clearScreen = new int[pixels.Length];</p>
<p>for (int i = 0; i &lt; pixels.Length; i++)<br />{<br />&nbsp;&nbsp;&nbsp; clearScreen[i] = color;<br />}<br />[/code]</p>
<p>3. Clear with Array.Clear: the fastest way, but unfortunately allows you to clear to 0 only (meaning transparent image).</p>
<p>[code:c#]</p>
<p>Array.Clear(pixels, 0, pixels.Length);</p>
<p>[/code]</p>
<p>Depending on the application you'd either choose Array.CopyTo(), since it's the most versatile or Array.Clear(). You may also choose Array.CopyTo() over Array.Clear() because Array.CopyTo() is easily multithreaded, and can take&nbsp;advantage of multiple cores, while Array.Clear() currently runs on a single thread/core.</p>
<p>Note that all measurements assume single-core used. If you have multiple-core system you can improve the speed quite a bit by running those multithreaded.</p>