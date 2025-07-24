Return-Path: <linux-spi+bounces-9166-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C26B1065E
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 11:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C8AAE44E7
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B4528FA83;
	Thu, 24 Jul 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oqw/IbvX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3182798E5;
	Thu, 24 Jul 2025 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349302; cv=none; b=WgA6NgnotCPqtu2Z/bPVEg5yOyyy6gGce4hkdCYYE9tewa23vD5mfCsvE4O4y18TfGVcLo4oi19XvJMu7B9JBxCZ8LQwM19ITYdSM+gFKhfj82rrrkCQ7gT+nv8vAT/ACyBoW8AD4uwLgpa3/7G7kCaR/6mEz43QTsjT///fzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349302; c=relaxed/simple;
	bh=WYMPODQhAsLzoMJrAXAiTpNrsUXzt4F13JZtJ2UOQGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CywlBJdHgrWyQmM6JOolYerceDovypB3GaUaV7ANrc1ihEZoCMFa7DBvb8pB2UfrizSWp8K09pJin6xJ8x+dor4dRf2FQ+sVBE6v/kSLXJdRTH+CxR7Qr/h1ZlNPj1oBdtKGm5TDrbgBY0qoXIGDPynBvVvOZ869Pw0jB7wo0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oqw/IbvX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXefN029504;
	Thu, 24 Jul 2025 09:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Y2nexYQi+Ay0oUaHgnpoFh
	CVS9sFIuAbIuDC0AFfVII=; b=Oqw/IbvXo9xXTVWORtY6qcOvnpM04ldQXfTDML
	ZXlD6S3WKaU+kDE2MB1JPRaF6g3b9gIVnl0PHkjVq80pZEG7YjCxYHuw91x8gDmv
	ZfwR8+rrfJFN1pJ4tpg7Pn9n8K0TfsVjZuD96i7Dj3IXSS9D5bARoc3O9xyetQRW
	kmtNtI5VEBKnB9ooDh5mTmXoFDNTFPtp6dEAny2dXQ9itGs04FTwWx/4hIK3KecY
	G5qWM8XzwTMI2zRlwutwWFS6cMrHtXlBLEuhY3lGQwfAXmWvQx24745SAPf6Qqhq
	zadlU8jM7Sh+BxRDXIjc9TqmwEW7BBqzmCKwP8src0ijMCxg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1fh1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 09:28:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56O9S3HM024348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 09:28:03 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Jul 2025 02:28:00 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [RFC PATCH v6 0/3] Virtio SPI Linux driver
Date: Thu, 24 Jul 2025 17:27:43 +0800
Message-ID: <20250724092746.1297608-1-quic_haixcui@quicinc.com>
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
X-Proofpoint-GUID: HoIB_kSiNUcOs8HNI6tieD_P8zuKdshj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA2OCBTYWx0ZWRfX//hJBjmU6fC0
 oXHNwR4vA2gU3HgugVXM6tK+HLWBYNYeixZ0YiR6sTSoohg/rvlwKfG4C1G6TeRxjqRi2h3faOE
 X0dH7aEhYBOkOG0vEqliyen/Qc2mhbPeufk6/w1uzL3TTW+/B3zhz85/0lscEPMeqdtZ+hL1iuW
 6PjoHgqbIpHXbQ6o3qWC+sdHvO1tXk+6UykGJ4hUkKjk50SHFCDepfwiOhdN72lVkOi5ySJKmT9
 VCYryWqnBYC44flxFHzsYu9rmOUxuMq0qe9zQrsmVl3EYDaPKvmc+/lya7WG3X8O6BDbHcLVz/T
 /T7LEuKcI4OcjyEvlOs3JoPyVDKeENfCBBY6eRETQe44UHHQHv27X8GJAgKYi5jwYYlApkEcRTN
 LcPUUQ46IpX/DQ+n8L7JHvOSruFV/ZC9x8qTmebUU8Sqlzieg1byrHNiGDuZcm8bFXE/BlDw
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=6881fca4 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=FS0OwZJzMusLKYCsq9IA:9
X-Proofpoint-ORIG-GUID: HoIB_kSiNUcOs8HNI6tieD_P8zuKdshj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240068

This is the 6th RFC version of a virtio SPI Linux driver which is
intended to be compliant with the upcoming virtio specification
version 1.4. The specification can be found in repository
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

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


