import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> NewsArticleEntry {
      NewsArticleEntry(date: Date(), title: "Sample Text that will change")
    }

    func getSnapshot(in context: Context, completion: @escaping (NewsArticleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.widgetget")
               let title = userDefaults?.string(forKey: "headline_title") ?? "Sample Text that will change"
               let entry = NewsArticleEntry(date: Date(), title: title)
               completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
      getSnapshot(in: context) { (entry) in
        let timeline = Timeline(entries: [entry], policy: .atEnd)
                  completion(timeline)
              }
    }
}

struct NewsArticleEntry: TimelineEntry {
    let date: Date
    let title: String
   
}

struct NewsWidgetsEntryView : View {
  var entry: Provider.Entry
    
    // New: Register the font.
    init(entry: Provider.Entry){
            self.entry = entry
            CTFontManagerRegisterFontsForURL(bundle.appending(path: "/fonts/Chewy-Regular.ttf") as CFURL, CTFontManagerScope.process, nil)
        }
    
    // New: Add the helper function.
    var bundle: URL {
            let bundle = Bundle.main
            if bundle.bundleURL.pathExtension == "appex" {
                // Peel off two directory levels - MY_APP.app/PlugIns/MY_APP_EXTENSION.appex
                var url = bundle.bundleURL.deletingLastPathComponent().deletingLastPathComponent()
                url.append(component: "Frameworks/App.framework/flutter_assets")
                return url
            }
            return bundle.bundleURL
        }

    var body: some View {
           VStack(alignment: .leading) {
               Text(entry.title)
                   .font(.subheadline)
                   .padding(.vertical, 8)
                   .padding(.horizontal, 16)
                   .background(Color.gray.opacity(0.2))
                   .cornerRadius(25)

               Button(action: {
                   // Handle button action
               }) {
                   Text("Button ")
                       .foregroundColor(.white)
                       .padding(.vertical, 5)
                       .padding(.horizontal, 16)
                    
                      
               }
               .background(Color.blue)
               .cornerRadius(25)
               
               
           }
           .padding()
  }
}

struct HomeWidget: Widget {
    let kind: String = "HomeWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            NewsWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

