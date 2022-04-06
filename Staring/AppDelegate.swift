//
//  AppDelegate.swift
//  Staring
//
//  Created by Zhenyi Tan on 23/11/21.
//

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItem: NSStatusItem!
    private var menu: NSMenu!
    private var process: Process!
    private var isStaring = false

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        createStatusItem()
        createMenu()
        createButton()
        startStaring()
        stopStaring()
    }

    // MARK: - Create views

    private func createStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: 30)
    }

    private func createMenu() {
        menu = NSMenu()
        menu.addItem(withTitle: "", action: nil, keyEquivalent: "")
        menu.addItem(withTitle: "", action: nil, keyEquivalent: "")
        menu.addItem(withTitle: "", action: nil, keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quit Staring", action: #selector(quit), keyEquivalent: "")
    }

    private func createButton() {
        if let button = statusItem.button {
            button.title = ""
            button.action = #selector(clicked)
            button.sendAction(on: [.leftMouseDown, .rightMouseDown])
        }
    }

    // MARK: - Click handlers

    @objc private func clicked() {
        if let event = NSApp.currentEvent {
            if event.type == .leftMouseDown {
                leftClicked()
            } else {
                rightClicked()
            }
        }
    }

    private func leftClicked() {
        if isStaring {
            stopStaring()
        } else {
            startStaring()
        }
    }

    private func rightClicked() {
        statusItem.menu = menu
        if let button = statusItem.button {
            button.performClick(nil)
        }
        statusItem.menu = nil
    }

    // MARK: - Misc

    @objc private func startStaring() {
        isStaring = true
        process = Process.launchedProcess(launchPath: "/usr/bin/caffeinate", arguments: ["-ut 315360000"])

        if let button = statusItem.button {
            button.title = "ಠ_ಠ"
        }
        if let status1 = menu.item(at: 0) {
            status1.title = "I Am Staring at You"
        }
        if let status2 = menu.item(at: 1) {
            status2.title = "Your Mac Cannot Sleep"
        }
        if let onOff = menu.item(at: 2) {
            onOff.title = "Stop Staring"
            onOff.action = #selector(stopStaring)
        }
    }

    @objc private func stopStaring() {
        isStaring = false;
        process.terminate()

        if let button = statusItem.button {
            button.title = "-_-"
        }
        if let status1 = menu.item(at: 0) {
            status1.title = "I Am Not Staring at You"
        }
        if let status2 = menu.item(at: 1) {
            status2.title = "Your Mac Can Now Sleep"
        }
        if let onOff = menu.item(at: 2) {
            onOff.title = "Start Staring"
            onOff.action = #selector(startStaring)
        }
    }

    @objc private func quit() {
        if isStaring { stopStaring() }
        NSApp.terminate(nil)
    }

}
