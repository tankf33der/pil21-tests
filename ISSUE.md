Requirements to this file and repo are:
* TODO
* Raw list of appended found and not fixed yet issue(s), file should be empty
* find . -name "*.l" | xargs grep -ci "xxx" - should returns all zeroes

```
add and readline via pkg-config, otherwise failed on FreeBSD 12
```

```
# should be (2 0)
: (out "a" (pr (2 0))) (in "a" (rd))
-> (2 .)
:
```

```
pil21 can execute irb, pil64 can
$ pil21 +
(call 'irb)
▽Traceback (most recent call last):
	28: from /usr/bin/irb:23:in `<main>'
	27: from /usr/bin/irb:23:in `load'
	26: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/exe/irb:11:in `<top (required)>'
	25: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb.rb:400:in `start'
	24: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb.rb:471:in `run'
	23: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb.rb:471:in `catch'
	22: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb.rb:472:in `block in run'
	21: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb.rb:537:in `eval_input'
	20: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb/ruby-lex.rb:150:in `each_top_level_statement'
	19: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb/ruby-lex.rb:150:in `catch'
	18: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb/ruby-lex.rb:151:in `block in each_top_level_statement'
	17: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb/ruby-lex.rb:151:in `loop'
	16: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb/ruby-lex.rb:154:in `block (2 levels) in each_top_level_statement'
	15: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb/ruby-lex.rb:182:in `lex'
	14: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb.rb:518:in `block in eval_input'
	13: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb.rb:704:in `signal_status'
	12: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb.rb:519:in `block (2 levels) in eval_input'
	11: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.7/lib/irb/input-method.rb:294:in `gets'
	10: from /usr/lib/ruby/2.7.0/forwardable.rb:235:in `readmultiline'
	 9: from /usr/lib/ruby/2.7.0/forwardable.rb:235:in `readmultiline'
	 8: from /usr/lib/ruby/gems/2.7.0/gems/reline-0.1.5/lib/reline.rb:175:in `readmultiline'
	 7: from /usr/lib/ruby/gems/2.7.0/gems/reline-0.1.5/lib/reline.rb:208:in `inner_readline'
	 6: from /usr/lib/ruby/gems/2.7.0/gems/reline-0.1.5/lib/reline.rb:349:in `may_req_ambiguous_char_width'
	 5: from /usr/lib/ruby/gems/2.7.0/gems/reline-0.1.5/lib/reline/ansi.rb:120:in `cursor_pos'
	 4: from /usr/lib/ruby/gems/2.7.0/gems/reline-0.1.5/lib/reline/ansi.rb:120:in `raw'
	 3: from /usr/lib/ruby/gems/2.7.0/gems/reline-0.1.5/lib/reline/ansi.rb:123:in `block in cursor_pos'
	 2: from /usr/lib/ruby/gems/2.7.0/gems/reline-0.1.5/lib/reline/ansi.rb:123:in `loop'
	 1: from /usr/lib/ruby/gems/2.7.0/gems/reline-0.1.5/lib/reline/ansi.rb:124:in `block (2 levels) in cursor_pos'
/usr/lib/ruby/gems/2.7.0/gems/reline-0.1.5/lib/reline/ansi.rb:124:in `getc': Input/output error @ io_fillbuf - fd:0  (Errno::EIO)
```
