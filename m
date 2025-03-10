Return-Path: <linux-spi+bounces-7081-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7284A593D9
	for <lists+linux-spi@lfdr.de>; Mon, 10 Mar 2025 13:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0FB18831CD
	for <lists+linux-spi@lfdr.de>; Mon, 10 Mar 2025 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8EB229B13;
	Mon, 10 Mar 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qi0f11ia"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A04F2288C3;
	Mon, 10 Mar 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608590; cv=none; b=DX/lRC3zPXWftuLKThOIkymWfniyv6EKSY81DVILM7nyj5vGmPcKUyT1YyTN3tRLjXdN25wTcpPo/IFGQHjwvRrpGrEVQwMTT0WRBDHcMLz8nHqjnASuyBIp+bB72TpRxtZcL4Av5h5Ek7Ppbvtbh2pXKTPMfoZjhYTzX5L8SYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608590; c=relaxed/simple;
	bh=t8D1h9fbsRnyGfaal8jkAqYXA1Fl7fy7WW3NrrAgy5c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRRk2gu9Cnazi5N4ExoglinDpLX12S+Kc5AdwEYaR8wZsKl1+z308xNfRS5UX6Rixa6+xEDnIoTwpiPZUK8+5PAyrd0RpdBQmoMDrAfZYm3j0dJVAj+CeU+x8QE39Kf1zxGYIa4E29gjEQCj+HFWfoqEuzH9zd+/V+MwAMyx5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qi0f11ia; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9ujwq024744;
	Mon, 10 Mar 2025 12:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zrTnM0Fve5fUTlJHvpQwbTFY+eg/oU2A5W1AzhdIjpw=; b=Qi0f11iaA0UGtZkN
	6N/bz2oZGnbvjvIYEm670iXYSM22zjRNUT6EcdY7xBaVVM9/8f6yIpUNcE3zR3sL
	jULrzsPeN51ELMrCrK4sMb6t2jNQ8+q3BV9wor7YYz/DhaFx50jkUiPcWx9A8y8F
	qPKwtFdS21s+jcElByTVmIlcxkd3bq/BED1W2gqsFn2UEi+TYGhuJ0+8zLS34CtT
	tyBRnLQFgDVYX+NyKRykSDHe3NjpHjrXQIftEOXZVu0U0XwQ8zAciy47XrdQcY7I
	iybkv5L5QZlKBfEgMOI+464TpZJu8sdbp5Gsw/fb9Wj1IgtT9yVrozQHwRuYcd4u
	Ie88Tg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f2mcqxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 12:09:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52AC9b0B024931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 12:09:37 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 05:09:34 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <bbrezillon@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v3 4/4] spi: spi-qpic-snand: set nandc_offset for ipq9574
Date: Mon, 10 Mar 2025 17:39:06 +0530
Message-ID: <20250310120906.1577292-5-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: gLsQJTIzA5iegtj2Gj6I81OeBN4tKBcR
X-Proofpoint-ORIG-GUID: gLsQJTIzA5iegtj2Gj6I81OeBN4tKBcR
X-Authority-Analysis: v=2.4 cv=ab+bnQot c=1 sm=1 tr=0 ts=67ced681 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=PIZUERMwkWLMlXSLb_cA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100096

The BAM block expects NAND register addresses to be computed based on
the NAND register offset from QPIC base. This value is 0x30000 for
ipq9574. Update the 'nandc_offset' value in the qcom_nandc_props
appropriately.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* Added nand_offset for proper address calculation
  for newer Socs

Change in [v2]

* This patch was not part of v2

Change in [v1]

* This patch was not part of v1

 drivers/spi/spi-qpic-snand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 8c413a6a5152..85a742e21cf9 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1604,6 +1604,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
 static const struct qcom_nandc_props ipq9574_snandc_props = {
 	.dev_cmd_reg_start = 0x7000,
 	.supports_bam = true,
+	.nandc_offset = 0x30000,
 };
 
 static const struct of_device_id qcom_snandc_of_match[] = {
-- 
2.34.1


