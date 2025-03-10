Return-Path: <linux-spi+bounces-7078-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27181A593B7
	for <lists+linux-spi@lfdr.de>; Mon, 10 Mar 2025 13:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB8C16480C
	for <lists+linux-spi@lfdr.de>; Mon, 10 Mar 2025 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06242222593;
	Mon, 10 Mar 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y96JWYN8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1322423E;
	Mon, 10 Mar 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608586; cv=none; b=B+tAeMkmMn4PtbCs0Osv1jVZ3hJXkMG4YSKRtAKl4o2IL62efXJRhUpaxl1jvPtlrNkK7EJrIxb/z7asYBlKA/AfoJF8fWBRRD7LydPZ2Ym30Kmp6KIYVgQD7tmO6BqT2phwCCWslfH59JZ5vbFAoL3j8ly2CWlXzuJXVTcahLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608586; c=relaxed/simple;
	bh=ww3Eu/NZe1gPd9/SR83ncH625Q4WvNV25ldoR32BOyA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DwUfR0Piyk7o+NdWKzBkWwnv5NsDFiU8UxkNKiMT8Qyx6ZpEyNRlkcj/hmi5xSK5299zvC2KE4S5pqWaqE63SvlVhRDLnDznWmq6Mv5tXQlr7IsdoPBaOHz9f6BBtH3y/CQnFm7WeI2U/WTxhOlKBbZRYL4EaC4/y/5RUBqu7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y96JWYN8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AA0R9D016566;
	Mon, 10 Mar 2025 12:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TKz3OR1pLumuAjoEZdvb6s
	Q1Epml2YTOuj985ElE6k0=; b=Y96JWYN8HdtZoYPpYLlLpr9n1+QUrvnSTgBbsu
	cHL6kzhxkrfwPviwx9/lRX2I2fg2g9RjHDOB3ORdG1GA+aLiaX/vr8Q5GSpjglL9
	oR9uLk7IsvhE2ybaihwVO6pztNEZssluP+pmI3mnQsHSu3QmNDaPqT1+qH6H5Zpf
	Drxo+D/VHFzBR4jyFpQv7Uq3jyWubTDVbnR+KowaRYBfXBao/W5o22oZPYhfO9js
	p0t8jX91641WYMX+62DhPi2sFSSefdrDHoZAqSmOvd7KD1nseJ9OkR5qiQmKZZIY
	Z7LWws2cy7FHO/0mzbG710yHDJk8xXDJlFEWaA/fFBqQpF4w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eypcpsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 12:09:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52AC9OBi011386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 12:09:24 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 05:09:21 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <bbrezillon@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v3 0/4] QPIC v2 fixes for SDX75
Date: Mon, 10 Mar 2025 17:39:02 +0530
Message-ID: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=A9yWP7WG c=1 sm=1 tr=0 ts=67ced674 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=xRkTYtAs_KQTFvTIrP4A:9
X-Proofpoint-ORIG-GUID: NvRxWxIVbo-vMcsUNZlAAmvxQQ26N7Qq
X-Proofpoint-GUID: NvRxWxIVbo-vMcsUNZlAAmvxQQ26N7Qq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100096

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

Md Sadre Alam (4):
  mtd: rawnand: qcom: Pass 18 bit offset from QPIC base address to BAM
  mtd: rawnand: qcom: Fix last codeword read in
    qcom_param_page_type_exec()
  mtd: rawnand: qcom: Fix read len for onfi param page
  spi: spi-qpic-snand: set nandc_offset for ipq9574

 drivers/mtd/nand/raw/qcom_nandc.c    | 18 +++++++++++++++---
 drivers/spi/spi-qpic-snand.c         |  1 +
 include/linux/mtd/nand-qpic-common.h |  3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.34.1


