Return-Path: <linux-spi+bounces-221-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F39F80E5A5
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 09:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F321281E5E
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046F15ADF;
	Tue, 12 Dec 2023 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XipcMupa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1681C7
	for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 00:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=7Rc13HU5Hew3Gt
	2Ni0E4H3z03yClMr1EWHsYl1/be4g=; b=XipcMupa7b4+rqrWOvIUM2nM3R58/B
	j4EaCMSK1eGMnNs/5JchrnI3qokaZhJtiuazHJxVJtlenKWeKSM//U8n4jIL9Lor
	mssJ0q0YhAeBO0iofBfUHt/pzNtBBIgI3BVAS2HQYJiC2Tj6yCEMTTl/Zy4dLXfc
	TqjdYOjrQ5hO759sxXWiVyIQllgcxa3OOnh7XpFjBvdJameBDdHCAFsca6HKLHN9
	dEsUMsPOW/5dC61NTJ3pYkMLPnlB5CzukI6mepz3mDqORvtBRXSnuo31TIdQHrWK
	QeffqZrY+LxmZMw9JaHMOdimK6XHRLIlD1c4+1ymb5i6PEERzoDBWakg==
Received: (qmail 128790 invoked from network); 12 Dec 2023 09:12:49 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Dec 2023 09:12:49 +0100
X-UD-Smtp-Session: l3s3148p1@s2HDnUsMMpUujnuR
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
Date: Tue, 12 Dec 2023 09:12:38 +0100
Message-Id: <20231212081239.14254-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation says only DTDL of 200 is allowed for this SoC.

Fixes: 4286db8456f4 ("spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---

This patch sadly slipped through the cracks since April.

Changes since v2:

* added fixes tag
* rebased to v6.7-rc5

 drivers/spi/spi-sh-msiof.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index fb452bc78372..cfc3b1ddbd22 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -29,12 +29,15 @@
 
 #include <asm/unaligned.h>
 
+#define SH_MSIOF_FLAG_FIXED_DTDL_200	BIT(0)
+
 struct sh_msiof_chipdata {
 	u32 bits_per_word_mask;
 	u16 tx_fifo_size;
 	u16 rx_fifo_size;
 	u16 ctlr_flags;
 	u16 min_div_pow;
+	u32 flags;
 };
 
 struct sh_msiof_spi_priv {
@@ -1072,6 +1075,16 @@ static const struct sh_msiof_chipdata rcar_gen3_data = {
 	.min_div_pow = 1,
 };
 
+static const struct sh_msiof_chipdata rcar_r8a7795_data = {
+	.bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
+			      SPI_BPW_MASK(24) | SPI_BPW_MASK(32),
+	.tx_fifo_size = 64,
+	.rx_fifo_size = 64,
+	.ctlr_flags = SPI_CONTROLLER_MUST_TX,
+	.min_div_pow = 1,
+	.flags = SH_MSIOF_FLAG_FIXED_DTDL_200,
+};
+
 static const struct of_device_id sh_msiof_match[] __maybe_unused = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
 	{ .compatible = "renesas,msiof-r8a7743",   .data = &rcar_gen2_data },
@@ -1082,6 +1095,7 @@ static const struct of_device_id sh_msiof_match[] __maybe_unused = {
 	{ .compatible = "renesas,msiof-r8a7793",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,msiof-r8a7794",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,rcar-gen2-msiof", .data = &rcar_gen2_data },
+	{ .compatible = "renesas,msiof-r8a7795",   .data = &rcar_r8a7795_data },
 	{ .compatible = "renesas,msiof-r8a7796",   .data = &rcar_gen3_data },
 	{ .compatible = "renesas,rcar-gen3-msiof", .data = &rcar_gen3_data },
 	{ .compatible = "renesas,rcar-gen4-msiof", .data = &rcar_gen3_data },
@@ -1279,6 +1293,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	if (chipdata->flags & SH_MSIOF_FLAG_FIXED_DTDL_200)
+		info->dtdl = 200;
+
 	if (info->mode == MSIOF_SPI_TARGET)
 		ctlr = spi_alloc_target(&pdev->dev,
 				        sizeof(struct sh_msiof_spi_priv));
-- 
2.35.1


