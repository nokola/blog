---
title: "Improving Download Time (2-3x) for Full Screen Background Images"
date: 2010-01-04T10:57:00.0000000
draft: false
featured_image: ""
---

<p>Getting your backgrounds quickly is very important for games, especially at startup time when you're downloading a lot of stuff anyway (like menu buttons, simple effects, such as explosions and other things that didn't make it into the "core" xap to reduce initial load time).</p>
<p>Since you are full screen, it is a good idea to detect the resolution (that would be the ActualWidth and ActualHeight properties of your root control) and programatically return a suitable sized background.</p>
<p>For example, a 1920x1080 JPG image is about 200K while the same image 800x600 is about 50K.</p>
<p>The source code is simple, but I post it in case someone needs it and doesn't have to write it from scratch:</p>
<p>[code:c#]</p>
<p>/// &lt;summary&gt;<br />/// The background resolutions available<br />/// &lt;/summary&gt;<br />private static int[] _resAvailable = new int[] { 800, 1024, 1280, 1600, 1920 };</p>
<p>/// &lt;summary&gt;<br />/// Returns the most appropriate resolution from the list of available resolutions for the background images<br />/// Best resolution is defined as the closest resolution that is bigger than the resolution input as an argument<br />/// &lt;/summary&gt;<br />/// &lt;param name="currentXResolution"&gt;&lt;/param&gt;<br />/// &lt;returns&gt;&lt;/returns&gt;<br />private static int GetBestStockResolution(int currentXResolution) {<br />&nbsp;&nbsp;&nbsp; int count = _resAvailable.Length;</p>
<p>&nbsp;&nbsp;&nbsp; for (int i = 0; i &lt; count; i++) {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (_resAvailable[i] &gt;= currentXResolution) {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return _resAvailable[i];<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp; }</p>
<p>&nbsp;&nbsp;&nbsp; // no suitable resolution found, return largest<br />&nbsp;&nbsp;&nbsp; return _resAvailable[count - 1];<br />}</p>
<p>/// &lt;summary&gt;<br />/// Determines the correct url for an image based on teh current resolution and short image name<br />/// &lt;/summary&gt;<br />/// &lt;param name="imageShortName"&gt;the short name of the image (e.g. "shockLord"&lt;/param&gt;<br />/// &lt;returns&gt;url to the image, including resolution (<a href="http://.../image1920.jpg">http://.../image1920.jpg</a>) &lt;/returns&gt;<br />public static string GetBackgroundImageUrl(string imageShortName) {<br />&nbsp;&nbsp;&nbsp; return String.Format("<a href="http://www.mysite.com/images/{0}{1}.jpg">http://www.mysite.com/images/{0}{1}.jpg</a>", imageShortName, GetBestStockResolution((int)Globals.XResolution));<br />}<br />[/code]&nbsp;</p>
<p>In the above code Globals.XResolution is set to the current full screen resolution when the player clicks play to go full screen.</p>
<p>To use the code, you need to have the same image with various resolutions, e.g. mysite.com/images/background1920.jpg, mysite.com/images/background1024.jpg and so on.</p>
<p>Last but not least, you can use a low-quality background image when the game goes full screen for the first time, and then replace it with the high-quality image once available. I made a special control just for that: SmoothImage in the <a id="ctl00_ContentPlaceHolder1_HyperLink9" href="MoreControls.zip">Controls Pack</a>&nbsp;on Nokola.com. The SmoothImage control will preserve its previous image, whenever you change it's Source and will display the new image once it's available. You can see the SmoothImage sample by launching <a href="http://nokola.com/shock">http://nokola.com/shock</a>&nbsp;and switching between the classes - note how the backroung changes "smoothly" and you don't see a period of transparent/missing image background while the new background gets downloaded.</p>
<p>&nbsp;</p>