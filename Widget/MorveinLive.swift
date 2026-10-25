import WidgetKit
import SwiftUI
import ActivityKit

@main
struct MorveinBundle: WidgetBundle {
    var body: some Widget { MorveinLive() }
}

struct LockView: View {
    let st: MorveinAttributes.ContentState
    var body: some View {
        HStack(spacing: 12) {
            MorveinView(pose: st.pose).frame(width: 70, height: 84)
            VStack(alignment: .leading, spacing: 4) {
                Text("Морвейн").font(.headline).foregroundColor(.white)
                Text(st.phrase).font(.subheadline).foregroundColor(.white.opacity(0.8))
                Text("Мана \(st.mana) · Сытость \(st.hunger)").font(.caption).foregroundColor(Color(hex: 0xb44cff))
            }
            Spacer()
        }.padding()
    }
}

struct MorveinLive: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MorveinAttributes.self) { ctx in
            LockView(st: ctx.state).activityBackgroundTint(Color(hex: 0x0b0814))
        } dynamicIsland: { ctx in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    MorveinView(pose: ctx.state.pose).frame(width: 60, height: 72)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .trailing) {
                        Text("Мана \(ctx.state.mana)").foregroundColor(Color(hex: 0xb44cff))
                        Text("Сыт \(ctx.state.hunger)").foregroundColor(.orange)
                    }.font(.caption)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(ctx.state.phrase).font(.subheadline)
                }
            } compactLeading: {
                MorveinView(pose: ctx.state.pose, focus: true).frame(width: 24, height: 24)
            } compactTrailing: {
                Text("\(ctx.state.mana)").foregroundColor(Color(hex: 0xb44cff))
            } minimal: {
                MorveinView(pose: ctx.state.pose, focus: true).frame(width: 22, height: 22)
            }
        }
    }
}
