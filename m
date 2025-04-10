Return-Path: <linux-spi+bounces-7515-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8485A83FF2
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD14A5B48
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAB827934B;
	Thu, 10 Apr 2025 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C6+W8b+b"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19B26F457;
	Thu, 10 Apr 2025 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279298; cv=none; b=JeJY6q7tABqYs/Bu1iENw9YuLuZj8QnDJmWd/hmu3G0bUHngLkR0/BzKA2R2jQ85rXwsmJnFoLIH2gnYIp19eTD9GGsP3kQX1hAof41sWnlok/2ALHSsl+9zV/4NisSQcGHnUGDpU677rynKNAdFf+QNd+TixS/Xk0XlpAkoeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279298; c=relaxed/simple;
	bh=FoyK/E6QKZbKN9+2slMu8A2NwgBg1QLs03UpcQ1DPG4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ2qpPyZXYM3jz9l6+UE0XG4jo+KbU3Mr6aCNka6IWxj2eDYfIx81KuMpJPKbF3qjf4+WJJ+3nBxcpz433SHGLU4YRLstWym5QfdCRqgkT/dHJxZl/E8tqteTaSnhWC96AcwiJfwGHcwvtGAczvefeUrfTnRFpJJJzGWjjIR9tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C6+W8b+b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A75loi029741;
	Thu, 10 Apr 2025 10:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uKO+HlAXxErI7sk+sbykpCRcZS4cY7JSKuHRHinNxkk=; b=C6+W8b+bXfQ3VVWj
	yT4DknN48OtMJ2smV+nqGdNgGMzPTbmu72pCkbL8yRL86UB22XcsH5xA0Ej0u5U6
	bhU3lVrPdIslvaJay2h2zagZxx40fNa5grdt2VmoR5Kft+Lkdl5bRyYQIRVBcc5u
	TMwGe1cquMHSotYE6FlmwHAcAHdTAsqueEBuMA0JQgiksZOHsdGwXsexm4jxVBvN
	WDmfVtIrGX2qkvaNimfnOrMmcnCfdbsdgTRVZ61OeDmZbB38+keU6eTolvBhoMTc
	CXwn4D1p422GMJn/ctJw89rKQMs7v1joLkt+vd6N40HnohviOn48y54ZIxKzfEGP
	5aDEKg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbupgnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:00:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AA0rFl019944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:00:53 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 03:00:48 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <broonie@kernel.org>,
        <absahu@codeaurora.org>, <bbrezillon@kernel.org>,
        <architt@codeaurora.org>, <quic_srichara@quicinc.com>,
        <quic_mdalam@quicinc.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v4 3/3] mtd: rawnand: qcom: Fix read len for onfi param page
Date: Thu, 10 Apr 2025 15:30:19 +0530
Message-ID: <20250410100019.2872271-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
References: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: 1zclfYbNV_PQh7RVWAUQ7kr9q6MRRPCX
X-Proofpoint-ORIG-GUID: 1zclfYbNV_PQh7RVWAUQ7kr9q6MRRPCX
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f796d5 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=TL38SSn-kruOQBs3kxwA:9
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1011 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100075

The minimum size to fetch the data from device to QPIC buffer
is 512-bytes. If size is less than 512-bytes the data will not be
protected by ECC as per QPIC standard. So while reading onfi parameter
page from NAND device set nandc->buf_count = 512.

Cc: stable@vger.kernel.org
Fixes: 89550beb098e ("mtd: rawnand: qcom: Implement exec_op()")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v4]

* Added Reviewed-by tag

Change in [v3]

* No change

Change in [v2]

* Set buf_count to 512 in the parameter page read

Change in [v1]

 drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index a73bb154353f..1003cf118c01 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1930,7 +1930,7 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 		qcom_write_reg_dma(nandc, &nandc->regs->cmd1, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
 	}
 
-	nandc->buf_count = len;
+	nandc->buf_count = 512;
 	memset(nandc->data_buffer, 0xff, nandc->buf_count);
 
 	config_nand_single_cw_page_read(chip, false, 0);
-- 
2.34.1


