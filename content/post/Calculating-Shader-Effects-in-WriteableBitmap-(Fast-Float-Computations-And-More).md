---
title: "Calculating Shader Effects in WriteableBitmap (Fast Float Computations And More)"
date: 2010-01-11T09:27:00.0000000
draft: false
featured_image: ""
---

<p>Here's a small code snippet that allows you to calculate any pixel shader and get the output into a WriteableBitmap!</p>
<p>[code:c#]</p>
<p>Stream stream = Application.GetResourceStream(new Uri("SilverlightApplication1;component/Images/test.jpg", UriKind.Relative)).Stream;<br />WriteableBitmap result = new WriteableBitmap(1, 1); // avoid creating intermediate BitmapImage<br />result.SetSource(stream);</p>
<p>Image image = new Image();<br />image.Effect = new BlurEffect(); // any pixel shader effect<br />image.Source = result; // set the image to the original<br />result.Render(image, null);<br />result.Invalidate(); // render the pixel shader<br />image.Source = null; // release the bitmap reference<br />image.Effect = null;<br />GC.Collect(); // remove all obsolete bitmaps from memory [optional]<br />// result contains the image with shader effect applied! assign it to any Image.Source!<br />myImage.Source = result;<br />[/code]</p>
<p>For the sample, I used InvertColorEffect() that I had on my PC, but you could try with your own (or just use the BlurEffect() to see how it works).</p>
<p>Note that the image doesn't even have to be part of the UI tree, and you don't have to wait for a render pass!</p>
<h2>Why is this good?</h2>
<p>In an apples-to-apples comparison (float computations) pixel shaders are much faster than managed code. See <a href="http://kodierer.blogspot.com/2009/08/silverlight-3-writeablebitmap.html">http://kodierer.blogspot.com/2009/08/silverlight-3-writeablebitmap.html</a>&nbsp;for performance comparison. This means that you can now run even faster computations from managed code in Silverlight!</p>
<p>Also in case Silverlight eventually executes shaders on the GPU (I don't know what is the plan about that), your applications will really be able to benefit from the fast computations!</p>
<p>There is also one other reason why is it so good: but I'll mention it in a later post (working on secret project now...) :)</p>
<p>&nbsp;</p>