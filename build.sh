bundle exec middleman build --clean

cp -r ~/Sites/Slate/build ~/Sites/Textiful_v2/api

rm -r ~/Sites/Textiful_v2/api/docs

mv ~/Sites/Textiful_v2/api/build ~/Sites/Textiful_v2/api/docs