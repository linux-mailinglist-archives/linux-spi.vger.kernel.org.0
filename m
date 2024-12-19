Return-Path: <linux-spi+bounces-6124-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9739F7D21
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C75188CFA8
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343BB70830;
	Thu, 19 Dec 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BXzSyWmV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m121144.qiye.163.com (mail-m121144.qiye.163.com [115.236.121.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA12225419;
	Thu, 19 Dec 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.121.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618455; cv=none; b=KCpIvNz7/j4Lzrvfbh47dSNIFcW7OnMwJNhgdCK9aNrzgS8itvum+HopskA2bZIcTGXomfZqa/6sICYJ0zCvb+U15GwIUvvajXbSL11qUFN0yHTj5MXo0mO5/07R7ouKPOilBSh2q0dvuJcDNzHk4QdQ0e+mK5wZjLRDaSZyJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618455; c=relaxed/simple;
	bh=O3YtGLX6VMyhp1kXXBwXdpjgeAEJiyZNRz3+xlLy2Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DuU4XzuC/B3MU12H7NpDPsz+t32Zkz/ww3/9Jkgd885IE42Wvka/eQMck4CjwCJh4Ua/MzXNIAGc2hoWbGmB6DznC2/9MhUWcUZClSeAcijWXzpFS2rrlNjRp3o6Ju5gtEnBD3wvJ7PcnJ+iYzogsmss2S6A+Sc/sNVdzHcSVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BXzSyWmV; arc=none smtp.client-ip=115.236.121.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 63cf60df;
	Thu, 19 Dec 2024 22:22:18 +0800 (GMT+08:00)
From: Jon Lin <jon.lin@rock-chips.com>
To: broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	jon.lin@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: rockchip-sfc: Support sclk_x2 version
Date: Thu, 19 Dec 2024 22:22:16 +0800
Message-Id: <20241219142216.2123065-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgeTVZPGR9MSB9MQx5LSUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93df4c475409d9kunm63cf60df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MUk6Tgw6FDINPgsXODhOGBMe
	T09PCwJVSlVKTEhPTUpDSkhCSElKVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFKQk5JNwY+
DKIM-Signature:a=rsa-sha256;
	b=BXzSyWmVT/sY1tB/1XsRSqr4/YT7MXKhG6dbJWnM/Xg0ZtSqnJDBRI3qbSyuEnor/xO7POBv19f9X/RyVbYobAW6+EfDIPeoRewmVp/iVSiwVscfqTivF5viM5CaNnhDklaO0+tH9Jc6LQVBMxj7tE9nh00IslIoPb441fALTO4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=mogB8Z2BaCep1O7h/L6gI4XBbJfzWmp9owLVw4u/w3E=;
	h=date:mime-version:subject:message-id:from;

SFC after version 8 supports dtr mode, so the IO is the binary output of
the controller clock.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip-sfc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 36509bcccc27..59de351499a0 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -112,6 +112,7 @@
 #define  SFC_VER_3			0x3
 #define  SFC_VER_4			0x4
 #define  SFC_VER_5			0x5
+#define  SFC_VER_8			0x8
 
 /* Delay line controller register */
 #define SFC_DLL_CTRL0			0x3C
@@ -217,6 +218,22 @@ static u32 rockchip_sfc_get_max_iosize(struct rockchip_sfc *sfc)
 	return SFC_MAX_IOSIZE_VER3;
 }
 
+static int rockchip_sfc_clk_set_rate(struct rockchip_sfc *sfc, unsigned long  speed)
+{
+	if (sfc->version >= SFC_VER_8)
+		return clk_set_rate(sfc->clk, speed * 2);
+	else
+		return clk_set_rate(sfc->clk, speed);
+}
+
+static unsigned long rockchip_sfc_clk_get_rate(struct rockchip_sfc *sfc)
+{
+	if (sfc->version >= SFC_VER_8)
+		return clk_get_rate(sfc->clk) / 2;
+	else
+		return clk_get_rate(sfc->clk);
+}
+
 static void rockchip_sfc_irq_unmask(struct rockchip_sfc *sfc, u32 mask)
 {
 	u32 reg;
@@ -519,12 +536,12 @@ static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op
 
 	if (unlikely(mem->spi->max_speed_hz != sfc->speed[cs]) &&
 	    !has_acpi_companion(sfc->dev)) {
-		ret = clk_set_rate(sfc->clk, mem->spi->max_speed_hz);
+		ret = rockchip_sfc_clk_set_rate(sfc, mem->spi->max_speed_hz);
 		if (ret)
 			goto out;
 		sfc->speed[cs] = mem->spi->max_speed_hz;
 		dev_dbg(sfc->dev, "set_freq=%dHz real_freq=%ldHz\n",
-			sfc->speed[cs], clk_get_rate(sfc->clk));
+			sfc->speed[cs], rockchip_sfc_clk_get_rate(sfc));
 	}
 
 	rockchip_sfc_adjust_op_work((struct spi_mem_op *)op);
-- 
2.34.1


