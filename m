Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7E71931B
	for <lists+linux-spi@lfdr.de>; Thu,  1 Jun 2023 08:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFAGWT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Jun 2023 02:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFAGWT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Jun 2023 02:22:19 -0400
X-Greylist: delayed 16797 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 23:22:16 PDT
Received: from 19.mo583.mail-out.ovh.net (19.mo583.mail-out.ovh.net [46.105.35.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2799
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 23:22:16 -0700 (PDT)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.1.191])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id CD84A245B3
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 20:55:58 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-lxwgq (unknown [10.111.208.70])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E6AB11FD34;
        Wed, 31 May 2023 20:55:57 +0000 (UTC)
Received: from etezian.org ([37.59.142.107])
        by ghost-submission-6684bf9d7b-lxwgq with ESMTPSA
        id p+pxMF20d2QlDwAA4fq3wQ
        (envelope-from <andi@etezian.org>); Wed, 31 May 2023 20:55:57 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-107S001522e08c7-87a2-407b-853c-156994c55239,
                    CE32843581E8B828DAC27BD526439CBEDE034C14) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.172.216
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] spi: s3c64xx: Use devm_clk_get_enabled()
Date:   Wed, 31 May 2023 22:55:50 +0200
Message-Id: <20230531205550.568340-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12996825577183513159
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpedtveeuieehfeetudejhfehleeijedvveetleefhfehuedtleektdevjedujefgvdenucfkphepuddvjedrtddrtddruddpudejkedrvdefkedrudejvddrvdduiedpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrnhguihesvghtvgiiihgrnhdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Replace the tuple devm_clk_get()/clk_prepare_enable() with the
single function devm_clk_get_enabled().

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e30562f96a4c8..d5ec32bda1587 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1244,46 +1244,28 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Setup clocks */
-	sdd->clk = devm_clk_get(&pdev->dev, "spi");
+	sdd->clk = devm_clk_get_enabled(&pdev->dev, "spi");
 	if (IS_ERR(sdd->clk)) {
 		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
 		ret = PTR_ERR(sdd->clk);
 		goto err_deref_master;
 	}
 
-	ret = clk_prepare_enable(sdd->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
-		goto err_deref_master;
-	}
-
 	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
-	sdd->src_clk = devm_clk_get(&pdev->dev, clk_name);
+	sdd->src_clk = devm_clk_get_enabled(&pdev->dev, clk_name);
 	if (IS_ERR(sdd->src_clk)) {
 		dev_err(&pdev->dev,
 			"Unable to acquire clock '%s'\n", clk_name);
 		ret = PTR_ERR(sdd->src_clk);
-		goto err_disable_clk;
-	}
-
-	ret = clk_prepare_enable(sdd->src_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
-		goto err_disable_clk;
+		goto err_deref_master;
 	}
 
 	if (sdd->port_conf->clk_ioclk) {
-		sdd->ioclk = devm_clk_get(&pdev->dev, "spi_ioclk");
+		sdd->ioclk = devm_clk_get_enabled(&pdev->dev, "spi_ioclk");
 		if (IS_ERR(sdd->ioclk)) {
 			dev_err(&pdev->dev, "Unable to acquire 'ioclk'\n");
 			ret = PTR_ERR(sdd->ioclk);
-			goto err_disable_src_clk;
-		}
-
-		ret = clk_prepare_enable(sdd->ioclk);
-		if (ret) {
-			dev_err(&pdev->dev, "Couldn't enable clock 'ioclk'\n");
-			goto err_disable_src_clk;
+			goto err_deref_master;
 		}
 	}
 
@@ -1332,11 +1314,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-	clk_disable_unprepare(sdd->ioclk);
-err_disable_src_clk:
-	clk_disable_unprepare(sdd->src_clk);
-err_disable_clk:
-	clk_disable_unprepare(sdd->clk);
 err_deref_master:
 	spi_master_put(master);
 
@@ -1357,12 +1334,6 @@ static void s3c64xx_spi_remove(struct platform_device *pdev)
 		dma_release_channel(sdd->tx_dma.ch);
 	}
 
-	clk_disable_unprepare(sdd->ioclk);
-
-	clk_disable_unprepare(sdd->src_clk);
-
-	clk_disable_unprepare(sdd->clk);
-
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.40.1

