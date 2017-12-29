---
title: "EasyPainter Source Pack1: Color Picker, RangeSlider, Small Expander, Fast Drop Shadow and more!"
date: 2010-02-08T23:18:00.0000000
draft: false
featured_image: ""
---

<p>I'm very happy to publish the EasyPainter source code pack. The controls in the pack are optimized for usability, speed and size.</p>
<p>All of them have been succesfully used in real-life apps which is the best way to test if something works.</p>
<p><a href="http://nokola.com/sources/EasyPainterControlsPack1.zip">Download Source Code</a></p>
<p>Here's a live demo:</p>
<iframe src="/sample.aspx?xap=EasyPainterControlsPack1" width="650px" height="460px" style="border: 0px solid" frameborder="0"></iframe>
<p>This pack contains the following controls:</p>
<ul>
<li><strong>Color Picker</strong> - feature complete control that allows to pick any color, transparency or&nbsp;type in&nbsp;hex color</li>
<li><strong>Editable, auto-formatting slider</strong> - if you want to give the user the ability to quickly choose values with previews, this control is for you. It will also try and self-adapt the number format (spaces after the zero), based on the scale you specify.</li>
<li><strong>Fast drop shadow frame</strong> - consists of few rectangles, without customizations. But you can have a lot of those, in many sizes and not worry about performance.</li>
<li><strong>Minimalistic Expander</strong> - the best thing about this control is that it's small (12KB). You don't need to get the whole 300+KB Microsoft.Windows.Controls from the Silverlight Toolkit.</li>
<li><strong>The toolbar buttons</strong> used in EasyPainter on the side and top toolbar</li>
<li><strong>The toolbar radio buttons</strong> used in EasyPainter for tool selection</li>
</ul>
<p>Hope you like it!</p>
<p>btw, here's a nice trick that I used to do the rectangle background for the alpha picker:</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;Rectangle Fill="White" /&gt;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;Line Stroke="Gray" StrokeThickness="4" StrokeDashArray="1,1" X1="2" Y1="0" X2="2" Y2="300"&nbsp; /&gt;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;Line Stroke="Gray" StrokeThickness="4" StrokeDashArray="0,1,0" X1="2" Y1="0" X2="2" Y2="300" Grid.Column="1"&nbsp; /&gt;</p>
<p>In the posts coming up, I'll talk about compositing the image on screen, filters,&nbsp;and drawing with pixel shaders! There's also adorner, cursor code, and Flickr integration coming up!</p>
<p>&nbsp;</p>