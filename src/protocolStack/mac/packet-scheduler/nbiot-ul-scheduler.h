/*
 * NBIotUlScheduler.h
 *
 *  Created on: 08/12/2016
 *      Author: great
 */

#ifndef SRC_PROTOCOLSTACK_MAC_PACKET_SCHEDULER_NBIOT_UL_SCHEDULER_H_
#define SRC_PROTOCOLSTACK_MAC_PACKET_SCHEDULER_NBIOT_UL_SCHEDULER_H_

#include "enhanced-uplink-packet-scheduler.h"

class NbIotUlScheduler: public EnhancedUplinkPacketScheduler {
private:
	int currUser = 0.0;
	double nextScheduleT = 0.0;
	double ruDuration;
protected:
	int scGroupSize;
public:
	NbIotUlScheduler(int scSpacing, int scGroupSize);
	virtual ~NbIotUlScheduler();

	virtual void RBsAllocation();

	virtual double ComputeSchedulingMetric (RadioBearer *bearer, double spectralEfficiency, int subChannel);
	virtual double ComputeSchedulingMetric (UserToSchedule* user, int subchannel);

	const void UpdateNextScheduleTime(double t);
	const double GetNextScheduleTime();

	const double GetRuDuration();
};

#endif /* SRC_PROTOCOLSTACK_MAC_PACKET_SCHEDULER_NBIOT_UL_SCHEDULER_H_ */
