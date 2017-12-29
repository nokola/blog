---
title: "Shock Game got new character - Old Man (the one with the raindeer)"
date: 2009-12-25T08:20:00.0000000
draft: false
featured_image: ""
---

<p>Now with music (again), special effects. Read more about the effects and other improvements here:</p>
<p>Yes! Thanks to few donations and some out-of-pocket money, I was able to buy back some of Shock's music.</p>
<ul>
<li>Each character has a theme song now. The new character - Old Man, is named after that guy that flies raindeers and distributes gifts through his Christmas distribution chain.</li>
<li>The music has new engine now, with "announcing" control (a popup that displays the song title with information). </li>
<li>Other improvements include sounds for everything - ball hit, shattering glass, etc. To make this work, I had to create an AutoPlay MediaElement for each mp3 and play it. There are few tricks here that you can use to minimize objects created and mem usage - code will follow!</li>
<li>New visual effects include "shatter" effect which is based on this: <a href="http://www.shinedraw.com/animation-effect/flash-vs-silverlight-colorful-fireworks/">http://www.shinedraw.com/animation-effect/flash-vs-silverlight-colorful-fireworks/</a>, with the following simple changes/improvements: 
<ul>
<li>Fireworks consist of 2 ellipses instead of 5 - speed optimization</li>
<li>The effect has "range" - e.g. you can make the dots appear everywhere on the brick, not just one point</li>
<li>The effect takes TimeSpan (e.g. 0.5 sec), and plays for a specific time, then the Canvas removes itself from it's parent. This allows to just add the effect anywhere and then start it and forget it. Nice and self-manageable :)</li>
</ul>
</li>
<li>Many speed improvements related to GPU and BitmapCache. For some weird reason, I've left the bitmap cache off many of the images before...most notably the background image that takes a lot of space</li>
</ul>
<p>I have few more improvements in the pipeline - mainly perf and resolving few minor issues (I doubt if anyone will notice most of them)</p>
<p>It is a busy Christmas :) I'll post some code from v3 of the game soon...first let's wrap it up.</p>
<p>Yes, the game is here: <a href="http://nokola.com/shock">http://nokola.com/shock</a></p>
<p>I strongly advise playing with the Old Man, as it provides the most festive experience! :)</p>
<p>Please let me know your opinion - does it play well? What do you think about it and what would you change or improve?</p>
<p>Thanks!</p>
<p>Note: donations are still open, since the game hasn't paid for itself just yet and I'm planning&nbsp;more games&nbsp;:)</p>