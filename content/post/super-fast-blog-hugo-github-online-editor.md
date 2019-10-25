+++
date = "2019-10-23T07:00:00+00:00"
featured_image = ""
title = "Make a super-fast blog using Hugo+GitHub+online editor for free"

+++
![](/uploads/reportCard.png)

When your site starts responding in the sub-10 millisecond range, something magical happens. It's so fast, that it almost feels unreal.

Total setup time: \~2-4 hours first time following the info below.

<!--more-->

This is how I made [https://systemfailure.io](https://systemfailure.io "System Failure"):

The general idea:

1. Use [GitHub](https://github.com) for storing all files in [nokola/blog](https://github.com/nokola/blog "https://github.com/nokola/blog")
2. Use [Hugo](https://gohugo.io/) for building the static site from [nokola/blog](https://github.com/nokola/blog "https://github.com/nokola/blog") to [nokola/nokola.github.io](https://github.com/nokola/nokola.github.io "https://github.com/nokola/nokola.github.io")
3. Use GitHub Pages to specify that [nokola/nokola.github.io](https://github.com/nokola/nokola.github.io "https://github.com/nokola/nokola.github.io") will publish on [https://systemfailure.io](https://systemfailure.io)
4. Use [Forestry.io](https://forestry.io)
5. Test the final speed using [https://testmysite.io/](https://testmysite.io/ "https://testmysite.io/"), rejoice, and gloat (FYI: it's faster than Netlify, the leading speed provider.)

After all setup is done, the data flow looks like this:

                                   GitHub                 
                                   Actions                
                                   Autobuild               GitHub Pages   
               Human saves blog    Using Hugo ~45sec       Auto-publish (10-30sec)
                     |               |                           |
    forestry editor --> nokola/blog --> nokola/nokola.github.io --> systemfailure.io

The whole auto-publish takes about 1.5 minutes from clicking Save in Forestry to until the site is live.

Setup steps:

1. Use [Hugo](https://gohugo.io/) to bootstrap a blog on your repository (e.g. [nokola/blog](https://github.com/nokola/blog "https://github.com/nokola/blog")). Posts are in markdown.
   Hugo is the "world's fastest framework for building websites" according to their homepage.
2. Add a CNAME file in the static folder pointing to your final site, e.g. systemfailure.io.

   Example: [nokola/blog/static/CNAME](https://github.com/nokola/blog/blob/master/static/CNAME "https://github.com/nokola/blog/blob/master/static/CNAME")
3. Build the site using [peaceiris/actions-hugo](https://github.com/peaceiris/actions-hugo "https://github.com/peaceiris/actions-hugo") into [nokola/nokola.github.io](https://github.com/nokola/nokola.github.io "https://github.com/nokola/nokola.github.io"):

   a. [Sign up for GitHub actions](https://github.com/features/actions).

   b. Add ssh deploy key ([instructions](https://github.com/peaceiris/actions-gh-pages#1-add-ssh-deploy-key)) and secret to allow GitHub Actions to publish to  nokola/blog -> nokola/nokola.github.io. I named my secret NOKOLA_BLOG_WRITE_KEY

   c. Add this settings file: [publish-blog-hugo.yml](https://github.com/nokola/blog/blob/master/.github/workflows/publish-blog-hugo.yml "https://github.com/nokola/blog/blob/master/.github/workflows/publish-blog-hugo.yml"), which explains the steps to publish blog --> nokola.github.io. Also references the above secret: NOKOLA_BLOG_WRITE_KEY
   **At this point, you will have auto-buildable site** from nokola/blog to nokola/nokola.github.io!
4. Setup GitHub Pages to publish to systemfailure.io. Multiple steps here, see [https://pages.github.com/](https://pages.github.com/ "https://pages.github.com/")
5. Sign up for free account on [forestry.io](https://forestry.io), import nokola/blog and start writing!

Here's another useful benchmark across world severs: [https://performance.sucuri.net/domain/systemfailure.io](https://performance.sucuri.net/domain/systemfailure.io "https://performance.sucuri.net/domain/systemfailure.io")

Enjoy!