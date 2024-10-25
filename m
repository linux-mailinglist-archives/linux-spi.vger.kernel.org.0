Return-Path: <linux-spi+bounces-5492-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A59D69B0995
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27FA8B22951
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046C77080E;
	Fri, 25 Oct 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lV6tQzaT"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0F7082B
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872933; cv=none; b=I6gmtajZ0VtTDZjgl2Sq9xnDopMvjCPkyy7otZAg85v5dxPRzT4Wd62c1MgAK1vRnfp2GR/IWls0CVtCaYKdhdiOXevN30mDyaU3t+8lUSV1vuusFkY6Zqa0tBRGRlaVriq8LYV/vR1ET7pAcQ9hz4gep/avK2Ejoz9Ps3mwDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872933; c=relaxed/simple;
	bh=A+wRNJLROps3tR/Vg2bnBLleUPhoGTLB7xu8NkXlKJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuV8mR6Lq1SwuQlMHhdhy8sKAgSj86jDwhBL896vS6SnebgpVUDFJZkr0Q8s4cQbjzLZZCSySA5VPTc5Hbq1kXpS0qFllA/tUbO9wgU5Dn4B9ukIhuepkXqYtPWCJSv9i3ttx6a/xBeA9FxeNjwZHrB3Bt2MTtckBWjisXg1lwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lV6tQzaT; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27878E000B;
	Fri, 25 Oct 2024 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNZ35tLIp+zDY5uimmtQaRUO+/7F8c6/BRoCKTGJAbA=;
	b=lV6tQzaTtkC+P4cye4A2ad8iy7A10YGcynh8zAjJ+e1p8bi51dKfgTuh6RR2HZGBHTmsXK
	WcWewLOx9zBtKJZQYVV+SCyfF+UCZw0mokLGFFbk4idhgh8E36QUCdDMyliuhoL0PhRPdn
	AXxE1Oe71AIa11YV0QZJMOYh9AOHLpxcwN4GVfQOGkij0yS2FGXNXySZgDl0kcI2Djerq9
	TI6kVmzzUrmSk/dZz5PG984NA3Pa7Q+KFe4WQ7y9B56DxrpgG3S7MjUEkrRJeSMLv0Q5JU
	3QMskdRswVzZ+8l3gpO1Fh10gzhP7ayWJ6zD5IMLU4ju6ROXJqG8CGVI7CydsA==
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
Subject: [PATCH 24/24] mtd: spinand: winbond: Add support for DTR operations
Date: Fri, 25 Oct 2024 18:15:01 +0200
Message-ID: <20241025161501.485684-25-miquel.raynal@bootlin.com>
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

W25N01JW and W25N02JW support many DTR read modes in single, dual and
quad configurations.

DTR modes however cannot be used at 166MHz, as the bus frequency in
this case must be lowered to 80MHz.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 9e2562805d23..77897a52b149 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -24,10 +24,15 @@
  */
 
 static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_DTR_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_DTR_OP(0, 4, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
 
-- 
2.43.0


