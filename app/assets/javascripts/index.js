$(document).on(`turbolinks:load`, function() {
  $(`#sidebarCollapse`).on(`click`, function () {
    toggleStatus(`sidebarCollapse`, `#sidebar`, `active`);
    toggleStatus(`sidebarCollapse`, `.content`, `active`);
  });

  $(window).resize(function() {
    if ($(window).width() < 1275) {
      Cookies.set(`sidebarCollapse`, `active`, { path: `/` });
      $(`#sidebar`).addClass(Cookies.get(`sidebarCollapse`));
      $(`.content`).addClass(Cookies.get(`sidebarCollapse`));
    } else {
      $(`#sidebar`).removeClass(Cookies.get(`sidebarCollapse`));
      $(`.content`).removeClass(Cookies.get(`sidebarCollapse`));
      Cookies.set(`sidebarCollapse`, ``, { path: `/` });
    }
  });
});

function toggleStatus(cookie, element, cssClass) {
  if ($(element).hasClass(cssClass)) {
    $(element).removeClass(cssClass);
    Cookies.set(cookie, ``, { path: `/` });
  } else {
    $(element).addClass(cssClass);
    Cookies.set(cookie, cssClass, { path: `/` });
  }
}
