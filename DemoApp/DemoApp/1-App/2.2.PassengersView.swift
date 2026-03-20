//
//  PassengerView.swift
//  DemoApp
//

import SwiftUI
import mdi_mob_sdk_doc_model_ios
//import AMADocModeliOS

struct PassengersView: View {
    // MARK: - Form State

    @State private var language: String = MockData.passenger1.language ?? ""
    @State private var mrz: String = MockData.passenger1.mrz ?? ""
    @State private var boardingPass: String = MockData.passenger1.boardingPasses?.first ?? ""
    @State private var docPhotoBase64: String = MockData.passenger1.docPhotoBase64 ?? ""
    @State private var selfieBase64: String = MockData.passenger1.selfieBase64 ?? ""
    @State private var ePassport: Bool = MockData.passenger1.ePassport ?? false
    @State private var tag: String = MockData.passenger1.tag ?? ""

    // MARK: - Committed Data

    @Binding var committedPassengers: [Passenger]
    @State private var showCommitAlert = false

    // MARK: - Computed Passenger

    private var currentPassenger: Passenger {
        Passenger(
            language: language,
            mrz: mrz,
            boardingPasses: [boardingPass],
            docPhotoBase64: docPhotoBase64,
            selfieBase64: selfieBase64,
            ePassport: ePassport,
            tag: tag,
            ebagtagId: ""
        )
    }

    private var canCommit: Bool {
        guard !mrz.isEmpty else { return false }

        let existingMRZs = committedPassengers.compactMap(\.mrz)
        return !existingMRZs.contains(mrz)
    }

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Form Input

                Section("General") {
                    TextField("Language", text: $language)
                    TextField("Tag", text: $tag)
                    Toggle("ePassport", isOn: $ePassport)
                }

                Section("Document Data") {
                    TextField("MRZ", text: $mrz, axis: .vertical)
                        .lineLimit(3...6)

                    TextField("Boarding Pass", text: $boardingPass, axis: .vertical)
                        .lineLimit(2...4)
                }

                Section("Photos (Base64)") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Document Photo")
                            .font(.headline)

                        imagePreview(from: docPhotoBase64)
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        TextField("Document Photo Base64", text: $docPhotoBase64, axis: .vertical)
                            .lineLimit(2...4)
                            .font(.footnote)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Selfie Photo")
                            .font(.headline)

                        imagePreview(from: selfieBase64)
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        TextField("Selfie Photo Base64", text: $selfieBase64, axis: .vertical)
                            .lineLimit(2...4)
                            .font(.footnote)
                    }
                }

                // MARK: - Commit Button

                Section {
                    Button("Commit Passenger #\(committedPassengers.count + 1)") {
                        commitPassenger()
                    }
                    .disabled(!canCommit)
                }

                // MARK: - Committed Passengers

                if !committedPassengers.isEmpty {
                    Section("Committed Passengers") {
                        ForEach(Array(committedPassengers.enumerated()), id: \.offset) { index, passenger in
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Passenger \(index + 1)")
                                    .font(.headline)

                                HStack {
                                    imagePreview(from: passenger.docPhotoBase64 ?? "")
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))

                                    imagePreview(from: passenger.selfieBase64 ?? "")
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }

                                Text(passenger.mrz ?? "")
                                    .font(.footnote)
                                    .lineLimit(2)

                                Text("ePassport: \((passenger.ePassport ?? false) ? "Yes" : "No")")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Passenger")
            .alert("Passenger Committed", isPresented: $showCommitAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Passenger #\(committedPassengers.count + 1) was successfully added.")
            }
        }
    }
}

// MARK: - Logic

private extension PassengersView {
    func commitPassenger() {
        guard canCommit else { return }
        committedPassengers.append(currentPassenger)
        showCommitAlert = true

        language = MockData.passenger2.language ?? ""
        mrz = MockData.passenger2.mrz ?? ""
        boardingPass = MockData.passenger2.boardingPasses?.first ?? ""
        docPhotoBase64 = MockData.passenger2.docPhotoBase64 ?? ""
        selfieBase64 = MockData.passenger2.selfieBase64 ?? ""
        ePassport = MockData.passenger2.ePassport ?? false
        tag = MockData.passenger2.tag ?? ""
    }
}

// MARK: - Image Helper

private extension PassengersView {
    @ViewBuilder
    func imagePreview(from base64: String) -> some View {
        if let uiImage = decodeBase64Image(base64) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                Text("Invalid")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }

    func decodeBase64Image(_ base64: String) -> UIImage? {
        guard let data = Data(base64Encoded: base64),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}
