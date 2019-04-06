/*
* Copyright (c) 2014-2018 Writer Developers
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

namespace Writer.Widgets {
    public class TextToolBar : Gtk.Toolbar {
        public TextEditor editor { get; construct; }
        public Gtk.ToggleButton bold_button;
        public Gtk.ToggleButton italic_button;
        public Gtk.ToggleButton underline_button;
        public Gtk.ToggleButton strikethrough_button;
        public Gtk.Button indent_more_button;
        public Gtk.Button indent_less_button;
        public Granite.Widgets.ModeButton align_button;
        public Gtk.SeparatorToolItem item_separator;

        public TextToolBar (TextEditor editor) {
            Object (
                editor: editor
            );
        }

        construct {
            get_style_context ().add_class ("writer-toolbar");

            editor.cursor_moved.connect (cursor_moved);

            var paragraph_combobox = new Gtk.ComboBoxText ();
            paragraph_combobox.append ("Paragraph", ("Paragraph"));
            paragraph_combobox.append ("Title", ("Title"));
            paragraph_combobox.append ("Subtitle", ("Subtitle"));
            paragraph_combobox.append ("Bullet List", ("Bullet List"));
            paragraph_combobox.append ("Numbered List", ("Numbered List"));
            paragraph_combobox.append ("Two-Column", ("Two-Column"));
            paragraph_combobox.set_active_id ("Paragraph");
            var paragraph_item = new Gtk.ToolItem ();
            paragraph_item.add (paragraph_combobox);

            var font_button = new Gtk.ToggleButton ();
            var font_item = new Gtk.ToolItem ();
            font_item.add (font_button);

            var font_popover = new Gtk.Popover (font_button);
            font_popover.border_width = 12;
            var font_chooser = new Gtk.FontChooserWidget ();
            // TODO: Allow to set default font in PreferenceWindow
            font_chooser.set_font ("Open Sans 12");
            font_popover.add (font_chooser);

            font_button.label = font_chooser.font;

            var font_color_button = new Gtk.ToggleButton ();
            font_color_button.width_request = 42;
            var font_color_item = new Gtk.ToolItem ();
            font_color_item.add (font_color_button);

            var font_color_popover = new Gtk.Popover (font_color_button);
            var font_color_header = new Granite.HeaderLabel ("Font Color");
            var font_color_chooser = new Gtk.ColorChooserWidget ();
            font_color_chooser.rgba = { 0, 0, 0, 1 };
            font_color_chooser.show_editor = false;
            var font_color_grid = new Gtk.Grid ();
            font_color_grid.margin = 12;
            font_color_grid.margin_top = 6;
            font_color_grid.attach (font_color_header, 0, 0, 1, 1);
            font_color_grid.attach (font_color_chooser, 0, 1, 1, 1);
            font_color_popover.add (font_color_grid);

            bold_button = new Gtk.ToggleButton ();
            bold_button.add (new Gtk.Image.from_icon_name ("format-text-bold-symbolic", Gtk.IconSize.BUTTON));
            bold_button.focus_on_click = false;
            italic_button = new Gtk.ToggleButton ();
            italic_button.add (new Gtk.Image.from_icon_name ("format-text-italic-symbolic", Gtk.IconSize.BUTTON));
            italic_button.focus_on_click = false;
            underline_button = new Gtk.ToggleButton ();
            underline_button.add (new Gtk.Image.from_icon_name ("format-text-underline-symbolic", Gtk.IconSize.BUTTON));
            underline_button.focus_on_click = false;
            strikethrough_button = new Gtk.ToggleButton ();
            strikethrough_button.add (new Gtk.Image.from_icon_name ("format-text-strikethrough-symbolic", Gtk.IconSize.BUTTON));
            strikethrough_button.focus_on_click = false;
            var styles_buttons = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            styles_buttons.get_style_context ().add_class (Gtk.STYLE_CLASS_LINKED);
            styles_buttons.pack_start (bold_button);
            styles_buttons.pack_start (italic_button);
            styles_buttons.pack_start (underline_button);
            styles_buttons.pack_start (strikethrough_button);
            var styles_item = new Gtk.ToolItem ();
            styles_item.add (styles_buttons);

            align_button = new Granite.Widgets.ModeButton ();
            align_button.append (new Gtk.Image.from_icon_name ("format-justify-left-symbolic", Gtk.IconSize.BUTTON));
            align_button.append (new Gtk.Image.from_icon_name ("format-justify-center-symbolic", Gtk.IconSize.BUTTON));
            align_button.append (new Gtk.Image.from_icon_name ("format-justify-right-symbolic", Gtk.IconSize.BUTTON));
            align_button.append (new Gtk.Image.from_icon_name ("format-justify-fill-symbolic", Gtk.IconSize.BUTTON));
            var align_item = new Gtk.ToolItem ();
            align_item.add (align_button);

            var indent_more_button = new Gtk.Button.from_icon_name ("format-indent-more-symbolic", Gtk.IconSize.BUTTON);
            var indent_less_button = new Gtk.Button.from_icon_name ("format-indent-less-symbolic", Gtk.IconSize.BUTTON);
            var indent_button = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            indent_button.get_style_context ().add_class (Gtk.STYLE_CLASS_LINKED);
            indent_button.add (indent_more_button);
            indent_button.add (indent_less_button);
            var indent_item = new Gtk.ToolItem ();
            indent_item.add (indent_button);

            item_separator = new Gtk.SeparatorToolItem ();

            var insert_comment_button = new Gtk.Button.from_icon_name ("insert-text-symbolic", Gtk.IconSize.BUTTON);
            var insert_link_button = new Gtk.Button.from_icon_name ("insert-link-symbolic", Gtk.IconSize.BUTTON);
            var insert_image_button = new Gtk.Button.from_icon_name ("insert-image-symbolic", Gtk.IconSize.BUTTON);
            var insert_table_button = new Gtk.Button.from_icon_name ("insert-object-symbolic", Gtk.IconSize.BUTTON);
            var insert_button = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            insert_button.get_style_context ().add_class (Gtk.STYLE_CLASS_LINKED);
            insert_button.add (insert_comment_button);
            insert_button.add (insert_link_button);
            insert_button.add (insert_image_button);
            insert_button.add (insert_table_button);
            var insert_item = new Gtk.ToolItem ();
            insert_item.add (insert_button);

            paragraph_item.border_width = 6;
            font_item.border_width = 6;
            font_color_item.border_width = 6;
            styles_item.border_width = 6;
            align_item.border_width = 6;
            indent_item.border_width = 6;
            insert_item.border_width = 6;

            add (paragraph_item);
            add (font_item);
            add (font_color_item);
            add (styles_item);
            add (align_item);
            add (indent_item);
            add (item_separator);
            add (insert_item);

            align_button.mode_changed.connect (() => {
                change_align (align_button.selected);
            });
            font_chooser.font_activated.connect (() => {
                editor.set_font_from_string (font_chooser.font);
                font_popover.hide ();
                font_button.label = font_chooser.font;
            });
            font_button.toggled.connect (() => {
                if (font_button.active) {
                    font_popover.show_all ();
                }
            });
            font_popover.closed.connect (() => {
                font_button.active = false;
            });
            font_color_button.toggled.connect (() => {
                if (font_color_button.active) {
                    font_color_popover.show_all ();
                }
            });
            font_color_popover.closed.connect (() => {
                font_color_button.active = false;
            });
            font_color_button.draw.connect ((cr) => {
                int width = font_color_button.get_allocated_width ();
                int height = font_color_button.get_allocated_height ();
                const int BORDER = 6;

                // TODO: Reflect the current selected color
                cr.set_source_rgba (0, 0, 0, 1);
                cr.rectangle (BORDER, BORDER, width - (BORDER * 2), height - (BORDER * 2));
                cr.fill ();

                return false;
            });
            font_color_chooser.notify["rgba"].connect (() => {
                var rgba = Gdk.RGBA ();
                rgba = font_color_chooser.rgba;
                editor.set_font_color (rgba);
                font_color_popover.hide ();
            });
            bold_button.button_press_event.connect ((event) => {
                if (event.type == Gdk.EventType.BUTTON_PRESS) {
                    editor.toggle_style ("bold");
                }
                return false;
            });
            italic_button.button_press_event.connect ((event) => {
                if (event.type == Gdk.EventType.BUTTON_PRESS) {
                    editor.toggle_style ("italic");
                }
                return false;
            });
            underline_button.button_press_event.connect ((event) => {
                if (event.type == Gdk.EventType.BUTTON_PRESS) {
                    editor.toggle_style ("underline");
                }
                return false;
            });
            strikethrough_button.button_press_event.connect ((event) => {
                if (event.type == Gdk.EventType.BUTTON_PRESS) {
                    editor.toggle_style ("strikethrough");
                }
                return false;
            });
        }

        /*
         * Signal callbacks
         */

        public void change_align (int index) {
            switch (index) {
                case 1:
                    editor.set_justification ("center"); break;
                case 2:
                    editor.set_justification ("right"); break;
                case 3:
                    editor.set_justification ("fill"); break;
                default:
                    editor.set_justification ("left"); break;
            }
        }

        public void cursor_moved () {
            bold_button.active = editor.has_style ("bold");
            italic_button.active = editor.has_style ("italic");
            underline_button.active = editor.has_style ("underline");
            strikethrough_button.active = editor.has_style ("strikethrough");

            align_button.selected = editor.get_justification_as_int ();

            // TODO
            // Update font and color Gtk.Buttons
        }
    }
}
