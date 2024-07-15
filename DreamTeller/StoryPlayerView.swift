//
//  StoryPlayerView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 15.07.2024.
//

import SwiftUI
import AVFoundation

struct StoryPlayerView: View {
    let story: Story
    @State private var isPlaying: Bool = false
    @State private var player: AVAudioPlayer?
    @State private var progress: Double = 0.0
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text(story.title)
                .font(.largeTitle)
                .padding()
            
            Image(story.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .padding()
            
            Slider(value: $progress, in: 0...1, step: 0.01)
                .padding()

            HStack {
                Button(action: {
                    if self.isPlaying {
                        self.pauseAudio()
                    } else {
                        self.playAudio()
                    }
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                }
            }
        }
        .onAppear {
            self.setupAudio()
        }
        .onDisappear {
            self.stopAudio()
        }
    }

    func setupAudio() {
        guard let path = Bundle.main.path(forResource: story.audio, ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        } catch {
            print("Error loading audio file")
        }
    }

    func playAudio() {
        player?.play()
        isPlaying = true
        startTimer()
    }

    func pauseAudio() {
        player?.pause()
        isPlaying = false
        stopTimer()
    }

    func stopAudio() {
        player?.stop()
        isPlaying = false
        stopTimer()
        progress = 0.0
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            guard let player = self.player else { return }
            self.progress = player.currentTime / player.duration
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct StoryPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        StoryPlayerView(story: Story(title: "Cinderella",
                                     audio: "The Adventures of Little Bruno in the Forest",
                                     imageName: "Image 1",
                                     isFavorite: true,
                                     ageGroup: .threeToFive,
                                     category: .fantasy)
        )
    }
}
