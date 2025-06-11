Return-Path: <linux-spi+bounces-8446-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C481AD536E
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 13:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456FB1C241A4
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE312E6119;
	Wed, 11 Jun 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XdjLxKY0"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5118625;
	Wed, 11 Jun 2025 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640082; cv=none; b=G+Gh0dFt3CQh0n85NtfHxxyeTe0goGhhLGH2byXda4FBMxmrNYxTmpN/XCHAhWLZKiGwhrjIle+NoSICRzaVnlXLBJ3zwCkag8eUpN08DFNLzhhM5k3/9O9yq19lTz9UNhKzIrvZGwiMGWE2ngo/5jiPX2rEFQrLpRl0kDyaJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640082; c=relaxed/simple;
	bh=AZdbARWOeCnWEmDLRenfjc1WfkYQIODwwqhvNjwz+1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOVwrpjkrT4jtbTwI6o0HMs6+nZVr2orfjGSMLJwdEhfJaYs6hKkkNBTOPabjdru/5GPR8Lj43Q9W9YcPE/uQpdjRgs4YCQn7FEpp+RkE4mC9pitZtNfYf0132K5S3lQI0bzNr2U6UexB+b+RlbpGbA5yI4kWaX0fBGJX1tNLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XdjLxKY0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749640079;
	bh=AZdbARWOeCnWEmDLRenfjc1WfkYQIODwwqhvNjwz+1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdjLxKY0sG7cDYnt0erdLwjdWYFThlRyNe8Kw9epJBHnh2JDpFMKGQsRZvEPOohbV
	 F1/wOcCO4xTNDc7QXvaPtexs6N06xcBb1mM09nzKw7i/N2LuBkjf9sdvFPZJZKK2ls
	 O1jHlKDESpQhctlMnkcpz/lwAQXEAokeLtb5mLgDJX/qgnxfr4TYwe2l2xAlHVk18C
	 763RrlGtjPU8NsRr7F/jZJI6bS8ofnmpM4ckuneBdxBMy2CnaMC3zQrb917RSFirGM
	 +11bO/Wp/IFo2n71qED+vHYZiR4qzmvJmmLNWyYxxrinVUdT051Epw8VHtD7FKg8TX
	 afy45P7Z/Qowg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4E27017E0F66;
	Wed, 11 Jun 2025 13:07:58 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	leilk.liu@mediatek.com,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 2/2] spi: spi-mt65xx: Add support for MT6991 Dimensity 9400 SPI IPM
Date: Wed, 11 Jun 2025 13:07:47 +0200
Message-ID: <20250611110747.458090-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611110747.458090-1-angelogioacchino.delregno@collabora.com>
References: <20250611110747.458090-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the SPI IPM controller found in the MediaTek
Dimensity 9400 (MT6991) SoC. As a note, this is the same SPI
IPM Controller IP found on the MT8196 Kompanio counterpart.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 4b0a1c0db041..a6032d44771b 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -220,6 +220,14 @@ static const struct mtk_spi_compatible mt6893_compat = {
 	.no_need_unprepare = true,
 };
 
+static const struct mtk_spi_compatible mt6991_compat = {
+	.need_pad_sel = true,
+	.must_tx = true,
+	.enhance_timing = true,
+	.dma_ext = true,
+	.ipm_design = true,
+};
+
 /*
  * A piece of default chip info unless the platform
  * supplies it.
@@ -245,6 +253,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
 	{ .compatible = "mediatek,mt6765-spi",
 		.data = (void *)&mt6765_compat,
 	},
+	{ .compatible = "mediatek,mt6991-spi",
+		.data = (void *)&mt6991_compat,
+	},
 	{ .compatible = "mediatek,mt7622-spi",
 		.data = (void *)&mt7622_compat,
 	},
-- 
2.49.0


