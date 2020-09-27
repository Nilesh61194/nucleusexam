/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function (config) {
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';

    config.extraPlugins += (config.extraPlugins.length == 0 ? '' : ',') + 'ckeditor_wiris';
    config.allowedContent = true;
    config.height = '300px';

    config.toolbarGroups = [

               { name: 'basicstyles', groups: ['basicstyles', 'cleanup'] },
               { name: 'paragraph', groups: ['list', 'blocks', 'align', 'bidi', 'paragraph'] },
               { name: 'styles', groups: ['styles'] },
               { name: 'colors', groups: ['colors'] },
               { name: 'tools', groups: ['tools'] },
               { name: 'insert', groups: ['insert'] },
               { name: 'others', groups: ['others'] }

    ];

    config.removeButtons = 'Source,Save,Templates,Cut,Undo,Find,SelectAll,Scayt,Form,Outdent,Blockquote,BidiLtr,Link,Styles,About,SpecialChar,HorizontalRule,Strike,RemoveFormat,Maximize,Image';

};