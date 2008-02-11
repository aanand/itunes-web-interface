$(function() {
    // alternating row colours
    $('#content tr:odd td').addClass('odd');

    // header gradient
    // $('#content th').gradient({from: 'dbdbdb', to: 'bbbbbb'});
    
    // context menu
    // $('tr').each(function() {
    //     var ul = $(this).find('td.actions ul:first').attr('id', uniqueId());
    //     var bindings = {}
    //     
    //     ul.find('li').each(function() {
    //         $(this).attr('id', uniqueId());
    //         bindings[$(this).attr('id')] = function() { console.log('hi!') };
    //     });
    //     
    //     $(this).contextMenu(ul.attr('id'), {
    //         onContextMenu: function() { console.log('hello') }
    //     });
    // });

    $('.actions').hide();
    
    // select on click
    $('#content tr').click(function() {
        $('.selected').removeClass('selected');
        $(this).addClass('selected');
    });

    // play on double-click
    $('#content tr').dblclick(function() {
        $.ajax({url: $(this).find('.action_play').attr('href')});
    });
    
    function uniqueId() {
        return 'uniqueId_' + new String(Math.random()).replace('0.', '');
    }
});
