from stackapi import StackAPI
SITE = StackAPI('dsp')
SITE.max_pages = 100
tags = SITE.fetch('tags')
word_frequency = {}
for i in tags['items']:
	word_frequency[i['name']] = i['count']

from wordcloud import WordCloud

wordcloud = WordCloud(width = 800, height = 800,
                background_color ='black',
                min_font_size = 10).fit_words(word_frequency)

wordcloud.to_file('word_cloud.png')
