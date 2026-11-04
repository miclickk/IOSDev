//
//  ViewController.swift
//  Assignment_music_player
//
//  Created by Аскар Кулахметов on 31.10.2026.
//
import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!

    
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    var currentIndex = 0

    
    let tracks: [Track] = [
        Track(title: "Day Night Morning", artist: "No Copyright", fileName: "daynigthmorning-no-copyright-music-425784", coverImageName: "cover1"), //[cite: 4]
        Track(title: "Palm Trees in Stereo", artist: "Cinematic Soul", fileName: "cinematic-soul-upbeat-corporate-music-palm-trees-in-stereo-587095", coverImageName: "cover2"), //[cite: 5]
        Track(title: "Spooky Halloween", artist: "Cinematic Soul", fileName: "cinematic-soul-spooky-halloween-background-music-617917", coverImageName: "cover3"), //[cite: 6]
        Track(title: "Motivational Sport Rock", artist: "AudioCoffee", fileName: "audiocoffee-motivational-sport-rock-no-copyright-music-578087", coverImageName: "cover4"), //[cite: 7]
        Track(title: "Spooky Background", artist: "Cinematic Soul", fileName: "cinematic-soul-spooky-background-music-617904", coverImageName: "cover5"), //[cite: 8]
        Track(title: "Rock Trailer", artist: "AudioCoffee", fileName: "audiocoffee-rock-trailer-no-copyright-music-469216", coverImageName: "cover6"), //[cite: 9]
        Track(title: "Halloween Intro", artist: "Cinematic Soul", fileName: "cinematic-soul-halloween-intro-background-music-617910", coverImageName: "cover7"), //[cite: 10]
        Track(title: "Maybe This Is Living", artist: "Cinematic Soul", fileName: "cinematic-soul-maybe-this-is-living-instrumental-587101", coverImageName: "cover8"), //[cite: 11]
        
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    
    func updateUI() {
        let currentTrack = tracks[currentIndex]
        titleLabel.text = currentTrack.title
        artistLabel.text = currentTrack.artist
        coverImageView.image = UIImage(named: currentTrack.coverImageName)
        
        loadAudio(for: currentTrack)
    }

    func loadAudio(for track: Track) {
        guard let url = Bundle.main.url(forResource: track.fileName, withExtension: "mp3") else {
            print("Ошибка: Файл \(track.fileName).mp3 не найден в бандле")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
        } catch {
            print("Ошибка загрузки аудио: \(error.localizedDescription)")
        }
    }

    // MARK: - Управление воспроизведением
    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let player = audioPlayer else { return }

        if isPlaying {
            player.pause()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player.play()
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        isPlaying.toggle()
    }

    @IBAction func previousTapped(_ sender: UIButton) {
        // Если первый трек, переключаем на последний
        currentIndex = currentIndex == 0 ? tracks.count - 1 : currentIndex - 1
        changeTrack()
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        // Остаток от деления возвращает индекс к 0 на последнем треке
        currentIndex = (currentIndex + 1) % tracks.count
        changeTrack()
    }

    func changeTrack() {
        updateUI()
        if isPlaying {
            audioPlayer?.play()
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }

    // MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            nextTapped(UIButton())
        }
    }
}
