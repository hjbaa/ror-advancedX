$(document).on('turbolinks:load', function() {
    $('.voting form').on('ajax:success', function(e) {
        let vote = e.detail[0];
        let votingDiv = $(this).closest('.voting')
        let ratingCell = votingDiv.find('.rating')[0];
        let newCell = document.createElement('td');
        newCell.innerText = editString(ratingCell.outerText, vote.value);
        ratingCell.replaceWith(newCell);
        votingDiv.find('form').closest('td').remove();
        let cancelVoteLink = document.createElement('a');
        cancelVoteLink.setAttribute('data-method', 'delete');
        cancelVoteLink.setAttribute('href', '/votes/' + vote.id.toString());
        cancelVoteLink.innerText = 'Cancel vote';
        let cell = document.createElement('td');
        cell.appendChild(cancelVoteLink)
        votingDiv.find('table')[0].append(cell)
    })
});

function editString(str, value) {
    let wordArray = str.split(' ');
    wordArray[wordArray.length - 1] = (Number(wordArray[wordArray.length - 1]) + value).toString();
    return wordArray.join(' ');
}
