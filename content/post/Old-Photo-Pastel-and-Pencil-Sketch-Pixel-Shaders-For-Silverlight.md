---
title: "Old Photo, Pastel, and Pencil Sketch Pixel Shaders For Silverlight"
date: 2010-02-18T21:10:00.0000000
draft: false
featured_image: ""
---

<p>EasyPainter has new filters! Source code below! Try them out <a href="http://nokola.com/easypainter">here</a></p>
<p><strong>Edit: </strong>I'd actually like to improve the pastel shader further - real-life pastel is usually on white background, and the shaders are on black...</p>
<h2>Samples</h2>
<p>Original (<a title="http://www.flickr.com/photos/-arpi/4280428638/" href="http://www.flickr.com/photos/-arpi/4280428638/">http://www.flickr.com/photos/-arpi/4280428638/</a>):</p>
<p><a href="/Original_1.jpg"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Original" src="/Original_thumb_1.jpg" border="0" alt="Original" width="644" height="433" /></a></p>
<p><strong>Pastel Drawing:</strong></p>
<p><a href="/Pastel.jpg"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Pastel" src="/Pastel_thumb.jpg" border="0" alt="Pastel" width="644" height="433" /></a></p>
<p><strong>Old Photo: </strong></p>
<p><a href="/OldPhoto1.jpg"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="OldPhoto1" src="/OldPhoto1_thumb.jpg" border="0" alt="OldPhoto1" width="644" height="433" /></a></p>
<p><strong>Old Photo ("younger"): [more]</strong></p>
<p><a href="/OldPhoto2.jpg"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="OldPhoto2" src="/OldPhoto2_thumb.jpg" border="0" alt="OldPhoto2" width="644" height="433" /></a></p>
<p><strong>Pencil Sketch: </strong></p>
<p><a href="/Pencil.jpg"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Pencil" src="/Pencil_thumb.jpg" border="0" alt="Pencil" width="644" height="433" /></a></p>
<h2>Source Code</h2>
<p><a href="http://nokola.com/sources/OldPhotoPastelPencilShaders.zip">Download shader source code and required images</a></p>
<p>The .zip file contains the old photo shader, and 2 variations of the sketch shader. The first variation uses 2 input images (good for debugging) while the second one uses just one image which contains the information about one stroke in its red channel and the other stroke in its blue channel, effectively compressing 2 black-and-white images into one red-blue image :)</p>
<p>The Old Photo Shader is based on the <a href="http://kodierer.blogspot.com/search?updated-max=2010-01-10T20%3A12%3A00%2B01%3A00&amp;max-results=5">Old Movie Shader by Rene</a>.</p>
<p>The Sketch shaders are based on <a href="http://www.talula.demon.co.uk/postprocessing/postprocessing.html">this excellent explanation of how to do pencil sketch effect</a>. I made very small modifications to the original shader and also created a "pastel" effect in addition to the pencil sketch effect.</p>
<p>Creating a sketch effect turned out to be easy:</p>
<p>1. make 2 sketches on paper like this (I used real-life pastels from my 3 year old daughter):</p>
<p><a href="/pastel1.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="pastel1" src="/pastel1_thumb.png" border="0" alt="pastel1" width="132" height="132" /></a> <a href="/pastel2.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="pastel2" src="/pastel2_thumb.png" border="0" alt="pastel2" width="132" height="132" /></a></p>
<p>2. Scan the images</p>
<p>3. Create a pixel shader that combines the sketches with the input image, based on the input image's color (e.g. red determines the amount of the first sketch image, blue determines the amount of the second image). This ensures we'll get uneven sketch strokes, similar to an artist.</p>
<p>On the screenshots above you can see that depending on color the orientation of the sketch is either left-to-right, right-to-left or some combination.</p>
<p>Very nice effect &ndash; kudos to Shawn Hargreaves who thought it up (see link above) :)</p>
<p>You can extend this easily to do pen, watercolor or potentially other drawings as well.</p>
<p>&nbsp;</p>
<p>Last but not least, I made a small modification to Shazzam to support sampler2D and sampler1D parameters. You can add a texture from inside the tool and experiment. I sent the code to Walt (the creator of Shazzam), so hopefully we'll see it out soon! Here's a screenshot:</p>
<p><a href="/Untitled.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Untitled" src="/Untitled_thumb.png" border="0" alt="Untitled" width="644" height="476" /></a></p>