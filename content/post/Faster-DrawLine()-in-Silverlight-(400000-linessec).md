---
title: "Fast DrawLine() in Silverlight"
date: 2009-11-06T22:39:00.0000000
draft: false
featured_image: ""
---

<p>How fast can you make it go?</p>
<p>How about this loop that draws the line:[code:c#]<br />int inc = incy1 * w + incx;<br />for (int i = 0; i &lt; lenY; i++) {<br />&nbsp;&nbsp;&nbsp; pixels[index &gt;&gt; PRECISION_SHIFT] = color;<br />&nbsp;&nbsp;&nbsp;&nbsp;index += inc;<br />}[/code]</p>
<p>40FPS * 10000 lines = 400,000 lines/sec</p>
<p>Note: in my perf tests I did a single-threaded version, so if you have multiple cores (2-4), you might be able to get to more than 0.4mln lines/sec :)</p>
<p>I looked at the excellent posts from Rene about <a href="http://kodierer.blogspot.com/2009/11/drawing-shapes-silverlight.html">Drawing Shapes in Silverlight</a>, and decided to give the DrawLine() code a whirl :) After trying to optimize it for some time, I ended up with code that runs twice as fast!</p>
<p>There is no sample here, because I expect that Rene will integrate it/try it out in his library (that&rsquo;s really the best place for the code now to avoid multiple sample DLLs)</p>
<p>Here is the complete DrawLine() with my optimizations:[code:c#]</p>
<p>public static void DrawLineFast(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int color)<br />{<br />&nbsp;&nbsp;&nbsp; // Use refs for faster access (really important!) speeds up a lot!&nbsp;</p>
<p>&nbsp;&nbsp;&nbsp; int w = bmp.PixelWidth;<br />&nbsp;&nbsp;&nbsp; int[] pixels = bmp.Pixels;</p>
<p>&nbsp;&nbsp;&nbsp; // Distance start and end point</p>
<p>&nbsp;&nbsp;&nbsp; int dx = x2 - x1;<br />&nbsp;&nbsp;&nbsp; int dy = y2 - y1;</p>
<p>&nbsp;&nbsp;&nbsp; const int PRECISION_SHIFT = 8;<br />&nbsp;&nbsp;&nbsp; const int PRECISION_VALUE = 1 &lt;&lt; PRECISION_SHIFT;</p>
<p>&nbsp;&nbsp;&nbsp; // Determine slope (absoulte value)</p>
<p>&nbsp;&nbsp;&nbsp; int lenX, lenY;<br />&nbsp;&nbsp;&nbsp; int incy1;<br />&nbsp;&nbsp;&nbsp; if (dy &gt;= 0)<br />&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; incy1 = PRECISION_VALUE;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lenY = dy;<br />&nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp; else<br />&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; incy1 = -PRECISION_VALUE;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lenY = -dy;<br />&nbsp;&nbsp;&nbsp; }</p>
<p>&nbsp;&nbsp;&nbsp; int incx1;<br />&nbsp;&nbsp;&nbsp; if (dx &gt;= 0)<br />&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; incx1 = 1;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lenX = dx;<br />&nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp; else<br />&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; incx1 = -1;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lenX = -dx;<br />&nbsp;&nbsp;&nbsp; }</p>
<p>&nbsp;&nbsp;&nbsp; if (lenX &gt; lenY)<br />&nbsp;&nbsp;&nbsp; { // x increases by +/- 1</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Init steps and start</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int incy = (dy &lt;&lt; PRECISION_SHIFT) / lenX;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int y = y1 &lt;&lt; PRECISION_SHIFT;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Walk the line!</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int i = 0; i &lt; lenX; i++)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pixels[(y &gt;&gt; PRECISION_SHIFT) * w + x1] = color;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x1 += incx1;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; y += incy;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp; else<br />&nbsp;&nbsp;&nbsp; { // since y increases by +/-1, we can safely add (*h) before the for() loop, since there is no fractional value for y <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Prevent divison by zero</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (lenY == 0)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Init steps and start</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int incx = (dx &lt;&lt; PRECISION_SHIFT) / lenY;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int index = (x1 + y1 * w) &lt;&lt; PRECISION_SHIFT;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Walk the line!</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int inc = incy1 * w + incx;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int i = 0; i &lt; lenY; i++)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pixels[index &gt;&gt; PRECISION_SHIFT] = color;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index += inc;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp; }<br />}</p>
<p>[/code]</p>
<h2>Summary of Optimizations Done</h2>
<ul>
<li>Moved from using float to using fixed point </li>
<li>Took advantage of the fact that if the line is longer in the y direction, vs the x direction (vertically-looking line), y will change by 1 on each iteration. This allows me to remove the multiplication in the innermost line drawing loop </li>
<li>Removed extra variables, so that remaining variables can be optimized by the JIT compiler, hopefully in CPU registers </li>
</ul>
<p>Hope you like it! Please comment! Also, if you can make it faster, please do!</p>
<p>&nbsp;</p>