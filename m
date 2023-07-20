Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5895B75B0DE
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jul 2023 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGTOJe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jul 2023 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGTOJe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jul 2023 10:09:34 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F27032122
        for <linux-spi@vger.kernel.org>; Thu, 20 Jul 2023 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4OeBOggC6oGY1m2lJZ
        R2ePcZeVUNHpNmPVGHoYQW3Qo=; b=hpKI/1g+jNStAbXhRjI8ALHk/Mh5F/WQVD
        gJPS8/fXMp7rLdXYrdH8BGDebpQza+cmD7cviVjAyPcKy8fB72W87RdcWVlgY/l3
        GJSN7XhUP+p64Y+YBhVa5c3lLAkRVVPwqxnpIkdFOIFyfQeQ6Lv8lAnvIDd3hNO8
        sBTj25m+I=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wAHHy8HQLlkAkI1Aw--.1215S4;
        Thu, 20 Jul 2023 22:09:16 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] spi: use devm_clk_get_enabled() in mcfqspi_probe()
Date:   Thu, 20 Jul 2023 22:09:09 +0800
Message-Id: <20230720140909.34084-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAHHy8HQLlkAkI1Aw--.1215S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4UXFy5Zw4Dury7JrykAFb_yoW8CF17pa
        97XFWagrWxAFWYkr1UKw1q9r15Xr1fK3yjk3yxKa40q3s8trWktr4rJryxXFWxuaykAa18
        G3W8ta1FyF4UurUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU9mi_UUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiUQ2y5WDESWmqkAAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

in mcfqspi_probe(), the return value of function
clk_prepare_enable() should be checked, since it may fail.
using devm_clk_get_enabled() instead of devm_clk_get() and
clk_prepare_enable() can avoid this problem.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/spi/spi-coldfire-qspi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index b1bd8a6b5bf9..31174e7ca7a6 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -381,13 +381,12 @@ static int mcfqspi_probe(struct platform_device *pdev)
 		goto fail0;
 	}
 
-	mcfqspi->clk = devm_clk_get(&pdev->dev, "qspi_clk");
+	mcfqspi->clk = devm_clk_get_enabled(&pdev->dev, "qspi_clk");
 	if (IS_ERR(mcfqspi->clk)) {
 		dev_dbg(&pdev->dev, "clk_get failed\n");
 		status = PTR_ERR(mcfqspi->clk);
 		goto fail0;
 	}
-	clk_prepare_enable(mcfqspi->clk);
 
 	master->bus_num = pdata->bus_num;
 	master->num_chipselect = pdata->num_chipselect;
@@ -396,7 +395,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	status = mcfqspi_cs_setup(mcfqspi);
 	if (status) {
 		dev_dbg(&pdev->dev, "error initializing cs_control\n");
-		goto fail1;
+		goto fail0;
 	}
 
 	init_waitqueue_head(&mcfqspi->waitq);
@@ -414,18 +413,16 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	status = devm_spi_register_master(&pdev->dev, master);
 	if (status) {
 		dev_dbg(&pdev->dev, "spi_register_master failed\n");
-		goto fail2;
+		goto fail1;
 	}
 
 	dev_info(&pdev->dev, "Coldfire QSPI bus driver\n");
 
 	return 0;
 
-fail2:
+fail1:
 	pm_runtime_disable(&pdev->dev);
 	mcfqspi_cs_teardown(mcfqspi);
-fail1:
-	clk_disable_unprepare(mcfqspi->clk);
 fail0:
 	spi_master_put(master);
 
-- 
2.17.1

