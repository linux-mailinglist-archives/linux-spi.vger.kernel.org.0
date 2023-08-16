Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EC477DDA0
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbjHPJnm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243463AbjHPJnc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89226AB
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:31 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQjpS6zWmz1GDWZ;
        Wed, 16 Aug 2023 17:42:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:29 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 21/24] spi: sh-sci: switch to use modern name
Date:   Wed, 16 Aug 2023 17:40:10 +0800
Message-ID: <20230816094013.1275068-22-yangyingliang@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-sh-sci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
index 92ca3f2d61ba..148d615d2f38 100644
--- a/drivers/spi/spi-sh-sci.c
+++ b/drivers/spi/spi-sh-sci.c
@@ -56,17 +56,17 @@ static inline void setbits(struct sh_sci_spi *sp, int bits, int on)
 
 static inline void setsck(struct spi_device *dev, int on)
 {
-	setbits(spi_master_get_devdata(dev->master), PIN_SCK, on);
+	setbits(spi_controller_get_devdata(dev->controller), PIN_SCK, on);
 }
 
 static inline void setmosi(struct spi_device *dev, int on)
 {
-	setbits(spi_master_get_devdata(dev->master), PIN_TXD, on);
+	setbits(spi_controller_get_devdata(dev->controller), PIN_TXD, on);
 }
 
 static inline u32 getmiso(struct spi_device *dev)
 {
-	struct sh_sci_spi *sp = spi_master_get_devdata(dev->master);
+	struct sh_sci_spi *sp = spi_controller_get_devdata(dev->controller);
 
 	return (ioread8(SCSPTR(sp)) & PIN_RXD) ? 1 : 0;
 }
@@ -105,7 +105,7 @@ static u32 sh_sci_spi_txrx_mode3(struct spi_device *spi,
 
 static void sh_sci_spi_chipselect(struct spi_device *dev, int value)
 {
-	struct sh_sci_spi *sp = spi_master_get_devdata(dev->master);
+	struct sh_sci_spi *sp = spi_controller_get_devdata(dev->controller);
 
 	if (sp->info->chip_select)
 		(sp->info->chip_select)(sp->info, spi_get_chipselect(dev, 0), value);
@@ -114,18 +114,18 @@ static void sh_sci_spi_chipselect(struct spi_device *dev, int value)
 static int sh_sci_spi_probe(struct platform_device *dev)
 {
 	struct resource	*r;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct sh_sci_spi *sp;
 	int ret;
 
-	master = spi_alloc_master(&dev->dev, sizeof(struct sh_sci_spi));
-	if (master == NULL) {
-		dev_err(&dev->dev, "failed to allocate spi master\n");
+	host = spi_alloc_host(&dev->dev, sizeof(struct sh_sci_spi));
+	if (host == NULL) {
+		dev_err(&dev->dev, "failed to allocate spi host\n");
 		ret = -ENOMEM;
 		goto err0;
 	}
 
-	sp = spi_master_get_devdata(master);
+	sp = spi_controller_get_devdata(host);
 
 	platform_set_drvdata(dev, sp);
 	sp->info = dev_get_platdata(&dev->dev);
@@ -136,7 +136,7 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 	}
 
 	/* setup spi bitbang adaptor */
-	sp->bitbang.master = master;
+	sp->bitbang.master = host;
 	sp->bitbang.master->bus_num = sp->info->bus_num;
 	sp->bitbang.master->num_chipselect = sp->info->num_chipselect;
 	sp->bitbang.chipselect = sh_sci_spi_chipselect;
@@ -166,7 +166,7 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 	setbits(sp, PIN_INIT, 0);
 	iounmap(sp->membase);
  err1:
-	spi_master_put(sp->bitbang.master);
+	spi_controller_put(sp->bitbang.master);
  err0:
 	return ret;
 }
@@ -178,7 +178,7 @@ static void sh_sci_spi_remove(struct platform_device *dev)
 	spi_bitbang_stop(&sp->bitbang);
 	setbits(sp, PIN_INIT, 0);
 	iounmap(sp->membase);
-	spi_master_put(sp->bitbang.master);
+	spi_controller_put(sp->bitbang.master);
 }
 
 static struct platform_driver sh_sci_spi_drv = {
-- 
2.25.1

