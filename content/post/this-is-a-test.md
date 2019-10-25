+++
date = "2019-10-23T07:00:00+00:00"
draft = true
featured_image = "uploads/reportCard.png"
title = "How to make a super-fast blog using Hugo + GitHub and online editor for free"

+++
![](/uploads/reportCard.png)

When your site starts responding in the sub-10 millisecond range, something magical happens. It's so fast, that it almost feels unreal. 

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
               Human saves blog    Using Hugo              Auto-publish 
                     |               |                           |
    forestry editor --> nokola/blog --> nokola/nokola.github.io --> systemfailure.io

Setup steps:

1. Use [Hugo](https://gohugo.io/) to bootstrap a blog on  in [nokola/blog](https://github.com/nokola/blog "https://github.com/nokola/blog"). Posts are in markdown.

   Hugo is the "world's fastest framework for building websites" according to their homepage.
2. Build the site using [peaceiris/actions-hugo](https://github.com/peaceiris/actions-hugo "https://github.com/peaceiris/actions-hugo") into [nokola/nokola.github.io](https://github.com/nokola/nokola.github.io "https://github.com/nokola/nokola.github.io")

   See the build settings here: [publish-blog-hugo.yml](https://github.com/nokola/blog/blob/master/.github/workflows/publish-blog-hugo.yml "https://github.com/nokola/blog/blob/master/.github/workflows/publish-blog-hugo.yml")
3. 