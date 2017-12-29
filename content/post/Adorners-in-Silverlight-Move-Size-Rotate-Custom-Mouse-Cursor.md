---
title: "Adorners in Silverlight - Move, Size, Rotate, Custom Mouse Cursor"
date: 2009-12-13T10:58:00.0000000
draft: false
featured_image: ""
---

<p>This adorner took me few days to get right!</p>
<p><strong>Edit Dec, 15: </strong><a href="http://tozon.info/blog/">Andrej Tozon</a> created an updated source supporting Behaviours (and drag-drop without code in Blend). Here's a link to <a href="http://cid-d34608bce9688fba.skydrive.live.com/self.aspx/Public/Development/Samples/AdornerTest2.zip">his version</a>. Thanks Andrej!</p>
<p>This&nbsp;is work in progress,&nbsp;but the base functionality is there and stable!</p>
<p><a href="http://nokola.com/sources/adorners.zip">Download source code</a></p>
<p><a href="http://nokola.com/adorners">View Sample</a></p>
<p><a href="http://nokola.com/adorners">&nbsp;<img src="/2009%2f12%2fadorners.jpg" alt="" /></a></p>
<p>The adorner currently has the following features:</p>
<ul>
<li>Shows custom mouse cursors that get rotated and aligned to the object being rotated/sized in realtime. The cursors are Path elements, so this makes the cursor rotation possible. To see the effect in action, try rotating a window and then sizing: the size cursor is always perpendicular to the sizing edges.</li>
<li>Move. It also does click detection on activation - so that you can click a non-adorned object and immediately start dragging.</li>
<li>Two resize modes: center-preserving and edge-preserving (currently set via private bool property).</li>
<li>Rotate: hover outside any corner with the mouse to see the rotating adorner</li>
<li>Extension panel: allows to add additional adorner controls (e.g. "send backwards" icon on top of adorner). This is currently private, but will become properly exposed in later versions</li>
<li>The element being adorned can choose any algorithm to rotate/move itself (e.g. use TranslateTransform vs Canvas.Left and Canvas.Top). The functionality with the element being adorned is loosely coupled with the adorner through a simple IAdornedOject interface.</li>
<li>Nice glass border (from <a href="http://www.sixin.nl/antoni-dol-blog/09-11-15/Silverlight_Style_GlassBorderStyle.aspx">http://www.sixin.nl/antoni-dol-blog/09-11-15/Silverlight_Style_GlassBorderStyle.aspx</a>)</li>
</ul>
<p>Turns out, properly doing rotation, translation and all those adorner-specific things, wasn't easy for me...in fact it took me quite a bit of time! I'm glad it's done for now! :)</p>
<p>Here is a quick extract of the source and how to use the interfaces:</p>
<p>[code:c#]</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; public interface IAdornedObject<br />&nbsp;&nbsp;&nbsp; {<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double Angle { get; set; }<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double X { get; set; }<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double Y { get; set; }<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double Width { get; set; }<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double Height { get; set; }<br />&nbsp;&nbsp;&nbsp; }</p>
<p>[/code]</p>
<p>Usage is straight-forward:</p>
<p>[code:c#]</p>
<p>Adorner adorner = new Adorner();<br />AdornedObject item = new AdornedObject(testImage);<br />adorner.SetAdornedObject(item);<br />panelDisplay.Children.Add(adorner);</p>
<p>[/code]</p>
<p>To avoid hassles with Thumbs moving around, the core of the move/size/rotate code is in thumb_MouseMove() - giving it nice absolute mouse coordinates!</p>
<p>What do you think this adorner?</p>