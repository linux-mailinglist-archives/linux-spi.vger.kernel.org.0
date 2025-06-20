Return-Path: <linux-spi+bounces-8681-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815FBAE124A
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 06:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8E05A5889
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 04:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951E1EB5FE;
	Fri, 20 Jun 2025 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DIFq8ThY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0C1EB5D0;
	Fri, 20 Jun 2025 04:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392796; cv=none; b=N33LHhec7stFuNZdPLeJhaVX0mPQJn5rSFKyWmymI98H9Wrmpb896SxDodHTKbqHQSA0TcENqzNxpbbWz8tRiyr5grZqp9TXCGZuYExm9EaTHPg3mKg7yCM7R1x7uLHhCU9DmLxaZAniTw9scGdpQ86jL8uwi5512ljZOdTcsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392796; c=relaxed/simple;
	bh=Qg6fg+NzuqdMyYShoYlTo9gRbCDKuVtxvxlAQWxQfUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UGem03hkJtPVi4eINvtPGbFeXn9mKmpcS47epwfi9bdL5Lx2UywF6gPeg32KJqHTSsu3aADL21HivfX9pryD6XavRltFUxzEaxPcYPkydyW/wUXg7TbO+gyoXbi0CLcIOrarOY4J6cWYXiuDQ0ZazVIKE37zLt+E4lhShsFRMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DIFq8ThY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JEAOXS015004;
	Fri, 20 Jun 2025 04:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PMtzEGhSufS4nLaMd0b5SX
	z4IBNgJ9Xh3vB/9v3FTf0=; b=DIFq8ThYW9nyFwKFlEw/LFhBq/DeNsXywNDei1
	838KjSjYkYfwFuWrw+rcdHT0edeRHZ7doD5GcdBW/v1FrklTm5LyqA7pByZ7ZxJF
	15+KSMlfs6pn4hF3Ob/28lWl6yg9zvclhPpeXG3l1mxLefCb1fYzhyPimgcZRr/4
	O5DoNvxKG4bxeIdVlyXPNjngwb93KWezz8KT/JgSfGq6tcVMV9qcR2KJmH7+OP11
	FwknHW0VFmn2jm56d2Cesr6R/LCUE62UD3Uz5sPSq/8wN2FE2t3yRfPXLNpS1v0x
	hlj4k+wjFtfyCIs6Dz2vkoifvyXg/pFOLXrTstvCQwgyWuJw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791h9hx9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 04:13:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55K4D0Zx008099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 04:13:00 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Jun 2025 21:12:57 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [RFC PATCH v5 0/3] Virtio SPI Linux driver
Date: Fri, 20 Jun 2025 12:12:27 +0800
Message-ID: <20250620041230.731504-1-quic_haixcui@quicinc.com>
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
X-Proofpoint-ORIG-GUID: X6z2IO_0_QW95-oAIbWrCq2WrozstSvS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAyOSBTYWx0ZWRfX/gfwoQmqgMNU
 uIm8McDcMPj9fq+Re6XnqevKiBzA6AmgLFLZxiAjNOXhJtDIWn+1cypNpP9rgeGe/ZhfWqdu8MP
 2nYQ+MMNYVJyoBjnsAC72UPqRS0LGftN1crsIknueMw+9JZdNOuuasLx15blvMAXy1AvBtxUG72
 4+bKtn27mxeFm7op1cL91bZYIBlFQmpTZCyWvmlSb1ZUiBi6xnnCjRBdhefyXLwY9t7adb42/Tc
 X07hhqjUc3MVLkVUDI1EecPhgy1sma6aWTDysNFZ4q0x+oYRoG4OThvmzXtVq9Lzi1/8+fPOKsz
 e2ZmNeyzMMY61xTGOgcIrE2O1dc0BkacOgLKwdrjPEISWBPn1HFDn+6Bpj7sMYvqG3vYTIU/kOL
 gLhgo8abR7WeoyxWpt9Rh89gGBaHHNp8gCT9QEsckdCfZDVc+Rst9fmLoIwY5TfmOw00VdgE
X-Authority-Analysis: v=2.4 cv=UL/dHDfy c=1 sm=1 tr=0 ts=6854dfcd cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=FS0OwZJzMusLKYCsq9IA:9
X-Proofpoint-GUID: X6z2IO_0_QW95-oAIbWrCq2WrozstSvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_01,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200029

This is the 5th RFC version of a virtio SPI Linux driver which is
intended to be compliant with the upcoming virtio specification
version 1.4. The specification can be found in repository
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

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



