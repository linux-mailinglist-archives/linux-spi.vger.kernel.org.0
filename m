Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E9B348454
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 23:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhCXWFp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 18:05:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238720AbhCXWF2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 18:05:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OM2vJq026543;
        Wed, 24 Mar 2021 18:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=l8or5TUcHsvNqpPcmEDhSobfz5xeCciUB5blaMfLtOo=;
 b=lvGVgowbFsqmRYQ8j9UBzEIFo+TVOJZPf0TS3rKdTPON5+rV3+xg0Q8KX0YuUBf/iFI6
 7Dga4Y7gJOt2rGbmFM1q31G7vbQUqC073pvKjYWwpe/VDs2HEKuc1ZE/8/a6NzlDYOJB
 4geZG+FggVkL+2Dhn1zZrMlItAvkeuWQi0q4ijbkgBrTjlX4olo9d0GfFFFMJU27UAd7
 f4BSwo1437Mh6I99BgoxqJh5m/HEm1VtW9z4E6JK33IAsRYx0B36TxqbDLS893wqLLYw
 CaPybm/XkJJ9/dhvPHppph+3CkYITAVhKOMRm8LyiSYbyqOsqEr/Itm1hfDACu0Vg+eV Cg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37gca625hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 18:05:26 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12OLlOqI010248;
        Wed, 24 Mar 2021 22:05:25 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 37equds2ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 22:05:25 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12OM5Otk22348224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 22:05:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C77B1AE076;
        Wed, 24 Mar 2021 22:05:24 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F16EAE05F;
        Wed, 24 Mar 2021 22:05:24 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.68.238])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Mar 2021 22:05:23 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org, joel@jms.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] spi: fsi: Remove multiple sequenced ops for restricted chips
Date:   Wed, 24 Mar 2021 17:05:16 -0500
Message-Id: <20210324220516.41192-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=934 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240157
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Updated restricted chips have trouble processing multiple sequenced
operations. So remove the capability to sequence multiple operations and
reduce the maximum transfer size to 8 bytes.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/spi/spi-fsi.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index 3920cd3286d8..de359718e816 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -26,7 +26,7 @@
 #define SPI_FSI_BASE			0x70000
 #define SPI_FSI_INIT_TIMEOUT_MS		1000
 #define SPI_FSI_MAX_XFR_SIZE		2048
-#define SPI_FSI_MAX_XFR_SIZE_RESTRICTED	32
+#define SPI_FSI_MAX_XFR_SIZE_RESTRICTED	8
 
 #define SPI_FSI_ERROR			0x0
 #define SPI_FSI_COUNTER_CFG		0x1
@@ -265,14 +265,12 @@ static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
 				     struct fsi_spi_sequence *seq,
 				     struct spi_transfer *transfer)
 {
-	bool docfg = false;
 	int loops;
 	int idx;
 	int rc;
 	u8 val = 0;
 	u8 len = min(transfer->len, 8U);
 	u8 rem = transfer->len % len;
-	u64 cfg = 0ULL;
 
 	loops = transfer->len / len;
 
@@ -292,28 +290,17 @@ static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
 		return -EINVAL;
 	}
 
-	if (ctx->restricted) {
-		const int eidx = rem ? 5 : 6;
-
-		while (loops > 1 && idx <= eidx) {
-			idx = fsi_spi_sequence_add(seq, val);
-			loops--;
-			docfg = true;
-		}
-
-		if (loops > 1) {
-			dev_warn(ctx->dev, "No sequencer slots; aborting.\n");
-			return -EINVAL;
-		}
+	if (ctx->restricted && loops > 1) {
+		dev_warn(ctx->dev,
+			 "Transfer too large; no branches permitted.\n");
+		return -EINVAL;
 	}
 
 	if (loops > 1) {
+		u64 cfg = SPI_FSI_COUNTER_CFG_LOOPS(loops - 1);
+
 		fsi_spi_sequence_add(seq, SPI_FSI_SEQUENCE_BRANCH(idx));
-		docfg = true;
-	}
 
-	if (docfg) {
-		cfg = SPI_FSI_COUNTER_CFG_LOOPS(loops - 1);
 		if (transfer->rx_buf)
 			cfg |= SPI_FSI_COUNTER_CFG_N2_RX |
 				SPI_FSI_COUNTER_CFG_N2_TX |
-- 
2.27.0

