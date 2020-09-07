# Changelog

## [1.0.0-beta](https://github.com/prettier/vim-prettier/tree/1.0.0-beta) (2020-09-07)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/1.0.0-alpha...1.0.0-beta)

**Implemented enhancements:**

- Toggle autoformat feature and/or documentation [\#170](https://github.com/prettier/vim-prettier/issues/170)
- 1.0 release [\#126](https://github.com/prettier/vim-prettier/issues/126)

**Fixed bugs:**

- formatting by saving works only for languages of last opened file [\#185](https://github.com/prettier/vim-prettier/issues/185)
- bugfix/issue-229-fixing-neovim-0-4-compatibility [\#231](https://github.com/prettier/vim-prettier/pull/231) ([mitermayer](https://github.com/mitermayer))

**Closed issues:**

- Support prettier-stylelint [\#255](https://github.com/prettier/vim-prettier/issues/255)
- Autoformat on save does not work on yaml files [\#245](https://github.com/prettier/vim-prettier/issues/245)
- PrettierFragment not work  [\#241](https://github.com/prettier/vim-prettier/issues/241)
- Error when running :Prettier on gvim [\#240](https://github.com/prettier/vim-prettier/issues/240)
- Installation fails in post-update hook using vim plug [\#237](https://github.com/prettier/vim-prettier/issues/237)
- `autoformat\_config\_present` does not re-evaluate the presence of the prettier config file after vim is started [\#233](https://github.com/prettier/vim-prettier/issues/233)
- Add support for `prettier 2.x`  [\#232](https://github.com/prettier/vim-prettier/issues/232)
- PrettierAsync moves cursor to top of buffer [\#229](https://github.com/prettier/vim-prettier/issues/229)
- Autoformatting Stops Working [\#228](https://github.com/prettier/vim-prettier/issues/228)
- /\* prettier-ignore \*/ inside CSS file not working [\#227](https://github.com/prettier/vim-prettier/issues/227)
- How do I run prettier for markdown files for Hugo the static site generator? [\#223](https://github.com/prettier/vim-prettier/issues/223)
- Package.json configuration not loaded properly \(release 1.x\) [\#221](https://github.com/prettier/vim-prettier/issues/221)
- TypeScript is formatted as PHP \(1.x\) [\#219](https://github.com/prettier/vim-prettier/issues/219)
- How configure  [\#218](https://github.com/prettier/vim-prettier/issues/218)
- Error on `:wq` [\#215](https://github.com/prettier/vim-prettier/issues/215)
- Bug: failed to parse buffer.  [\#214](https://github.com/prettier/vim-prettier/issues/214)
- release/1.x: prettier plugins do not work when installed with pnpm [\#211](https://github.com/prettier/vim-prettier/issues/211)
- .prettierignore appends a bunch of nonsense [\#189](https://github.com/prettier/vim-prettier/issues/189)
- Failed to parse buffer import.meta.url [\#188](https://github.com/prettier/vim-prettier/issues/188)
- Document how to add q-args [\#168](https://github.com/prettier/vim-prettier/issues/168)
- Document how to add custom extensions [\#167](https://github.com/prettier/vim-prettier/issues/167)
- styling over scp [\#149](https://github.com/prettier/vim-prettier/issues/149)

**Merged pull requests:**

- Uses default cli configs [\#260](https://github.com/prettier/vim-prettier/pull/260) ([ethan605](https://github.com/ethan605))
- Add buffer-level prettier exec command to doc [\#259](https://github.com/prettier/vim-prettier/pull/259) ([jsit](https://github.com/jsit))
- Add support for buffer-level prettier\_exec\_cmd, for prettier-stylelint for instance [\#256](https://github.com/prettier/vim-prettier/pull/256) ([jsit](https://github.com/jsit))
- Bump acorn from 5.7.3 to 5.7.4 [\#254](https://github.com/prettier/vim-prettier/pull/254) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump lodash from 4.17.15 to 4.17.19 [\#253](https://github.com/prettier/vim-prettier/pull/253) ([dependabot[bot]](https://github.com/apps/dependabot))
- Fix error when quitting Neovim with :wq [\#252](https://github.com/prettier/vim-prettier/pull/252) ([mrnugget](https://github.com/mrnugget))
- Add missing ".yml" in autocmd [\#246](https://github.com/prettier/vim-prettier/pull/246) ([raxell](https://github.com/raxell))
- Fix string concatenation typo [\#243](https://github.com/prettier/vim-prettier/pull/243) ([coolreader18](https://github.com/coolreader18))
- issue/232-adding-support-for-prettier-2.x - Adding support for prettier 2x [\#238](https://github.com/prettier/vim-prettier/pull/238) ([mitermayer](https://github.com/mitermayer))
- Add instructions for installing with vim 8+ [\#236](https://github.com/prettier/vim-prettier/pull/236) ([coolaj86](https://github.com/coolaj86))
- Autoformat .rb files [\#235](https://github.com/prettier/vim-prettier/pull/235) ([jamesbvaughan](https://github.com/jamesbvaughan))
- Force reevaluation of autoformat settings at buffer write time [\#234](https://github.com/prettier/vim-prettier/pull/234) ([cjlarose](https://github.com/cjlarose))
- Fix readme to properly reflect how to downgrade [\#225](https://github.com/prettier/vim-prettier/pull/225) ([ParamagicDev](https://github.com/ParamagicDev))
- New option: prettier\#autoformat\_require\_pragma [\#224](https://github.com/prettier/vim-prettier/pull/224) ([simnalamburt](https://github.com/simnalamburt))

## [1.0.0-alpha](https://github.com/prettier/vim-prettier/tree/1.0.0-alpha) (2020-02-05)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.7...1.0.0-alpha)

**Implemented enhancements:**

- Add A "Close Empty JSX Element" Option Like On VS Code's Prettier [\#202](https://github.com/prettier/vim-prettier/issues/202)
- Support custom prettier plugins [\#119](https://github.com/prettier/vim-prettier/issues/119)
- Add support for neovim async [\#99](https://github.com/prettier/vim-prettier/issues/99)
- Formatting with visual selection doesn't respect indentation [\#75](https://github.com/prettier/vim-prettier/issues/75)
- Using prettier-eslint-cli [\#42](https://github.com/prettier/vim-prettier/issues/42)
- Support for 'prettier-standard-formatter' [\#20](https://github.com/prettier/vim-prettier/issues/20)

**Fixed bugs:**

- First undo after :Prettier takes me to the top of the file [\#184](https://github.com/prettier/vim-prettier/issues/184)
- Vim-prettier doesn't use project config [\#162](https://github.com/prettier/vim-prettier/issues/162)
- Error infinite loop Prettier: failed to parse buffer [\#113](https://github.com/prettier/vim-prettier/issues/113)
- vim-prettier not working when editing files that have white spaces on its path [\#108](https://github.com/prettier/vim-prettier/issues/108)

**Closed issues:**

- Bug: Bracket spacing is ignored [\#222](https://github.com/prettier/vim-prettier/issues/222)
- E121: Undefined variable: g:prettier\#autoformat [\#216](https://github.com/prettier/vim-prettier/issues/216)
- Plugin should load project config if available [\#213](https://github.com/prettier/vim-prettier/issues/213)
- incosistent with prettier cli and introducing syntaxt error. [\#200](https://github.com/prettier/vim-prettier/issues/200)
- For "in-memory" buffers \(not saved to file system\): `Prettier: failed to parse buffer` [\#199](https://github.com/prettier/vim-prettier/issues/199)
- Loading global .prettierrc from user's home ? [\#197](https://github.com/prettier/vim-prettier/issues/197)
- Can I automatically disable vim-prettier if .prettierrc is doesn't exists in project folder? [\#195](https://github.com/prettier/vim-prettier/issues/195)
- make prettier respect eslint [\#194](https://github.com/prettier/vim-prettier/issues/194)
- Window is unexpectedly scrolled after :Prettier [\#192](https://github.com/prettier/vim-prettier/issues/192)
- Autoformat not working on save [\#191](https://github.com/prettier/vim-prettier/issues/191)
- fail to parse buffer? [\#187](https://github.com/prettier/vim-prettier/issues/187)
- Wrong parser used for markdown files [\#186](https://github.com/prettier/vim-prettier/issues/186)
- No syntax color for html files when vim-prettier is enabled [\#183](https://github.com/prettier/vim-prettier/issues/183)
- Error detected while processing BufWrite Auto commands for "\*.rb" [\#180](https://github.com/prettier/vim-prettier/issues/180)
- Calling Prettier error if project contains prettier configuration [\#178](https://github.com/prettier/vim-prettier/issues/178)
- add groovy handling [\#177](https://github.com/prettier/vim-prettier/issues/177)
- on run :Prettier command weird characters added at the beginning of the file [\#174](https://github.com/prettier/vim-prettier/issues/174)
- Support prettier/prettier-ruby [\#172](https://github.com/prettier/vim-prettier/issues/172)
- vim-prettier clobbering markdown files [\#166](https://github.com/prettier/vim-prettier/issues/166)
- How to not always auto format by default [\#164](https://github.com/prettier/vim-prettier/issues/164)
- `E121: Undefined variable: g:prettier\#autoformat` when executing `vi` [\#161](https://github.com/prettier/vim-prettier/issues/161)
- Error parsing Typescript [\#153](https://github.com/prettier/vim-prettier/issues/153)
- Restarting development from today [\#152](https://github.com/prettier/vim-prettier/issues/152)
- Unexpected cursor movement [\#151](https://github.com/prettier/vim-prettier/issues/151)
- Adding support for lint tools custom executables after prettier \(like lint-staged\) [\#148](https://github.com/prettier/vim-prettier/issues/148)
- Prettier: failed to parse buffer.  [\#147](https://github.com/prettier/vim-prettier/issues/147)
- my config single\_quote is ignored [\#146](https://github.com/prettier/vim-prettier/issues/146)
- Prettier: failed to parse buffer. [\#145](https://github.com/prettier/vim-prettier/issues/145)
- Prettier throws an invalid expression ' --print-width ' when I run in vim [\#143](https://github.com/prettier/vim-prettier/issues/143)
- Re-enable .editorconfig support [\#141](https://github.com/prettier/vim-prettier/issues/141)
- saving a file ignored in .prettierignore outputs part of the file back to the buffer [\#140](https://github.com/prettier/vim-prettier/issues/140)
- Prettierrc support/default usage [\#137](https://github.com/prettier/vim-prettier/issues/137)
- Update DOC's and README [\#106](https://github.com/prettier/vim-prettier/issues/106)

**Merged pull requests:**

- Use `get\(\)` to check `g:prettier\#autoformat` safely in ftplugin [\#217](https://github.com/prettier/vim-prettier/pull/217) ([hankchiutw](https://github.com/hankchiutw))
- Toggle the autoformat setting based on config file presence. [\#212](https://github.com/prettier/vim-prettier/pull/212) ([atomdmac](https://github.com/atomdmac))
- making-auto-format-disabled-by-default - Making autoformat disabled by [\#208](https://github.com/prettier/vim-prettier/pull/208) ([mitermayer](https://github.com/mitermayer))
- Issues/184 fixing undo step [\#207](https://github.com/prettier/vim-prettier/pull/207) ([mitermayer](https://github.com/mitermayer))
- Adding support for require-pragma and depracting previous naive implemenation [\#206](https://github.com/prettier/vim-prettier/pull/206) ([mitermayer](https://github.com/mitermayer))
- moving-build-to-make-file - Adding build file [\#203](https://github.com/prettier/vim-prettier/pull/203) ([mitermayer](https://github.com/mitermayer))
- enabling-tests-on-ci - Enabling tests as part of the CI run [\#201](https://github.com/prettier/vim-prettier/pull/201) ([mitermayer](https://github.com/mitermayer))
- updating-travis-to-use-docker - Moving to use vint from docker image [\#198](https://github.com/prettier/vim-prettier/pull/198) ([mitermayer](https://github.com/mitermayer))
- Shore/master rebasing [\#196](https://github.com/prettier/vim-prettier/pull/196) ([mitermayer](https://github.com/mitermayer))
- Added some file extensions [\#193](https://github.com/prettier/vim-prettier/pull/193) ([hrkw00](https://github.com/hrkw00))
- improve Requirement's message clearness [\#190](https://github.com/prettier/vim-prettier/pull/190) ([jonathan-soifer](https://github.com/jonathan-soifer))
- Ignore generated help tags file [\#181](https://github.com/prettier/vim-prettier/pull/181) ([mikesep](https://github.com/mikesep))
- Fix README markdown. [\#179](https://github.com/prettier/vim-prettier/pull/179) ([Onra](https://github.com/Onra))
- Integrating vim driver [\#176](https://github.com/prettier/vim-prettier/pull/176) ([mitermayer](https://github.com/mitermayer))
- Release/1.x [\#175](https://github.com/prettier/vim-prettier/pull/175) ([mitermayer](https://github.com/mitermayer))
- Make markdown check more resilient [\#173](https://github.com/prettier/vim-prettier/pull/173) ([rivertam](https://github.com/rivertam))
- Fix markdown mangling issue [\#169](https://github.com/prettier/vim-prettier/pull/169) ([rivertam](https://github.com/rivertam))
- Add option for html whitespace sensitivity [\#165](https://github.com/prettier/vim-prettier/pull/165) ([dewyze](https://github.com/dewyze))
- Handle file paths with whitespace [\#163](https://github.com/prettier/vim-prettier/pull/163) ([jason0x43](https://github.com/jason0x43))
- Set default "config\_precendence" to "file-override" [\#160](https://github.com/prettier/vim-prettier/pull/160) ([shuLhan](https://github.com/shuLhan))
- Added html support using the latest prettier 1.15 version [\#159](https://github.com/prettier/vim-prettier/pull/159) ([premithk](https://github.com/premithk))
- space for --use-tabs [\#158](https://github.com/prettier/vim-prettier/pull/158) ([andreiglingeanu](https://github.com/andreiglingeanu))
- On python3.6 we dont need those extra pip deps to be declared [\#157](https://github.com/prettier/vim-prettier/pull/157) ([mitermayer](https://github.com/mitermayer))
- Fixing linting rules [\#156](https://github.com/prettier/vim-prettier/pull/156) ([mitermayer](https://github.com/mitermayer))
- Rebasing vim-prettier plugin Pull Request 120 to 1.0 branch [\#155](https://github.com/prettier/vim-prettier/pull/155) ([mitermayer](https://github.com/mitermayer))
- Add YAML support [\#150](https://github.com/prettier/vim-prettier/pull/150) ([bracki](https://github.com/bracki))
- Enable the default editorconfig support again [\#144](https://github.com/prettier/vim-prettier/pull/144) ([oskarrough](https://github.com/oskarrough))
- Fix PrettierAsync ignored file contents mangling [\#142](https://github.com/prettier/vim-prettier/pull/142) ([SamHowie](https://github.com/SamHowie))
- Remove wrong comment on README.md comment example [\#139](https://github.com/prettier/vim-prettier/pull/139) ([vieiralucas](https://github.com/vieiralucas))
- use buffered mode for neovim job [\#136](https://github.com/prettier/vim-prettier/pull/136) ([chemzqm](https://github.com/chemzqm))
- Start using prettier default arguments [\#130](https://github.com/prettier/vim-prettier/pull/130) ([docwhat](https://github.com/docwhat))

## [0.2.7](https://github.com/prettier/vim-prettier/tree/0.2.7) (2018-05-25)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.6...0.2.7)

**Fixed bugs:**

- Vim crashes with segmentation fault with PrettierAsync [\#135](https://github.com/prettier/vim-prettier/issues/135)
- Deletes file contents of files ignored by .prettierignore [\#92](https://github.com/prettier/vim-prettier/issues/92)

**Closed issues:**

- Upgraded to Node v10 - Pretter:Failed to parse buffer [\#134](https://github.com/prettier/vim-prettier/issues/134)
- \<Plug\>\(Prettier\) doesn't work [\#132](https://github.com/prettier/vim-prettier/issues/132)
- Caught deadly signal SEGV when :PrettierAsync with large file [\#128](https://github.com/prettier/vim-prettier/issues/128)
- bash: no job control in this shell [\#123](https://github.com/prettier/vim-prettier/issues/123)
- Support for language-specific settings [\#121](https://github.com/prettier/vim-prettier/issues/121)
- Can't spot why prettier fails to parse css: "1 col 6| Unexpected token, expected ;" [\#118](https://github.com/prettier/vim-prettier/issues/118)
- Is there a prettier.eslintIntegration config [\#117](https://github.com/prettier/vim-prettier/issues/117)
- Format without saving [\#116](https://github.com/prettier/vim-prettier/issues/116)
- Error on autosave [\#114](https://github.com/prettier/vim-prettier/issues/114)
- Use prettier config for formatting rules [\#112](https://github.com/prettier/vim-prettier/issues/112)
- Unexpected token @ [\#109](https://github.com/prettier/vim-prettier/issues/109)
- Overwrite default configs patterns not found [\#102](https://github.com/prettier/vim-prettier/issues/102)
- Ignored unknown options appearing at top of file [\#100](https://github.com/prettier/vim-prettier/issues/100)
- Neovim unstable async formatting bugs [\#96](https://github.com/prettier/vim-prettier/issues/96)
- How do I enable trailing commas? [\#95](https://github.com/prettier/vim-prettier/issues/95)
- Ignoring unknown option --loglevel, --no-editorconfig and --config-precedence [\#89](https://github.com/prettier/vim-prettier/issues/89)
- Override for proseWrap option [\#88](https://github.com/prettier/vim-prettier/issues/88)

**Merged pull requests:**

- Fix PrettierAsync segmentation fault [\#138](https://github.com/prettier/vim-prettier/pull/138) ([SamHowie](https://github.com/SamHowie))
- Adding discord link [\#131](https://github.com/prettier/vim-prettier/pull/131) ([mitermayer](https://github.com/mitermayer))
- git: ignore unix yarn.lock file [\#129](https://github.com/prettier/vim-prettier/pull/129) ([docwhat](https://github.com/docwhat))
- Amend syntax in documentation around config overrides [\#127](https://github.com/prettier/vim-prettier/pull/127) ([chris-kobrzak](https://github.com/chris-kobrzak))
- Updating the logic for controlling the quickfix flag [\#125](https://github.com/prettier/vim-prettier/pull/125) ([mitermayer](https://github.com/mitermayer))
- doc: typo for quickfix option [\#124](https://github.com/prettier/vim-prettier/pull/124) ([docwhat](https://github.com/docwhat))
- don't change focus to the quicklist [\#122](https://github.com/prettier/vim-prettier/pull/122) ([docwhat](https://github.com/docwhat))
- Fix space in autocmd breaking autosave [\#115](https://github.com/prettier/vim-prettier/pull/115) ([LinuCC](https://github.com/LinuCC))
- Fixing empty spaces directory for async [\#111](https://github.com/prettier/vim-prettier/pull/111) ([mitermayer](https://github.com/mitermayer))
- Fix \#108 spaces in executable path problem [\#110](https://github.com/prettier/vim-prettier/pull/110) ([nelsyeung](https://github.com/nelsyeung))
- Updating docs with vue support reference [\#107](https://github.com/prettier/vim-prettier/pull/107) ([mitermayer](https://github.com/mitermayer))
- Adding vue file detect [\#105](https://github.com/prettier/vim-prettier/pull/105) ([mitermayer](https://github.com/mitermayer))
- Bumping prettier dependencie to 1.10.2 [\#104](https://github.com/prettier/vim-prettier/pull/104) ([mitermayer](https://github.com/mitermayer))
- Add vue file format to README [\#103](https://github.com/prettier/vim-prettier/pull/103) ([corburn](https://github.com/corburn))
- Support the `--arrow-parens` configuration option [\#101](https://github.com/prettier/vim-prettier/pull/101) ([nthurow](https://github.com/nthurow))
- Disabling nvim async by default under feature flag [\#98](https://github.com/prettier/vim-prettier/pull/98) ([mitermayer](https://github.com/mitermayer))
- Fixing lint [\#97](https://github.com/prettier/vim-prettier/pull/97) ([mitermayer](https://github.com/mitermayer))
- Add default option values from Prettier for configuration [\#94](https://github.com/prettier/vim-prettier/pull/94) ([maurobringolf](https://github.com/maurobringolf))
- bugfix - making sure we do not replace content with empty buffer [\#93](https://github.com/prettier/vim-prettier/pull/93) ([mitermayer](https://github.com/mitermayer))
- fix typo in pathogen install method [\#91](https://github.com/prettier/vim-prettier/pull/91) ([nicoder](https://github.com/nicoder))
- Add --prose-wrap option [\#90](https://github.com/prettier/vim-prettier/pull/90) ([frankychung](https://github.com/frankychung))
- Just a simple documentation for vim-pathogen [\#87](https://github.com/prettier/vim-prettier/pull/87) ([gustavo-gimenez](https://github.com/gustavo-gimenez))
- Add async support for neovim [\#81](https://github.com/prettier/vim-prettier/pull/81) ([chemzqm](https://github.com/chemzqm))

## [0.2.6](https://github.com/prettier/vim-prettier/tree/0.2.6) (2017-12-08)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.5...0.2.6)

**Closed issues:**

- Single quote option not working [\#84](https://github.com/prettier/vim-prettier/issues/84)
- no semicolon not working [\#83](https://github.com/prettier/vim-prettier/issues/83)
- Slow [\#82](https://github.com/prettier/vim-prettier/issues/82)

**Merged pull requests:**

- Bumping prettier dep to 1.9.1 [\#86](https://github.com/prettier/vim-prettier/pull/86) ([mitermayer](https://github.com/mitermayer))
- issues-83-and-84 - Fixing prettier 1.9 regression [\#85](https://github.com/prettier/vim-prettier/pull/85) ([mitermayer](https://github.com/mitermayer))

## [0.2.5](https://github.com/prettier/vim-prettier/tree/0.2.5) (2017-11-08)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.4...0.2.5)

**Implemented enhancements:**

- Add support for prettier 1.8 [\#77](https://github.com/prettier/vim-prettier/issues/77)

**Fixed bugs:**

- Prettier: failed to parse buffer. Prettier fails on css files. [\#76](https://github.com/prettier/vim-prettier/issues/76)

**Closed issues:**

- prepends `Ignored unknown option: --config-precedence` in buffer [\#73](https://github.com/prettier/vim-prettier/issues/73)

**Merged pull requests:**

- Issue 77/adding support for prettier 1.8 [\#80](https://github.com/prettier/vim-prettier/pull/80) ([mitermayer](https://github.com/mitermayer))
- issues/76 - the shellescapping util function was breaking async [\#79](https://github.com/prettier/vim-prettier/pull/79) ([mitermayer](https://github.com/mitermayer))
- Add shellescape for file path [\#74](https://github.com/prettier/vim-prettier/pull/74) ([chemzqm](https://github.com/chemzqm))

## [0.2.4](https://github.com/prettier/vim-prettier/tree/0.2.4) (2017-10-20)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.3...0.2.4)

**Implemented enhancements:**

- No references to getting help or support [\#67](https://github.com/prettier/vim-prettier/issues/67)

**Fixed bugs:**

- Incorrect resolving of prettier config [\#71](https://github.com/prettier/vim-prettier/issues/71)

**Closed issues:**

- SyntaxError: Unexpected token [\#69](https://github.com/prettier/vim-prettier/issues/69)

**Merged pull requests:**

- Fixing bug where config was not being correctly loaded based on file [\#72](https://github.com/prettier/vim-prettier/pull/72) ([mitermayer](https://github.com/mitermayer))
- Including extra information on the autoload header and doc header [\#70](https://github.com/prettier/vim-prettier/pull/70) ([mitermayer](https://github.com/mitermayer))

## [0.2.3](https://github.com/prettier/vim-prettier/tree/0.2.3) (2017-10-08)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.2...0.2.3)

**Merged pull requests:**

- adding suppor for vim8 versions older than 8.0.0015 to use async job API [\#66](https://github.com/prettier/vim-prettier/pull/66) ([mitermayer](https://github.com/mitermayer))

## [0.2.2](https://github.com/prettier/vim-prettier/tree/0.2.2) (2017-10-07)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.1...0.2.2)

**Merged pull requests:**

- Making sure we can still save the results of last prettier async run on [\#65](https://github.com/prettier/vim-prettier/pull/65) ([mitermayer](https://github.com/mitermayer))

## [0.2.1](https://github.com/prettier/vim-prettier/tree/0.2.1) (2017-10-07)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.2.0...0.2.1)

**Fixed bugs:**

- Overwrites Buffer1 with contents of Buffer2 [\#62](https://github.com/prettier/vim-prettier/issues/62)
- Confused by file type overrides [\#60](https://github.com/prettier/vim-prettier/issues/60)

**Merged pull requests:**

- bugfix: Fixing auto command params to use extensions instead of magic [\#64](https://github.com/prettier/vim-prettier/pull/64) ([mitermayer](https://github.com/mitermayer))
- bugfix: fixing race condition incorrect buffer formating [\#63](https://github.com/prettier/vim-prettier/pull/63) ([mitermayer](https://github.com/mitermayer))

## [0.2.0](https://github.com/prettier/vim-prettier/tree/0.2.0) (2017-10-04)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.1.3...0.2.0)

**Fixed bugs:**

- `--parser` with value `postcss` is deprecated [\#59](https://github.com/prettier/vim-prettier/issues/59)

**Merged pull requests:**

- bug: Fixing config overwrite value for non js by levaraging --stdin-f… [\#61](https://github.com/prettier/vim-prettier/pull/61) ([mitermayer](https://github.com/mitermayer))

## [0.1.3](https://github.com/prettier/vim-prettier/tree/0.1.3) (2017-09-30)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.1.2...0.1.3)

## [0.1.2](https://github.com/prettier/vim-prettier/tree/0.1.2) (2017-09-26)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.1.1...0.1.2)

**Implemented enhancements:**

- Allow configuration to set lookup path for `prettier` cli on `.vimrc` [\#56](https://github.com/prettier/vim-prettier/issues/56)

**Merged pull requests:**

- issue/56 - Allowing user path overwrite configuration [\#57](https://github.com/prettier/vim-prettier/pull/57) ([mitermayer](https://github.com/mitermayer))
- Fixed some typos in the README [\#55](https://github.com/prettier/vim-prettier/pull/55) ([Haegin](https://github.com/Haegin))

## [0.1.1](https://github.com/prettier/vim-prettier/tree/0.1.1) (2017-09-18)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.1.0...0.1.1)

**Implemented enhancements:**

- Upgrade to support prettier 1.6 [\#51](https://github.com/prettier/vim-prettier/issues/51)

**Merged pull requests:**

- feature: Adding more commands [\#54](https://github.com/prettier/vim-prettier/pull/54) ([mitermayer](https://github.com/mitermayer))

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

## [0.0.14](https://github.com/prettier/vim-prettier/tree/0.0.14) (2017-08-24)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.13...0.0.14)

**Fixed bugs:**

- :Prettier causes :Ggrep to lose history [\#39](https://github.com/prettier/vim-prettier/issues/39)

**Closed issues:**

- Trailing comma is causing issues with IE10/11 [\#45](https://github.com/prettier/vim-prettier/issues/45)

**Merged pull requests:**

- Async command was not working for windows this patch will make sure it [\#47](https://github.com/prettier/vim-prettier/pull/47) ([mitermayer](https://github.com/mitermayer))
- Add instructions on changing the mapping to README [\#43](https://github.com/prettier/vim-prettier/pull/43) ([eddiezane](https://github.com/eddiezane))

## [0.0.13](https://github.com/prettier/vim-prettier/tree/0.0.13) (2017-08-13)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.12...0.0.13)

**Implemented enhancements:**

- Include changelog [\#35](https://github.com/prettier/vim-prettier/issues/35)

**Merged pull requests:**

- bugfix: should not clear quickfix unless opened by vim-prettier itself [\#40](https://github.com/prettier/vim-prettier/pull/40) ([mitermayer](https://github.com/mitermayer))

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

## [0.0.7](https://github.com/prettier/vim-prettier/tree/0.0.7) (2017-06-20)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.6...0.0.7)

**Merged pull requests:**

- feature: enabling partial buffer conversion [\#15](https://github.com/prettier/vim-prettier/pull/15) ([mitermayer](https://github.com/mitermayer))
- fixed typo [\#13](https://github.com/prettier/vim-prettier/pull/13) ([wangsongiam](https://github.com/wangsongiam))

## [0.0.6](https://github.com/prettier/vim-prettier/tree/0.0.6) (2017-06-07)

[Full Changelog](https://github.com/prettier/vim-prettier/compare/0.0.5...0.0.6)

**Merged pull requests:**

- Adding async command and configuration controls [\#12](https://github.com/prettier/vim-prettier/pull/12) ([mitermayer](https://github.com/mitermayer))

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

- Fix default settings [\#16](https://github.com/prettier/vim-prettier/pull/16) ([vutran](https://github.com/vutran))
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

[Full Changelog](https://github.com/prettier/vim-prettier/compare/a53ffa1ba81c76d0b2c29afe55ab131c6cc9a0e3...0.0.1)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
