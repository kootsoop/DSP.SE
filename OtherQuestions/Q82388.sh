ffmpeg -i audio-max-quality.aifc -vn -ar 44100 -ac 2 -b:a 192k audio-1.mp3
ffmpeg -i audio-1.mp3 audio-1.wav

for ITER in $( seq 1 1000 )
do
	NEXT=$((ITER+1))
	echo $ITER $NEXT
	ffmpeg -i audio-$ITER.wav -vn -ar 44100 -ac 2 -b:a 192k audio-$NEXT.mp3
	ffmpeg -i audio-$NEXT.mp3 audio-$NEXT.wav
done
