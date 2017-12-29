---
title: "Tips/Tricks: Short Sounds, Fireworks and BitmapCache Speed"
date: 2010-01-04T10:17:00.0000000
draft: false
featured_image: ""
---

<p>This blog post is a follow-up of the <a href="http://nokola.com/blog/post/2009/12/25/Shock-Game-got-new-character-Old-Man-(the-one-with-the-raindeer).aspx">previous one</a> dedicated to the <a href="http://nokola.com/shock">Shock</a> improvements.</p>
<p>I'll just list all tips or other interesting findings/updates in no particular order:</p>
<h2>Playing Short Sounds in Silverlight (Improved)</h2>
<p>You probably know by now that Silverlight (2,3) has an annoying issue with short sounds - sometimes the sound is not played correctly. The simple <a href="http://kindohm.com/archive/2009/01/21/workaround-for-quotshort-soundquot-silverlight-bug.aspx">workaround is here</a>.&nbsp;</p>
<p>If you happen to play too many sounds/sec, the above workaround can cause your memory usage to&nbsp;grow more than you want to&nbsp;for short time. The easiest way to avoid the surge in mem usage is to cache the streams that contain the .mp3 sounds, like this:</p>
<p>[code:c#]</p>
<p>private static Dictionary&lt;string, Stream&gt; _streams = new Dictionary&lt;string, Stream&gt;();</p>
<p>public static void PlayShortSound(string embeddedSoundName, double volume)<br />{<br />&nbsp;&nbsp;&nbsp; Stream stream;<br />&nbsp;&nbsp;&nbsp; if (!_streams.TryGetValue(embeddedSoundName, out stream))<br />&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream = Application.GetResourceStream(new Uri(String.Format("/Shock;component/Sounds/{0}", embeddedSoundName), UriKind.Relative)).Stream;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _streams[embeddedSoundName] = stream;<br />&nbsp;&nbsp;&nbsp; }<br />&nbsp;&nbsp;&nbsp; MediaElement media = new MediaElement();<br />&nbsp;&nbsp;&nbsp; _soundContainer.Children.Add(media);<br />&nbsp;&nbsp;&nbsp; media.MediaFailed += media_MediaFailed;<br />&nbsp;&nbsp;&nbsp; media.MediaEnded += media_MediaEnded;<br />&nbsp;&nbsp;&nbsp; media.Volume = volume;<br />&nbsp;&nbsp;&nbsp; media.AutoPlay = true;<br />&nbsp;&nbsp;&nbsp; media.Position = TimeSpan.FromMilliseconds(0);<br />&nbsp;&nbsp;&nbsp; media.SetSource(stream);<br />}</p>
<p>[/code]</p>
<p>Then, just call the function like this example: PlayShortSound("explosion.mp3").&nbsp;You can use this trick, because multiple sounds using&nbsp;the same stream&nbsp;don't cause issues with each other, which is nice.</p>
<h2>"Shatter" Effect</h2>
<p>In my previous blog post I mentioned the "shatter" brick effect, which is based on this one:&nbsp; <a href="http://www.shinedraw.com/animation-effect/flash-vs-silverlight-colorful-fireworks/">http://www.shinedraw.com/animation-effect/flash-vs-silverlight-colorful-fireworks/</a></p>
<p>I changed the effect and made it self-recycling: removes itself from the parent after a given time period. It will also display "fireworks" in an area, not&nbsp; a dot. All of these are really small modifications, but help make the effect "run and forget", and easy to use for "shattering" stuff like bricks.</p>
<p>Here's an usage sample:</p>
<p>[code:c#]</p>
<p>public static TimeSpan ShatterEffectTimeSpan = TimeSpan.FromSeconds(0.3);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>Fireworks fireworks = new Fireworks(TimeSpan.FromSeconds(0.3), (int)width, (int)height, brickAppearance == BrickAppearance.Ice);<br />Canvas.SetLeft(fireworks, centerX);<br />Canvas.SetTop(fireworks, centerY);<br />Globals.BoomContaier.Children.Add(fireworks);<br />fireworks.Start();<br />[/code]</p>
<p>And here's the source code. Note: get the complete sample from the shinedraw.com link above and then change the 2 files below. The code won't compile, but you just have to call your own Random() function, and maybe fix few other basic things.</p>
<p><a href="/blog/file.axd?file=2010%2f1%2fFireworks.xaml.cs">Fireworks.xaml.cs (4.98 kb)</a>&nbsp; <a href="/blog/file.axd?file=2010%2f1%2fMagicDot.cs">MagicDot.cs (2.89 kb)</a></p>
<p>I want to call out something very interesting in the above effect (not made by me originally) - each MagicDot is created within its own container. I believe it will cause less layout work than putting all dots within the same container (this is a gut-feeling unverified speculation)</p>
<p>If you want to see the shatter effect in action, break the ice bricks on level 2 of Shock: <a href="http://nokola.com/shock">http://nokola.com/shock</a></p>
<h2>When (Not) To Use BitmapCache, Even For Images That Don't Move</h2>
<p>I found out that if I use CacheMode="BitmapCache" for each brick (100+ per level), the performance suffers. This is very interesting, and is something to keep in mind when using bitmap cache.</p>
<p>Seems like the larger the image, the better.</p>
<h2>More On Speed</h2>
<p>Some blogs (don't remember where) mention that images with Opacity=0 still render and take valuable CPU/GPU time - I tested it and it seems that in Silverlight 4 Beta this is not the case.</p>
<p>I observed no noticeable speed change when a UserControl (the highscore) had Opacity=0 vs Visibility=Invisible. Note, however that Opacity=0 means you get hit testing, so there is some speed difference - don't just blindly overuse Opacity=0 instead of Visibility=Invisible.</p>
<p>&nbsp;</p>