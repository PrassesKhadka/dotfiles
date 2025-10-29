-- To comment/uncomment/toggle between comments
return {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
        require('Comment').setup()
    end
}
