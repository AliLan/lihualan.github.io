import SwiftUI

struct ErrorBanner: View {
    let message: String
    var retryAction: (() -> Void)?

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.white)
            Text(message)
                .foregroundColor(.white)
                .font(.subheadline)
            Spacer()
            if let retryAction {
                Button("Retry") {
                    retryAction()
                }
                .buttonStyle(.borderedProminent)
                .tint(.white.opacity(0.2))
            }
        }
        .padding()
        .background(Color.red)
        .cornerRadius(12)
    }
}

#Preview {
    ErrorBanner(message: "Unable to load closet items.")
        .padding()
}
