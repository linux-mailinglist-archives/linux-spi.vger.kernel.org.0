Return-Path: <linux-spi+bounces-9180-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF224B11B05
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 11:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180C21CC7CE9
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889A2D3741;
	Fri, 25 Jul 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P28PbgTF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D812C326A;
	Fri, 25 Jul 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436551; cv=none; b=UuMBhRgfxh0aNEq5Y4B707xAovWny0LAg5bNO8CilK5t3x3p3KAoAg+OnmSR+IPlnS2MuAy11LeKBpQIEsTJrNK3Bw5K/a/HYICIrEMHNBvJsSC4Cg8YJqWbqkDEBmFbu4NPJp7UULYu+pXu2J+rZcjbNyEYvARjVZrbj8fkMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436551; c=relaxed/simple;
	bh=Es97E0wLDPHFxpvgBWk2xgEdCNCYrf15EplrqcM3Djs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=exTqwRVOnxMjfdTd+iSSCapYHVxbMEh/Vh6VzqdzmNrtc9jCq7jliSFTKgH6j49h9fuckpWvTXEsav2ev/ZncCtSIsamM/vQ9qFNJsUsKP7H80G5ax8hkCZJe8507iPJceyioCG+CLyl1Pep7iKl/Is03zLD6a19pzeqv5pTViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P28PbgTF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P99dBa015754;
	Fri, 25 Jul 2025 09:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=D+g6NYDhk7cbGkHiZMlrAy
	eS02iNqHA8KmqTD1KFDiI=; b=P28PbgTFkLlSC8WT7Kpkzv15QybLnWPq7JIEaJ
	zYbaDbMeeYikohDfcHHbG0UBKQq7YNlRW8pPPpr7XHndc0NdSbH1Q8UWqfluDK0C
	SpXkGrHLsYzCIL75zUCOJNjDw705zvxvU56hfIJRU8g9wXLqJk2Lvom6alC6dJuT
	t95FjoAI3E8QG4efiiOx6Eda4SZs4D1ZNuuiCh0WduADOdRMExMgdrQ1a5OQej/4
	NnGQ2t4KQuulS8cIhbsFM4YKwyiNdGO/VRZQVofOA7tN7fjf/WjaGKtwcVPL+ISq
	IvXjWbYXJDdx3itkHn2M0WmjSbjmMXeQLfgt+8xMQ0jT7AMQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w501kf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:42:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56P9gBFT007570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:42:11 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 25 Jul 2025 02:42:08 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [RFC PATCH v7 0/3] Virtio SPI Linux driver
Date: Fri, 25 Jul 2025 17:41:41 +0800
Message-ID: <20250725094144.1783243-1-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q20ePh3N4biMyiP_cbHyrUQDGFluuaTB
X-Proofpoint-ORIG-GUID: q20ePh3N4biMyiP_cbHyrUQDGFluuaTB
X-Authority-Analysis: v=2.4 cv=bKAWIO+Z c=1 sm=1 tr=0 ts=68835174 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=FS0OwZJzMusLKYCsq9IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4MSBTYWx0ZWRfX2WiOwiOHHXxG
 9JQhFp9TjtL9wpO3EIx+QAX1M81zuEvJkXOm60WEq/ay7A1hDXI3zYdZSc+22du8Q6Cz0PTzPNJ
 pKxnepjsasowJEoMo/mFd9LmEKpK1AoZm62NdPQ4mIy9KyhX7ZST1E/XcsFimpIM8pqKzAbRIeK
 WM7/Eb/ggOXf0OjtBkFU3zvEje5532WigZ4LQr/3tIH7cOi2e3JsYofCPuIJ4JraCH6lu6iOOEP
 FxUvMoJRN4PXQrVPUQOz1ogyFMojYMv7xcgRf+Q18Vdbi7BmJNak0ja7D0RqjM1ArzGgnAOMsDx
 /FfCKWTjRFUFe/FtGYWV7uNmLeZ0Ric+Y8E1qZvm1/6DSNK91QBz9vHUguXQo3UMJyAmx4f4fnn
 lhvtL3KoKLCcUuGTTkxOVV5Cv+viBybzzZ9nYvRb9T5mKthZm0Xe6ysw90Tv61nYsJzh6min
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250081

This is the 7th RFC version of a virtio SPI Linux driver which is
intended to be compliant with the upcoming virtio specification
version 1.4. The specification can be found in repository
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

Changes between 6th and 7th virtio SPI driver RFC:
- Restored original MODULE_AUTHOR information in the driver source file.
- Reinstated the original Signed-off-by tags.

Changes between 5th and 6th virtio SPI driver RFC:
- Dynamically allocate the virtio_spi_req structure instead of keeping
  it as a member of virtio_spi_priv.
- Remove redundant comments.

Changes between 4th and 5th virtio SPI driver RFC:
- Use dev_err_probe instead of dev_err in virtio_spi_probe function
  to improve error handling.
- Add comments to virtio_spi_set_delays function and revise several
  field descriptions in mode_func_supported for improved clarity.
- Update bitmask definitions from (1 << n) to BIT(n) to enhance code
  readability.
 
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



