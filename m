Return-Path: <linux-spi+bounces-3887-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8A933A8A
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2024 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E4F282AAD
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB317E918;
	Wed, 17 Jul 2024 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWzKtiZH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA817F369;
	Wed, 17 Jul 2024 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210401; cv=none; b=f82MNcKC6YkUmpy8fqCXMhjnSF2NNMDfC0mhFFAsSB3luE7av3IXfQT7gSob3m41iFfW5evWahMWNKG29MlsEKzvKJa8+xJ4fojjaNsKV/V4K0somhUyHOrVj21/bwxyKnU5OChIpaP8HPnGgTJH0KuLx5/gPGzcfAvPimThXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210401; c=relaxed/simple;
	bh=fcaQeVYlwpBiQy64PeATOVnG5Jbx+9u+ZH3xphKxDbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=See2RKRhvXq3NoFGYdAeA5KlY8UXtp1sLxXNntySHeiYOTkmJuQgmG7wzeRB7XmDIRQQ1V0bx45m23WsSch0rhZhLNSRk2TESl4NFyCJM8wuGTvU8lDY5YlE11E1Ab0ow+B2VlY2lO0DBK52vhl4IMXiZchOoTrvc6/xtPzEEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWzKtiZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D2CC4AF0E;
	Wed, 17 Jul 2024 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721210401;
	bh=fcaQeVYlwpBiQy64PeATOVnG5Jbx+9u+ZH3xphKxDbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWzKtiZHNwzAdTR9t9wQgbyxeYKOt0/Lxl6aHY9GvSIdfqcg3wPb90t3/wMNPNu84
	 fBYPuj5D/mXTWKYpHmH33HTj0eiogdfjxHFMhwvi4BrgC1YbnTSdDk7v0QaTEKS490
	 Xd6f/ljj3T85DHqHjrgS4GLsvXyIRW72NOGb4bqUBSQPipWdtGk02B+2XBMSzk5noW
	 uxvSUYFgD20aQt2tVrYMctia1f7Mn2lfyrZimpUeZxaPWe+vahj5rCLt6sRpO42igx
	 3BMD06I2RN8kqMFbEOcCjCpDARzoGHWHqNpusV3Xsl6gaGbKayQRCuSYrhq1A456LY
	 UZbjQxC5SZKtQ==
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
Subject: [PATCH v1 1/3] dt-bindings: trivial-devices: fix Rohm BH2228FV compatible string
Date: Wed, 17 Jul 2024 10:59:48 +0100
Message-ID: <20240717-exuberant-enlighten-f890fabcd247@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717-impotence-zippy-254b86593069@spud>
References: <20240717-impotence-zippy-254b86593069@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Pv6EDJ42tO+761aHkXvuRjBuVza1njIC6Q/agA+48Ro=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTp4lsC+Y/eeJan/OEI+e1bji8ErrYWeJTsOHi4225i efLJVfc7yhlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEttxiZGhWn7HP9fuSRT/+ 3bJamxGzeLl/5Px296XXt921kmD4E7uJkaGDPyPj8dyTnz92mN1fycofO6ndVLE6VIZhi0ByZez jMzwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When Maxime originally added the BH2228FV to the spidev driver, he spelt
it incorrectly - the d should have been a b. That spelling was then
propagated to the binding when written by Krzysztof. Add a new, correctly
spelt compatible and advise against using the incorrectly spelling.

Fixes: 025aea27732d ("dt-bindings: trivial-devices: document SPI dev compatibles")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 5d3dc952770d..7913ca9b6b54 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -328,7 +328,9 @@ properties:
           - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
           - renesas,isl29501
-            # Rohm DH2228FV
+            # Rohm BH2228FV 8 channel DAC
+          - rohm,bh2228fv
+            # Rohm DH2228FV - This device does not exist, use rohm,bh2228fv instead.
           - rohm,dh2228fv
             # S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
           - samsung,24ad0xd1
-- 
2.43.0


