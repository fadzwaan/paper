you can test with this code
```jsx
import test from 'tape';
import BlogPostCard from '../components/BlogPostCard';

test('Test BlogPostCard component', (t) => {
    t.ok(BlogPostCard, 'BlogPostCard should be imported');
    t.end();
});

```


npx tape -r path/to/test.js


```bash
┌──(lancer㉿eyun)-[~/Downloads/Trash/ahcclubiium]
└─$ find -type f -name '*.jsx' | xargs -I {} sh -c 'npx tape {} || true'
/home/lancer/Downloads/Trash/ahcclubiium/app/adoption/page.jsx:1
import BlogPostCard from '../components/BlogPostCard';
^^^^^^

SyntaxError: Cannot use import statement outside a module
    at wrapSafe (node:internal/modules/cjs/loader:1378:20)
    at Module._compile (node:internal/modules/cjs/loader:1428:41)
    at Module._extensions..js (node:internal/modules/cjs/loader:1548:10)
    at Module.load (node:internal/modules/cjs/loader:1288:32)
    at Module._load (node:internal/modules/cjs/loader:1104:12)
    at Module.require (node:internal/modules/cjs/loader:1311:19)
    at require (node:internal/modules/helpers:179:18)
    at importOrRequire (/home/lancer/.npm/_npx/56d1233753005df3/node_modules/tape/bin/import-or-require.js:14:2)
    at /home/lancer/.npm/_npx/56d1233753005df3/node_modules/tape/bin/tape:110:8
    at Array.reduce (<anonymous>)

Node.js v20.17.0
TAP version 13

1..0
# tests 0
# pass  0

# ok
```
