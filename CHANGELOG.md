# Change Log

## [Unreleased](https://github.com/prettier/vim-prettier/tree/HEAD)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.1...HEAD)

**Merged pull requests:**

- bugfix: Fixing auto command params to use extensions instead of magic [\#64](https://github.com/prettier/vim-prettier/pull/64) ([mitermayer](https://github.com/mitermayer))

## [0.2.1](https://github.com/prettier/vim-prettier/tree/0.2.1) (2017-10-07)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.0...0.2.1)

**Fixed bugs:**

- Overwrites Buffer1 with contents of Buffer2 [\#62](https://github.com/prettier/vim-prettier/issues/62)
- Confused by file type overrides [\#60](https://github.com/prettier/vim-prettier/issues/60)

**Merged pull requests:**

- bugfix: fixing race condition incorrect buffer formating [\#63](https://github.com/prettier/vim-prettier/pull/63) ([mitermayer](https://github.com/mitermayer))
- bug: Fixing config overwrite value for non js by levaraging --stdin-f… [\#61](https://github.com/prettier/vim-prettier/pull/61) ([mitermayer](https://github.com/mitermayer))

## [0.2.0](https://github.com/prettier/vim-prettier/tree/0.2.0) (2017-10-04)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.1.3...0.2.0)

**Fixed bugs:**

- `--parser` with value `postcss` is deprecated [\#59](https://github.com/prettier/vim-prettier/issues/59)

## [0.1.3](https://github.com/prettier/vim-prettier/tree/0.1.3) (2017-09-30)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.1.2...0.1.3)

## [0.1.2](https://github.com/prettier/vim-prettier/tree/0.1.2) (2017-09-26)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.1.1...0.1.2)

**Implemented enhancements:**

- Allow configuration to set lookup path for `prettier` cli on `.vimrc` [\#56](https://github.com/prettier/vim-prettier/issues/56)

**Merged pull requests:**

- issue/56 - Allowing user path overwrite configuration [\#57](https://github.com/prettier/vim-prettier/pull/57) ([mitermayer](https://github.com/mitermayer))
- Fixed some typos in the README [\#55](https://github.com/prettier/vim-prettier/pull/55) ([Haegin](https://github.com/Haegin))
- feature: Adding more commands [\#54](https://github.com/prettier/vim-prettier/pull/54) ([mitermayer](https://github.com/mitermayer))

## [0.1.1](https://github.com/prettier/vim-prettier/tree/0.1.1) (2017-09-18)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.1.0...0.1.1)

**Implemented enhancements:**

- Upgrade to support prettier 1.6 [\#51](https://github.com/prettier/vim-prettier/issues/51)

## [0.1.0](https://github.com/prettier/vim-prettier/tree/0.1.0) (2017-09-14)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.15...0.1.0)

**Merged pull requests:**

- Issue/51 adding support for prettier 1.7 [\#52](https://github.com/prettier/vim-prettier/pull/52) ([mitermayer](https://github.com/mitermayer))

## [0.0.15](https://github.com/prettier/vim-prettier/tree/0.0.15) (2017-08-30)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.14...0.0.15)

**Fixed bugs:**

- PrettierAsync does not work on Windows [\#46](https://github.com/prettier/vim-prettier/issues/46)

**Closed issues:**

- :Prettier make cursor history wrong when navigating with \<C-O\> [\#48](https://github.com/prettier/vim-prettier/issues/48)

**Merged pull requests:**

- Making sure that after formatting we preserve in the same line [\#50](https://github.com/prettier/vim-prettier/pull/50) ([mitermayer](https://github.com/mitermayer))
- Added extensions to vim configuration example [\#49](https://github.com/prettier/vim-prettier/pull/49) ([niftylettuce](https://github.com/niftylettuce))
- Async command was not working for windows this patch will make sure it [\#47](https://github.com/prettier/vim-prettier/pull/47) ([mitermayer](https://github.com/mitermayer))

## [0.0.14](https://github.com/prettier/vim-prettier/tree/0.0.14) (2017-08-24)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.13...0.0.14)

**Fixed bugs:**

- :Prettier causes :Ggrep to lose history [\#39](https://github.com/prettier/vim-prettier/issues/39)

**Closed issues:**

- Trailing comma is causing issues with IE10/11 [\#45](https://github.com/prettier/vim-prettier/issues/45)

**Merged pull requests:**

- Add instructions on changing the mapping to README [\#43](https://github.com/prettier/vim-prettier/pull/43) ([eddiezane](https://github.com/eddiezane))
- bugfix: should not clear quickfix unless opened by vim-prettier itself [\#40](https://github.com/prettier/vim-prettier/pull/40) ([mitermayer](https://github.com/mitermayer))

## [0.0.13](https://github.com/prettier/vim-prettier/tree/0.0.13) (2017-08-13)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.12...0.0.13)

**Implemented enhancements:**

- Include changelog [\#35](https://github.com/prettier/vim-prettier/issues/35)

## [0.0.12](https://github.com/prettier/vim-prettier/tree/0.0.12) (2017-08-06)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.11...0.0.12)

**Implemented enhancements:**

- Bump internal plugin dependencie to use prettier to 1.5.3 [\#34](https://github.com/prettier/vim-prettier/issues/34)
- Add MIT license [\#33](https://github.com/prettier/vim-prettier/issues/33)

**Closed issues:**

- Unable to disable 'single-quote' [\#32](https://github.com/prettier/vim-prettier/issues/32)
- "failed to parse buffer", but prettier from console works well [\#31](https://github.com/prettier/vim-prettier/issues/31)
- Autoformat "all" files by default. [\#30](https://github.com/prettier/vim-prettier/issues/30)
- Neovim support for job/channel to allow async formatting [\#25](https://github.com/prettier/vim-prettier/issues/25)

**Merged pull requests:**

- Adding changelog file [\#38](https://github.com/prettier/vim-prettier/pull/38) ([mitermayer](https://github.com/mitermayer))
- Adding MIT license [\#37](https://github.com/prettier/vim-prettier/pull/37) ([mitermayer](https://github.com/mitermayer))
- Bumping prettier internal dependencie plugin to 1.5.3 [\#36](https://github.com/prettier/vim-prettier/pull/36) ([mitermayer](https://github.com/mitermayer))

## [0.0.11](https://github.com/prettier/vim-prettier/tree/0.0.11) (2017-07-12)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.10...0.0.11)

**Fixed bugs:**

- Json parser should not include comma at the end [\#26](https://github.com/prettier/vim-prettier/issues/26)

**Merged pull requests:**

- adding-support-for-vim7 - adding support for vim7 [\#29](https://github.com/prettier/vim-prettier/pull/29) ([mitermayer](https://github.com/mitermayer))

## [0.0.10](https://github.com/prettier/vim-prettier/tree/0.0.10) (2017-07-02)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.9...0.0.10)

**Implemented enhancements:**

- should support filetype detection when none is available [\#23](https://github.com/prettier/vim-prettier/issues/23)

**Merged pull requests:**

- bugfix: json parser should not add extra comma to the end [\#27](https://github.com/prettier/vim-prettier/pull/27) ([mitermayer](https://github.com/mitermayer))

## [0.0.9](https://github.com/prettier/vim-prettier/tree/0.0.9) (2017-07-01)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.8...0.0.9)

**Implemented enhancements:**

- bump plugin dependency to prettier 1.5 [\#22](https://github.com/prettier/vim-prettier/issues/22)
- add support for GraphQL parsing [\#21](https://github.com/prettier/vim-prettier/issues/21)

**Merged pull requests:**

- feature/add-filetype-support - Adding filetype detection support when [\#24](https://github.com/prettier/vim-prettier/pull/24) ([mitermayer](https://github.com/mitermayer))

## [0.0.8](https://github.com/prettier/vim-prettier/tree/0.0.8) (2017-06-30)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.7...0.0.8)

**Implemented enhancements:**

- Partial formatting support [\#14](https://github.com/prettier/vim-prettier/issues/14)

**Closed issues:**

- prettier add extra comma at the last parameter of function [\#18](https://github.com/prettier/vim-prettier/issues/18)

**Merged pull requests:**

- Add JSON/GraphQL parser \(prettier 1.5\) [\#17](https://github.com/prettier/vim-prettier/pull/17) ([vutran](https://github.com/vutran))
- Fix default settings [\#16](https://github.com/prettier/vim-prettier/pull/16) ([vutran](https://github.com/vutran))

## [0.0.7](https://github.com/prettier/vim-prettier/tree/0.0.7) (2017-06-20)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.6...0.0.7)

**Merged pull requests:**

- feature: enabling partial buffer conversion [\#15](https://github.com/prettier/vim-prettier/pull/15) ([mitermayer](https://github.com/mitermayer))
- fixed typo [\#13](https://github.com/prettier/vim-prettier/pull/13) ([wangsongiam](https://github.com/wangsongiam))
- Adding async command and configuration controls [\#12](https://github.com/prettier/vim-prettier/pull/12) ([mitermayer](https://github.com/mitermayer))

## [0.0.6](https://github.com/prettier/vim-prettier/tree/0.0.6) (2017-06-07)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.5...0.0.6)

## [0.0.5](https://github.com/prettier/vim-prettier/tree/0.0.5) (2017-06-06)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.4...0.0.5)

**Implemented enhancements:**

- Populate quickfix with prettier parsing errors [\#5](https://github.com/prettier/vim-prettier/issues/5)

**Merged pull requests:**

- Bumping support to latest prettier ^1.4.X and enabling support for [\#11](https://github.com/prettier/vim-prettier/pull/11) ([mitermayer](https://github.com/mitermayer))

## [0.0.4](https://github.com/prettier/vim-prettier/tree/0.0.4) (2017-05-31)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.3...0.0.4)

**Fixed bugs:**

- Prettier CLI expects params 'false' instead of 0 [\#9](https://github.com/prettier/vim-prettier/issues/9)

## [0.0.3](https://github.com/prettier/vim-prettier/tree/0.0.3) (2017-05-28)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.2...0.0.3)

**Implemented enhancements:**

- Make the prettier command run async  [\#4](https://github.com/prettier/vim-prettier/issues/4)

**Fixed bugs:**

- Fallback plugins not working [\#7](https://github.com/prettier/vim-prettier/issues/7)

**Merged pull requests:**

- Prettier CLI seems to expect 'false' for some parameters instead of 0 [\#10](https://github.com/prettier/vim-prettier/pull/10) ([mitermayer](https://github.com/mitermayer))
- bugfix: fixing bug where prettier installation of the plugin was never [\#8](https://github.com/prettier/vim-prettier/pull/8) ([mitermayer](https://github.com/mitermayer))
- Adding support for async formating and making it default for autosave [\#6](https://github.com/prettier/vim-prettier/pull/6) ([mitermayer](https://github.com/mitermayer))

## [0.0.2](https://github.com/prettier/vim-prettier/tree/0.0.2) (2017-05-26)
[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.1...0.0.2)

**Fixed bugs:**

- Should not overwrite buffer when prettier fails to parse file [\#2](https://github.com/prettier/vim-prettier/issues/2)

**Merged pull requests:**

- bugfix: Making sure that when prettier fail to parse buffer we do not [\#3](https://github.com/prettier/vim-prettier/pull/3) ([mitermayer](https://github.com/mitermayer))
- Adding working example GIF [\#1](https://github.com/prettier/vim-prettier/pull/1) ([mitermayer](https://github.com/mitermayer))

## [0.0.1](https://github.com/prettier/vim-prettier/tree/0.0.1) (2017-05-24)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*