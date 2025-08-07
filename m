Return-Path: <linux-spi+bounces-9306-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6AB1D353
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476DB1AA4B58
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEACA23E324;
	Thu,  7 Aug 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XE1T8fOM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D723B609;
	Thu,  7 Aug 2025 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551820; cv=none; b=KL0X5DzWYaAI8qhz3gn2JTpT1q/kz7qQaK99xmNVUikJnufOe1F/kIlE++RAYmuxXFLxkdKcEManXczABm3+wMWozQEbGTBURL52WTC9iuZKMAGSpOIceom+TfASAN7VuSDOaX3Pd5h6bXCc0yxy088D5NLySfRfPESCnROjFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551820; c=relaxed/simple;
	bh=UbdtmRswEjFjpe1QgOBh7XPgLzj04GxOmy22LBSiK6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IL2pxQt+3XppbRIcBIkUzGeUUleaeYaOiZyX302FO6PvqJ9kGspkocN3SoHvIbCG7tw4kL7S7fzOI/eCTnT0ufM7vSRk2YjyoEgDMUqKsd3Yw2fc+JH7HLqdskRXB87ecpE8hberk0k7MrgIWvHMyJr3BU1P0kQ6r+SsW+GkVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XE1T8fOM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57724RrL029756;
	Thu, 7 Aug 2025 07:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QvnzFwIDDBUUvndzdyxNnZ
	9o5Nj/eOVPjHkY3QGW/0o=; b=XE1T8fOMOnv7sIdc4IUHC0Wnfof91i18/1VGNI
	/cI2+wsXLlYM1GbhLjlapPhX5UQRZokhrjX8I8pTdCycfr+dGXUmDaBmEpqxylp0
	Kcvb1d5QJfOmrGVfcNlXDMBxFXrwo4LLC+/irGYPicfLCKP65Q42wDFeVJBOMN+/
	vVT2ay5klMAgSAg74sEOTjjOlPz/A790BP/ljsBUe/XNl1Yv/p/EovUdUtBkRTnu
	pv4DwiLzsVPWiyjjPMS2ZPPPm432DKzaTOt5YGAeeEj4/OEXvsYdkbGbD9U/NhFu
	sAY28o5ISO0LJ9RuWMQddKiW80EF7RJBOowTZq8U72NhVEZg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8ddh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:30:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5777U5iY002660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 07:30:05 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 7 Aug 2025 00:30:02 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <harald.mommer@oss.qualcomm.com>, <quic_msavaliy@quicinc.com>,
        <quic_haixcui@quicinc.com>, <broonie@kernel.org>,
        <virtio-dev@lists.linux.dev>, <viresh.kumar@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hdanton@sina.com>, <qiang4.zhang@linux.intel.com>,
        <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [RFC PATCH v8 0/3] Virtio SPI Linux driver
Date: Thu, 7 Aug 2025 15:29:33 +0800
Message-ID: <20250807072936.4155687-1-quic_haixcui@quicinc.com>
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
X-Proofpoint-GUID: 4WQcRM7M4OZrNrghrss2VnQCORMdTLnL
X-Proofpoint-ORIG-GUID: 4WQcRM7M4OZrNrghrss2VnQCORMdTLnL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX+2UA2o0aRDrm
 2jV7PxjUdUEZSdC4DRtl9dJSvncdzwAmMBMRWaUr+pG2vcLTcnEpoy/n9vuw5XVM3ZiNa5Vu5Pl
 2YBojHcijoxTaj++1mGij1L2S0YV64OUPznHyU0+THWup/6GKCiW/3H1g/ilsG+T7B+70jTnx/C
 SWrt+2pEua9KcW8DQLzgFq2nkqPWCNimsCiJdKRJjB1QI4JicO180+Q3AOhHaw6q5mGs84AEhH+
 yNuBcrKoGaCejj9W2L2JrNdHYg0NZgxihp9sr0E4GqGypNBmKaq0zXKEZ7oDTIIljCNCjxlDNm8
 XmHv6HBRwEy+lUGnDS3B/jPUC2kWUPSTIZxpQEdw6Zk0+JJc171h51Yy5IuIXPqgKFl5csohNW/
 qbmVR1mj
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=689455fe cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=FS0OwZJzMusLKYCsq9IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

This is the 8th RFC version of a virtio SPI Linux driver which is
intended to be compliant with the upcoming virtio specification
version 1.4. The specification can be found in repository
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

Changes between 7th and 8th virtio SPI driver RFC:
- Restored original Copyright.

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



