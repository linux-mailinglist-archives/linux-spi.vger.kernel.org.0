Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB09772486
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjHGMob (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjHGMoW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DC9172D
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:15 -0700 (PDT)
Received: from dggpemm100006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKGCS39czz1Z1WR;
        Mon,  7 Aug 2023 20:41:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 14/20] spi: hisi-sfc-v3xx: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:59 +0800
Message-ID: <20230807124105.3429709-15-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807124105.3429709-1-yangyingliang@huawei.com>
References: <20230807124105.3429709-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 7cbcb065bb44..9d22018f7985 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -152,7 +152,7 @@ static int hisi_sfc_v3xx_adjust_op_size(struct spi_mem *mem,
 	uintptr_t addr = (uintptr_t)op->data.buf.in;
 	int max_byte_count;
 
-	host = spi_controller_get_devdata(spi->master);
+	host = spi_controller_get_devdata(spi->controller);
 
 	max_byte_count = host->max_cmd_dword * 4;
 
@@ -174,7 +174,7 @@ static bool hisi_sfc_v3xx_supports_op(struct spi_mem *mem,
 	struct spi_device *spi = mem->spi;
 	struct hisi_sfc_v3xx_host *host;
 
-	host = spi_controller_get_devdata(spi->master);
+	host = spi_controller_get_devdata(spi->controller);
 
 	if (op->data.buswidth > 4 || op->dummy.buswidth > 4 ||
 	    op->addr.buswidth > 4 || op->cmd.buswidth > 4)
@@ -363,7 +363,7 @@ static int hisi_sfc_v3xx_exec_op(struct spi_mem *mem,
 	struct spi_device *spi = mem->spi;
 	u8 chip_select = spi_get_chipselect(spi, 0);
 
-	host = spi_controller_get_devdata(spi->master);
+	host = spi_controller_get_devdata(spi->controller);
 
 	return hisi_sfc_v3xx_generic_exec_op(host, op, chip_select);
 }
@@ -431,7 +431,7 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	u32 version, glb_config;
 	int ret;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*host));
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(*host));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -448,13 +448,13 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	host->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->regbase)) {
 		ret = PTR_ERR(host->regbase);
-		goto err_put_master;
+		goto err_put_host;
 	}
 
 	host->irq = platform_get_irq_optional(pdev, 0);
 	if (host->irq == -EPROBE_DEFER) {
 		ret = -EPROBE_DEFER;
-		goto err_put_master;
+		goto err_put_host;
 	}
 
 	hisi_sfc_v3xx_disable_int(host);
@@ -496,15 +496,15 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 
 	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
-		goto err_put_master;
+		goto err_put_host;
 
 	dev_info(&pdev->dev, "hw version 0x%x, %s mode.\n",
 		 version, host->irq ? "irq" : "polling");
 
 	return 0;
 
-err_put_master:
-	spi_master_put(ctlr);
+err_put_host:
+	spi_controller_put(ctlr);
 	return ret;
 }
 
-- 
2.25.1

