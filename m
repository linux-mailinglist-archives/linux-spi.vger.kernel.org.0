Return-Path: <linux-spi+bounces-9082-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5891AFF151
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 21:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200105682F8
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D2723CEFF;
	Wed,  9 Jul 2025 19:02:39 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9F23C4FE;
	Wed,  9 Jul 2025 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087759; cv=none; b=jSHIHFsLV2pq0/FYiJUAJEtkolFgtNn1pbWBLSY46bAG0LTZ6usCpi751ki2rJk6mENiQn6bbZ91OhHiUIwhjhlNQgrZEfV1PwNO5iLfm1ZxYVwcLQN4zFPzSSJ1DnHrbOcLK0ltuWcQ9S+fEXO2cpPChRkAyzYaEsZZpuAE9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087759; c=relaxed/simple;
	bh=1lfuOlPRTQl53IhjDaRX/DekBP9Ray642xwwYyqcoSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwi4hw6/wXU28dzYb+4mOI5Wk5f9th5PrbIZmab1vWsOGVN/foQNBamVSgCGS7Oto2Q/OK+P2ayHmPK6hH/bSNy41J8kYZ3tEbp8SPyEJtT9SKM1k1CCzY96kfbhuUTupaT1k/L60znrZvHdgAbTCf9w3IjYi+icMzw/RARHgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD05C4CEEF;
	Wed,  9 Jul 2025 19:02:36 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: sh-msiof: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed,  9 Jul 2025 21:02:33 +0200
Message-ID: <108c136f2cab9aa8bc8ac90d14a05e66fb87deb0.1752087740.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas SuperH MSIOF driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
check for CONFIG_PM_SLEEP without impacting code size, while increasing
build coverage.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 94a867967e024446..b695870fae8c4bd6 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1320,7 +1320,6 @@ static const struct platform_device_id spi_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 
-#ifdef CONFIG_PM_SLEEP
 static int sh_msiof_spi_suspend(struct device *dev)
 {
 	struct sh_msiof_spi_priv *p = dev_get_drvdata(dev);
@@ -1335,12 +1334,8 @@ static int sh_msiof_spi_resume(struct device *dev)
 	return spi_controller_resume(p->ctlr);
 }
 
-static SIMPLE_DEV_PM_OPS(sh_msiof_spi_pm_ops, sh_msiof_spi_suspend,
-			 sh_msiof_spi_resume);
-#define DEV_PM_OPS	(&sh_msiof_spi_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
+static DEFINE_SIMPLE_DEV_PM_OPS(sh_msiof_spi_pm_ops, sh_msiof_spi_suspend,
+				sh_msiof_spi_resume);
 
 static struct platform_driver sh_msiof_spi_drv = {
 	.probe		= sh_msiof_spi_probe,
@@ -1348,7 +1343,7 @@ static struct platform_driver sh_msiof_spi_drv = {
 	.id_table	= spi_driver_ids,
 	.driver		= {
 		.name		= "spi_sh_msiof",
-		.pm		= DEV_PM_OPS,
+		.pm		= pm_sleep_ptr(&sh_msiof_spi_pm_ops),
 		.of_match_table = of_match_ptr(sh_msiof_match),
 	},
 };
-- 
2.43.0


