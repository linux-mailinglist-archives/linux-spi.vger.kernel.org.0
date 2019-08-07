Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6D084831
	for <lists+linux-spi@lfdr.de>; Wed,  7 Aug 2019 10:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfHGIwQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Aug 2019 04:52:16 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:48270 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfHGIwQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Aug 2019 04:52:16 -0400
Received: from ramsan ([84.194.98.4])
        by andre.telenet-ops.be with bizsmtp
        id m8sE2000D05gfCL018sEKT; Wed, 07 Aug 2019 10:52:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hvHg6-0002fN-3n; Wed, 07 Aug 2019 10:52:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hvHg6-0006Qa-2Q; Wed, 07 Aug 2019 10:52:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: sh-msiof: Use devm_platform_ioremap_resource() helper
Date:   Wed,  7 Aug 2019 10:52:13 +0200
Message-Id: <20190807085213.24666-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of open-coding
the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index b50bdbc27e5899cc..fc1331057e7599d7 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1297,7 +1297,6 @@ static void sh_msiof_release_dma(struct sh_msiof_spi_priv *p)
 
 static int sh_msiof_spi_probe(struct platform_device *pdev)
 {
-	struct resource	*r;
 	struct spi_controller *ctlr;
 	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
@@ -1351,8 +1350,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->mapbase = devm_ioremap_resource(&pdev->dev, r);
+	p->mapbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->mapbase)) {
 		ret = PTR_ERR(p->mapbase);
 		goto err1;
-- 
2.17.1

