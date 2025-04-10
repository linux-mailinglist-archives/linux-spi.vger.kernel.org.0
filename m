Return-Path: <linux-spi+bounces-7516-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686FEA83FFB
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6BA17AD6E
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E290E27BF8D;
	Thu, 10 Apr 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NY7HWyS4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987E26E160;
	Thu, 10 Apr 2025 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279299; cv=none; b=Kw+6cKGcwI8eIVsaXizb8U1ePwpsQNxGxLlZRCzfS1V4szYNIzZCA/PkFgwz9flNWkfuKSuksqbdKtZuQuciETjj9GwY4ssX6BOlBu5QlJ7eVxagn/JEh8NhSYZ2pMWwhJdXAM3MV6MejsO6jqUY+ARHH3/34r9tyYRwGvg06nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279299; c=relaxed/simple;
	bh=SVw2obgk2PvV/6vt3R/QmkLQld4rps2x2W6JzwW/n0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jxt9SG8ZNzCaguokeAuoYs+VlMyMXFwAr+zrRwn9tq3PboOQRE3OD5HR/cmkqwrSvSpunZoovC8rIlJyOEYgNoAdbV54eyvu7TLQT8/s+3dCpGoc7l4G65IJ+3FEWyB/17GuLnQQ+MOkDkLwqNoK8VtSrJO84NRPhRhiUDq7BGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NY7HWyS4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A75c5j013900;
	Thu, 10 Apr 2025 10:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NchtbtraFMmqPHn0SazdXU
	b816o2RpvA5zsf8ovCTcA=; b=NY7HWyS4lEdUObbDU948HWReruBDOIBqLuqvd1
	zbFdC19kZ47WDl8TRoK20w6ZeHslph1nsa2IRwnvnfcPNlawjl2ajQTVIJCcGdBr
	DqJiHDYDB0dPWwVGYhT+aVqfsE8BtkEW7MHNLWQ9ek5O+aPtsmMtWJK4ogoEijPA
	BfVc7/UJypUQuE8WWwH9GvpftYkfajrNClwX8MOT7yp6nFXNnCF+yzk7ncEGixxn
	QstbUNFbyK8XUI5fmnaGMjqZjNdv97ZJSVSfpKMXCP8x/6O+/Ni7EEtBz9rosVz/
	Oogq4JF7wtWgJnS4JT45UOQ56hSRe5aCeK0zThymhlIdObww==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbeej92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:00:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AA0e07013849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:00:40 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 03:00:35 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <broonie@kernel.org>,
        <absahu@codeaurora.org>, <bbrezillon@kernel.org>,
        <architt@codeaurora.org>, <quic_srichara@quicinc.com>,
        <quic_mdalam@quicinc.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v4 0/3] QPIC v2 fixes for SDX75
Date: Thu, 10 Apr 2025 15:30:16 +0530
Message-ID: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
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
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N2LFS1NTaM-ZbhqeYhkuswWJTBLTCTav
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f796c8 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=kYr7qnbrJmlb9xinWT0A:9
X-Proofpoint-ORIG-GUID: N2LFS1NTaM-ZbhqeYhkuswWJTBLTCTav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100075

The BAM command descriptor provides only 18 bits to specify the NAND
register offset. Additionally, in the BAM command descriptor, the NAND
register offset is supposed to be specified as "(NANDc base - BAM base)
+ reg_off". Since, the BAM controller expecting the value in the form of
"NANDc base - BAM base", so that added a new field 'bam_offset' in the
NAND properties structure and use it while preparing the command descriptor.

Previously, the driver was specifying the NANDc base address in the BAM
command descriptor.

also fixing last codeword read in qcom_param_page_type_exec() and read
len for onfi param page.

v4:
 * updated commit message
 * Renamed nand_offset to bam_offset
 * Dropped this patch "spi: spi-qpic-snand: set nand_offset for ipq9574"
   as "Gabor" suggested at [1]
   [1]:https://lore.kernel.org/lkml/a72f0db0-fd49-4cff-bffe-671fc757a219@gmail.com/
 * Removed nandc_reg_phys(chip, offset) macro and implemented this in function
   itself
 * Merged "spi: spi-qpic-snand: set bam_offset for ipq9574" in 
   "mtd: rawnand: qcom: Pass 18 bit offset from QPIC base address to BAM"

v3:
 * Updated commit message
 * updated qpic_v2 to qpic_version2
 * Removed dev_cmd_reg_start = 0 in sdx55_nandc_props {}
 * Added new patch to add nand_offset in spi_qpic_snand
   driver

v2:
 * Updated commit message
 * Added stable kernel tag
 * Added Fixes tag
 * Renamed the variable from offset_from_qpic to nandc_offset
 * Set buf_count to 512 in the parameter page read
 * Replaced the buf_count value of 512 with the len in bytes 

v1:
 * These patches will fix the following:
 * 1) onfi param page read which was broken by exec_op() patch.
 * 2) Fixed offset passed to BAM from QPIC base


Md Sadre Alam (3):
  mtd: rawnand: qcom: Pass 18 bit offset from NANDc base to BAM base
  mtd: rawnand: qcom: Fix last codeword read in
    qcom_param_page_type_exec()
  mtd: rawnand: qcom: Fix read len for onfi param page

 drivers/mtd/nand/qpic_common.c       |  8 ++++----
 drivers/mtd/nand/raw/qcom_nandc.c    | 18 +++++++++++++++---
 drivers/spi/spi-qpic-snand.c         |  1 +
 include/linux/mtd/nand-qpic-common.h |  4 +---
 4 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.34.1


