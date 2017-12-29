---
title: "Detect the CPU Core Count From Silverlight"
date: 2009-11-12T02:06:00.0000000
draft: false
featured_image: ""
---

<p>If you're are writing an application that is heavy on multi-threaded computations (e.g. full screen blur, game, or scientific data processing), you will want to know how many threads to run optimally.</p>
<p><strong>Edit: just fixed a bug reported where the initial assesment woult be 0 msec, thanks Morten for reporting it!</strong></p>
<p>The answer is easy: run as many threads as the CPU cores. For example, on Dual Core, you should run 2 threads and on Quad Core 4 threads.</p>
<p><a href="http://www.nokola.com/sources/DetectCPUCoreCount.zip">Download Source Code</a></p>
<iframe src="/sample.aspx?xap=DetectCPUCoreCount" width="300px" height="200px"></iframe>
<p>This is how to find the number of cores:</p>
<ol>
<li>Create a simple computing function (e.g. that adds +1 to a number continuously) and run it with 1, 2, 4, 8, and 16&nbsp;threads</li>
<li>Measure the time it takes for the function to complete for each set of threads.</li>
</ol>
<p>Once you hit the "core limit" of the client system, the time will significantly increase. Here's an example from my box:</p>
<ul>
<li>1 thread:&nbsp;132 msec</li>
<li>2 threads:&nbsp;111 msec</li>
<li>4 threads:&nbsp;140 msec</li>
<li>8 threads:&nbsp;822 msec</li>
</ul>
<p>If you look at the above data, you can easily tell I'm running on a quad-core system, because jumping from 4 to 8 threads significanly increases the computational time needed (more than 1.8 times).</p>
<p>This is how to use the source code:</p>
<p>[code:c#]</p>
<p>int coreCount = PerformanceMeasure.GetCoreCount();</p>
<p>[/code]</p>
<p>You can call the above function from the UI thread.</p>
<p>There are also two tweaks in the code that allows it to run roughly at the same speed on all machines and run faster on single-core machines too:</p>
<ul>
<li>Once the core limit is hit, the algorithm stops. E.g. if you find that 4 threads take more than 1.8x the time as compared to 2 threads, this means you have 2 cores and there is no need to test with 8 threads</li>
<li>Before the main algorithm (above) starts, there is an estimation step, which calculates how many operations can be executed for 100 msec on 1 thread. This ensures that the assesment will run fast even on slow machines.</li>
</ul>
<p>Please comment! I would be interesting to know how well the algorithm works and if it detected your cores as you expected!</p>