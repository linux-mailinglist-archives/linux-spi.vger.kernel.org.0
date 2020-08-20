Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB324C3EE
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgHTRC6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 13:02:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729894AbgHTRCq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 13:02:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KH1VFe134320;
        Thu, 20 Aug 2020 13:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rT0q5paLxDTNmpB6TiOegAFsyiJLuUvb7I72smzJHh4=;
 b=XY6Z9P2ztvLlB+UEeCNojprOdrqYdpNotpNykATgavtXWRSa3jLUm8HBJf8z3+WP6AIt
 +ntqn/Ro3RYcQ7UwwrFOI5i9dUF1vWbjz/bVNSOcNJIidgDjy7o52+Nu/rIK3DTB+DN+
 GeRMrFeUfe0YNyxCjSP9fhd8ZQtHJFISd70BG1MTN+qKT7WDGwEa4QRt5IvJtd6lldle
 ZSlaS93weAr9yWj9tmbQRMtLzstSfpr2a3GulH/F4SED1nm6mA+ySHLvD5kLXLOtVo0L
 J/V6UHdCAsP1l+R7k5rkrjSQXXS0XSlaQBxahyCnzB8ekiTdS/IGvMUKhr4z/bHm0nQ9 oQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 331ugy3fcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 13:02:39 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KH0ITd001550;
        Thu, 20 Aug 2020 17:02:37 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3304cedu9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 17:02:37 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KH2bk145023498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 17:02:37 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03297AE05C;
        Thu, 20 Aug 2020 17:02:37 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1555FAE060;
        Thu, 20 Aug 2020 17:02:36 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.70.74])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 17:02:35 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, joel@jms.id.au, bradleyb@fuzziesquirrel.com,
        broonie@kernel.org, robh+dt@kernel.org, arnd@arndb.de
Subject: [PATCH 6/7] spi: fsi: Check mux status before transfers
Date:   Thu, 20 Aug 2020 12:02:27 -0500
Message-Id: <20200820170228.42053-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820170228.42053-1-eajames@linux.ibm.com>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_03:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=804 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=1 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200135
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
index 53cfa201e187..9c0a4413ec3d 100644
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

