# 🚢 shipin

help you ship into a new mac in interactive way

<img src="https://user-images.githubusercontent.com/6839576/96358317-801a9a80-1138-11eb-98e0-62f3f0fdaf65.gif" width="1000" />

*▲ 🚢 shipin*

## 📝 usage

```bash
curl "https://raw.githubusercontent.com/JiangWeixian/shipin/master/mac.shipin.sh" | sh
```

### install crontab

```sh
# git clone repo
cd shipin
sh scripts/cron/install.sh
```

- **"0 11 * * * sh $PWD/$BASEDIR/greet.sh"** - say hello at `11:00am`
- **"0 21 * * * sh $PWD/$BASEDIR/offwork.sh"** - time to offwork at `21:00pm`
- **"0 * * * * sh $PWD/$BASEDIR/drinkwater.sh"** - `@hourly` remind drink water

## ✨ features
> it will...

- `git`
  - config `git`
- `ohmyzsh`
  - config with [p10k](https://github.com/romkatv/powerlevel10k#oh-my-zsh)
  - install some [awesome-zsh-plugins](/docs/zshplugins.md)
- `nvm`
  - install lts nodejs
- `homebrew`
  - install lots of [apps](/mac.shipin.sh)..., like `switchhosts, vscode...`
- `alfred`
  - set alfred-theme with [alfred-theme-simple](https://github.com/sindresorhus/alfred-simple)
  - some [awesome-alfred-workflows](/docs/alfred.md)
- bind `forward-word & backward-word`
- install some [awesome-cli-tools](/docs/clitools.md)
- install useful crontab

# 
<div align='right'>

*built with ❤️ by JiangWeixian*

</div>