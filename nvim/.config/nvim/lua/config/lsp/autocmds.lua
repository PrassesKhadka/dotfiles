-- Run optimize imports automatically on save + auto import on save
-- Function to attach auto-import and optimize-imports on save
local function setup_lsp_autocmds(client, bufnr)
    -- Only attach if the server supports code actions
    if not client.server_capabilities.codeActionProvider then return end

    -- Create autocmd for this buffer only
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            -- Add missing imports (if supported)
            pcall(function()
                vim.lsp.buf.code_action({
                    context = { only = { "source.addMissingImports" } },
                    apply = true,
                })
            end)

            -- Organize / optimize imports (if supported)
            pcall(function()
                vim.lsp.buf.code_action({
                    context = { only = { "source.organizeImports" } },
                    apply = true,
                })
            end)
        end,
    })
end

-- Expose a function to attach this to LSPs
return {
    attach = setup_lsp_autocmds,
}
