Return-Path: <linux-spi+bounces-4105-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2389427F2
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 09:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB0128A1D3
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 07:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CFE1A7202;
	Wed, 31 Jul 2024 07:30:10 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0D17580;
	Wed, 31 Jul 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411010; cv=none; b=MkgdkYhZO0zbEpjoK4p2N3m6Y9qD6nAoeVDnPmE8R/G2GA4x1bpyig2l5LkX1cApaxpUMIMWoDv0uW2Wm7L82uJhvSIPdcGgbJMiepiauc8yVQS9nqeFr1gWVJFmgIhGKJx7ePOi8fLUgQ6Of2Ma2Ehnyxr0tld9QCzX6+NPD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411010; c=relaxed/simple;
	bh=6vQ0Q+rkbWXa8+0E8gND9DF11LYjQT9aSnrn0uidpdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRBNB6tHpn9j5hDBMvL7twqTJa1nubcjOhsgiVdzTSGxCoQV6QTbzdaJz42nukUlWxa2wQ2VTRHIHfcNSOW3kev7lpf1+JT+TaSxS5dMKzzOozlpa9h9UpwMDqkYPsnKXtABIeiIjfTmIXX8+m/4nB96uiimD7kBlU+Y1HCa+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.09,250,1716217200"; 
   d="scan'208";a="214205733"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jul 2024 16:29:59 +0900
Received: from localhost.localdomain (unknown [10.226.93.39])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8EB964010DE4;
	Wed, 31 Jul 2024 16:29:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	linux-spi@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
Date: Wed, 31 Jul 2024 08:29:53 +0100
Message-ID: <20240731072955.224125-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing MODULE_DEVICE_TABLE definition for automatic loading of the
driver when it is built as a module.

Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
On RZ/G2L:
Before we need to manually install spi-rpc-if module for
getting partition table info

After this fix, partition table can be seen during boot
 2 fixed-partitions partitions found on MTD device spi1.0
 Creating 2 MTD partitions on "spi1.0":
 0x000000000000-0x000002000000 : "boot"
 0x000002000000-0x000004000000 : "user"
---
 drivers/spi/spi-rpc-if.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index d3f07fd719bd..b468a95972bf 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -198,9 +198,16 @@ static int __maybe_unused rpcif_spi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
 
+static const struct platform_device_id rpc_if_spi_id_table[] = {
+	{ .name = "rpc-if-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, rpc_if_spi_id_table);
+
 static struct platform_driver rpcif_spi_driver = {
 	.probe	= rpcif_spi_probe,
 	.remove_new = rpcif_spi_remove,
+	.id_table = rpc_if_spi_id_table,
 	.driver = {
 		.name	= "rpc-if-spi",
 #ifdef CONFIG_PM_SLEEP
-- 
2.43.0


