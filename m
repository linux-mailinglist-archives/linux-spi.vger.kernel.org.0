Return-Path: <linux-spi+bounces-3889-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA7933A90
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2024 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1163B1F23190
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2024 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B26717F4F1;
	Wed, 17 Jul 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAMxBM7d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24D17E91D;
	Wed, 17 Jul 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210410; cv=none; b=cpHIyinjzcifncECtyBP9MKRWmSx1+J6rRl3n3dluXSEF5BerRNTr574cJmna3BsUC9PHoGgbX/aC3lpqZ8YKiTFHmqvCmqQUY9nmehDNJDPMZlbWM103hgkh//tb6ejj6+b68Nm613rBB2j+1dT7FdtHhW3XYDOBRpT0LrlidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210410; c=relaxed/simple;
	bh=apvG84V5D72A2ovX8Ym5o4GyiAqCNrUwmsljBqYzti4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBdPlNioEp55niQpcDcMblYVzI/+LEu1pkRuVTPFR8ZEc0IC2I8/qwMcF83Qayo0mHDopgQzxBDlGbSDTeQM7sHCzjEu3g2zTP4Q3ewjsOH579W2WrsR7cKM9We4+0QSi7ucOn4MA7nq3RTlT2XNfXNZn60IjUKfinadzJ4t7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAMxBM7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD3EC4AF0C;
	Wed, 17 Jul 2024 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721210409;
	bh=apvG84V5D72A2ovX8Ym5o4GyiAqCNrUwmsljBqYzti4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAMxBM7dM3iZM90G09J2sTpcTYpvsVGIavBmWZyzFQL4/DSzwqvfSXS0MtcJDwh44
	 ZyEujha0/1Rh6u+ryIuXzHi1KXHWorR9lMt+5zSyEiC8+5AHkv1ahoFmywS/jO05RN
	 4YxpNrtmavjmQHpe0kn6nB/E8ctiC5Qb9dAUmFZrxD2JoFVkGaomRBLKoy0IOYnNu/
	 HZ7RZyQ3nf2n4VnjoxdXRqNJLByFfvDoNKWTDXVabxeECcvVg7RjZGBB+mZxE2OLb8
	 WcXwVLP9YbYZsuQW8o3Ov+6YaVjKcqbUMBXeWhkY/2+45Ip5Ge06qKgPHaU0Kp107z
	 7z648utjzWGZw==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 3/3] ARM: dts: nxp: correct DAC compatible on Crystalfontz's CFA10049
Date: Wed, 17 Jul 2024 10:59:50 +0100
Message-ID: <20240717-ruse-cardinal-c30cf11bbf1e@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717-impotence-zippy-254b86593069@spud>
References: <20240717-impotence-zippy-254b86593069@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=po4ukk2TtrTbTP6VRex1woV9O4IoqV8AZfS3boi8AP0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTp4kYKOQ98du0snKlpi5ztLVBwPSoH0v7dPQNJne8c bW9ECDeUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgInEfWRkWJH67I1ayQXV7/wh up3X71lVHfNSkFNw5GjS/PnMnH/7bIb/sTNy5rt9eHDk/J7q+8XtfzbV9fmfmm957P3G3Tsyf74 5zAAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When Maxime originally added the BH2228FV to the kernel, he spelt it
incorrectly - the d should have been a b. Correct the compatible used in
the devicetree.

Fixes: db7a8946dc40 ("ARM: dts: cfa10049: Add the DH2228FV DAC to the DTS")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts
index f0ce897b9d5c..3cd2acbd8931 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts
@@ -143,7 +143,7 @@ gpio6: gpio6@1 {
 		};
 
 		dac0: dh2228@2 {
-			compatible = "rohm,dh2228fv";
+			compatible = "rohm,bh2228fv";
 			reg = <2>;
 			spi-max-frequency = <100000>;
 		};
-- 
2.43.0


