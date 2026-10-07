// =============================================================
//  Station ALMA-7, Part III: The Repair Fleet
//  iOS Mobile Development · Module 5 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part3_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section. LegacyBeacon in
//     particular must be reached with an extension, not edited.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • The Health Rule must exist in exactly ONE place in this file.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Drone records recovered from the fleet registry.
/// One `kind` does not correspond to any drone type you will build.
let fleetData: [(kind: String, id: String, charge: Int)] = [
    (kind: "welder",  id: "W-1", charge: 80),
    (kind: "scanner", id: "S-1", charge: 45),
    (kind: "cargo",   id: "C-1", charge: 100),
    (kind: "welder",  id: "W-2", charge: 15),
    (kind: "scanner", id: "S-2", charge: 60),
    (kind: "tug",     id: "T-1", charge: 50)
]

/// Hull sensors. These are NOT drones — they never move and never work a shift.
let sensorData: [(id: String, charge: Int)] = [
    (id: "hull-cam", charge: 12),
    (id: "thermal",  charge: 77)
]

/// Hardware from the original station. You may not add anything to this
/// declaration — no methods, no protocols, no properties.
struct LegacyBeacon {
    let name: String
    let signalStrength: Int
}

let beacon = LegacyBeacon(name: "ALMA-BEACON", signalStrength: 8)

print("Fleet registry online: \(fleetData.count) drone records, \(sensorData.count) sensors, beacon \(beacon.name).")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each declaration when you start working on it.


// MARK: Level 1 · The Power Cell

// Why a class and not a struct here?  -> Потому что батарея - это разделяемое изменяемое состояние.

final class PowerCell {
    private var charge: Int
    
    init(charge: Int) {
        if charge < 0 {
            self.charge = 0
        } else if charge > 100 {
            self.charge = 100
        } else {
            self.charge = charge
        }
    }
    
    func level() -> Int {
        return charge
    }
    
    func spend(amount: Int) -> Bool {
        if amount <= 0 || charge < amount {
            return false
        }
        charge -= amount
        return true
    }
    
    func recharge(by amount: Int) {
        if amount > 0 {
            charge += amount
            if charge > 100 {
                charge = 100
            }
        }
    }
}

// Encapsulation proof (leave this commented, with the compiler error):
// let cell = PowerCell(charge: 100)
// cell.charge = 100
// error: 'charge' is inaccessible due to 'private' protection level






// MARK: Level 2 · The Fleet


class Drone: Diagnosable, Rechargeable {
    let id: String
    let cell: PowerCell
    
    init(id: String, cell: PowerCell) {
        self.id = id
        self.cell = cell
    }
    
    var powerCost: Int { 10 }
    var statusLine: String { "\(id): \(cell.level().powerBar)" }
    
    var componentID: String { id }
    var statusCode: Int { getStatusCode(from: cell.level()) }
    
    func performTask() -> Int { 0 }
    
    final func runOnce() -> Int {
        if cell.spend(amount: powerCost) {
            return performTask()
        }
        return 0
    }
    
    func recharge(by amount: Int) {
        cell.recharge(by: amount)
    }
}

// 2.2
final class WelderDrone: Drone {
    override var powerCost: Int { 25 }
    override func performTask() -> Int { 40 }
    func weldSeam() -> String { "Seam welded" }
}

class ScannerDrone: Drone {
    override var powerCost: Int { 10 }
    override func performTask() -> Int { 15 }
    override var statusLine: String {
        return super.statusLine + " [scanner]"
    }
}

final class CargoDrone: Drone {
    override var powerCost: Int { 20 }
    override func performTask() -> Int { 25 }
}

// 2.3
func makeDrone(kind: String, id: String, charge: Int) -> Drone? {
    let cell = PowerCell(charge: charge)
    if kind == "welder" {
        return WelderDrone(id: id, cell: cell)
    } else if kind == "scanner" {
        return ScannerDrone(id: id, cell: cell)
    } else if kind == "cargo" {
        return CargoDrone(id: id, cell: cell)
    }
    return nil
}

var fleet: [Drone] = []
for record in fleetData {
    if let drone = makeDrone(kind: record.kind, id: record.id, charge: record.charge) {
        fleet.append(drone)
    } else {
        print("Warning: Skipped unknown drone kind '\(record.kind)'")
    }
}


// MARK: Level 3 · The Shift

func runShift(_ fleet: [Drone], rounds: Int) -> Int {
    var totalWork = 0
    for _ in 0..<rounds {
        for drone in fleet {
            totalWork += drone.runOnce()
        }
    }
    return totalWork
}

let A = runShift(fleet, rounds: 3)

for drone in fleet {
    print(drone.statusLine)
}

var B = 0
for drone in fleet {
    B += drone.cell.level()
}

var C = 0
for drone in fleet {
    if drone.cell.level() >= drone.powerCost {
        C += 1
    }
}


// MARK: Level 4 · Diagnostics

// Why does Drone implement recharge(by:) without `mutating`?  -> Drone - reference type
struct SensorModule: Diagnosable, Rechargeable {
    let id: String
    var chargeLevel: Int
    
    var componentID: String { id }
    var statusCode: Int { getStatusCode(from: chargeLevel) }
    
    mutating func recharge(by amount: Int) {
        if amount > 0 {
            chargeLevel += amount
            if chargeLevel > 100 { chargeLevel = 100 }
        }
    }
}

// Why could [Drone] never have held the sensors?  -> SensorModule - struct
func diagnosticsReport(_ components: [Diagnosable]) -> String {
    var report = ""
    for component in components {
        report += component.diagnose() + "\n"
    }
    return report
}


// MARK: Level 4.1
protocol Diagnosable {
    var componentID: String { get }
    var statusCode: Int { get }
    func diagnose() -> String
}
// 4.2
protocol Rechargeable {
    mutating func recharge(by amount: Int)
}

extension Diagnosable {
    func diagnose() -> String {
        return "\(componentID): code \(statusCode)"
    }
    
    func getStatusCode(from value: Int) -> Int {
        if value < 20 { return 2 }
        if value < 50 { return 1 }
        return 0
    }
}


// MARK: Level 5 · Shared Behaviour

// 5.2 · the beacon you cannot edit
extension LegacyBeacon: Diagnosable {
    var componentID: String { name }
    var statusCode: Int { getStatusCode(from: signalStrength) }
    
    func diagnose() -> String {
        return "LEGACY HARDWARE: \(name) | STATUS: \(statusCode)"
    }
}

var allComponents: [Diagnosable] = []
for drone in fleet {
    allComponents.append(drone)
}
for data in sensorData {
    allComponents.append(SensorModule(id: data.id, chargeLevel: data.charge))
}
allComponents.append(beacon)

print(diagnosticsReport(allComponents))

var D = 0
for component in allComponents {
    D += component.statusCode
}

// MARK: Level 5.3
extension Int {
    var powerBar: String {
        var clamped = self
        if clamped < 0 { clamped = 0 }
        if clamped > 100 { clamped = 100 }
        
        let hashes = clamped / 10
        let dots = 10 - hashes
        var bar = ""
        
        for _ in 0..<hashes { bar += "#" }
        for _ in 0..<dots { bar += "." }
        
        return bar
    }
}



// MARK: Level 6 · Incident Reports
// Two of these do not compile. Two compile and lie.
// For each: expectation, actual behaviour, the language rule, the fix.

/*
// Report 1
class PatchDrone: Drone {
    func performTask() -> Int {
        return 30
    }
}

// Report 2
final class HeavyWelder: WelderDrone {
    override func runOnce() -> Int {
        return 999
    }
}

// Report 3
let reportFleet: [Drone] = [WelderDrone(id: "W-9", cell: PowerCell(charge: 100))]
let first = reportFleet[0]
print(first.weldSeam())

// Report 4
protocol Labelled {
    var componentID: String { get }
}

extension Labelled {
    func label() -> String { "generic component" }
}

struct Thruster: Labelled {
    let componentID: String
    func label() -> String { "thruster \(componentID)" }
}

let parts: [Labelled] = [Thruster(componentID: "T-1")]
print(parts[0].label())
*/


// MARK: Finale · Mission Code

 let missionCode = "\(A)-\(B)-\(C)-\(D)"
 print("MISSION CODE: \(missionCode)")


// MARK: Bonus

// Two ways to forbid using Drone directly; a protocol-based redesign;
// two or three sentences comparing them.


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why does a class satisfy a `mutating` protocol requirement without the
    keyword, while a struct must write it?
    Classes are reference types (changing a property doesn't change the pointer). Structs are value types, so they need the keyword.

 2. One thing inheritance does that protocols cannot, and one thing
    protocols do that inheritance cannot:
    Inheritance shares stored properties. Protocols can be applied to structs.

 3. What does `final` prevent, and what did it protect in runOnce()?
    Blocks overriding. It stopped subclasses from doing free work without spending battery

 4. In Report 4, why did the protocol extension's method win?
    The method wasn't declared inside the protocol itself, which caused static dispatch.

*/
