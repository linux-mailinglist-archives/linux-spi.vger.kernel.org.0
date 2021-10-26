Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DF543BAE2
	for <lists+linux-spi@lfdr.de>; Tue, 26 Oct 2021 21:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbhJZTgJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Oct 2021 15:36:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27880 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238774AbhJZTgH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Oct 2021 15:36:07 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QJXdAx012841;
        Tue, 26 Oct 2021 19:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UZrwX8kexi2H5wyp2LrSeev585HIUj9tPKNmQ+WU3TU=;
 b=HaCxsMKGCCLEVeKqrIrsSskcZnvt+QKXMBk+EvAzwoav++E3JifvdUCsMY+svEnGGHVN
 Ohr3kPdffBTqFmS2qHVwFDBemrP2sE1axs0+aJc98b8ZCX3Sz47hkQKB8BbDK65NCYHq
 Tr6ILUTYbRGw5ygIr4CvRT3A1zX9TEmOFC0WAn4pPaweR5SX/8bdmDtkCLHOvY02mMEd
 AITIThVfm4ZuoZumMkkbslNRv5pq4sdb/CcLWH03QPMqlxWUzA5gGXZxBdT0YqUNUy+S
 WQWh4sZZKEF1DSE4TH1Ztu4b99tWhpQtjNbNYiNjB0Itr+eAzBRh+sZ7q0Mz2E4RSLvy Bw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4kbkqss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 19:33:40 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19QJSsMf012183;
        Tue, 26 Oct 2021 19:33:33 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3bx4f03a3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 19:33:33 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19QJXWjL12714936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 19:33:32 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A27B5AE05C;
        Tue, 26 Oct 2021 19:33:32 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B43DFAE060;
        Tue, 26 Oct 2021 19:33:31 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.133.45])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 19:33:31 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] spi: fsi: Fix contention in the FSI2SPI engine
Date:   Tue, 26 Oct 2021 14:33:27 -0500
Message-Id: <20211026193327.52420-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H5-c5Q_096OgHl5okIq3D9VH1f0XmrwB
X-Proofpoint-GUID: H5-c5Q_096OgHl5okIq3D9VH1f0XmrwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_05,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=951 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260108
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There was nothing to protect multiple SPI controllers on the same FSI2SPI
device from being accessed through the FSI2SPI device at the same time.
For example, multiple writes to the command and data registers might occur
for different SPI controllers, resulting in complete chaos in the SPI
engine. To prevent this, add a FSI2SPI device level mutex and lock it in
the SPI register read and write functions.

Fixes: bbb6b2f9865b ("spi: Add FSI-attached SPI controller driver")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/spi/spi-fsi.c | 75 ++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index 9be18db03722..b6c7467f0b59 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -67,9 +67,14 @@
 	 SPI_FSI_STATUS_RDR_OVERRUN)
 #define SPI_FSI_PORT_CTRL		0x9
 
+struct fsi2spi {
+	struct fsi_device *fsi; /* FSI2SPI CFAM engine device */
+	struct mutex lock; /* lock access to the device */
+};
+
 struct fsi_spi {
 	struct device *dev;	/* SPI controller device */
-	struct fsi_device *fsi;	/* FSI2SPI CFAM engine device */
+	struct fsi2spi *bridge; /* FSI2SPI device */
 	u32 base;
 };
 
@@ -104,7 +109,7 @@ static int fsi_spi_check_status(struct fsi_spi *ctx)
 	u32 sts;
 	__be32 sts_be;
 
-	rc = fsi_device_read(ctx->fsi, FSI2SPI_STATUS, &sts_be,
+	rc = fsi_device_read(ctx->bridge->fsi, FSI2SPI_STATUS, &sts_be,
 			     sizeof(sts_be));
 	if (rc)
 		return rc;
@@ -120,73 +125,91 @@ static int fsi_spi_check_status(struct fsi_spi *ctx)
 
 static int fsi_spi_read_reg(struct fsi_spi *ctx, u32 offset, u64 *value)
 {
-	int rc;
+	int rc = 0;
 	__be32 cmd_be;
 	__be32 data_be;
 	u32 cmd = offset + ctx->base;
+	struct fsi2spi *bridge = ctx->bridge;
 
 	*value = 0ULL;
 
 	if (cmd & FSI2SPI_CMD_WRITE)
 		return -EINVAL;
 
-	cmd_be = cpu_to_be32(cmd);
-	rc = fsi_device_write(ctx->fsi, FSI2SPI_CMD, &cmd_be, sizeof(cmd_be));
+	rc = mutex_lock_interruptible(&bridge->lock);
 	if (rc)
 		return rc;
 
+	cmd_be = cpu_to_be32(cmd);
+	rc = fsi_device_write(bridge->fsi, FSI2SPI_CMD, &cmd_be,
+			      sizeof(cmd_be));
+	if (rc)
+		goto unlock;
+
 	rc = fsi_spi_check_status(ctx);
 	if (rc)
-		return rc;
+		goto unlock;
 
-	rc = fsi_device_read(ctx->fsi, FSI2SPI_DATA0, &data_be,
+	rc = fsi_device_read(bridge->fsi, FSI2SPI_DATA0, &data_be,
 			     sizeof(data_be));
 	if (rc)
-		return rc;
+		goto unlock;
 
 	*value |= (u64)be32_to_cpu(data_be) << 32;
 
-	rc = fsi_device_read(ctx->fsi, FSI2SPI_DATA1, &data_be,
+	rc = fsi_device_read(bridge->fsi, FSI2SPI_DATA1, &data_be,
 			     sizeof(data_be));
 	if (rc)
-		return rc;
+		goto unlock;
 
 	*value |= (u64)be32_to_cpu(data_be);
 	dev_dbg(ctx->dev, "Read %02x[%016llx].\n", offset, *value);
 
-	return 0;
+unlock:
+	mutex_unlock(&bridge->lock);
+	return rc;
 }
 
 static int fsi_spi_write_reg(struct fsi_spi *ctx, u32 offset, u64 value)
 {
-	int rc;
+	int rc = 0;
 	__be32 cmd_be;
 	__be32 data_be;
 	u32 cmd = offset + ctx->base;
+	struct fsi2spi *bridge = ctx->bridge;
 
 	if (cmd & FSI2SPI_CMD_WRITE)
 		return -EINVAL;
 
+	rc = mutex_lock_interruptible(&bridge->lock);
+	if (rc)
+		return rc;
+
 	dev_dbg(ctx->dev, "Write %02x[%016llx].\n", offset, value);
 
 	data_be = cpu_to_be32(upper_32_bits(value));
-	rc = fsi_device_write(ctx->fsi, FSI2SPI_DATA0, &data_be,
+	rc = fsi_device_write(bridge->fsi, FSI2SPI_DATA0, &data_be,
 			      sizeof(data_be));
 	if (rc)
-		return rc;
+		goto unlock;
 
 	data_be = cpu_to_be32(lower_32_bits(value));
-	rc = fsi_device_write(ctx->fsi, FSI2SPI_DATA1, &data_be,
+	rc = fsi_device_write(bridge->fsi, FSI2SPI_DATA1, &data_be,
 			      sizeof(data_be));
 	if (rc)
-		return rc;
+		goto unlock;
 
 	cmd_be = cpu_to_be32(cmd | FSI2SPI_CMD_WRITE);
-	rc = fsi_device_write(ctx->fsi, FSI2SPI_CMD, &cmd_be, sizeof(cmd_be));
+	rc = fsi_device_write(bridge->fsi, FSI2SPI_CMD, &cmd_be,
+			      sizeof(cmd_be));
 	if (rc)
-		return rc;
+		goto unlock;
+
+	rc = fsi_spi_check_status(ctx);
 
-	return fsi_spi_check_status(ctx);
+unlock:
+	mutex_unlock(&bridge->lock);
+	return rc;
 }
 
 static int fsi_spi_data_in(u64 in, u8 *rx, int len)
@@ -242,7 +265,7 @@ static int fsi_spi_status(struct fsi_spi *ctx, u64 *status, const char *dir)
 		return rc;
 
 	if (*status & SPI_FSI_STATUS_ANY_ERROR) {
-		dev_err(ctx->dev, "%s error: %08llx\n", dir, *status);
+		dev_err(ctx->dev, "%s error: %016llx\n", dir, *status);
 
 		rc = fsi_spi_reset(ctx);
 		if (rc)
@@ -394,7 +417,7 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_transfer *transfer;
 	struct fsi_spi *ctx = spi_controller_get_devdata(ctlr);
 
-	rc = fsi_spi_check_mux(ctx->fsi, ctx->dev);
+	rc = fsi_spi_check_mux(ctx->bridge->fsi, ctx->dev);
 	if (rc)
 		goto error;
 
@@ -484,12 +507,20 @@ static int fsi_spi_probe(struct device *dev)
 	int rc;
 	struct device_node *np;
 	int num_controllers_registered = 0;
+	struct fsi2spi *bridge;
 	struct fsi_device *fsi = to_fsi_dev(dev);
 
 	rc = fsi_spi_check_mux(fsi, dev);
 	if (rc)
 		return -ENODEV;
 
+	bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return -ENOMEM;
+
+	bridge->fsi = fsi;
+	mutex_init(&bridge->lock);
+
 	for_each_available_child_of_node(dev->of_node, np) {
 		u32 base;
 		struct fsi_spi *ctx;
@@ -512,7 +543,7 @@ static int fsi_spi_probe(struct device *dev)
 
 		ctx = spi_controller_get_devdata(ctlr);
 		ctx->dev = &ctlr->dev;
-		ctx->fsi = fsi;
+		ctx->bridge = bridge;
 		ctx->base = base + SPI_FSI_BASE;
 
 		rc = devm_spi_register_controller(dev, ctlr);
-- 
2.27.0

