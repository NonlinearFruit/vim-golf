# [Reordering properties](https://www.vimgolf.com/challenges/9v0067a47b9200000000069f)
Arrange the CSS lines for the #topbar selector based on their complete line length, from shortest to longest.
## Input
```
#topbar {
  background-image: url("images/abc.png");
  background-position: 12px 13px;
  font-size: 1px;
  left: 36px;
  margin-top: 10px;
  position: relative;
  top: 23px;
  vertical-align: middle;
  width: 200px;
}

#topbar .logo {
  top: 50%;
  position: absolute;
  left: 20px;
  transform: translateY(-50%);
  font-size: 28px;
  font-weight: bold;
  color: #fff;
  text-transform: uppercase;
  letter-spacing: 1px;
}

```
## Output
```
#topbar {
  top: 23px;
  left: 36px;
  width: 200px;
  font-size: 1px;
  margin-top: 10px;
  position: relative;
  vertical-align: middle;
  background-position: 12px 13px;
  background-image: url("images/abc.png");
}

#topbar .logo {
  top: 50%;
  left: 20px;
  color: #fff;
  font-size: 28px;
  font-weight: bold;
  position: absolute;
  letter-spacing: 1px;
  text-transform: uppercase;
  transform: translateY(-50%);
}

```