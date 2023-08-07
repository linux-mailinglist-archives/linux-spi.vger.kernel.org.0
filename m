Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ED977271B
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjHGOKQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjHGOKO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBE783
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:13 -0700 (PDT)
Received: from dggpemm100014.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKJ8Z42dGz1KCNN;
        Mon,  7 Aug 2023 22:09:02 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100014.china.huawei.com (7.185.36.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 02/21] spi: aspeed: switch to use modern name
Date:   Mon, 7 Aug 2023 22:06:58 +0800
Message-ID: <20230807140717.3484180-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807140717.3484180-1-yangyingliang@huawei.com>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 drivers/spi/spi-aspeed-smc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index e75b0d51f06a..21b0fa646c7d 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -295,7 +295,7 @@ static const struct aspeed_spi_data ast2400_spi_data;
 
 static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->controller);
 	struct aspeed_spi_chip *chip = &aspi->chips[spi_get_chipselect(mem->spi, 0)];
 	u32 addr_mode, addr_mode_backup;
 	u32 ctl_val;
@@ -374,7 +374,7 @@ static int aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 static const char *aspeed_spi_get_name(struct spi_mem *mem)
 {
-	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = aspi->dev;
 
 	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev),
@@ -553,7 +553,7 @@ static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip);
 
 static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
-	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->controller);
 	struct aspeed_spi_chip *chip = &aspi->chips[spi_get_chipselect(desc->mem->spi, 0)];
 	struct spi_mem_op *op = &desc->info.op_tmpl;
 	u32 ctl_val;
@@ -620,7 +620,7 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offset, size_t len, void *buf)
 {
-	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->controller);
 	struct aspeed_spi_chip *chip = &aspi->chips[spi_get_chipselect(desc->mem->spi, 0)];
 
 	/* Switch to USER command mode if mapping window is too small */
@@ -669,7 +669,7 @@ static void aspeed_spi_chip_enable(struct aspeed_spi *aspi, unsigned int cs, boo
 
 static int aspeed_spi_setup(struct spi_device *spi)
 {
-	struct aspeed_spi *aspi = spi_controller_get_devdata(spi->master);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(spi->controller);
 	const struct aspeed_spi_data *data = aspi->data;
 	unsigned int cs = spi_get_chipselect(spi, 0);
 	struct aspeed_spi_chip *chip = &aspi->chips[cs];
@@ -697,7 +697,7 @@ static int aspeed_spi_setup(struct spi_device *spi)
 
 static void aspeed_spi_cleanup(struct spi_device *spi)
 {
-	struct aspeed_spi *aspi = spi_controller_get_devdata(spi->master);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(spi->controller);
 	unsigned int cs = spi_get_chipselect(spi, 0);
 
 	aspeed_spi_chip_enable(aspi, cs, false);
@@ -726,7 +726,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENODEV;
 
-	ctlr = devm_spi_alloc_master(dev, sizeof(*aspi));
+	ctlr = devm_spi_alloc_host(dev, sizeof(*aspi));
 	if (!ctlr)
 		return -ENOMEM;
 
-- 
2.25.1

