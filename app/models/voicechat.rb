class Voicechat  < ActiveHash::Base
    self.data = [
      {id: 1, name: 'なし' },
      {id: 2, name: '聞き専' },
      {id: 3, name: 'Skype' },
      {id: 4, name: 'LINE' },
      {id: 5, name: 'PS4' },
      {id: 6, name: 'Discord' },
      {id: 7, name: 'ゲーム内' },
    ]
end
