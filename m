Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DE14DD000
	for <lists+linux-spi@lfdr.de>; Thu, 17 Mar 2022 22:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiCQVP7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Mar 2022 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiCQVP7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Mar 2022 17:15:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849AB2405AF;
        Thu, 17 Mar 2022 14:14:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HJGP4M026413;
        Thu, 17 Mar 2022 21:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=apMRq4mae8+2j+tSOSavs0UnUWcHBNVoprohqfjTeuY=;
 b=BxdNT68w8iBsWbACAY3WNWPJmjtDt8uehaqG3NXXOEekqqFrkt21n8p7gGxOam4uo3+i
 SG2auXxErB4eIXj/FOv3j8ezxzeSo02kBqwKyDrcCfWj7MxdH0chII1bh+RnWqlY+SCZ
 02tlF07hX0oWQn8YGlh7EEmrhHjrknQEFFiocC2E+zDLGetChO4dGqnWT4AUHVcsBeZM
 Oc/jof0jNtS6PaZ5RBKJBPeoRGAUvgrBDs6cBEHNktJo5pcW8XHpPm7m2d0kY35T+9ev
 St9xpW5PluUzPuPQKC4gkJEsdd2tlpdtXOTjqJjm0X0TILT2uJngx9mYKRarh2qaXroU yg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev04q880w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 21:14:35 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HLDVgh018860;
        Thu, 17 Mar 2022 21:14:34 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3erk5a7f51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 21:14:34 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22HLEXse7275166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 21:14:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3AD2B205F;
        Thu, 17 Mar 2022 21:14:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD5C1B206E;
        Thu, 17 Mar 2022 21:14:31 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.82.208])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Mar 2022 21:14:31 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org, joel@jms.id.au,
        openbmc@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] spi: fsi: Implement a timeout for polling status
Date:   Thu, 17 Mar 2022 16:14:26 -0500
Message-Id: <20220317211426.38940-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rdwRJAIw1DTGQsBOuy21UnzjMXm8lzOG
X-Proofpoint-ORIG-GUID: rdwRJAIw1DTGQsBOuy21UnzjMXm8lzOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_07,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxlogscore=880
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The data transfer routines must poll the status register to
determine when more data can be shifted in or out. If the hardware
gets into a bad state, these polling loops may never exit. Prevent
this by returning an error if a timeout is exceeded.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/spi/spi-fsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index b6c7467f0b59..d403a7a3021d 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -25,6 +25,7 @@
 
 #define SPI_FSI_BASE			0x70000
 #define SPI_FSI_INIT_TIMEOUT_MS		1000
+#define SPI_FSI_STATUS_TIMEOUT_MS	100
 #define SPI_FSI_MAX_RX_SIZE		8
 #define SPI_FSI_MAX_TX_SIZE		40
 
@@ -299,6 +300,7 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 				 struct spi_transfer *transfer)
 {
 	int rc = 0;
+	unsigned long end;
 	u64 status = 0ULL;
 
 	if (transfer->tx_buf) {
@@ -315,10 +317,14 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 			if (rc)
 				return rc;
 
+			end = jiffies + msecs_to_jiffies(SPI_FSI_STATUS_TIMEOUT_MS);
 			do {
 				rc = fsi_spi_status(ctx, &status, "TX");
 				if (rc)
 					return rc;
+
+				if (time_after(jiffies, end))
+					return -ETIMEDOUT;
 			} while (status & SPI_FSI_STATUS_TDR_FULL);
 
 			sent += nb;
@@ -329,10 +335,14 @@ static int fsi_spi_transfer_data(struct fsi_spi *ctx,
 		u8 *rx = transfer->rx_buf;
 
 		while (transfer->len > recv) {
+			end = jiffies + msecs_to_jiffies(SPI_FSI_STATUS_TIMEOUT_MS);
 			do {
 				rc = fsi_spi_status(ctx, &status, "RX");
 				if (rc)
 					return rc;
+
+				if (time_after(jiffies, end))
+					return -ETIMEDOUT;
 			} while (!(status & SPI_FSI_STATUS_RDR_FULL));
 
 			rc = fsi_spi_read_reg(ctx, SPI_FSI_DATA_RX, &in);
-- 
2.27.0

