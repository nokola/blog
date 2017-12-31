---
title: "The Most Important Silverlight WriteableBitmap Gotcha - Does It Lose/Change Colors?"
date: 2010-01-27T06:29:00.0000000
draft: false
featured_image: ""
---

<p><strong>Edit Nov 21, 2011: </strong>changed 256/a to 255/a due to Gert’s comment – thanks Gert!</p>  <p>The first time I tried saving WriteableBitmap to png, the transparencies didn't look right. The color was &quot;washed out&quot; and replaced with gray:</p>  <p>&#160;<img alt="" src="/2010%2f1%2fcomparison.png" /></p>  <p>Moreover: Let's say you wanted to set a half-opaque red pixel color inside a WriteableBitmap.</p>  <p>To my biggest surprise this didn't work:</p>  <p>bitmap.Pixels[i] = (255 &lt;&lt; 24) + (255 &lt;&lt; 16)</p>  <p>I got a redder pixel than expected! What's going on?</p>  <p>After long search and speaking with people, it turned out it's because WriteableBitmap for Silverlight uses pARGB (pre-multiplied alpha) format.</p>  <p>If you look at MSDN carefully, you'll notice the single place (as far as I know) that mentions it: <a href="http://msdn.microsoft.com/en-us/library/system.windows.media.imaging.writeablebitmap(VS.95).aspx">http://msdn.microsoft.com/en-us/library/system.windows.media.imaging.writeablebitmap(VS.95).aspx</a></p>  <p>It reads: &quot;When assigning colors to pixels in your bitmap, use pre-multiplied colors.&quot;</p>  <p>The reason for this initially unintuitive choice of format is speed. Blending with pre-multiplied colors can save significant time as compared to just ARGB.</p>  <p>For more info and blending formulas, read here: <a href="http://www.teamten.com/lawrence/graphics/premultiplication/">http://www.teamten.com/lawrence/graphics/premultiplication/</a></p>  <p>Here is the source code to call before saving WriteableBitmap to PNG in order to convert the colors to &quot;regular&quot; ARGB:</p>  <p>[code:c#]</p>  <p>public static void CompensateForRender(int[] bitmapPixels)   <br />{    <br />&#160;&#160;&#160; int count = bitmapPixels.Length;</p>  <p>&#160;&#160;&#160; for (int i = 0; i &lt; count; i++)   <br />&#160;&#160;&#160; {    <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; uint pixel = unchecked((uint)bitmapPixels[i]);    <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; // decompose    <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; double a = (pixel &gt;&gt; 24) &amp; 255;    <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; if ((a == 255) || (a == 0)) continue;</p>  <p>&#160;&#160;&#160;&#160;&#160;&#160;&#160; double r = (pixel &gt;&gt; 16) &amp; 255;   <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; double g = (pixel &gt;&gt; 8) &amp; 255;    <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; double b = (pixel) &amp; 255;</p>  <p>&#160;&#160;&#160;&#160;&#160;&#160;&#160; double factor = 255 / a;   <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; uint newR = (uint)Math.Round(r * factor);    <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; uint newG = (uint)Math.Round(g * factor);    <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; uint newB = (uint)Math.Round(b * factor);    <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; // compose    <br />&#160;&#160;&#160;&#160;&#160;&#160;&#160; bitmapPixels[i] = unchecked((int)((pixel &amp; 0xFF000000) | (newR &lt;&lt; 16) | (newG &lt;&lt; 8) | newB));    <br />&#160;&#160;&#160; }    <br />}</p>  <p>[/code]</p>  <p>If you look at the <a href="http://nokola.com/blog/post/2010/01/21/Quick-and-Dirty-Output-of-WriteableBitmap-as-TGA-Image.aspx">previous post</a>, you'd call CompensateForRender(_screen.Pixels) just before TgaWriter.Write(_screen, fileStream);</p>  <p>Obviously the above function can be optimized, and should if you use it often (e.g. several times per second or as part of batch processing).</p>  <p>   <br />You know that speed is a benefit, the drawback is that there is some loss of precision. It's nice that for completely opaque images there is no precision loss and the pARGB format is equivalent to the ARGB format. So in most cases you wouldn't care :)</p>  <p>In the cases where the alpha gets below 255, you have to go all the way to 128 alpha to lose one bit-per-pixel from the color information. Not that bad, given how many CPU cycles can be saved in blending and used for something else.</p>  <p>Hope this helps, please comment - if you had a choice, which format would you choose and why?</p>