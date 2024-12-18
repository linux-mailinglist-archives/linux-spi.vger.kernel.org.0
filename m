Return-Path: <linux-spi+bounces-6116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AB9F6EDB
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 21:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6572618896D6
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09161FC0EB;
	Wed, 18 Dec 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XKpvBvIh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m12817.netease.com (mail-m12817.netease.com [103.209.128.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F01448F2;
	Wed, 18 Dec 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734553433; cv=none; b=hASTvaTJBKXg2Tvs1MkdoDgKxkxP0BSZ4zp24nEpCT6DgXxO6hGJis+51OgYVRdmh29f+9GuHzzzPKzJghFSPR44QG3vSrycNjyJ4mKqO8ewcE9JHorhkKApvd03iFg55CBapzue3cc8T+Po9YkZXpOMuMahgFC/Lyata+yNskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734553433; c=relaxed/simple;
	bh=lObA13yr4r71LMXlU9RucKIDJZmCI5D4zjGy9A3yP3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fksfI4YEzXvyGgaXvGimNTJhR2E6CgnvadZBosqnHXPlHYbykChaA69jfNjoLwJuFuZtgZFKaZemCgvj+xPn0c/S0JsBoPyJpamjYYlRLrFy1Jkdso0OerKX+D6xUuk8fFOIAYmoS2LXraiN31LNdKNM1/btM58zrKoPcKrIjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XKpvBvIh; arc=none smtp.client-ip=103.209.128.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 62079658;
	Wed, 18 Dec 2024 23:47:43 +0800 (GMT+08:00)
From: Jon Lin <jon.lin@rock-chips.com>
To: broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	jon.lin@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: rockchip-sfc: Fix error in remove progress
Date: Wed, 18 Dec 2024 23:47:41 +0800
Message-Id: <20241218154741.901591-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIZGVZMGB5JGUsaSxpIHU5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93da741f7209d9kunm62079658
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAw6Aww5NTITCBAQHyxJKzFN
	CQIaCxJVSlVKTEhPTkhNQ01PT09MVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFKT09KNwY+
DKIM-Signature:a=rsa-sha256;
	b=XKpvBvIh0GfihsjPdKvwG9EvIk7S7fckssglKXt5f1EhMppvwFaMQ8p5v9LUY63ysK5KmZCkI92fdGSJ3p+MQ45FGI2DJakha8Rri7jTvZuCAewPG4bmzdJhSNXN7sA1F4QVKDXBpee6yL9C+bdxPcHfGcv9kjX9xzhrSQuWGkg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=OU+G1H8f52f2/x0TSjJIsIY+TxkbETn6gOAbnCRhzbM=;
	h=date:mime-version:subject:message-id:from;

Fix error in remove progress:
	[   43.026148] Call trace:
	[   43.026370]  klist_next+0x1c/0x1d4
	[   43.026671]  device_for_each_child+0x48/0xac
	[   43.027049]  spi_unregister_controller+0x30/0x130
	[   43.027469]  rockchip_sfc_remove+0x48/0x80 [spi_rockchip_sfc]

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip-sfc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 9146b56713b6..ca4f20283d23 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -184,6 +184,7 @@ struct rockchip_sfc {
 	bool use_dma;
 	u32 max_iosize;
 	u16 version;
+	struct spi_controller *host;
 };
 
 static int rockchip_sfc_reset(struct rockchip_sfc *sfc)
@@ -603,6 +604,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	sfc = spi_controller_get_devdata(host);
 	sfc->dev = dev;
+	sfc->host = host;
 
 	sfc->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sfc->regbase))
@@ -708,8 +710,8 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 static void rockchip_sfc_remove(struct platform_device *pdev)
 {
-	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct rockchip_sfc *sfc = platform_get_drvdata(pdev);
+	struct spi_controller *host = sfc->host;
 
 	spi_unregister_controller(host);
 
-- 
2.34.1


