Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFC6596BD
	for <lists+linux-spi@lfdr.de>; Fri, 30 Dec 2022 10:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiL3JbT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Dec 2022 04:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiL3JbR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Dec 2022 04:31:17 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFC2193
        for <linux-spi@vger.kernel.org>; Fri, 30 Dec 2022 01:31:16 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nk0K425qszJpWf;
        Fri, 30 Dec 2022 17:27:20 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 30 Dec
 2022 17:31:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 3/3] spi: ar934x: switch to use modern name
Date:   Fri, 30 Dec 2022 17:28:06 +0800
Message-ID: <20221230092806.1687340-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221230092806.1687340-1-yangyingliang@huawei.com>
References: <20221230092806.1687340-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-ar934x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
index ec7250c4c810..4a6ecaa0a9c9 100644
--- a/drivers/spi/spi-ar934x.c
+++ b/drivers/spi/spi-ar934x.c
@@ -61,7 +61,7 @@ static inline int ar934x_spi_clk_div(struct ar934x_spi *sp, unsigned int freq)
 
 static int ar934x_spi_setup(struct spi_device *spi)
 {
-	struct ar934x_spi *sp = spi_controller_get_devdata(spi->master);
+	struct ar934x_spi *sp = spi_controller_get_devdata(spi->controller);
 
 	if ((spi->max_speed_hz == 0) ||
 	    (spi->max_speed_hz > (sp->clk_freq / 2))) {
@@ -74,10 +74,10 @@ static int ar934x_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int ar934x_spi_transfer_one_message(struct spi_controller *master,
+static int ar934x_spi_transfer_one_message(struct spi_controller *ctlr,
 					   struct spi_message *m)
 {
-	struct ar934x_spi *sp = spi_controller_get_devdata(master);
+	struct ar934x_spi *sp = spi_controller_get_devdata(ctlr);
 	struct spi_transfer *t = NULL;
 	struct spi_device *spi = m->spi;
 	unsigned long trx_done, trx_cur;
@@ -150,7 +150,7 @@ static int ar934x_spi_transfer_one_message(struct spi_controller *master,
 
 msg_done:
 	m->status = stat;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(ctlr);
 
 	return 0;
 }
@@ -183,7 +183,7 @@ static int ar934x_spi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*sp));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*sp));
 	if (!ctlr) {
 		dev_info(&pdev->dev, "failed to allocate spi controller\n");
 		ret = -ENOMEM;
-- 
2.25.1

