import SwiftUI
import ActivityKit

@main
struct MorveinApp: App {
    var body: some Scene { WindowGroup { ContentView() } }
}

struct ContentView: View {
    @State var pose = "idle"
    @State var mana = 100
    @State var hunger = 80
    @State var phrase = "Морвейн пробудился из тени…"
    @State var activity: Activity<MorveinAttributes>?
    let tick = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var st: MorveinAttributes.ContentState {
        .init(pose: pose, mana: mana, hunger: hunger, phrase: phrase)
    }

    var body: some View {
        ZStack {
            Color(hex: 0x07060b).ignoresSafeArea()
            VStack(spacing: 14) {
                Text("Морвейн").font(.title.bold()).foregroundColor(.white)
                MorveinView(pose: pose).frame(height: 280)
                Text(phrase).foregroundColor(.white)
                Text("Мана \(mana) · Сытость \(hunger)").foregroundColor(.gray)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    btn("🏝 Запустить остров") { start() }
                    btn("🛑 Убрать остров") { stop() }
                    btn("🍎 Покормить") { feed() }
                    btn("💤 Сон") { sleep() }
                }
                btn("⛧ Призвать пентаграмму") { cast() }
            }.padding()
        }
        .onReceive(tick) { _ in
            mana = min(100, mana + 2)
            hunger = max(0, hunger - 1)
            if pose == "idle" && hunger < 25 { pose = "hungry" }
            push()
        }
    }

    func btn(_ t: String, _ a: @escaping () -> Void) -> some View {
        Button(action: a) { Text(t).frame(maxWidth: .infinity) }
            .buttonStyle(.borderedProminent).tint(.purple)
    }

    func push() {
        let s = st
        Task { await activity?.update(ActivityContent(state: s, staleDate: nil)) }
    }
    func start() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            phrase = "Включите Live Activities в настройках"; return
        }
        activity = try? Activity.request(attributes: MorveinAttributes(name: "Морвейн"),
                                         content: ActivityContent(state: st, staleDate: nil))
    }
    func stop() {
        Task { await activity?.end(nil, dismissalPolicy: .immediate); activity = nil }
    }
    func feed() {
        hunger = min(100, hunger + 30); pose = "idle"; phrase = "Ням… даже тьма голодна."; push()
    }
    func sleep() {
        pose = pose == "sleep" ? "idle" : "sleep"
        phrase = pose == "sleep" ? "Закрываю глаза…" : "Я выспался."; push()
    }
    func cast() {
        guard mana >= 30 else { phrase = "Мало маны…"; push(); return }
        mana -= 30; pose = "cast"; phrase = "Ave Umbra!"; push()
        Task {
            try? await Task.sleep(nanoseconds: 6_000_000_000)
            pose = hunger < 25 ? "hungry" : "idle"; phrase = "Тьма довольна."; push()
        }
    }
}
