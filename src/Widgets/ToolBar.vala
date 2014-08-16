/***
The MIT License (MIT)

Copyright (c) 2014 Tuur Dutoit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
***/


using Gtk;
using Granite.Widgets;

namespace Writer.Widgets {
    public class ToolBar : Gtk.HeaderBar {
    
        private Editor editor;
    
        public ToolBar (Editor editor) {
            this.editor = editor;
            
            this.get_style_context ().add_class ("primary-toolbar");
            
            
            var paragraph_item = new ToolItem ();
                var paragraph_button = new Button.with_label ("Paragraph");
                paragraph_item.add (paragraph_button);
                
            var font_item = new ToolItem ();
                var font_button = new Button.with_label ("Open Sans");
                font_item.add (font_button);
                
            var font_size_item = new ToolItem ();
                var font_size_adjustment = new Adjustment (12, 8, 120, 1, 5, 5);
                var font_size_button = new SpinButton (font_size_adjustment, 1, 0);
                font_size_item.add (font_size_button);
                
            var styles_item = new ToolItem ();
                var styles_buttons = new ButtonGroup ();
                    var bold_button = new Button.from_stock (Stock.BOLD);
                        styles_buttons.pack_start (bold_button);
                    var italic_button = new Button.from_stock (Stock.ITALIC);
                        styles_buttons.pack_start (italic_button);
                    var underline_button = new Button.from_stock (Stock.UNDERLINE);
                        styles_buttons.pack_start (underline_button);
                    var strikethrough_button = new Button.from_stock (Stock.STRIKETHROUGH);
                        styles_buttons.pack_start (strikethrough_button);
                styles_item.add (styles_buttons);
                
            var align_item = new ToolItem ();
                var align_button = new ModeButton ();
                    align_button.append (new Image.from_stock (Stock.JUSTIFY_LEFT, IconSize.BUTTON));
                    align_button.append (new Image.from_stock (Stock.JUSTIFY_CENTER, IconSize.BUTTON));
                    align_button.append (new Image.from_stock (Stock.JUSTIFY_RIGHT, IconSize.BUTTON));
                    align_button.append (new Image.from_stock (Stock.JUSTIFY_FILL, IconSize.BUTTON));
                align_item.add (align_button);
                
            var insert_item = new ToolItem ();
                var insert_button = new Button.with_label ("Insert");
                insert_item.add (insert_button);
            
            
            this.add (paragraph_item);
            this.add (font_item);
            this.add (font_size_item);
            this.add (styles_item);
            this.add (align_item);
            this.add (insert_item);
            
            font_size_button.value_changed.connect (() => {
                change_font_size (font_size_button.get_value_as_int());
            });
            align_button.mode_changed.connect (() => {
                change_align (align_button.selected);
            });
            
            bold_button.clicked.connect (() => {
                editor.apply_style ("bold");
            });
            italic_button.clicked.connect (() => {
                editor.apply_style ("italic");
            });
            underline_button.clicked.connect (() => {
                editor.apply_style ("underline");
            });
            strikethrough_button.clicked.connect (() => {
                editor.apply_style ("strikehtough");
            });
            
        }
        
        public void change_font_size (int size) {
            editor.set_font_size (size);
        }
        
        public void change_style (int index) {
            if(index == 0) {
                editor.make_bold ();
            } else if (index == 1) {
                editor.make_italic ();
            } else if (index == 2) {
                editor.make_underline ();
            } else {
                editor.make_strikethrough ();
            }
        }
        
        public void change_align (int index) {
            if(index == 0) {
                editor.justify_left ();
            } else if (index == 1) {
                editor.justify_center ();
            } else if (index == 2) {
                editor.justify_right ();
            } else {
                editor.justify_fill ();
            }
        }
    
    }
}