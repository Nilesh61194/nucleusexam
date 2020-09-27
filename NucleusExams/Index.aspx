<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="NucleusExams.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Index Demo</title>
    <script src="ckeditor4/ckeditor.js"></script>
    <script src="Scripts/jquery.min.js"></script>
    <style>
        textarea {
            padding: 10px;
            vertical-align: top;
            width: 200px;
        }

            textarea:focus {
                outline-style: solid;
                outline-width: 2px;
            }
    </style>
    <script>

        //$(document).ready(function () {
        //    // executes when HTML-Document is loaded and DOM is ready
        //    console.log("document is ready");
        //});


        //$(window).load(function () {
        //    // executes when complete page is fully loaded, including all frames, objects and images
        //    console.log("window is loaded");
        //});


        //$(document).ready(function () {
        //    window.setInterval(function () {
        //        //debugger;
        //        CheckNet();
        //    }, 10000);
        //});

        //function CheckNet() {
        //    //debugger;
        //    var ifConnected = window.navigator.onLine;
        //    if (ifConnected) {
        //        console.log('Connection available');
        //    } else {
        //        alert('Your wi-fi connection is lost.\nPlease check your wi-fi connection. \nRe-login for exam again.');
        //    }
        //}

        //var myVar;
        //function callSave() {
        //    alert('hello');
        //}

        //function StopAutoSave() {
        //    clearInterval(myVar);
        //}

        //$(document).ready(function () {
        //    window.setInterval(function () {
        //        callSave();
        //    }, 10000);
        //});


        //var myVar = setInterval(myTimer, 1000);

        //function myTimer(a) {
        //    var d = new Date();
        //    var t = d.toLocaleTimeString();
        //    alert(t);

        //}

        //function myStopFunction() {
        //    clearInterval(myVar);
        //}

        //$(document).ready(function () {
        //    myVar = setInterval(callSave(), 10000);
        //});
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="text-center">
            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion1');" onfocusout="return StopAutoSave('txtQuestion1');"></asp:TextBox>
            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion1')" class="btn btn-primary">Save</button>
            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
        </div>
        <div class="text-center">
            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion2')" class="btn btn-primary">Save</button>
            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
        </div>
        <div>
            <%--<asp:TextBox ID="txt1" runat="server" TextMode="MultiLine"></asp:TextBox>--%>
            <textarea>Nilesh Lokhande 
                Hello 
                Fs '
                Organization 
                Demo 
                Trial

            </textarea>
        </div>
    </form>
</body>
<script>
    autosize(document.querySelectorAll('textarea'));
</script>
</html>


<%--<script> const map = (typeof Map === "function") ? new Map() : (function () {
        const keys = [];
        const values = [];

        return {
            has(key) {
                return keys.indexOf(key) > -1;
            },
            get(key) {
                return values[keys.indexOf(key)];
            },
            set(key, value) {
                if (keys.indexOf(key) === -1) {
                    keys.push(key);
                    values.push(value);
                }
            },
            delete(key) {
                const index = keys.indexOf(key);
                if (index > -1) {
                    keys.splice(index, 1);
                    values.splice(index, 1);
                }
            },
        }
    })();

    let createEvent = (name)=> new Event(name, {bubbles: true});
    try {
        new Event('test');
    } catch(e) {
        // IE does not support `new Event()`
        createEvent = (name)=> {
            const evt = document.createEvent('Event');
            evt.initEvent(name, true, false);
            return evt;
        };
    }

    function assign(ta) {
        if (!ta || !ta.nodeName || ta.nodeName !== 'TEXTAREA' || map.has(ta)) return;

        let heightOffset = null;
        let clientWidth = null;
        let cachedHeight = null;

        function init() {
            const style = window.getComputedStyle(ta, null);

            if (style.resize === 'vertical') {
                ta.style.resize = 'none';
            } else if (style.resize === 'both') {
                ta.style.resize = 'horizontal';
            }

            if (style.boxSizing === 'content-box') {
                heightOffset = -(parseFloat(style.paddingTop)+parseFloat(style.paddingBottom));
            } else {
                heightOffset = parseFloat(style.borderTopWidth)+parseFloat(style.borderBottomWidth);
            }
            // Fix when a textarea is not on document body and heightOffset is Not a Number
            if (isNaN(heightOffset)) {
                heightOffset = 0;
            }

            update();
        }

        function changeOverflow(value) {
            {
                // Chrome/Safari-specific fix:
                // When the textarea y-overflow is hidden, Chrome/Safari do not reflow the text to account for the space
                // made available by removing the scrollbar. The following forces the necessary text reflow.
                const width = ta.style.width;
                ta.style.width = '0px';
                // Force reflow:
                /* jshint ignore:start */
                ta.offsetWidth;
                /* jshint ignore:end */
                ta.style.width = width;
            }

            ta.style.overflowY = value;
        }

        function getParentOverflows(el) {
            const arr = [];

            while (el && el.parentNode && el.parentNode instanceof Element) {
                if (el.parentNode.scrollTop) {
                    arr.push({
                        node: el.parentNode,
                        scrollTop: el.parentNode.scrollTop,
                    })
                }
                el = el.parentNode;
            }

            return arr;
        }

        function resize() {
            if (ta.scrollHeight === 0) {
                // If the scrollHeight is 0, then the element probably has display:none or is detached from the DOM.
                return;
            }

            const overflows = getParentOverflows(ta);
            const docTop = document.documentElement && document.documentElement.scrollTop; // Needed for Mobile IE (ticket #240)

            ta.style.height = '';
            ta.style.height = (ta.scrollHeight+heightOffset)+'px';

            // used to check if an update is actually necessary on window.resize
            clientWidth = ta.clientWidth;

            // prevents scroll-position jumping
            overflows.forEach(el => {
                el.node.scrollTop = el.scrollTop
            });

            if (docTop) {
                document.documentElement.scrollTop = docTop;
            }
        }

        function update() {
            resize();

            const styleHeight = Math.round(parseFloat(ta.style.height));
            const computed = window.getComputedStyle(ta, null);

            // Using offsetHeight as a replacement for computed.height in IE, because IE does not account use of border-box
            var actualHeight = computed.boxSizing === 'content-box' ? Math.round(parseFloat(computed.height)) : ta.offsetHeight;

            // The actual height not matching the style height (set via the resize method) indicates that
            // the max-height has been exceeded, in which case the overflow should be allowed.
            if (actualHeight < styleHeight) {
                if (computed.overflowY === 'hidden') {
                    changeOverflow('scroll');
                    resize();
                    actualHeight = computed.boxSizing === 'content-box' ? Math.round(parseFloat(window.getComputedStyle(ta, null).height)) : ta.offsetHeight;
                }
            } else {
                // Normally keep overflow set to hidden, to avoid flash of scrollbar as the textarea expands.
                if (computed.overflowY !== 'hidden') {
                    changeOverflow('hidden');
                    resize();
                    actualHeight = computed.boxSizing === 'content-box' ? Math.round(parseFloat(window.getComputedStyle(ta, null).height)) : ta.offsetHeight;
                }
            }

            if (cachedHeight !== actualHeight) {
                cachedHeight = actualHeight;
                const evt = createEvent('autosize:resized');
                try {
                    ta.dispatchEvent(evt);
                } catch (err) {
                    // Firefox will throw an error on dispatchEvent for a detached element
                    // https://bugzilla.mozilla.org/show_bug.cgi?id=889376
                }
            }
        }

        const pageResize = () => {
            if (ta.clientWidth !== clientWidth) {
                update();
            }
        };

        const destroy = (style => {
            window.removeEventListener('resize', pageResize, false);
            ta.removeEventListener('input', update, false);
            ta.removeEventListener('keyup', update, false);
            ta.removeEventListener('autosize:destroy', destroy, false);
            ta.removeEventListener('autosize:update', update, false);

            Object.keys(style).forEach(key => {
                ta.style[key] = style[key];
            });

            map.delete(ta);
        }).bind(ta, {
            height: ta.style.height,
            resize: ta.style.resize,
            overflowY: ta.style.overflowY,
            overflowX: ta.style.overflowX,
            wordWrap: ta.style.wordWrap,
        });

        ta.addEventListener('autosize:destroy', destroy, false);

        // IE9 does not fire onpropertychange or oninput for deletions,
        // so binding to onkeyup to catch most of those events.
        // There is no way that I know of to detect something like 'cut' in IE9.
        if ('onpropertychange' in ta && 'oninput' in ta) {
            ta.addEventListener('keyup', update, false);
        }

        window.addEventListener('resize', pageResize, false);
        ta.addEventListener('input', update, false);
        ta.addEventListener('autosize:update', update, false);
        ta.style.overflowX = 'hidden';
        ta.style.wordWrap = 'break-word';

        map.set(ta, {
            destroy,
            update,
        });

        init();
    }

    function destroy(ta) {
        const methods = map.get(ta);
        if (methods) {
            methods.destroy();
        }
    }

    function update(ta) {
        const methods = map.get(ta);
        if (methods) {
            methods.update();
        }
    }

    let autosize = null;

    // Do nothing in Node.js environment and IE8 (or lower)
    if (typeof window === 'undefined' || typeof window.getComputedStyle !== 'function') {
        autosize = el => el;
        autosize.destroy = el => el;
        autosize.update = el => el;
    } else {
        autosize = (el, options) => {
            if (el) {
                Array.prototype.forEach.call(el.length ? el : [el], x => assign(x, options));
            }
            return el;
        };
        autosize.destroy = el => {
            if (el) {
                Array.prototype.forEach.call(el.length ? el : [el], destroy);
            }
            return el;
        };
        autosize.update = el => {
            if (el) {
                Array.prototype.forEach.call(el.length ? el : [el], update);
            }
            return el;
        };
    }

export default autosize;

</script>--%>
