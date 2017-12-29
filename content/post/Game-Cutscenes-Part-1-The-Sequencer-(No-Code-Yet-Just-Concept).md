---
title: "Game Cutscenes Part 1 - The Sequencer (No Code Yet, Just Concept)"
date: 2010-01-04T11:13:00.0000000
draft: false
featured_image: ""
---

<p>This post is a call for initial feedback, before&nbsp;I go deeper into coding and stuff, just to make sure I'm not missing anything and capture cool ideas...</p>
<p>I've been working on a new game recently, and thought it would be really nice to have some cutscenes in the game.</p>
<p>Here's a sample frame such a scene:&nbsp;</p>
<p><img src="/2010%2f1%2fsequencerFrame.jpg" alt="" /></p>
<p>Obviously, the above frame is not too advanced, but it looks pretty exciting and fun to create, especially when combined with the right <a href="http://www.jamendo.com/en/track/252004">soundtrack</a></p>
<p>Credits:</p>
<p>&nbsp;&nbsp; Image background: <a href="http://shadow-trance.deviantart.com/art/Moonshine-Bay-88935567">http://shadow-trance.deviantart.com/art/Moonshine-Bay-88935567</a></p>
<p>&nbsp;&nbsp; Ninja warriors: <a href="http://tinrobo.deviantart.com/art/Little-Samurai-Warriors-80135868">http://tinrobo.deviantart.com/art/Little-Samurai-Warriors-80135868</a>&nbsp;</p>
<p>&nbsp;&nbsp; Both image sources are by-nc-sa CC license: <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">http://creativecommons.org/licenses/by-nc-sa/3.0/</a></p>
<h2>The Sequencer</h2>
<p>What we really need is a way to control all game "events" (such as encounters, text on screen, music, etc). The Sequencer is a central point (e.g. a C# class), that "knows" about high-level game events, such as "Level1 Start", or "Battle 2 Encounter".</p>
<p>The sequencer controls all in-game events, such as text being displayed, cutscenes, music sync (for example, when a cutscene starts, the sequencer will switch the music).</p>
<p>Here's a small high-level diagram of what I think is needed to implement a single-screen cutscene:</p>
<p>&nbsp;</p>
<p><img src="/2010%2f1%2fsequencer.jpg" alt="" /></p>
<p>I'm assuming that Sequencer, Sequence and the Action-s will end up as C# classes that know how to operate on the game world.</p>
<p>In the above diagram, Sequence1 might represent the complete cut-scene, with all dialogue that occurs.</p>
<h2>Interface</h2>
<p>&nbsp;</p>
<p><img src="/2010%2f1%2fconceptUI.jpg" alt="" /></p>
<p>Above is&nbsp;a draft interface (made with Paint, if it's not obvious :))&nbsp; for creating the cutscenes.</p>
<p>The initial version of the interface will allow for:</p>
<ul>
<li>Choosing music (1 only)</li>
<li>Selecting background</li>
<li>Adding characters, dialogue, movements, synced to the music</li>
<li>Save as XML</li>
</ul>
<p>That's all for now.</p>
<p><strong>Any ideas that you'd like to share or other feedback?</strong>&nbsp;Please comment.</p>