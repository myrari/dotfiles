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
				{ '(', ')' }, { '[', ']' }, { '{', '}' }, { '$', '$' }
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
							brackets[3][1] .. brackets[3][2],
							brackets[4][1] .. brackets[4][2],
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
							brackets[3][1] .. '  ' .. brackets[3][2],
							brackets[4][1] .. '  ' .. brackets[4][2],
						}, context)
					end)
			})

			-- REMOVE all instance of "`" rule, we'll re-add it but better
			npairs.remove_rule("`")
			npairs.remove_rule("'")
			npairs.add_rules({
				Rule("`", "`", { "-tex", "-latex", "-lisp" })
					:with_move(cond.done()),
				Rule("\'", "\'", { "-tex", "-latex", "-ml", "-ocaml" })
					:with_pair(cond.not_before_regex("%w"))
					:with_move(cond.done()),
			})

			-- comment pairs for ML
			npairs.add_rules({
				Rule("(* ", " *", { "ml", "ocaml", "mli" }),
				Rule("(** ", " *", { "ml", "ocaml", "mli" }),
			})

			-- add dollar signs for tex & typst
			npairs.add_rules({
				Rule("$", "$", { "tex", "latex", "typst", "typ" })
					:with_move(cond.done()),
				Rule("``", "''", { "tex", "latex" })
			})

			for _, p in pairs(brackets) do
				-- create custom tex rules for each set of brackets
				npairs.add_rules({
					Rule(p[1], p[2], { "tex", "latex" }),
					Rule("\\" .. p[1], "\\" .. p[2], { "tex", "latex" }),
				})
			end

			-- overwrite parentheses rules for lisp
			npairs.add_rules({
				Rule("(", ")", { "lisp" })
					:with_pair(cond.done())
			})

			-- extra formatting for markdown
			npairs.add_rules({
				Rule("*", "*", { "md", "markdown" })
					:with_pair(cond.not_before_regex("%*"))
					:with_pair(cond.not_after_regex("%*"))
					:with_move(cond.done()),
				Rule("**", "*", { "md", "markdown" }),
			})

			-- extra formatting for typst
			npairs.add_rules({
				Rule("*", "*", { "typst", "typ" })
					:with_move(cond.done()),
				Rule("_", "_", { "typst", "typ" })
					:with_move(cond.done()),
			})
		end,
	}
}
