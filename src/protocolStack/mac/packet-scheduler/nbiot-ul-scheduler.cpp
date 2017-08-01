/*
 * NBIotUlScheduler.cpp
 *
 *  Created on: 08/12/2016
 *      Author: great
 */

#include "nbiot-ul-scheduler.h"
#include "../ul-nbiot-AMCModule.h"
#include "../../../core/spectrum/nbiot-bandwidth-manager.h"
#include "../../../phy/lte-phy.h"
#include "../../../utility/eesm-effective-sinr.h"
#include "../../../core/eventScheduler/simulator.h"

NbIotUlScheduler::NbIotUlScheduler(int scSpacing, int scGroupSize) {
	SetMacEntity(0);
	setNodeTypeToSchedule(NetworkNode::TYPE_NBIOT_UE);
	CreateUsersToSchedule();
	this->scGroupSize = scGroupSize;
	nextScheduleT = 0.0;
	currUser = 0;
	servedUsers = std::set<int>();

	if (scSpacing == 15) {
		if (scGroupSize == 1)
			ruDuration = 0.008;
		if (scGroupSize == 3)
			ruDuration = 0.004;
		if (scGroupSize == 6)
			ruDuration = 0.002;
		if (scGroupSize == 12)
			ruDuration = 0.001;
	} else {
		this->scGroupSize = 12;
		ruDuration = 0.001;
	}
}

NbIotUlScheduler::~NbIotUlScheduler() {
	std::cout << "servedUsers: " << servedUsers.size() << std::endl;
	Destroy();
	DeleteUsersToSchedule();
}

void NbIotUlScheduler::RBsAllocation() {
	//RoundRobin

	UlNbIotAMCModule amcModule;

	UsersToSchedule *users = this->GetUsersToSchedule();
	UsersToSchedule::iterator it;

	NbIotBandwidthManager *bwManager = (NbIotBandwidthManager*) users->at(0)->m_userToSchedule->GetPhy()->GetBandwidthManager();
	int scToSchedule = bwManager->GetUlBandwidth();
	int nUsersToSchedule = scToSchedule / scGroupSize;
	int sc = 0;
	for (int i = 0; i < nUsersToSchedule; i++) {
		if (currUser >= users->size())
			currUser = 0;

		UserToSchedule *selectedUser = users->at(currUser);

		vector<double> temp;
		for (int j = 0; j < scGroupSize; j++) {
			temp.push_back(selectedUser->m_channelContition.at(sc + j));
		}

		double sinr = GetEesmEffectiveSinr(temp);
		int mcs = amcModule.GetMCSFromCQI(amcModule.GetCQIFromSinr(sinr));
		int tbs = ((amcModule.GetTBSizeFromMCS(mcs, 1)) / 8);


		selectedUser->m_listOfAllocatedRBs.push_back(i);
		selectedUser->m_transmittedData = tbs;
		selectedUser->m_selectedMCS = mcs;

		servedUsers.insert(selectedUser->m_userToSchedule->GetIDNetworkNode());

#ifdef NBIOT_DEBUG
		std::cout << "[NBIOT_DEBUG] Selected user " << selectedUser->m_userToSchedule->GetIDNetworkNode() << " for RU " << i << " MCS " << mcs << " txBytes " << tbs << std::endl;
#endif

		currUser++;
		sc += scGroupSize;
	}
	UpdateNextScheduleTime(ruDuration);
}

double NbIotUlScheduler::ComputeSchedulingMetric(RadioBearer* bearer, double spectralEfficiency) {
	return 0.0;
}

double NbIotUlScheduler::ComputeSchedulingMetric(UserToSchedule* user, int subchannel) {
	return 0.0;
}

const void NbIotUlScheduler::UpdateNextScheduleTime(double deltat) {
	nextScheduleT = Simulator::Init()->Now() + deltat;
}

const double NbIotUlScheduler::GetNextScheduleTime() {
	return nextScheduleT;
}

const double NbIotUlScheduler::GetRuDuration() {
	return ruDuration;
}
