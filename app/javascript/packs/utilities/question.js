$(document).on('turbolinks:load', function() {
    $('.edit-question-btn').on('click', function(e) {
        e.preventDefault();
        $(this.parentNode).hide()
        $('form#edit-question').removeClass('hidden')
    })
});
