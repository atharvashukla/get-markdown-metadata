# post-json


**requirement: jsonlint** `npm install jsonlint -g`


Let's say we have a number of "blog posts" as `.md` files


`post1.md`
```
# Blog heading 1

content
content 
content
```


`second-post.md`
```
# Second blog post

some content
```


`./run.sh` will simply parse the filenames and the headings and produce a `posts.json` file with the following schema:

```
{
  "posts": [
    {
      "name": "post1.md",
      "heading": "Blog heading 1"
    },
    {
      "name": "second-post.md",
      "heading": "Second blog post"
    },
  ]
}
```


This metadata can be read to:
- convert all files to html
- use "name" to properly generate links in the html
- use "heading" as the text for the link
