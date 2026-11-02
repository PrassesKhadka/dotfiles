-- PDF previewer: yazi's built-in one (a page per J/K step) with "page / total" under the page
local M = {}

local pdf = require("pdf")

local function page_count(path)
	local out = Command("pdfinfo"):arg({ tostring(path) }):output()
	if out and out.status.success then
		return tonumber(out.stdout:match("Pages:%s*(%d+)"))
	end
end

function M:peek(job)
	local start, cache = os.clock(), ya.file_cache(job)
	if not cache then
		return
	end

	local ok, err, bound = pdf:preload(job)
	if bound and bound > 0 then
		return ya.emit("peek", { bound - 1, only_if = job.file.url, upper_bound = true })
	elseif not ok or err then
		return ya.preview_widget(job, err)
	end

	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

	-- keep the bottom row free for the page counter
	local a = job.area
	local shown, err = ya.image_show(cache, ui.Rect { x = a.x, y = a.y, w = a.w, h = math.max(1, a.h - 1) })
	if not shown then
		return ya.preview_widget(job, err)
	end

	local label = string.format(" %d / %s ", job.skip + 1, page_count(job.file.path) or "?")
	local style = ui.Style():fg("#1b1d1e"):bg("#e6dc44"):bold()
	ya.preview_widget(
		job,
		ui.Line(ui.Span(label):style(style))
			:area(ui.Rect { x = shown.x, y = shown.y + shown.h, w = shown.w, h = 1 })
			:align(ui.Align.CENTER)
	)
end

function M:seek(job) pdf:seek(job) end

function M:preload(job) return pdf:preload(job) end

return M
