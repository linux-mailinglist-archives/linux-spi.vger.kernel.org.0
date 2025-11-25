Return-Path: <linux-spi+bounces-11522-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B14C85DF4
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 17:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 017B84E2069
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497DA22424E;
	Tue, 25 Nov 2025 16:07:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115D20A5F3
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086821; cv=none; b=XbRtFDh92fS3Ny3BVly0u4rjJ+xlxtvAFEuik5LkUq+sfpNFGf5pv3fnfypLqVFIuafIIB6XsDGejYDu6DvrcGhSBKBxMQg+/RFebR0HM7biC5SCGf7Nv3Q6hEwfmq2Ic6YEg4qx2Av+hPzsyb9Qwk1KDneSZ51/I+WnrxUVjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086821; c=relaxed/simple;
	bh=ceMns4J2COL4cggMPp+ueNuz2K45S3tjbr6kqN0c7ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+XdJYEdqgHtRkMNxzpaEC/8jbSBcq+f9T685aCYcrNWwriwCNO515UUCdLAgKzVGeCKLlVfynbH25vAOiBAaYV9QeWXREohg6AURby8Sc2txVXH4OX3BFij7gR2DC5Soj6p1rElU0FnPq8aJSgdsdigDnAoaDxrSKpdKPsVlU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF99DC4CEF1;
	Tue, 25 Nov 2025 16:06:58 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Conor Dooley <conor.dooley@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: linux-spi@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: microchip: Enable compile-testing for FPGA SPI controllers
Date: Tue, 25 Nov 2025 17:06:56 +0100
Message-ID: <6f96848b026f9a343b80d48179149b30c6b76d1d.1764086805.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Microchip FPGA SPI controller driver builds fine on other platforms.

While at it, drop a superfluous empty line.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 79c21aeaad240b33..c7e440ef251deab6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -880,9 +880,9 @@ config SPI_PL022
 	  bus and a PL022 controller, say Y or M here.
 
 config SPI_POLARFIRE_SOC
-
 	tristate "Microchip FPGA SPI controllers"
-	depends on SPI_MASTER && ARCH_MICROCHIP
+	depends on SPI_MASTER
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	help
 	  This enables the SPI driver for Microchip FPGA SPI controllers.
 	  Say Y or M here if you want to use the "hard" controllers on
-- 
2.43.0


