import SwiftUI

struct ContentView: View {
    @State private var question: String = ""
    @State private var answer: String = ""
    @State private var showAnswer = false
    @State private var showShare = false
    @State private var isRotating = false // 控制旋转动画
    @FocusState private var isTextFieldFocused: Bool // 绑定焦点控制键盘弹出
    @State private var keyboardHeight: CGFloat = 0 // 添加键盘高度状态

    
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
        "现在的你比以往任何时候都清楚", "只需说声谢谢", "或许，等你再年长些就明白了", "这将轰动一时", "放手一搏", "事情会朝目标发展",
        "更细心去了解，你就知道该怎么做了", "需要做更多的努力", "等待一个更好的机会", "数到5，再试一次", "你不得不妥协", "很快就能解决", "十分确定",
        "这还不确定", "谨慎处理", "全力以赴", "重新考虑你的做法", "问问你的母亲吧", "如果你独自一人就不要", "无需担忧", "保持开放的心态", "你会为自己所做的感到高兴的",
        "发挥你的想象力", "献出你的一切", "顺从你的意愿", "先做好自己的事", "不要怀疑", "是时候做新打算了", "省省力气吧", "合作将是关键", "此时不宜", "把这看做一次机会",
        "莫等待", "你可能不得不放弃其他东西", "遵守规则", "相关问题可能会出现", "事情将如你所愿", "赌一把", "以后再处理", "结果是乐观的", "期待解决", "灵活应对",
        "注意细节", "你的行动会使一切变好", "答案就在公园里", "消除你自身的障碍", "这是不明智的", "将需要大量的努力", "不要勉强自己", "是时候做打算了", "别再犹豫了", "享受这次体验",
        "要付出坚持不懈的努力", "那仍旧无法预测", "毋庸置疑", "多花点时间来做决定", "只做这一次", "做出改变", "可行", "先做好其他事", "不要陷入到情绪之中", "相信你的直觉",
        "采纳智者的建议", "情况不明了", "你不得不妥协", "列出否定的理由", "要有耐心", "一笑置之", "继续", "你必须随机应变", "别忘记享受乐趣", "那是在浪费金钱", "重要的优先",
        "为了做出最好的决定，务必保持冷静", "尝试一个更没把握的方法", "清除你自身的障碍", "那可能已成事实", "保守你的秘密", "你必须马上行动", "不要妄下赌注", "那可能已无法改变", "一些帮助能确保你成功", "你肯定会获得支持", "只做一次", "遵循智者的建议", "如你所愿", "当局者迷", "无论你怎么做，结果依旧", "先主后次", "这会让你付出代价", "尽早行动", "寻求更多选择", "你现在比以往任何时候都清楚", "极可能发生事故", "带着好奇去探索", "列出这样做的理由", "马上停下来", "这不是很确定", "不用担心", "不要告诉别人", "你需要其他人的帮助", "那将是一件乐事", "不要迫于压力草率行事", "不要等待", "你能以任何方式改善现状", "你会为此感到高兴", "放弃之前的想法", "你不会失望的","此路仍需观察","不妨大胆尝试","请先聆听他人的意见","再三思量才可行动","耐心是你最好的盟友", "时机未到，静待良机","或许该先退一步"/*,"谋定而后动","再多等待一日","大胆跨越旧桎梏","寻求新的助力","多问自己为何而行","换个角度再看","一切自有因果","守住内心的平衡","稳中求变才是正道","你必须主动出击","切勿因小失大","考量得失再决定","倾听直觉的声音","不妨向更高之处攀登","不轻言放弃","你比想象中更强大","保持谦逊有益无害","切换思路或能豁然开朗","必须让行动兑现承诺","远离琐事才能看清全貌","一场冒险或许值得","请谨慎取舍","静观其变乃上策","用事实说服他人","别让成见阻碍你","暗中积蓄力量","守住本心才会坚定","用微笑面对未知","小心火烛，勿被热情烧灼","潜在的危险需提防","你有更多选择权","突破固有思维","不要回避沟通","再试一次也无妨","今日行事稍安勿躁","着眼长远更有益","向内心寻找答案","协同他人将更顺利","学会放下旧包袱","自信却不自负","化复杂为简单","莫被外界杂音左右","一步一步稳步前行","换种方式再努力","轻松心态更有助力","保留一丝神秘感","别吝啬真诚与热忱","任何时刻皆可重启","寻找值得信赖的伙伴","平衡理想与现实","以和为贵","尝试新的合作关系","主动出击方能胜","改变不可避免","当下行动比空想重要","坚守初心最难得","别忽视身边微小细节","结果或超出预期","直面挑战无可回避","请保持弹性思维","留意潜藏机遇","倾听内心的声音","不要忽视小小的灵感","点滴累积成就大局","专注于最重要的事","拒绝随波逐流","暂时的退让也是进步","给自己留点余裕","等待更佳的时机","越过舒适区","将主动权掌握手中","关键在于沟通技巧","不妨试试新的方法","脚踏实地，胜过空想","要能承担相应后果","勿被过去困扰","尝试迎接不同声音","多倾听而少指责","换一条路或许更快","成功需时间酝酿","聚焦目标，切忌分心","再问自己为何出发","或许已有暗示","把目标细分更易完成","抓住稍纵即逝的机会","提前布局以防万一","适度保留退路","别让忧虑绊住前行","有所保留地表达","你的选择将改变未来","克制情绪以保清醒","做最真实的自己","尝试逆向思维","守住秘密乃关键","主动分享可获助力","不要低估你的潜能","先完成再追求完美","必要时请寻求外援","慢慢酝酿必有好处","留意人际关系动态","细节之处见真章","不妨先暂停片刻","坦诚能化解误会","最好的答案往往简单","做好准备再扬帆","平衡利益与原则","深思后再发言","相信持续努力的力量","你需要一次革新","短暂离开能重获灵感","少说多做","准备备用方案","意外或带来惊喜","回头看看走过的路","沉住气，别急于表态","记住初心所在","坚持你最重要的价值","果断执行已定方案","多倾听专家意见","轻装上阵才能远行","不如先整理思绪","放手或能收获更多","给自己一个明确时限","巧妙绕过障碍","向熟悉的人求助","保守不代表退缩","重视合作伙伴的感受","灵活应变才是王道","抛开旧有成见","新的旅程即将开启","有些秘密不必揭开","时机成熟时一切顺理成章","点到为止即可","不可忽视小小的暗示","偶尔需要些妥协","承担风险是必经之路","试探对方态度","目标清晰胜过盲目行动","将自信注入每一步","某些遗憾难以挽回","你必须牺牲一部分","注意及时止损","克服恐惧才有新生","你的沉默可能是力量","不要只看眼前","认真衡量成本收益","或许需要再一次尝试","改变做事顺序","多关注市场变化","请用行动证明","直觉常常不骗人","你已接近真相","把繁琐化简","过去的经验是财富","为自己设定更高目标","等待并非懦弱","留给他人足够空间","别让情绪牵着走","也许要从头开始","抓住微小的火花","尝试不一样的节奏","调整脚步别急于求成","珍惜每一次失败的教训","稳扎稳打才能更远","运气也是实力的一部分","换个地点再思考","求变之心不可缺","慢一步也许更稳","要有“放弃”的勇气","你会有新的发现","别被现状限制","期待更多奇妙变化","容忍一些不完美","请相信彼此的善意","从旁观者角度审视","重新梳理核心需求","先做再说","应对变化时保持灵活","引导而非强制","尊重每个人的节奏","关注当下手头要务","可能需要改变原计划","少许风险不必惧怕","你正在接近成功","客观评估当前资源","切忌盲目自大","不必急于表态","征询更多反馈","稳重才能走得更远","有时沉默是最佳回答","守住关键的节点","简化你的目标","避免重复旧错误","你需要更多耐心","事情尚未到最终阶段","或许该把话说清楚","看准再出手","把握好分寸","懂得取舍才会收获","真诚交流胜过一切","时间会给出答案","潜心钻研终见回报","请坚定你原本的想法","给予他人更多信任","抓紧机会不要犹豫","先让自己强大起来","看似简单实则不易","需要一些创造力","让行动回应质疑","必要时坦然承认失误","问问自己究竟想要什么","不要害怕未知","进一步的分析必不可少","聚焦当下的挑战","尊重合作伙伴的意见","放下过去才能前行","把复杂问题分段解决","相信团队的力量","每个人都有不同角色","或许需要外部专业支持","积累的口碑很重要","展现你的领导力","保持学习的热情","偶尔试试无计划的创作","及时汇报进度","节制欲望方可长远","明智的退让也是前行","结局往往不止一个","警惕虚假的承诺","不要在意短暂的偏见","以积极心态应对问题","记住初衷，不忘初心"*/
    ]
 
    
    var body: some View {
        ZStack {
            // 背景色
            Color(red: 245/255, green: 244/255, blue: 239/255)
                .opacity(1)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                               isTextFieldFocused = false // 取消输入框焦点，收起键盘
                           }
            
            // 主要内容
            VStack(spacing: 20) {
                if showAnswer {
                    ZStack {
                        Image("\(Int.random(in: 1...15))")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                            .frame(maxHeight: UIScreen.main.bounds.height) // 图片高度 = 屏幕高度 - 80pt
                        
                        VStack(spacing: 20) {
                            Spacer()
                            Text("\(question) ？")
                                .font(.title)
                                .opacity(0.6)
                                .multilineTextAlignment(.center)
                                .colorScheme(.light)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                                .padding()
                            
                            Text("\"\(answer)\"")
                                .font(.title)
                                .bold()
                                .multilineTextAlignment(.center)
                                .colorScheme(.light)
                                .opacity(0.7)
                            
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.8) // 限制最大宽度为屏幕的 80%
                                .padding()
                            
                            Spacer() // 让按钮贴到底部
                            HStack(spacing: 20) {
                                Button("再问一个") {
                                    showAnswer = false
                                    question = ""
                                    answer = ""
                                }.padding()
                                .buttonStyle(StyledButton())
                                
//                                Button("分享") {
//                                    //                                    showShare = true
//                                }
                                .buttonStyle(StyledButton())
                            }
                        }
                        .padding()
                        
                    }
                } else {
                    VStack() {
                   
                        
//                        Image("circle6")
//                            .resizable()
//                            .scaledToFit()
//                            .opacity(0.6)
//                            .frame(width: UIScreen.main.bounds.width * 0.8)
//                            .rotationEffect(.degrees(isRotating ? 260 : 0), anchor: .center)
//                            .animation(.linear(duration: 0.5), value: isRotating)
//                            .offset(y:-(UIScreen.main.bounds.height * 0.2))
//                    }
                    Image("circle6")
                                .resizable()
                                .scaledToFit()
                                .opacity(0.5)
                                .frame(width: UIScreen.main.bounds.width * (UIDevice.current.userInterfaceIdiom == .pad ? 0.6 : 0.8))
                                .rotationEffect(.degrees(isRotating ? 260 : 0), anchor: .center)
                                .animation(.linear(duration: 0.5), value: isRotating)
                                .offset(y: -(UIScreen.main.bounds.height * 0.2))
                        }
                    Image("slogan3")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28).padding()
                        .offset(y:-(UIScreen.main.bounds.height * 0.22))
                }
            }
            
            // 输入框层，独立定位
            if !showAnswer {
                VStack {
                    Image("logo")
                        .resizable()
                        .opacity(0.6)
                        .scaledToFit()
                        .frame(height: 60).padding()
                        .offset(y:(UIScreen.main.bounds.height * 0.75))
                 
                    Spacer()
                    ZStack(alignment: .trailing) {
                        TextEditor(text: $question)
                            .frame(height: 32)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .padding(.trailing, 40)
                            .scrollContentBackground(.hidden) // 隐藏默认的背景
                            .background(Color(red: 245/255, green: 244/255, blue: 239/255))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .overlay(
                                Group {
                                    if question.isEmpty {
                                        Text("请输入你的问题...")
                                            .foregroundColor(Color.gray)
                                            .padding(.leading, 16)
                                            .padding(.top, 14)
                                    }
                                }
                                , alignment: .topLeading
                            )
                            .colorScheme(.light)
                            .environment(\.colorScheme, .light)
                            .focused($isTextFieldFocused)
                        
                        Button(action: {
                            if !question.isEmpty {
                                isRotating = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                    answer = answers.randomElement() ?? "No answer"
                                    showAnswer = true
                                    isRotating = false
                                }
                            }
                        }) {
                            Image("eye")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .colorScheme(.light)
                                .opacity(question.isEmpty ? 0.3 : 1.0)
                        }
                        .frame(width: 40)
                        .padding(.trailing, 8)
                        .disabled(question.isEmpty)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, keyboardHeight > 0 ? keyboardHeight-32 : UIScreen.main.bounds.height * 0.25) // 设置固定的底部距离
                }}
            }.ignoresSafeArea(.keyboard, edges: .bottom)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .ignoresSafeArea(.container, edges: .bottom)
//            .edgesIgnoringSafeArea(.bottom)
                .onAppear {
                    setupKeyboardObservers()
                }
                .onDisappear {
                    removeKeyboardObservers()
                }
    }
    
    // 添加键盘观察者方法
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
            keyboardHeight = keyboardFrame.height
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

struct StyledEyeBtn: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(0)
            .frame(width: 100)
//            .background(Color.black.opacity(configuration.isPressed ? 0.5 : 1))
            .background(Color(red: 238/255, green: 234/255, blue: 226/255).opacity(0.5))
            .overlay( // 添加黑色边框
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 2)
                    )
//            .foregroundColor(Color.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .shadow(radius: configuration.isPressed ? 0 : 5)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
struct StyledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 150)
        
//            .background(Color.black.opacity(configuration.isPressed ? 0.5 : 1))
            .background(Color.white.opacity(0.8))
            .foregroundColor(Color.black)
            .bold()

//            .foregroundColor(Color.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .shadow(radius: configuration.isPressed ? 0 : 5)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
