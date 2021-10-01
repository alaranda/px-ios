import Foundation

/**
Use this object to call methods related to our PX tracker.
 */
@objcMembers
open class PXTracker: NSObject {
    // MARK: Static Setter.
    /**
     Set your own tracker listener protocol to be aware of PX-Checkout tracking events
     */
    public static func setListener(_ listener: PXTrackerListener) {
        setListener(listener, flowName: nil, flowDetails: nil)
    }

    public static func setListener(_ listener: PXTrackerListener, flowName: String?, flowDetails: [String: Any]?) {
        MPXTracker.sharedInstance.setTrack(listener: listener)
        MPXTracker.sharedInstance.setFlowDetails(flowDetails: flowDetails)
        MPXTracker.sharedInstance.setFlowName(name: flowName)
    }
}
