puts '                              !         !'
puts '                             ! !       ! !'
puts '                            ! . !     ! . !'
puts '                               ^^^^^^^^^ ^'
puts '                             ^             ^'
puts '                           ^  (0)       (0)  ^'
puts '                          ^        ''         ^'
puts '                         ^   ***************    ^'
puts '                       ^   *                 *   ^'
puts '                      ^   *   /\   /\   /\    *    ^'
puts '                     ^   *                     *    ^'
puts '                    ^   *   /\   /\   /\   /\   *    ^'
puts '                   ^   *                         *    ^'
puts '                   ^  *                           *   ^'
puts '                   ^  *                           *   ^'
puts '                    ^ *                           *  ^'
puts '                     ^*                           * ^'
puts '                      ^ *                        * ^'
puts '                      ^  *                      *  ^'
puts '                        ^  *       ) (         * ^'
puts '                            ^^^^^^^^ ^^^^^^^^^ '
puts ' '
puts 'Hello! We will begin setting up your new computer.'
puts ' '
puts '              /     \ '
puts '              vvvvvvv  /|__/|'
puts '                 I   /O,O   |'
puts '                 I /_____   |      /|/|'
puts '                J|/^ ^ ^ \  |    /00  |    _//|'
puts '                 |^ ^ ^ ^ |W|   |/^^\ |   /oo |'
puts '                  \m___m__|_|    \m_m_|   \mm_|'
puts ' '
puts 'We\'ll get to work. Make sure to stick around to enter your password when prompted.'
puts 'Also, if you haven\'t installed Dropbox and synced all of your files yet this isn\'t going to work. Go do that if you haven\'t.'
puts ' '
puts '================================='
puts 'Installing OS X Commandline Tools'
puts '================================='
puts ' '

`xcode-select --install`

puts ' '
puts ' '
puts '===================='
puts 'Installing homebrew.'
puts '===================='
puts ' '

`ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'`

puts '============================='
puts 'Installing homebrew formulas.'
puts '============================='
puts ' '

`brew install ack autoconf bash bash-completion fasd fish git jq libevent mercurial mysql node openssl phantomjs pkg-config rbenv readline rmtrash ruby-build the_platinum_searcher tmux vim multimarkdown ag`
`brew doctor`
`brew update`

puts '=============================='
puts 'Making Fish our default shell.'
puts '=============================='
puts ' '

`echo '/usr/local/bin/fish' | sudo tee -a /etc/shells`

puts '===================='
puts 'Installing dotfiles.'
puts '===================='
puts ' '

[
    %w( 'config.fish'   '~/.config/fish/' ),
    %w( 'functions'     '~/.config/fish/' ),
    %w( 'vimrc'         '~/'              ),
    %w( 'vim'           '~/'              ),
    %w( 'tmux.conf'     '~/'              ),
    %w( 'tm_properties' '~/'              ),
    %w( 'irbrc'         '~/'              ),
    %w( 'gitconfig'     '~/'              ),
    %w( 'bash_profile'  '~/'              )
].each do |arr|
    puts 'Symlinking #{arr[0]}'
    `ln -s ~/Dropbox/dotfiles/#{arr[0]}.symlink ~/.#{arr[1]}`
end

puts '======================'
puts 'Unhiding our ~/Library'
puts '======================'
puts ' '

`chflags nohidden ~/Library/`

puts '=================================================='
puts 'Installing rbenv'
puts 'NOTE: Make sure you have rbenv shims in your path!'
puts '=================================================='
puts ' '

`git clone https://github.com/sstephenson/rbenv.git ~/.rbenv`
`rbenv rehash`

puts '================'
puts 'Installing Rails'
puts '================'
puts ' '

`gem install rails`

puts '==========================='
puts 'Installing Inconsolata Font'
puts '==========================='
puts ' '

`curl -o ~/Downloads/Inconsolata.otf 'http://www.levien.com/type/myfonts/Inconsolata.otf'; and open ~/Downloads/Inconsolata.otf`

puts '========='
puts 'Setup Vim'
puts '========='
puts ' '

`updatevim` # This is a custom Fish function I wrote which you can find at ~/.config/fish/functions/updatevim.fish.
