Raw list of appended found and not fixed yet issue(s), should be empty.
```
: (test '((1)) '((1)))
```

```
: (setq A '(B))
-> (B)
: (put 'B 'a 123)
-> 123
: (meta 'A 'a)
-> NIL
   ^^^ should be 123
```
