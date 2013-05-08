CKEDITOR.editorConfig = function( config )
{
    config.filebrowserParams = function(){
        var csrf_token = $('meta[name=csrf-token]').attr('content'),
                csrf_param = $('meta[name=csrf-param]').attr('content'),
                params = new Object();

        if (csrf_param !== undefined && csrf_token !== undefined) {
            params[csrf_param] = csrf_token;
        }

        return params;
    };
    config.toolbar = "MyToolbar";
    config.enterMode = CKEDITOR.ENTER_BR; 

    config.toolbar_MyToolbar =
    [
        ['Bold','Italic', 'Underline'],
        [ 'SpecialChar', '-', 'Scayt'] 
    ];

    config.toolbar_abridgedToolbar =
    [
        ['Bold','Italic', 'Underline'],
	['SpecialChar', '-', 'Scayt']
    ];

    config.extraPlugins = 'wordcount';
    config.wordcount = {
	showWordCount: true,
	showCharCount: true
    };

}
