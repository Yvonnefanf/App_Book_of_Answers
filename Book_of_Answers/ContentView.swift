import SwiftUI

struct ContentView: View {
    @State private var question: String = ""
    @State private var answer: String = ""
    @State private var showAnswer = false
    @State private var showShare = false
    
    let answers = [
        "寻求更多的选择", "不", "别忽视显而易见的东西", "结果可能令人吃惊", "有决心就能成功", "做一次改变", "照别人告诉你的去做",
        "不能保证", "答案可能会以另一种形式出现", "毫无疑问", "这样做会使事情变得有趣", "这是肯定的", "有可能会伤害到他人",
        "全身心投入将赢得好结果", "采取冒险的态度", "最好等待", "可能会惹上麻烦", "你需要采取主动", "似乎没问题", "当然",
        "不要在意", "尽早做好它", "你终会发现你想知道的一切", "除非你独自一人", "是，但不要强求", "你需要去适应", "明天再来试试",
        "以更放松的态度去面对", "你需要考虑其他方法", "在习惯中接受一些改变", "要知道选择太多和选择太少一样很难", "别浪费时间了", "是",
        "花更多时间来决定", "灵活应对", "似乎已成事实", "看开一点", "问问你的异性同事", "柳暗花明又一村", "你会后悔的", "避免第一个解决办法",
        "随它去吧", "过段时间就不那么重要了", "拭目以待", "相信你最初的想法", "请不要抗拒", "这会带来好运", "那一定很棒", "把它记下来",
        "可能发生小意外", "学习并享受它", "这具有重要意义", "防备意外发生", "一切将依赖于你的选择", "转移注意力", "离开", "你需要其他人的帮助",
        "这有些特别", "不要犹豫", "先完成其他事", "给自己一点时间", "现在你就能", "那不值得纠结", "那将影响别人对你的看法", "照别人说的去做",
        "转移你的注意力", "你会失望的", "最好关注你的工作", "形式尚不明朗", "不要抱有成见", "你必须现在就行动", "那可能很难，但值得", "付出就会有回报",
        "对意外要有思想准备", "更细心地去倾听，你就会知道", "且行且思", "你有能力以任何方式改善", "这是你不会忘记的事物", "履行你的义务",
        "快刀斩乱麻", "别在这上面下赌注", "也许吧", "专注于你的家庭生活", "绝对不", "等待", "别犯傻了", "可能吧", "表示怀疑", "意义非凡",
        "那可能非同寻常", "不可能失败", "你需要了解更多", "情况很快就会有变化", "这并不重要", "顺其自然", "问问你最好的朋友", "这时不要再自找麻烦",
        "晚一点处理", "尝试一种更可能的解决方案", "先做重要的事", "投硬币来做决定吧", "这也取决于另一种情况", "你最终能如愿", "可行", "答案就在你家窗外",
        "现在的你比以往任何时候都清楚", "只需说声“谢谢”", "或许，等你再年长些就明白了", "这将轰动一时", "放手一搏", "事情会朝目标发展",
        "更细心去了解，你就知道该怎么做了", "需要做更多的努力", "等待一个更好的机会", "数到5，再试一次", "你不得不妥协", "很快就能解决", "十分确定",
        "这还不确定", "谨慎处理", "全力以赴", "重新考虑你的做法", "问问你的母亲吧", "如果你独自一人就不要", "无需担忧", "保持开放的心态", "你会为自己所做的感到高兴的",
        "发挥你的想象力", "献出你的一切", "顺从你的意愿", "先做好自己的事", "不要怀疑", "是时候做新打算了", "省省力气吧", "合作将是关键", "此时不宜", "把这看做一次机会",
        "莫等待", "你可能不得不放弃其他东西", "遵守规则", "相关问题可能会出现", "事情将如你所愿", "赌一把", "以后再处理", "结果是乐观的", "期待解决", "灵活应对",
        "注意细节", "你的行动会使一切变好", "答案就在公园里", "消除你自身的障碍", "这是不明智的", "将需要大量的努力", "不要勉强自己", "是时候做打算了", "别再犹豫了", "享受这次体验",
        "要付出坚持不懈的努力", "那仍旧无法预测", "毋庸置疑", "多花点时间来做决定", "只做这一次", "做出改变", "可行", "先做好其他事", "不要陷入到情绪之中", "相信你的直觉",
        "采纳智者的建议", "情况不明了", "你不得不妥协", "列出否定的理由", "要有耐心", "一笑置之", "继续", "你必须随机应变", "别忘记享受乐趣", "那是在浪费金钱", "重要的优先",
        "为了做出最好的决定，务必保持冷静", "尝试一个更没把握的方法", "清除你自身的障碍", "那可能已成事实", "保守你的秘密", "你必须马上行动", "不要妄下赌注", "那可能已无法改变", "一些帮助能确保你成功", "你肯定会获得支持", "只做一次", "遵循智者的建议", "如你所愿", "当局者迷", "无论你怎么做，结果依旧", "先主后次", "这会让你付出代价", "尽早行动", "寻求更多选择", "你现在比以往任何时候都清楚", "极可能发生事故", "带着好奇去探索", "列出这样做的理由", "马上停下来", "这不是很确定", "不用担心", "不要告诉别人", "你需要其他人的帮助", "那将是一件乐事", "不要迫于压力草率行事", "不要等待", "你能以任何方式改善现状", "你会为此感到高兴", "放弃之前的想法", "你不会失望的"
    ]
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                if showShare {
                    VStack(spacing: 20) {
                       
                        Text("\(question) ？")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.white)
                            
                        
                        
                        Text("\"\(answer)\"")
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.white)
                      
                     
                        
                        Button("返回提问") {
                            showShare = false
                            showAnswer = false
                            question = ""
                            answer = ""
                        }
                        .buttonStyle(StyledButton())
                    }
                    .padding()
                } else if showAnswer {
                    
                    ZStack {
                        Image("\(Int.random(in: 1...15))")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                        VStack(spacing: 20) {
                            Text("\"\(answer)\"")
                                .font(.largeTitle)
                                .bold()
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color.white)
                            
                            HStack(spacing: 20) {
                                Button("再问一个") {
                                    showAnswer = false
                                    question = ""
                                    answer = ""
                                }
                                .buttonStyle(StyledButton())
                                
                                Button("分享") {
                                    showShare = true
                                }
                                .buttonStyle(StyledButton())
                            }
                        }
                        .padding()
                        
                    }
                    
                    
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "book.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.black)
                        
                        Text("当你遇事不决时，答案之书将会指引你")
                            .font(.title3)
                            .foregroundColor(.black)
                        
                        
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $question)
                                .frame(minHeight: 100, maxHeight: 100)
                                        .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                                        
                                    if question.isEmpty {
                                    Text("请输入你的问题...")
                                    .foregroundColor(.gray)
                                        .padding(.top, 25)
                                        .padding(.leading, 18)
                                    }
                                    }
                       
                                                
                                    Button("查看答案") {
                            if !question.isEmpty {
                            answer = answers.randomElement() ?? "No answer"
                            showAnswer = true
                            }
                                }
                            .buttonStyle(StyledButton())
                    }
                    .padding()
                }
            }
        }
    }
}

struct StyledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 150)
            .background(Color.black.opacity(configuration.isPressed ? 0.5 : 1))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: configuration.isPressed ? 0 : 5)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
