import SwiftUI

struct PR { let x, y, w, h: CGFloat; let c: UInt32; let a: Double }

func morveinRects(_ pose: String) -> [PR] {
    var r: [PR] = []
    let sl = pose == "sleep", cs = pose == "cast", sad = pose == "hungry"
    let dy: CGFloat = sl ? 3 : 0
    func R(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ c: UInt32, _ a: Double = 1) {
        r.append(PR(x: x, y: y + dy, w: w, h: h, c: c, a: a))
    }
    let B: UInt32 = 0x14121c, M: UInt32 = 0x1e1b2b, H: UInt32 = 0x343049, RM: UInt32 = 0x5b5380, TR: UInt32 = 0x7a4cc2
    let gl: UInt32 = cs ? 0xffe6ff : 0xd66bff
    R(-6.5, -17, 13, 12, 0x0a0910)
    for k in 0..<3 { R(-7 + CGFloat(k) * 4.5, -5, 3, 3, B) }
    if sl { R(-6.5, -3, 13, 3, M); R(-6.5, -3, 13, 0.5, H); R(-5, -1, 4, 1, B); R(1, -1, 4, 1, B) }
    else {
        R(-4, -6, 3, 6, M); R(1, -6, 3, 6, M); R(-4, -6, 0.5, 6, H); R(1, -6, 0.5, 6, H)
        R(-4, -4.5, 3, 1.5, H); R(1, -4.5, 3, 1.5, H)
        R(-5, -2, 4, 2, B); R(1, -2, 4, 2, B); R(-5, -2, 4, 0.5, RM); R(1, -2, 4, 0.5, RM)
    }
    R(-5, -16, 10, 10, M); R(-5, -16, 10, 1.5, H); R(-0.5, -16, 1, 10, H)
    R(-5, -12, 10, 0.5, B); R(-5, -9.5, 10, 0.5, B); R(-5, -16, 0.5, 10, TR); R(4.5, -16, 0.5, 10, TR)
    R(-1.5, -13.5, 3, 2, gl); R(-0.5, -14.5, 1, 4, gl); R(-0.5, -13, 1, 1, 0xffffff)
    R(-5.5, -7.5, 11, 1.5, 0x2a2038); R(-1.5, -7.5, 3, 1.5, 0x9b6bff); R(2.5, -6, 1, 3, TR)
    R(-8, -9, 3, 4, 0x2a1830); R(-8, -9, 0.5, 4, TR); R(-6.5, -7.5, 1, 1, gl)
    R(-8, -17, 4, 3, H); R(-8, -17, 4, 0.5, RM); R(-7.5, -14.5, 3, 1.5, M)
    R(4, -17, 4, 3, H); R(4, -17, 4, 0.5, RM); R(4.5, -14.5, 3, 1.5, M)
    R(-8, -19.5, 1, 2.5, RM); R(-6.5, -19, 1, 2, RM); R(7, -19.5, 1, 2.5, RM); R(5.5, -19, 1, 2, RM)
    let hb: CGFloat = (sad ? 1 : 0) + (sl ? 1.5 : 0)
    let ec: UInt32 = sad ? 0xff4d6d : (cs ? 0xffffff : 0xd66bff)
    R(-4.5, -24.5 + hb, 9, 8.5, B); R(-3.5, -26 + hb, 7, 2, B); R(-2, -27.5 + hb, 4, 2, B); R(-0.5, -28 + hb, 1, 1, B)
    R(-4.5, -24 + hb, 0.5, 7, H); R(4, -24 + hb, 0.5, 7, H); R(-3, -26 + hb, 3, 0.5, H); R(-1, -27.5 + hb, 2, 0.5, H)
    R(-5.5, -25 + hb, 1, 2, RM); R(-6.5, -27.5 + hb, 1, 3, RM); R(-7, -28 + hb, 0.5, 1, H)
    R(4.5, -25 + hb, 1, 2, RM); R(5.5, -27.5 + hb, 1, 3, RM); R(6.5, -28 + hb, 0.5, 1, H)
    R(-3.5, -22 + hb, 7, 5, 0x000000); R(-3.5, -21.5 + hb, 7, 2.5, gl, 0.3)
    if sl { R(-2.5, -20 + hb, 2, 0.5, 0x4a3a66); R(0.5, -20 + hb, 2, 0.5, 0x4a3a66) }
    else {
        let h: CGFloat = cs ? 3 : 1.5
        R(-2.5, -21.5 + hb, 2, h, ec); R(0.5, -21.5 + hb, 2, h, ec)
        R(-2.5, -21.5 + hb, 0.5, 0.5, 0xffffff); R(0.5, -21.5 + hb, 0.5, 0.5, 0xffffff)
        R(-1.5, -18.5 + hb, 0.5, 1, 0xdddddd); R(1, -18.5 + hb, 0.5, 1, 0xdddddd)
    }
    let sy: CGFloat = cs ? -5 : 0
    if cs {
        R(-8.5, -21, 2, 7, M); R(-8.5, -21, 0.5, 7, H); R(-9, -23, 3, 2, H)
        R(5.5, -22, 2.5, 8, M); R(5.5, -22, 0.5, 8, H); R(6.5, -23, 3, 2, H)
    } else {
        R(-8.5, -15, 2.5, 7, M); R(-8.5, -15, 0.5, 7, H); R(-8.5, -10.5, 2.5, 1.5, TR); R(-8.5, -8.5, 2.5, 2, H)
        R(5.5, -15, 2.5, 7, M); R(5.5, -15, 0.5, 7, H); R(5.5, -10.5, 2.5, 1.5, TR); R(6.5, -8.5, 3, 2, H)
    }
    R(7.5, -27 + sy, 1, 28, 0x3b2a1e); R(7.5, -27 + sy, 0.5, 28, 0x5a4030)
    R(7, -14 + sy, 2, 0.5, TR); R(7, -11 + sy, 2, 0.5, TR); R(7, -8 + sy, 2, 0.5, TR)
    R(6.5, -31 + sy, 1, 4, RM); R(9, -31 + sy, 1, 4, RM); R(7, -27.5 + sy, 2, 1, H)
    let os: CGFloat = cs ? 1.5 : 1
    R(6 - os, -35.5 + sy - os, 4 + 2 * os, 4 + 2 * os, gl, sl ? 0.15 : 0.35)
    R(7, -33.5 + sy, 2, 2, sl ? 0x4a2a70 : gl); R(7.5, -33.5 + sy, 0.5, 0.5, 0xffffff)
    return r
}

struct MorveinView: View {
    let pose: String
    var focus = false
    var body: some View {
        Canvas { c, size in
            let s: CGFloat, ox: CGFloat, oy: CGFloat
            if focus { s = min(size.width, size.height) / 15; ox = size.width / 2; oy = size.height / 2 + 22.5 * s }
            else { s = size.height / 42; ox = size.width / 2 - s; oy = size.height - 3 * s }
            if pose == "cast" && !focus {
                let cx = ox, cy = oy + s, rx = 15 * s, ry = 4 * s
                var ring = Path()
                ring.addEllipse(in: CGRect(x: cx - rx, y: cy - ry, width: 2 * rx, height: 2 * ry))
                c.stroke(ring, with: .color(Color(hex: 0xb44cff)), lineWidth: max(1, s * 0.35))
                var star = Path()
                for (i, k) in [0, 2, 4, 1, 3, 0].enumerated() {
                    let a = -Double.pi / 2 + Double(k) * 2 * Double.pi / 5
                    let pt = CGPoint(x: cx + rx * CGFloat(cos(a)), y: cy + ry * CGFloat(sin(a)))
                    if i == 0 { star.move(to: pt) } else { star.addLine(to: pt) }
                }
                c.stroke(star, with: .color(Color(hex: 0xf0c8ff)), lineWidth: max(1, s * 0.25))
            }
            for p in morveinRects(pose) {
                let rect = CGRect(x: ox + p.x * s, y: oy + p.y * s, width: p.w * s, height: p.h * s)
                c.fill(Path(rect), with: .color(Color(hex: p.c).opacity(p.a)))
            }
        }
    }
}
