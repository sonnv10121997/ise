$(document).on('turbolinks:load', () => {
    initTabs();
    initDropdown();

    function initTabs() {
        const tab = $('.tab');
        if (tab.length) {
            tab.on('click', function () {
                tab.removeClass('active');
                $(this).addClass('active');
                const clickedIndex = tab.index(this);
                console.log(clickedIndex);
                const panels = $('.tab_panel');
                panels.removeClass('active');
                $(panels[clickedIndex]).addClass('active');
            });
        }
    }

    function initDropdown() {
        const dropdownList = $('.dropdowns li');
        if (dropdownList.length) {
            dropdownList.each(function () {
                const dropdown = $(this);
                if (dropdown.hasClass('has_children')) {
                    if (dropdown.hasClass('active')) {
                        const panel = $(dropdown.find('> ul'));
                        const panelH = panel.prop('scrollHeight') + "px";

                        if (panel.css('max-height') === "0px") {
                            panel.css('max-height', `${panel.prop('scrollHeight')}px`);
                        } else {
                            panel.css('max-height', "0px");
                        }
                    }

                    dropdown.find(' > .dropdown_item').on('click', () => {
                        const panel = $(dropdown.find('> ul'));
                        const panelH = panel.prop('scrollHeight') + "px";
                        dropdown.toggleClass('active');

                        if (panel.css('max-height') === "0px") {
                            panel.css('max-height', `${panel.prop('scrollHeight')}px`);
                        } else {
                            panel.css('max-height', "0px");
                        }
                    });
                }
            });
        }
    }
})