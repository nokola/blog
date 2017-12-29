---
title: "Glass Command Prompt in Windows 7"
date: 2009-12-18T04:32:00.0000000
draft: false
featured_image: ""
---

<p>Everybody needs some glass in their life (or was it love? <img title="Smile" src="http://nokola.com/blog/editors/tiny_mce3/plugins/emotions/img/smiley-smile.gif" border="0" alt="Smile" />) Anyway, here's a small project I did today out of love for glassy things.</p>
<p>This one is in pure C++, a completely glassy command prompt:</p>
<p>Source code: <a href="/blog/file.axd?file=2009%2f12%2fGlassy.zip">Glassy.zip (34.05 kb)</a></p>
<p><img src="/2009%2f12%2fglassy.jpg" alt="" /></p>
<h2>Usage</h2>
<ol>
<li>Download the source <a href="/blog/file.axd?file=2009%2f12%2fGlassy.zip">Glassy.zip (34.05 kb)</a> and run Glassy\Debug\Glassy.exe, or compile and run. Run it as Administrator (right-click the .exe, Run as Administrator)</li>
<li>Open command prompt and enjoy the glass!&nbsp;</li>
</ol>
<h2>Important Notes</h2>
<ul>
<li>The source code requires <a href="http://www.microsoft.com/visualstudio/en-us/products/2010/default.mspx?CR_CC=100253207&amp;WT.mc_id=SEARCH&amp;WT.srch=1&amp;CR_SCC=100253207">Visual Studio 2010 Beta2</a> - free download. Or, you can port it back manually to Visual Studio 2008</li>
<li>This project works on 32-bit executables only. If you're running on a 64-bit system, make sure to start C:\Windows\SysWOW64\cmd.exe, instead of your "other" cmd.exe&nbsp;</li>
<li>The project will show only in task manager (no visible window). If you want to close it, open Task Manager, and end the Glassy.exe process</li>
</ul>
<h2>How is it made?</h2>
<p>The application hooks into the shell and monitors all processed being created. Once it sees "cmd.exe", it enables the glass. It takes only 5 MB or RAM.</p>
<ol>
<li>Hook shell messages using <span style="font-size: medium;"><span style="font-family: Consolas;"><span style="font-family: Consolas;">RegisterWindowMessage(L</span></span><span style="font-family: Consolas; color: #a31515;"><span style="font-family: Consolas; color: #a31515;"><span style="font-family: Consolas; color: #a31515;">"SHELLHOOK"</span></span></span><span style="font-family: Consolas;"><span style="font-family: Consolas;">);</span></span></span></li>
<li>Register your window with <span style="font-family: Consolas; font-size: x-small;"><span style="font-family: Consolas;"><span style="font-size: medium;">RegisterShellHookWindow(hWnd)</span></span></span></li>
<li>Process the <span style="font-family: Consolas; font-size: x-small;"><span style="font-family: Consolas; font-size: x-small;"><span style="font-size: medium;">HSHELL_WINDOWCREATED</span> </span></span>message</li>
<li>If you find the process being created to be "cmd.exe" (the command prompt), enable blur and extend it into the client area using <span style="font-family: Consolas; font-size: x-small;"><span style="font-family: Consolas; font-size: x-small;"><span style="font-size: medium;">DwmEnableBlurBehindWindow</span> </span></span>and <span style="font-family: Consolas; font-size: x-small;"><span style="font-family: Consolas;"><span style="font-size: medium;">DwmExtendFrameIntoClientArea</span></span></span></li>
</ol>
<p>You're done! Also, you may try enabling transparent background for other applications as well, but I found it works best for cmd.exe</p>
<p>Just a little rest from WPF/Silverlight :)</p>
<p>Hope you like it! After all, what is life without <span style="text-decoration: line-through;">love</span> glass?&nbsp;Please comment!</p>