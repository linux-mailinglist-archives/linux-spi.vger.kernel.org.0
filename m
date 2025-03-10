Return-Path: <linux-spi+bounces-7082-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D72A593C7
	for <lists+linux-spi@lfdr.de>; Mon, 10 Mar 2025 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB3E1648C6
	for <lists+linux-spi@lfdr.de>; Mon, 10 Mar 2025 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBFD22A1CA;
	Mon, 10 Mar 2025 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h/hvpUuu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103722288C6;
	Mon, 10 Mar 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608591; cv=none; b=IIgW36gE5NlxA3wZFSlqnZxAcsReAEBCVoILwUSfPMLCqe46KGGcfNX7s/H+b5qvHCkuniLiS5nRCGE0mSlhMG0lwNWJ3XNuWyXIdw7slXjsD5xwFAZAo2+x2sfO/gMSU8vedRRUu1UopKaVcog2P2xHRau5DJ976vz72alPi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608591; c=relaxed/simple;
	bh=DnoxLs98rYn6XS5mphroQWIxuUXuPaPIETdv9VuFOwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Px3Vfb7U0YXJnxRt0tdRg6ThK/sskI1EZfrxnHgB3wFkYgVjRdpxWN0vJCCsO9xSiMKNsk7Jvju9QFLPkZthbo7tNpkZPnoMEioDHmvfKdxB9SvpJpNDXiGRGZrIIVaqrzrszijelCqWf0c8y32vr+xNhV+GP48UguRK8IVXSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h/hvpUuu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9Sdxk026525;
	Mon, 10 Mar 2025 12:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oYAMJFCg4hwlJpbMOOHK0AoshW36RVn+FdFKzN7jQ6o=; b=h/hvpUuuPjDO+6Eh
	8r22x797Jg6r4nx5MetYHE5Di6JGb+2c1iXYGUwIi8r7+QtshYXeVdR7mBilD+da
	WW/geQcPZV3pSTJY/ijiPQTL962ssTfeep0EDc4T7sA745KCTIvKR0nAvkxUsVew
	rjCUmbT8S7EMHnUqC+cZVwt0Cb+Kq+gYBp9g2LLfozzRVVOTVcQIYAw8UJRcjUtu
	oCYJ1qQWyXCOvTxFdBCvW4XowccIKJ0ou5PV7yaVDPS5KAXyH1MezbtL1K8AlqRi
	8AwrFLPsVB+DQMKJPdCaO3yqcvCth+ZDdIxPQeMTRDh9F4Lv3UqJagcIS0UfSdh9
	/x+MZQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f2mcqx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 12:09:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52AC9UKR011513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 12:09:30 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 05:09:27 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <bbrezillon@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v3 2/4] mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()
Date: Mon, 10 Mar 2025 17:39:04 +0530
Message-ID: <20250310120906.1577292-3-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: HmnFvksTTJhI9dgh9tfCocZkKhZSh6a3
X-Proofpoint-ORIG-GUID: HmnFvksTTJhI9dgh9tfCocZkKhZSh6a3
X-Authority-Analysis: v=2.4 cv=ab+bnQot c=1 sm=1 tr=0 ts=67ced67b cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=OhSYzIeDMC8V1oLpjEAA:9
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1011 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100096

For QPIC V2 onwards there is a separate register to read
last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".

qcom_param_page_type_exec() is used to read only one code word
If it configures the number of code words to 1 in QPIC_NAND_DEV0_CFG0
register then QPIC controller thinks its reading the last code word,
since we are having separate register to read the last code word,
we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n" register
to fetch data from QPIC buffer to system memory.

Without this change page read was failing with timeout error

/ # hexdump -C /dev/mtd1
[  129.206113] qcom-nandc 1cc8000.nand-controller: failure to read page/oob
hexdump: /dev/mtd1: Connection timed out

This issue only seen on SDX targets since SDX target used QPICv2. But
same working on IPQ targets since IPQ used QPICv1.

Cc: stable@vger.kernel.org
Fixes: 89550beb098e ("mtd: rawnand: qcom: Implement exec_op()")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* Updated commit header and message

* Added condition check for location register
  and location_last register based on qpic_version2

* Added Reviewed-by tag

Change in [v2]

* Updated commit message

* Added stable kernel tag

* Replaced the buf_count value of 512 with the len in bytes.

Change in [v1]

* Resolved the issue with reading a single code word in the parameter
  page read

 drivers/mtd/nand/raw/qcom_nandc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 5443cb918e0b..d41c0e3926ed 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1863,7 +1863,12 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	const struct nand_op_instr *instr = NULL;
 	unsigned int op_id = 0;
 	unsigned int len = 0;
-	int ret;
+	int ret, reg_base;
+
+	reg_base = NAND_READ_LOCATION_0;
+
+	if (nandc->props->qpic_version2)
+		reg_base = NAND_READ_LOCATION_LAST_CW_0;
 
 	ret = qcom_parse_instructions(chip, subop, &q_op);
 	if (ret)
@@ -1915,7 +1920,10 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	op_id = q_op.data_instr_idx;
 	len = nand_subop_get_data_len(subop, op_id);
 
-	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
+	if (nandc->props->qpic_version2)
+		nandc_set_read_loc_last(chip, reg_base, 0, len, 1);
+	else
+		nandc_set_read_loc_first(chip, reg_base, 0, len, 1);
 
 	if (!nandc->props->qpic_version2) {
 		qcom_write_reg_dma(nandc, &nandc->regs->vld, NAND_DEV_CMD_VLD, 1, 0);
-- 
2.34.1


