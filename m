Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD2723683
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jun 2023 06:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFFE74 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Jun 2023 00:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjFFE7u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Jun 2023 00:59:50 -0400
X-Greylist: delayed 10804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 21:59:42 PDT
Received: from 13.mo550.mail-out.ovh.net (13.mo550.mail-out.ovh.net [178.33.253.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66AB1B3
        for <linux-spi@vger.kernel.org>; Mon,  5 Jun 2023 21:59:42 -0700 (PDT)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.138.83])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id BA1C6252A2
        for <linux-spi@vger.kernel.org>; Tue,  6 Jun 2023 01:21:52 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-qpdjd (unknown [10.110.208.152])
        by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3645C1FD54;
        Tue,  6 Jun 2023 01:21:52 +0000 (UTC)
Received: from etezian.org ([37.59.142.108])
        by ghost-submission-6684bf9d7b-qpdjd with ESMTPSA
        id JrB/CjCKfmTF4QMAeP9eZw
        (envelope-from <andi@etezian.org>); Tue, 06 Jun 2023 01:21:52 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-108S002af34c2b3-ca0e-452b-ab7a-bb05fbe5ea24,
                    89204758E3263BAD5AD9D1E9907359A1AF45ECBD) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.172.216
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 2/2] spi: s3c64xx: Use dev_err_probe()
Date:   Tue,  6 Jun 2023 03:20:51 +0200
Message-Id: <20230606012051.2139333-3-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606012051.2139333-1-andi.shyti@kernel.org>
References: <20230606012051.2139333-1-andi.shyti@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9957458778236652103
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepgfduveejteegteelhfetueetheegfeehhfektddvleehtefhheevkeduleeuueevnecukfhppeduvdejrddtrddtrddupddujeekrddvfeekrddujedvrddvudeipdefjedrheelrddugedvrddutdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorghnughisegvthgviihirghnrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Simplify the code by using dev_err_probe() instead of dev_err()
and 'return'.

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 65 ++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 787a89c046860..fd55697144cc2 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1160,28 +1160,23 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 			return PTR_ERR(sci);
 	}
 
-	if (!sci) {
-		dev_err(&pdev->dev, "platform_data missing!\n");
-		return -ENODEV;
-	}
+	if (!sci)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Platform_data missing!\n");
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (mem_res == NULL) {
-		dev_err(&pdev->dev, "Unable to get SPI MEM resource\n");
-		return -ENXIO;
-	}
+	if (!mem_res)
+		return dev_err_probe(&pdev->dev, -ENXIO,
+				     "Unable to get SPI MEM resource\n");
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_warn(&pdev->dev, "Failed to get IRQ: %d\n", irq);
-		return irq;
-	}
+	if (irq < 0)
+		return dev_err_probe(&pdev->dev, irq, "Failed to get IRQ\n");
 
 	master = devm_spi_alloc_master(&pdev->dev, sizeof(*sdd));
-	if (master == NULL) {
-		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
-		return -ENOMEM;
-	}
+	if (!master)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Unable to allocate SPI Master\n");
 
 	platform_set_drvdata(pdev, master);
 
@@ -1193,11 +1188,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->sfr_start = mem_res->start;
 	if (pdev->dev.of_node) {
 		ret = of_alias_get_id(pdev->dev.of_node, "spi");
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
-				ret);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to get alias id\n");
 		sdd->port_id = ret;
 	} else {
 		sdd->port_id = pdev->id;
@@ -1234,32 +1227,28 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(sdd->regs))
 		return PTR_ERR(sdd->regs);
 
-	if (sci->cfg_gpio && sci->cfg_gpio()) {
-		dev_err(&pdev->dev, "Unable to config gpio\n");
-		return -EBUSY;
-	}
+	if (sci->cfg_gpio && sci->cfg_gpio())
+		return dev_err_probe(&pdev->dev, -EBUSY,
+				     "Unable to config gpio\n");
 
 	/* Setup clocks */
 	sdd->clk = devm_clk_get_enabled(&pdev->dev, "spi");
-	if (IS_ERR(sdd->clk)) {
-		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
-		return PTR_ERR(sdd->clk);
-	}
+	if (IS_ERR(sdd->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sdd->clk),
+				     "Unable to acquire clock 'spi'\n");
 
 	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
 	sdd->src_clk = devm_clk_get_enabled(&pdev->dev, clk_name);
-	if (IS_ERR(sdd->src_clk)) {
-		dev_err(&pdev->dev,
-			"Unable to acquire clock '%s'\n", clk_name);
-		return PTR_ERR(sdd->src_clk);
-	}
+	if (IS_ERR(sdd->src_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sdd->src_clk),
+				     "Unable to acquire clock '%s'\n",
+				     clk_name);
 
 	if (sdd->port_conf->clk_ioclk) {
 		sdd->ioclk = devm_clk_get_enabled(&pdev->dev, "spi_ioclk");
-		if (IS_ERR(sdd->ioclk)) {
-			dev_err(&pdev->dev, "Unable to acquire 'ioclk'\n");
-			return PTR_ERR(sdd->ioclk);
-		}
+		if (IS_ERR(sdd->ioclk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(sdd->ioclk),
+					     "Unable to acquire 'ioclk'\n");
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
-- 
2.40.1

