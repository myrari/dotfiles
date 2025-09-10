-- nvim-autopairs config

return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		init = function()
			local Rule = require("nvim-autopairs.rule")
			local npairs = require("nvim-autopairs")
			local cond = require("nvim-autopairs.conds")

			-- add spaces inside brackets
			local brackets = {
				{ '(', ')' }, { '[', ']' }, { '{', '}' }
			}
			npairs.add_rules({
				-- Rule for a pair with left-side ' ' and right side ' '
				Rule(' ', ' ')
				-- Pair will only occur if the conditional function returns true
					:with_pair(function(opts)
						-- We are checking if we are inserting a space in (), [], or {}
						local pair = opts.line:sub(opts.col - 1, opts.col)
						return vim.tbl_contains({
							brackets[1][1] .. brackets[1][2],
							brackets[2][1] .. brackets[2][2],
							brackets[3][1] .. brackets[3][2]
						}, pair)
					end)
					:with_move(cond.none())
					:with_cr(cond.none())
				-- We only want to delete the pair of spaces when the cursor is as such: ( | )
					:with_del(function(opts)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local context = opts.line:sub(col - 1, col + 2)
						return vim.tbl_contains({
							brackets[1][1] .. '  ' .. brackets[1][2],
							brackets[2][1] .. '  ' .. brackets[2][2],
							brackets[3][1] .. '  ' .. brackets[3][2]
						}, context)
					end)
			})

			-- REMOVE all instance of "`" rule, we'll re-add it but better
			npairs.remove_rule("`")
			npairs.remove_rule("'")
			npairs.add_rules({
				Rule("`", "`", { "-tex", "-latex" })
					:with_move(cond.done()),
				Rule("\'", "\'", { "-tex", "-latex", "-md", "-markdown", "-ml", "-ocaml" })
					:with_move(cond.done()),
			})

			-- add dollar signs for tex
			npairs.add_rules({
				Rule("$", "$", { "tex", "latex" })
					:with_move(function(opts)
						return opts.next_char == opts.char
					end
					),
				Rule("``", "''", { "tex", "latex" })
			})

			for _, p in pairs(brackets) do
				-- create custom tex rules for each set of brackets
				npairs.add_rules({
					Rule(p[1], p[2], { "tex", "latex" }),
					Rule("\\" .. p[1], "\\" .. p[2], { "tex", "latex" }),
				})
			end

			-- extra formatting for markdown
			npairs.add_rules({
				Rule("*", "*", { "md", "markdown" })
					:with_move(cond.done()),
				Rule("**", "*", { "md", "markdown" }),
				Rule(" '", "'", { "md", "markdown" })
					:with_move(cond.done()),
			})
		end,
	}
}
