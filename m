Return-Path: <linux-spi+bounces-10191-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2905B8DA17
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BF617B5B9
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F8925DB06;
	Sun, 21 Sep 2025 11:27:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03838191493;
	Sun, 21 Sep 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454020; cv=none; b=V9xXA8yoahj8jY+COYeMoTug7SqzTifcunhw+hp6bk37HLzdxsMCujHktDeCvyTzmGqAnrt0s72URuHDeKEFCB2RXBpyB4eJhh1EV4xbN97j2zAjQ0+5GXjcQEfCPxj/j+pRwYl1OD0douetoFvPcE8V9tonNQ4YVWd0r4pZFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454020; c=relaxed/simple;
	bh=rJFpPeKJi49kRNT/K1rnzIZXHVymKtp89xTVUq3ZjHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byWb3lWsuk5NUDl0boqTtcDbAj/xY2BfDhdt3tpYMCjA57jY4PIT+PqqPPfUj8myszszZs+dLt0v0Sh7rUTbVGCqCz7sG+gyjZJ+rsdeQ02Mc/+/xdzY0DFzm1GCF5mwcNlLnVYnEuORbLbNer0hYBshBENwRCEUxLj6HCk0zOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: r/YoLOkhRvi7i1xzU+6kCA==
X-CSE-MsgGUID: GQqAp/efQTez4fuiwmGVRw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Sep 2025 20:26:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 654D1400E4E4;
	Sun, 21 Sep 2025 20:26:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] spi: rpc-if: Drop deprecated SIMPLE_DEV_PM_OPS
Date: Sun, 21 Sep 2025 12:26:45 +0100
Message-ID: <20250921112649.104516-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921112649.104516-1-biju.das.jz@bp.renesas.com>
References: <20250921112649.104516-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace SIMPLE_DEV_PM_OPS->DEFINE_SIMPLE_DEV_PM_OPS macro and use
pm_sleep_ptr(). This lets us drop the check for CONFIG_PM_SLEEP, and
reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled,
while increasing build coverage.

Also drop the __maybe_unused attribute from PM functions.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 627cffea5d5c..a8e783cc66e7 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -196,21 +196,21 @@ static void rpcif_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(rpc->dev);
 }
 
-static int __maybe_unused rpcif_spi_suspend(struct device *dev)
+static int rpcif_spi_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
 	return spi_controller_suspend(ctlr);
 }
 
-static int __maybe_unused rpcif_spi_resume(struct device *dev)
+static int rpcif_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
 	return spi_controller_resume(ctlr);
 }
 
-static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
 
 static const struct platform_device_id rpc_if_spi_id_table[] = {
 	{ .name = "rpc-if-spi" },
@@ -224,9 +224,7 @@ static struct platform_driver rpcif_spi_driver = {
 	.id_table = rpc_if_spi_id_table,
 	.driver = {
 		.name	= "rpc-if-spi",
-#ifdef CONFIG_PM_SLEEP
-		.pm	= &rpcif_spi_pm_ops,
-#endif
+		.pm	= pm_sleep_ptr(&rpcif_spi_pm_ops),
 	},
 };
 module_platform_driver(rpcif_spi_driver);
-- 
2.43.0


