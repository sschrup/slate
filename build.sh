bundle exec middleman build --clean

cp -r ~/Sites/Textiful_v2_ApiDocs/build ~/Sites/Textiful_v2/api

rm -r ~/Sites/Textiful_v2/api/docs

mv ~/Sites/Textiful_v2/api/build ~/Sites/Textiful_v2/api/docs