Return-Path: <linux-spi+bounces-192-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD8B80B6CA
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 23:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B6D1F2100C
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5F1DA40;
	Sat,  9 Dec 2023 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigler.one header.i=@bigler.one header.b="CHbH0zOO"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF02100;
	Sat,  9 Dec 2023 14:23:57 -0800 (PST)
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4SnjGM0tLjz5y97;
	Sat,  9 Dec 2023 23:23:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.one; s=key2;
	t=1702160635; bh=EnxGptbbemOBXJZfV7Vdg0y/0R3Tx3smsS3ArovZmIc=;
	h=From:To:Cc:Subject:Date:From;
	b=CHbH0zOOz3Jf/cajxDDY8a82K0BvdDEZxgs/z32F5zJagT9BKqJ5q9eKNfvTVUahJ
	 MvgUu92rSoEnnNXgqUFjGOob9w4b9y1ql3qfZf5skgARZ5u2M0kKO0qGIgR1JdZk8j
	 gGSs6UcCXwXOQ9e0SJyjlLW/sPhFmRpCMd1Dudva5CUT2bRRG4BFfXLqt/xtaHTH4p
	 AryC/cneGyx6131ryZMiSd/KUhv/l82zl3qjBnSx9UmB22SYRupqqaFjbMy85ck8V5
	 4sihq8TZGDKSY6anR6JzRKBA1/4k7GkNJYQ6m8Ws2RdXwCcmkPlOn8aDnJ/Au1Muke
	 unYqCcpDbwAeA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4SnjGM07lwz4xR4;
	Sat,  9 Dec 2023 23:23:55 +0100 (CET)
Received: from mx2fc6.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4SnjGL3rqdz8sZh;
	Sat,  9 Dec 2023 23:23:54 +0100 (CET)
Received: from bgi-desktop.yallo.box (xdsl-188-155-37-14.adslplus.ch [188.155.37.14])
	by mx2fc6.netcup.net (Postfix) with ESMTPA id 5391B40949;
	Sat,  9 Dec 2023 23:23:49 +0100 (CET)
Authentication-Results: mx2fc6;
	spf=pass (sender IP is 188.155.37.14) smtp.mailfrom=benjamin@bigler.one smtp.helo=bgi-desktop.yallo.box
Received-SPF: pass (mx2fc6: connection is authenticated)
From: Benjamin Bigler <benjamin@bigler.one>
To: broonie@kernel.org,
	linux@bigler.io,
	francesco@dolcini.it,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	regressions@lists.linux.dev,
	stefan.moring@technolution.nl,
	regressions@leemhuis.info
Cc: Benjamin Bigler <benjamin@bigler.one>
Subject: [PATCH] spi: spi-imx: correctly configure burst length when using dma
Date: Sat,  9 Dec 2023 23:23:26 +0100
Message-ID: <20231209222338.5564-1-benjamin@bigler.one>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <170216062984.32454.7026503541350922205@mx2fc6.netcup.net>
X-Rspamd-Queue-Id: 5391B40949
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: 13HCmpbDjgbCAcX7po9IGUoUBO+mApUJNZfnb4TkhsINTgs=

If DMA is used, burst length should be set to the bus width of the DMA.
Otherwise, the SPI hardware will transmit/receive one word per DMA
request.
Since this issue affects both transmission and reception, it cannot be
detected with a loopback test.
Replace magic numbers 512 and 0xfff with MX51_ECSPI_CTRL_MAX_BURST.

Signed-off-by: Benjamin Bigler <benjamin@bigler.one>
Reported-by Stefan Bigler <linux@bigler.io>
Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on transfer length")
Link: https://lore.kernel.org/r/8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com
---
 drivers/spi/spi-imx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 498e35c8db2c..272bc871a848 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -659,11 +659,18 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 		ctrl |= (spi_imx->target_burst * 8 - 1)
 			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	else {
-		if (spi_imx->count >= 512)
-			ctrl |= 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
-		else
-			ctrl |= (spi_imx->count * spi_imx->bits_per_word - 1)
+		if (spi_imx->usedma) {
+			ctrl |= (spi_imx->bits_per_word *
+				spi_imx_bytes_per_word(spi_imx->bits_per_word) - 1)
 				<< MX51_ECSPI_CTRL_BL_OFFSET;
+		} else {
+			if (spi_imx->count >= MX51_ECSPI_CTRL_MAX_BURST)
+				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST - 1)
+						<< MX51_ECSPI_CTRL_BL_OFFSET;
+			else
+				ctrl |= (spi_imx->count * spi_imx->bits_per_word - 1)
+						<< MX51_ECSPI_CTRL_BL_OFFSET;
+		}
 	}
 
 	/* set clock speed */
-- 
2.43.0


