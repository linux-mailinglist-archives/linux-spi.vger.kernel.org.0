Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166FE713FF4
	for <lists+linux-spi@lfdr.de>; Sun, 28 May 2023 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjE1T7B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 May 2023 15:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE1T7A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 May 2023 15:59:00 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF3A8
        for <linux-spi@vger.kernel.org>; Sun, 28 May 2023 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=+U75rpsQFDKe3AcAiSHeh2dlGhYJu9s1AK3whXkYPC8=; b=KGqT86654KJjNxKis/rbyMq5yj
        v0m99Sn9z5C7BM7fBN+Na2TUg6SsaAdy9Jm3nJ5JidHi2xNnv+n7j4GAY4tnccH+djx/lc07+tzp7
        gcPtgJwlhCFrsGrqB5iNnVAuY/GWjIVhmcBaP+fuy2NP0bZbtw65imenhuYbxFlc9OKrb8ImrlIWi
        bajtIb4AHKuiVxSnymtejGWSHN2INfmFnlnhunR9ov6onuqmsvxvMkWiv46TGUHlc+haoaX4m+X69
        n6e9RytNpffySY/Z5Uls1IJ3ey7LD8e5aPpOykZfiZpTiBrEVHF+xubch574GWXpWIbefZRWDwLHi
        IxDJX6Mg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1q3MXY-0005NO-2F; Sun, 28 May 2023 21:58:55 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1q3MXX-000DRD-9L; Sun, 28 May 2023 21:58:55 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-spi@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] spi: spi-sn-f-ospi: Use devm_clk_get_enabled()
Date:   Sun, 28 May 2023 12:58:28 -0700
Message-Id: <20230528195830.164669-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26921/Sun May 28 09:22:09 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Replace the combination of devm_clk_get_enable() plus clk_prepare_enable()
with devm_clk_get_enabled(). Slightly reduces the amount of boilerplate
code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/spi/spi-sn-f-ospi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index a2bd9dcde075..39c4df54cdb8 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -634,18 +634,12 @@ static int f_ospi_probe(struct platform_device *pdev)
 		goto err_put_ctlr;
 	}
 
-	ospi->clk = devm_clk_get(dev, NULL);
+	ospi->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(ospi->clk)) {
 		ret = PTR_ERR(ospi->clk);
 		goto err_put_ctlr;
 	}
 
-	ret = clk_prepare_enable(ospi->clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable the clock\n");
-		goto err_disable_clk;
-	}
-
 	mutex_init(&ospi->mlock);
 
 	ret = f_ospi_init(ospi);
@@ -661,9 +655,6 @@ static int f_ospi_probe(struct platform_device *pdev)
 err_destroy_mutex:
 	mutex_destroy(&ospi->mlock);
 
-err_disable_clk:
-	clk_disable_unprepare(ospi->clk);
-
 err_put_ctlr:
 	spi_controller_put(ctlr);
 
@@ -674,8 +665,6 @@ static void f_ospi_remove(struct platform_device *pdev)
 {
 	struct f_ospi *ospi = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(ospi->clk);
-
 	mutex_destroy(&ospi->mlock);
 }
 
-- 
2.30.2

