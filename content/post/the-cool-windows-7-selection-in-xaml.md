---
title: "The Cool Windows 7 Selection in XAML"
date: 2009-08-26T16:23:38-08:00
draft: false
featured_image: "xaml-selection.jpg"
---

Here's the XAML to make a selection rectangle similar to the one in Win7:
<!--more-->
``` XAML
<Grid Height="22" Width="300" > 
    <Rectangle Stroke="#FF7DA2CE" RadiusX="2" RadiusY="2">
        <Rectangle.Fill>
            <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                <GradientStop Color="#FFDCEBFC" Offset="0" />
                <GradientStop Color="#FFC1DBFC" Offset="1" />
            </LinearGradientBrush>
        </Rectangle.Fill>
    </Rectangle>
    <Rectangle Margin="1" Stroke="#FFEBF4FD" RadiusX="2" RadiusY="2" Fill="{x:Null}">
    </Rectangle>
</Grid>
```