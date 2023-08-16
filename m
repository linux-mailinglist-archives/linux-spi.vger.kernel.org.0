Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603C877DD97
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbjHPJnj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243458AbjHPJna (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A711985
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:29 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQjlp47cHztS1n;
        Wed, 16 Aug 2023 17:39:50 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:27 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:26 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 16/24] spi: rzv2m-csi: switch to use modern name
Date:   Wed, 16 Aug 2023 17:40:05 +0800
Message-ID: <20230816094013.1275068-17-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816094013.1275068-1-yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-rzv2m-csi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index d098aefa370d..7326d88e6bda 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -41,7 +41,7 @@
 #define CSI_CLKSEL_CKP		BIT(17)
 #define CSI_CLKSEL_DAP		BIT(16)
 #define CSI_CLKSEL_MODE		(CSI_CLKSEL_CKP|CSI_CLKSEL_DAP)
-#define CSI_CLKSEL_SLAVE	BIT(15)
+#define CSI_CLKSEL_TARGET	BIT(15)
 #define CSI_CLKSEL_CKS		GENMASK(14, 1)
 
 /* CSI_CNT */
@@ -70,7 +70,7 @@
 #define CSI_EN_DIS_TIMEOUT_US	100
 /*
  * Clock "csiclk" gets divided by 2 * CSI_CLKSEL_CKS in order to generate the
- * serial clock (output from master), with CSI_CLKSEL_CKS ranging from 0x1 (that
+ * serial clock (output from host), with CSI_CLKSEL_CKS ranging from 0x1 (that
  * means "csiclk" is divided by 2) to 0x3FFF ("csiclk" is divided by 32766).
  */
 #define CSI_CKS_MAX		GENMASK(13, 0)
@@ -402,8 +402,8 @@ static int rzv2m_csi_setup(struct spi_device *spi)
 	rzv2m_csi_reg_write_bit(csi, CSI_MODE, CSI_MODE_DIR,
 				!!(spi->mode & SPI_LSB_FIRST));
 
-	/* Set the operation mode as master */
-	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_SLAVE, 0);
+	/* Set the operation mode as host */
+	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_TARGET, 0);
 
 	/* Give the IP a SW reset */
 	ret = rzv2m_csi_sw_reset(csi, 1);
@@ -555,7 +555,7 @@ static int rzv2m_csi_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	controller = devm_spi_alloc_master(dev, sizeof(*csi));
+	controller = devm_spi_alloc_host(dev, sizeof(*csi));
 	if (!controller)
 		return -ENOMEM;
 
-- 
2.25.1

