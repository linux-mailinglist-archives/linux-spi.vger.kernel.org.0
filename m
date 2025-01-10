Return-Path: <linux-spi+bounces-6292-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5031EA0941A
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0911B3AB5AD
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2852E212D95;
	Fri, 10 Jan 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o768u8Ot"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321D2116E5;
	Fri, 10 Jan 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520343; cv=none; b=ZMB3UmZ5Uu2y2FA1icdvL8l6Lx3ZhJLrJ87SRZLm9MqnwbN3btwsacJ4XmzPROuzulKmr4skrOYAvBcLd7Pc7cj4l75KWmx/nYyPBiO8LpEf7VkHyUFQ+WD5olYTIo3HlF44BcAPCM6BWcziawCi2qLTRhhdOIiMqcS0Hac41WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520343; c=relaxed/simple;
	bh=TEeVZGg16CBNzKpYiDTOF2vuh2H8irTZXTQt3vZ9Yt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/tH3KADTpAHhzkjuw6bif/P/O9uh+BevxdUeYTg8GImzyoU6oVZ4XRHonlHn4XcGsQZ/Hp8AD+VZXw+J1vtzooD9a92OkeUhmVyhYtuaO/+milEfAJP1/DrLkfvMDky7Vol19NXwdhYO1QrE4C+2Zw0PHAjWwnsYS8lUFcXn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o768u8Ot; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79EF1FF804;
	Fri, 10 Jan 2025 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuQ/lBXfZRP3KmcoAIIIjIvvj0TWlpOZ+bgtTbc13Ew=;
	b=o768u8Otcsz2Km36EsCHtEU5he37v6Eo3tHx2ozWdVQJXyjPuDsZOLWsGba3bIrjUGzP3Y
	ZKMtr/uwbqHC46+jWufNx7PWLIwMnBH4aJ6sEMdVfCV8HAhGEHQVGqGLotvIca27+WPBuL
	yOYCXHbamw/Fza1JVQB8BxpUv3JwMtiWKyY36HQvZJUgUz4AKqRGGOTi1nV+zrn46NfUnH
	7l1qgd/5NDOdgHrKm/HRIPARiCzrTBfQeaoPVReZVp/hi/ZkjK1/Aev3gYDSUJXhFzBB8n
	WQ/TWkmqAKqBwPY7IYCXgedFtcQDEzwIu4zfe5VBYWnCbnbHoSolOh4XAQoFvA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:13 +0100
Subject: [PATCH v3 11/27] spi: mxic: Support per spi-mem operation
 frequency switches
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-11-7ab4bd56cf6e@bootlin.com>
References: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mtd@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.15-dev
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
index 809767d3145c17291525ab7c246085597e0ff5e6..eeaea6a5e3103952e71a474e0de84099bc476a79 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -522,7 +522,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	int i, ret;
 	u8 addr[8], cmd[2];
 
-	ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
+	ret = mxic_spi_set_freq(mxic, op->max_freq);
 	if (ret)
 		return ret;
 
@@ -582,6 +582,7 @@ static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
 	.dtr = true,
 	.ecc = true,
 	.swap16 = true,
+	.per_op_freq = true,
 };
 
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)

-- 
2.47.0


