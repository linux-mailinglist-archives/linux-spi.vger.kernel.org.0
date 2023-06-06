Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC5723684
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jun 2023 07:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjFFFAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Jun 2023 01:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjFFFAG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Jun 2023 01:00:06 -0400
X-Greylist: delayed 10809 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 22:00:00 PDT
Received: from 9.mo575.mail-out.ovh.net (9.mo575.mail-out.ovh.net [46.105.78.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DD119C
        for <linux-spi@vger.kernel.org>; Mon,  5 Jun 2023 22:00:00 -0700 (PDT)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.146.50])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 30332255CA
        for <linux-spi@vger.kernel.org>; Tue,  6 Jun 2023 01:21:49 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-z4jdh (unknown [10.108.4.240])
        by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 31F041FD54;
        Tue,  6 Jun 2023 01:21:48 +0000 (UTC)
Received: from etezian.org ([37.59.142.98])
        by ghost-submission-6684bf9d7b-z4jdh with ESMTPSA
        id tW7AAiyKfmS7BysAD7mFsg
        (envelope-from <andi@etezian.org>); Tue, 06 Jun 2023 01:21:48 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-98R00274518744-50b6-452d-bc83-83386cd09704,
                    89204758E3263BAD5AD9D1E9907359A1AF45ECBD) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.172.216
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 1/2] spi: s3c64xx: Use the managed spi master allocation function
Date:   Tue,  6 Jun 2023 03:20:50 +0200
Message-Id: <20230606012051.2139333-2-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606012051.2139333-1-andi.shyti@kernel.org>
References: <20230606012051.2139333-1-andi.shyti@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9956614353698359879
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepgfduveejteegteelhfetueetheegfeehhfektddvleehtefhheevkeduleeuueevnecukfhppeduvdejrddtrddtrddupddujeekrddvfeekrddujedvrddvudeipdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrnhguihesvghtvgiiihgrnhdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm_spi_alloc_master() and get rid of one goto error path

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d5ec32bda1587..787a89c046860 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1177,8 +1177,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	master = spi_alloc_master(&pdev->dev,
-				sizeof(struct s3c64xx_spi_driver_data));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*sdd));
 	if (master == NULL) {
 		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
 		return -ENOMEM;
@@ -1197,7 +1196,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
 				ret);
-			goto err_deref_master;
+			return ret;
 		}
 		sdd->port_id = ret;
 	} else {
@@ -1232,23 +1231,19 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		master->can_dma = s3c64xx_spi_can_dma;
 
 	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
-	if (IS_ERR(sdd->regs)) {
-		ret = PTR_ERR(sdd->regs);
-		goto err_deref_master;
-	}
+	if (IS_ERR(sdd->regs))
+		return PTR_ERR(sdd->regs);
 
 	if (sci->cfg_gpio && sci->cfg_gpio()) {
 		dev_err(&pdev->dev, "Unable to config gpio\n");
-		ret = -EBUSY;
-		goto err_deref_master;
+		return -EBUSY;
 	}
 
 	/* Setup clocks */
 	sdd->clk = devm_clk_get_enabled(&pdev->dev, "spi");
 	if (IS_ERR(sdd->clk)) {
 		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
-		ret = PTR_ERR(sdd->clk);
-		goto err_deref_master;
+		return PTR_ERR(sdd->clk);
 	}
 
 	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
@@ -1256,16 +1251,14 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(sdd->src_clk)) {
 		dev_err(&pdev->dev,
 			"Unable to acquire clock '%s'\n", clk_name);
-		ret = PTR_ERR(sdd->src_clk);
-		goto err_deref_master;
+		return PTR_ERR(sdd->src_clk);
 	}
 
 	if (sdd->port_conf->clk_ioclk) {
 		sdd->ioclk = devm_clk_get_enabled(&pdev->dev, "spi_ioclk");
 		if (IS_ERR(sdd->ioclk)) {
 			dev_err(&pdev->dev, "Unable to acquire 'ioclk'\n");
-			ret = PTR_ERR(sdd->ioclk);
-			goto err_deref_master;
+			return PTR_ERR(sdd->ioclk);
 		}
 	}
 
@@ -1314,9 +1307,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-err_deref_master:
-	spi_master_put(master);
-
 	return ret;
 }
 
-- 
2.40.1

