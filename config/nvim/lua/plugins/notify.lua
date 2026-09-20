return {
    'rcarriga/nvim-notify',
    config = function ()
        require('notify').setup({
            icons = {
                ERROR = '',
                WARN = '',
                INFO = '',
                DEBUG = '',
                TRACE = '✎',
            },
            stages = 'static',
        })
    end
}
