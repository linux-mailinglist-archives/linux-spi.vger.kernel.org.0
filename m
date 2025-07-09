Return-Path: <linux-spi+bounces-9081-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A25AFF14A
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 21:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E54757AC46E
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071723816A;
	Wed,  9 Jul 2025 19:02:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76551F63D9;
	Wed,  9 Jul 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087732; cv=none; b=PcDtt24DvuLlRPWPXTMat4j9XaK2QSkBc+c1Ov99QZDA2k1mf6ZCV0oYYqKVbcHU8vBE2Ds9jIXB6ljiCPAKS0bzYQ8T4rfMS2qlxDS7MS2QdvaQ6K4oiawOXfzZuxoF2qi4L66haSDHKfDZEZr31O0thiWF6iY3N5sDdmiwuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087732; c=relaxed/simple;
	bh=Ms9qIYCw7LrNFjMQYjHth8D8aXmAXOkm6K/whXwq40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WebqKZRtX4tyLEG4/3gPfzY2w0lDbvwhMi1ghIcp62Hr5VBrGFBQP9otWtEaz9+ZgPLgkH04O05sZAKVIOcguduwyNc78zE0ho4FYZ62wXlO8nxdNXlGTbyeCfScE6lu9Bkb3vfhYKckHyRXhOUtKQzyzx/nsuH3GEpmsfG4ytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E878C4CEEF;
	Wed,  9 Jul 2025 19:02:11 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed,  9 Jul 2025 21:02:09 +0200
Message-ID: <0b64c1c3803e6d3eeb3ae9cd8921d4fe67f37118.1752087701.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas RSPI/QSPI driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
check for CONFIG_PM_SLEEP without impacting code size, while increasing
build coverage.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 92faaf614f8ea1b3..8e1d911b88b51c3a 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1404,7 +1404,6 @@ static const struct platform_device_id spi_driver_ids[] = {
 
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 
-#ifdef CONFIG_PM_SLEEP
 static int rspi_suspend(struct device *dev)
 {
 	struct rspi_data *rspi = dev_get_drvdata(dev);
@@ -1419,11 +1418,7 @@ static int rspi_resume(struct device *dev)
 	return spi_controller_resume(rspi->ctlr);
 }
 
-static SIMPLE_DEV_PM_OPS(rspi_pm_ops, rspi_suspend, rspi_resume);
-#define DEV_PM_OPS	&rspi_pm_ops
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
+static DEFINE_SIMPLE_DEV_PM_OPS(rspi_pm_ops, rspi_suspend, rspi_resume);
 
 static struct platform_driver rspi_driver = {
 	.probe =	rspi_probe,
@@ -1431,7 +1426,7 @@ static struct platform_driver rspi_driver = {
 	.id_table =	spi_driver_ids,
 	.driver		= {
 		.name = "renesas_spi",
-		.pm = DEV_PM_OPS,
+		.pm = pm_sleep_ptr(&rspi_pm_ops),
 		.of_match_table = of_match_ptr(rspi_of_match),
 	},
 };
-- 
2.43.0


