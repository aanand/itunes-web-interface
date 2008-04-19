var Tracklist = {
    focus: null,
    
    init: function() {
        this.clearSelection();
        
        $('#tracklist')
            .click(function(event) {
                window.getSelection().removeAllRanges();
                
                var row = Tracklist.getClickedRow(event);
            
                if (!row) return;

                if (event.metaKey) {
                    Tracklist.toggleSelection(row);
                } else if (event.shiftKey && Tracklist.focus) {
                    Tracklist.selectTo(row);
                } else {
                    Tracklist.setSelection(row);
                }
            })
            .dblclick(function(event) {
                window.getSelection().removeAllRanges();

                if (Tracklist.selection.length == 0) {
                    Tracklist.setSelection(Tracklist.getClickedRow(event));
                }
                
                Tracklist.queueSelection();
            })
            .contextMenu('context_menu', {
                bindings: {
                    queue_selection: function() { Tracklist.queueSelection() },
                    play_selection: function() { Tracklist.playSelection() }
                },
                
                onShowMenu: function(event, menu) {
                    var row = Tracklist.getClickedRow(event);
                    
                    if (!row.hasClass('selected')) {
                        Tracklist.setSelection(row);
                    }
                    
                    return menu;
                }
            });
        
        if ($('#browser').show().length > 0) {
            $('#browser').css('height', '50%');
            $('#tracklist').css('top', '50%');
            
            var sourceId = window.location.pathname.match(/\d+$/)[0];
            var artist = '', album = '';
            
            $('#artists').click(function(event) {
                var li = $(event.target);

                $("#artists, #albums").children().removeClass('selected');
                li.addClass('selected');
                
                album = '';
                artist = li.text();
                if (artist == 'All') artist = '';
                
                filterTracklist();
            });

            $('#albums').click(function(event) {
                var li = $(event.target);

                $(this).children().removeClass('selected');
                li.addClass('selected');

                album = li.text();
                if (album == 'All') album = '';
                
                filterTracklist();
            });
            
            function filterTracklist() {
                $.post(
                    '/source/filter',

                    {source_id: sourceId, artist: artist, album: album},

                    function(data, textStatus) {
                        var albumList = $('#albums', data);
                        
                        if (albumList.length > 0) {
                            $('#albums').html(albumList.html());
                        }
                        
                        $('#tracklist').html($('#tracklist', data).html());
                    });
            }
        }
    },
    
    getClickedRow: function(event) {
        return $(event.target).parents('.row');
    },
    
    queueSelection: function() {
        var selection = this.selection;
        
        $.post('/track/queue', this.selectionPaths(), function() {
            selection.find('.icon').text('Q');
        });
    },

    playSelection: function() {
        var selection = this.selection;
        
        $.post('/track/play', this.selectionPaths(), function() {
            selection.find('.icon').text('Q');
        });
    },
    
    selectionPaths: function() {
        var paths = [];
        
        this.selection.each(function() {
            paths.push($(this).attr('title'));
        });
        
        return paths.join('\n');
    },
    
    clearSelection: function() {
        this.setSelection($('#NOTHING'));
    },
    
    setSelection: function(e) {
        if (this.selection) {
            this.selection.removeClass('selected');
        }
        
        this.selection = e.addClass('selected');
        
        if (this.selection.length == 1) {
            this.focus = this.selection.get(0);
        }
    },
    
    toggleSelection: function(e) {
        if (this.selection.index(e.get(0)) == -1) {
            e.addClass('selected');
            this.selection = this.selection.add(e);
        } else {
            e.removeClass('selected');
            this.selection = this.selection.not(e);
        }
    },
    
    selectTo: function(e) {
        e = e.eq(0);
        
        var pos = $(this.focus).nextAll().index(e.get(0));
        
        if (pos != -1) {
            this.setSelection($(this.focus).nextAll(':lt(' + (pos+1) + ')').andSelf());
        } else {
            pos = e.nextAll().index(this.focus);
            
            if (pos != -1) {
                Tracklist.setSelection(e.nextAll(':lt(' + (pos+1) + ')').andSelf());
            }
        }
    }
}

$(function(){Tracklist.init()});
