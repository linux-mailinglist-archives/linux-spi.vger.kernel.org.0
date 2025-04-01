Return-Path: <linux-spi+bounces-7372-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B0A77300
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 05:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A913ACBA3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DEB189F56;
	Tue,  1 Apr 2025 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NRldvwnl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D033F6;
	Tue,  1 Apr 2025 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743478621; cv=none; b=UxJz3BmXDmDD5M+o/TCehsPe4TvTNzusmBRxpnhrZRJzlDFINKiPSHmo2jqKmIGTIaP6IsKrt+pzcwp+jWyngs1InuB8aj3krq6kIJByo12py68zkxIPM3/mRZUlV7E/ZX75gYZ1h2gwdzSvtXyB3WCUS39qlojyAjJkFWTLQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743478621; c=relaxed/simple;
	bh=EmZc9fGyZ4WOv9wWfmw+4n13U0kP5pM4qafVVV493oY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cNIU1vzayqtQG6Hr9KIrEO62wcDBCfb/Cbz0+AdyBK6PubTCVuEiRYCtdBm8vLOlkevMNsz+1/eJ6XH5iSU/ubBHfEWbWbbg1IgYpAqSUsoVsG7OepzRxSniTWtEJHRrefa/Aq8QXmqoGZrCRJpZRq8XZBSEW9wBZNMRpRpV71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NRldvwnl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5310J4a3032238;
	Tue, 1 Apr 2025 03:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZngRXbQhr0AX1t7xK7gvyM
	OGEcVTjVWIPufvcRDcJK8=; b=NRldvwnlVep1E8FJOO5Fcxndtepx83X07ReD4B
	u5wBCK2kLipplUgn5faKi8OgHiMw2gJB1wSDj14B1t9khMVY2wbV8/+wXuwYfn2F
	D2uBBhvuP1wFUEyM+39VFZzqTx2mUy4K1+59zOIo2bN2ptzeaYBkCR7GF+WWJxKL
	LELlMqB1g5S4l+lEeqh9hJh4ibiBSFwffPm+u5b0QFM4HsnMlPUkru9KYwmD3Gz8
	uCXjH5gOPNDqhHAkh+LnIkKzsikym2prNpc2sFsaB2qf8PuA7dIhLOTBvdCKwCU7
	WAYhLvO3/Lzx08m9WsGCIHJ9/dQVrzmleywHoSrL87ddr+6g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p9mjp84e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 03:36:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5313alms017867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Apr 2025 03:36:47 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 31 Mar 2025 20:36:45 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <quic_haixcui@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.oasis-open.org>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [RFC PATCH v4 0/3] Virtio SPI Linux driver
Date: Tue, 1 Apr 2025 11:36:18 +0800
Message-ID: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Mfhsu4/f c=1 sm=1 tr=0 ts=67eb5f50 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=Qpdbqe6kpIhgmtwBI9EA:9
X-Proofpoint-ORIG-GUID: iz9HYiUE3ZHw9A5pmpxZOdXSQMK1yX8x
X-Proofpoint-GUID: iz9HYiUE3ZHw9A5pmpxZOdXSQMK1yX8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010023

This is the 4th RFC version of a virtio SPI Linux driver which is
intended to be compliant with the upcoming virtio specification
version 1.4. The specification can be found in repository
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.
 
Changes between 3rd and 4th virtio SPI driver RFC:
- Remove the logic code for statically creating SPI devices through
  the spi_new_device function.
- Add ACPI support.
- According to Hillf Danton's comment, use init_completion instead of
reinit_completion in virtio_spi_transfer_one function.
 
Changes between 2nd and 3rd virtio SPI driver RFC:
- Order header inclusion alphabetically.
- Add Viresh Kumar's "signed-off" to the header files.
- Rework virtio_spi_one_transfer
  - Rework the delays according to Haixu Cui's advise. Delays are now
    handled in a new sub-function virtio_spi_set_delays.
  - Minor change: Re-formulate arguments of sg_init_one.
- Rework virtio_spi_probe
  - Replace some goto in error paths by return.
  - Add spi_unregister_controller to an error path. Abstained from
    using devm_spi_register_controller to keep order of
    de-initialization in virtio_spi_remove.
  - Add deletion of vqueue to all error paths taken after the virtqueues
    have been initialized.
 
Changes between 1st and 2nd virtio SPI driver RFC:
- Update from virtio SPI draft specification V4 to V10.
- Incorporate review comments gotten from the community.
- A proposal for a performance enhancement having more than only one SPI
message in flight had to be kept out. The more complicated code would
have caused an unacceptable project risk now.
 
The virtio SPI driver was smoke tested on qemu using Qualcomm's
target hardware providing a physical SPI backend device, based on
vhost-user protocol. Take vhost-device-spi as the vhost-user backend
and qemu integrated with vhost-user-spi implementation as the vhost-user
frontend. The Linux version used for testing is 6.12.



