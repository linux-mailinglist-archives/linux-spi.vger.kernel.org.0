Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85254217F3
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhJDTxp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 15:53:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232319AbhJDTxo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 15:53:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194J1XLt020055;
        Mon, 4 Oct 2021 15:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=D5CBfWpPd0B7m/sKYPtJG14KPRiLWINx6lfXOqgbvnc=;
 b=hY/C9hQOGde1e3ElNxu1yGSQ2PGjIibM3KkCU6I8h76JpRlpniYznCrd0f8nm3so7MMW
 XXZhNoENjEMlzdMewiiXlqRi2qA8dUUrFAZffi2YHVeH2aAczAURXcfVleN+4Y90TgOI
 lf/JL9gAL85oXhJSEPVY6hL5raBeEgN3fgnPOQBa+Yd+LYngCArkRcjbFaB03nyRu7ul
 P4rmED0YjF+mNVvDtZHoWr89nv2wgKzfTlVsF41ncRB5gLaqkwClWORHcX3BEDtZh2JY
 p1XAjk8FGlclDcHyCJ7AZTw0P6xf4iYzDPCXDKWn6V6/QJyUt/aCzly/84AtEhP8N5ZB fA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg7dh14yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 15:51:54 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194Jm2Xc017291;
        Mon, 4 Oct 2021 19:51:53 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 3bef2axe6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 19:51:53 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194Jpq3K43909552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 19:51:52 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDF67124054;
        Mon,  4 Oct 2021 19:51:52 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50845124053;
        Mon,  4 Oct 2021 19:51:52 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.50.158])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 19:51:52 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] spi: fsi: Print status on error
Date:   Mon,  4 Oct 2021 14:51:49 -0500
Message-Id: <20211004195149.29759-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NJhM7pxiX_TK1qAivSh0bgbAAVudPKgo
X-Proofpoint-GUID: NJhM7pxiX_TK1qAivSh0bgbAAVudPKgo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1011 phishscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040132
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Print the SPI engine status register when an error is detected. This
will aid tremendously in debugging failed transactions.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/spi/spi-fsi.c | 48 ++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index 829770b8ec74..9be18db03722 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -234,6 +234,26 @@ static int fsi_spi_reset(struct fsi_spi *ctx)
 	return fsi_spi_write_reg(ctx, SPI_FSI_STATUS, 0ULL);
 }
 
+static int fsi_spi_status(struct fsi_spi *ctx, u64 *status, const char *dir)
+{
+	int rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS, status);
+
+	if (rc)
+		return rc;
+
+	if (*status & SPI_FSI_STATUS_ANY_ERROR) {
+		dev_err(ctx->dev, "%s error: %08llx\n", dir, *status);
+
+		rc = fsi_spi_reset(ctx);
+		if (rc)
+			return rc;
+
+		return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
 static void fsi_spi_sequence_add(struct fsi_spi_sequence *seq, u8 val)
 {
 	/*
@@ -273,18 +293,9 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 				return rc;
 
 			do {
-				rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS,
-						      &status);
+				rc = fsi_spi_status(ctx, &status, "TX");
 				if (rc)
 					return rc;
-
-				if (status & SPI_FSI_STATUS_ANY_ERROR) {
-					rc = fsi_spi_reset(ctx);
-					if (rc)
-						return rc;
-
-					return -EREMOTEIO;
-				}
 			} while (status & SPI_FSI_STATUS_TDR_FULL);
 
 			sent += nb;
@@ -296,18 +307,9 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 
 		while (transfer->len > recv) {
 			do {
-				rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS,
-						      &status);
+				rc = fsi_spi_status(ctx, &status, "RX");
 				if (rc)
 					return rc;
-
-				if (status & SPI_FSI_STATUS_ANY_ERROR) {
-					rc = fsi_spi_reset(ctx);
-					if (rc)
-						return rc;
-
-					return -EREMOTEIO;
-				}
 			} while (!(status & SPI_FSI_STATUS_RDR_FULL));
 
 			rc = fsi_spi_read_reg(ctx, SPI_FSI_DATA_RX, &in);
@@ -348,8 +350,12 @@ static int fsi_spi_transfer_init(struct fsi_spi *ctx)
 		if (status & (SPI_FSI_STATUS_ANY_ERROR |
 			      SPI_FSI_STATUS_TDR_FULL |
 			      SPI_FSI_STATUS_RDR_FULL)) {
-			if (reset)
+			if (reset) {
+				dev_err(ctx->dev,
+					"Initialization error: %08llx\n",
+					status);
 				return -EIO;
+			}
 
 			rc = fsi_spi_reset(ctx);
 			if (rc)
-- 
2.27.0

