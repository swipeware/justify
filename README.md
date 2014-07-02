A simple Corona SDK module. Includes a function that adjusts the spacing between the words on each line of the given text so that the left and right margins are the same. 
The function returns a display group with a top-left anchor point.
 
 
#Syntax
```
justifyFull( options )
```
This function takes a single argument, options, which is a table that accepts the following parameters:  
  
**maxWidth (optional)**  
Number. The maximum width of each line. Defaults to display.contentWidth.  
  
**rtl (optional)**  
Boolean. Set to true if using an RTL text string (like Arabic). Defaults to false  
   
**text (required)**  
String. The text to justify.  
   
**font (optional)**  
String. Name of the font. Defaults to native.systemFont.  
   
**fontSize (optional)**  
Number. Font size. Defaults to 12.  
   
**fillColor (optional)**  
Table. A table with RGBA color values. Defaults to {1}.  
 
 
#Gotchas  
(1) You can't change the anchor point of the returned display group. It's fixed at 0, 0.  
(2) The justified text can't be modified. If you need to modify a word within the text the whole paragraph must be recreated.
