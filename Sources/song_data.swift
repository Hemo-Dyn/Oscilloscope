import Foundation

final class Song: Sendable {
    let title: String
    let path: String
    let lyrics: String

    init(title: String, path: String, lyrics: String) {
        self.title = title
        self.path = path
        self.lyrics = lyrics
    }
}

struct Library {
    static let working: Song = Song(
        title: "hardly working at all",
        path:
            "./Songs/hardly working at all.wav",
        lyrics: """

            In thirty short seconds         /
            forgot where your heart aligns  /
            hope you can't stand            /
            to look right at your damn self /
            stop making excuses             /
            stop telling your stupid lies   /
            were you hard at work           /
            or hardly working at all        ?
            """)

    static let blood: Song = Song(
        title: "thicker than water",
        path:
            "./Songs/thicker than water_mastered_instrumental_loud.wav",
        lyrics: """

                All of this blood               /
                and there's a rush to the head  /
                this river could run            /
                and lead you on to the next     /
                current thicker than water      /
                steered this ship out of course /
                with God as the witness         /
                you still feel so secure        .
            """)

    static let fuji: Song = Song(
        title: "fujifilm",
        path:
            "./Songs/fujifilm (mix 4).wav",
        lyrics: """

                    Your camera's got scratches         /
                    on its face                         /
                    make believe that there's something /
                    wrong at the source                 /
                    crystal clear                       /
                    think and thin                      /
                    something false in that shape       /
                    there's a shade of discomfort       /

                    you wanna                           /

                    live life on a fujifilm\u{2122}            /
                    live life on a fujifilm\u{2122}            /
                    
                    you wanna                           /

                    live life on a fujifilm\u{2122}            /
                    live life on a fujifilm\u{2122}            /
                                                        /
                    a fearful and lanky figure          /
                    keeps running just out of view      /
                    a silhouette keeps on sprinting     /
                    and rushing its way to you          /
                    if you keep on just standing idle   /
                    waiting a week or two               /
                    it means that all of your poison    /
                    might bleed back into your system   /
                    again                               .

            """)

    static let brady: Song = Song(
        title: "bradycardia",
        path:
            "./Songs/bradycardia (kind of mastered).wav",
        lyrics: """

                    We're not really here                   /   epinephrine                         /
                    fell right through the floor            /   be my best friend                   /
                    bradycardia                             /   be my lifeline be my Aid Kit        /
                                                            /   give me a kiss                      /
                    we don't feel alive                     /   'cause I don't feel well            /
                                                            /   like a phantom                      /
                    I-i-                                    /   I feel made up                      /
                    I-i-i-                                  /   I don't really wanna live like this /
                    I-i-                                    /   make it feel fine                   /
                    I-i-feee                                /   make it feel right                  /
                    (x4)                                    /   make me feel heard                  /
                                                            /   make me feel whole                  /
                    you just see through me                 /   make me human                       /
                    like I'm not really here                /   'cause                              /
                    because we're just one in the same      /   I've been on track                  /
                    same type in the blood that we boil     /   to be distant                       / 
                    same type in the way we behave          /   non-existant                        /
                                                            /   maladjusted                         /
                    our names don't stay as our names       /   fall in the earth                   /
                    this night might last us a lifetime     /                                       /
                                                            /   did it occur to you                 ?
                                                            /   make all this noise here            /
                                                            /   to get through you                  .
                                                            /   and we're still pining              /
                                                            /   for some platitudes                 /
                                                            
                                                            /   I wanna feel like I'm a person      /
                                                            /   too                                 .
            """)
}
