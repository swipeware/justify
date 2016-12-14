-- main.lua
--

local widget = require( "widget" )
local justify = require("justify")

local myText = "تتمتع عمان بوضع سياسي واقتصادي مستقر في العموم، مع ذلك شهدت السلطنة احتجاجات محدودة في ولاية صحار مطالبين برفع الرواتب وإنهاء الفساد وإيجاد المزيد من الفرص الوظيفية، المزيد من حرية التعبير وتقليل الرقابة الحكومية على الإعلام ولم تطالب بإسقاط نظام الحكم [10] رد السلطان قابوس بن سعيد بإقالة ثلث أعضاء حكومته من مناصبهم [11] وتشتهر عمان بأنها أحد أهم مراكز المذهب الإباضي، حيث يعتبر المذهب الآساسي في الحكم ، بالاضافة لوجود المذهب السني والشيعي.[12]"
--local myText = "This is to test non-RTL text. This is some other text that will wrap automatically and also justify the text with full justification leaving the same margins on both the left and right side of the paragraph. It will adjust the spacing between words automatically."

-- scrollView
local scrollView = widget.newScrollView
{
    top          = display.statusBarHeight,
    left         = 10,
    width        = display.contentWidth -20,
    height       = display.contentHeight - display.statusBarHeight*2,
    scrollWidth  = display.contentWidth -20,
    scrollHeight = 1000
}
 
local paragraph = justify.justifyFull {
    maxWidth  = scrollView.width - 20,
    rtl       = true,
    text      = myText, 
    font      = native.systemFont, 
    fontSize  = 12,
    fillColor = {0.2}
}

paragraph.x = 10
scrollView:insert(paragraph)
