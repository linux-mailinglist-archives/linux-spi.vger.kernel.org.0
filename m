Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C01263911
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 00:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgIIW3h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 18:29:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729275AbgIIW3K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 18:29:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089MEBWo074158;
        Wed, 9 Sep 2020 18:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DEmr4aJEPJnjTMZ+V7PyElhX3mO7ALiHeOirevVo29U=;
 b=bKNlzGUcKgUZUB3DFtTmJtNLQB++B1X0V4g/LQkWdRviSjuQSjCT9Uo7uE1vtofImAzS
 ypEF88hpSWRztzycthE/x7I1VsV2QvKRuchJZXo65fm+I5t9e6Y8od/rqXy/KJ6KaYmo
 vK0fTkcRfb0PbDNZ7nIlWfucxJNwrsgVTXJElZe1qLbzEHi4fbj5basNiW00n8khX98i
 p8nbzB9vyZ3rkUR3sP1HVLzj9u11tu7BIieR0Sk1HKVYUUvINrEnMXLp89bcGZihgI0S
 PXBFpVbkW4kka8ftwPwu4b9Ia0S2mvnd1zCkYiofgzNCoP1oyMHb80+iWo/Ng2sXLGt1 aA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f7nhg90s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 18:29:04 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089MQSCt010049;
        Wed, 9 Sep 2020 22:29:03 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 33c2a9bfuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 22:29:03 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089MSvjZ983680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 22:28:57 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31406136051;
        Wed,  9 Sep 2020 22:29:02 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4A8613604F;
        Wed,  9 Sep 2020 22:29:01 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.76.239])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 22:29:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        joel@jms.id.au, broonie@kernel.org, bradleyb@fuzziesquirrel.com,
        robh+dt@kernel.org, arnd@arndb.de, eajames@linux.ibm.com
Subject: [PATCH v2 6/6] spi: fsi: Check mux status before transfers
Date:   Wed,  9 Sep 2020 17:28:57 -0500
Message-Id: <20200909222857.28653-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909222857.28653-1-eajames@linux.ibm.com>
References: <20200909222857.28653-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=774 suspectscore=1 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090192
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI controllers are not accessible if the mux isn't set. Therefore,
check the mux status before starting a transfer and fail out if it isn't
set.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/spi/spi-fsi.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index a702e9d7d68c..8a440c7078ef 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -12,6 +12,7 @@
 
 #define FSI_ENGID_SPI			0x23
 #define FSI_MBOX_ROOT_CTRL_8		0x2860
+#define  FSI_MBOX_ROOT_CTRL_8_SPI_MUX	 0xf0000000
 
 #define FSI2SPI_DATA0			0x00
 #define FSI2SPI_DATA1			0x04
@@ -84,6 +85,26 @@ struct fsi_spi_sequence {
 	u64 data;
 };
 
+static int fsi_spi_check_mux(struct fsi_device *fsi, struct device *dev)
+{
+	int rc;
+	u32 root_ctrl_8;
+	__be32 root_ctrl_8_be;
+
+	rc = fsi_slave_read(fsi->slave, FSI_MBOX_ROOT_CTRL_8, &root_ctrl_8_be,
+			    sizeof(root_ctrl_8_be));
+	if (rc)
+		return rc;
+
+	root_ctrl_8 = be32_to_cpu(root_ctrl_8_be);
+	dev_dbg(dev, "Root control register 8: %08x\n", root_ctrl_8);
+	if ((root_ctrl_8 & FSI_MBOX_ROOT_CTRL_8_SPI_MUX) ==
+	     FSI_MBOX_ROOT_CTRL_8_SPI_MUX)
+		return 0;
+
+	return -ENOLINK;
+}
+
 static int fsi_spi_check_status(struct fsi_spi *ctx)
 {
 	int rc;
@@ -449,11 +470,15 @@ static int fsi_spi_transfer_init(struct fsi_spi *ctx)
 static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 					struct spi_message *mesg)
 {
-	int rc = 0;
+	int rc;
 	u8 seq_slave = SPI_FSI_SEQUENCE_SEL_SLAVE(mesg->spi->chip_select + 1);
 	struct spi_transfer *transfer;
 	struct fsi_spi *ctx = spi_controller_get_devdata(ctlr);
 
+	rc = fsi_spi_check_mux(ctx->fsi, ctx->dev);
+	if (rc)
+		return rc;
+
 	list_for_each_entry(transfer, &mesg->transfers, transfer_list) {
 		struct fsi_spi_sequence seq;
 		struct spi_transfer *next = NULL;
@@ -537,24 +562,13 @@ static size_t fsi_spi_max_transfer_size(struct spi_device *spi)
 static int fsi_spi_probe(struct device *dev)
 {
 	int rc;
-	u32 root_ctrl_8;
 	struct device_node *np;
 	int num_controllers_registered = 0;
 	struct fsi_device *fsi = to_fsi_dev(dev);
 
-	/*
-	 * Check the SPI mux before attempting to probe. If the mux isn't set
-	 * then the SPI controllers can't access their slave devices.
-	 */
-	rc = fsi_slave_read(fsi->slave, FSI_MBOX_ROOT_CTRL_8, &root_ctrl_8,
-			    sizeof(root_ctrl_8));
+	rc = fsi_spi_check_mux(fsi, dev);
 	if (rc)
-		return rc;
-
-	if (!root_ctrl_8) {
-		dev_dbg(dev, "SPI mux not set, aborting probe.\n");
 		return -ENODEV;
-	}
 
 	for_each_available_child_of_node(dev->of_node, np) {
 		u32 base;
-- 
2.26.2

