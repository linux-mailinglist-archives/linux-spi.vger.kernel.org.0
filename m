Return-Path: <linux-spi+bounces-5478-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C349B0987
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025861C23129
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6186617A597;
	Fri, 25 Oct 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZMZDmxvb"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6AC1CC8AB
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872918; cv=none; b=ika0I13PCB8jAZBDstg4NjChYbg67lnUcwz73gmN+wC2PZ9gnEmWCb+hV96PCPZUnIqVL+1zKUDq8cB21P4ng7fFubm3jW7LnCXyrqshlobC0BoEtgEkvIz70R+vy86NVitT7NU3d4D1oV/yYfroFQ/RVuhONImKKhqJNqMZgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872918; c=relaxed/simple;
	bh=ylltRHuyjvk8adpqyqvbrQAUWh//fdFz5Tg96Pc87k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiFRxJri3fO91Qbf03ZojpTQwytyw3CY74PXFue105nmZYVBcygkimqM+BEBhabR4+iq+MT2TUNaZc4lqsEuenUGwTzWikC9pxHRltOCtCg2J/BqSdrUG7ZWUxk9BSsQOSednSJMycvQyq3exUCdlWvcAunqgypC6aSuOXltXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZMZDmxvb; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDF9BE000A;
	Fri, 25 Oct 2024 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/FGEdYvu05llZNXxM7T7Gat6kFm2S1ba/ZknoEvKek=;
	b=ZMZDmxvbAo09mLuKP+Ifnwqn2g7ca6zUmET2x1WI/a+pikpEk1rhJGvjUsClEJz47lXYWR
	0HcsBcd/2ufoi8cD9uQhY3CFOGC6xe059dl3Ir081vlob8jORnHuP2XQsZvahe69E95WAt
	gw86k6BahhWkZ9aX3vVjNjLKca+1gYB6LczQYP7tw+zt3YSgfoV3TKtN0NTVFi36xFGyla
	IeRdO//PjCmxeNDkGVFKYJhcVvwP53vzaafLjA2dfsAL6WgHJDbM/JuLdZPIlGMuPWIhrW
	vxDNRbJFjlY0n2fk1abO8KrISJhPCQsMad5O0sfF+vKf5eLZqlEiHxyWrp17ew==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>,
	Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 10/24] spi: mxic: Support per spi-mem operation frequency switches
Date: Fri, 25 Oct 2024 18:14:47 +0200
Message-ID: <20241025161501.485684-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025161501.485684-1-miquel.raynal@bootlin.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Every ->exec_op() call correctly configures the spi bus speed to the
maximum allowed frequency for the memory using the constant spi default
parameter. Since we can now have per-operation constraints, let's use
the value that comes from the spi-mem operation structure instead. In
case there is no specific limitation for this operation, the default spi
device value will be given anyway.

The per-operation frequency capability is thus advertised to the spi-mem
core.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mxic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 6156d691630a..49a5833ca744 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -514,7 +514,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	int i, ret;
 	u8 addr[8], cmd[2];
 
-	ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
+	ret = mxic_spi_set_freq(mxic, op->max_freq);
 	if (ret)
 		return ret;
 
@@ -573,6 +573,7 @@ static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
 	.dtr = true,
 	.ecc = true,
+	.per_op_freq = true,
 };
 
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
-- 
2.43.0


