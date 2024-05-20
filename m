Return-Path: <linux-spi+bounces-2960-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C28CA0F5
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 18:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A61F1F21C89
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1A1CD39;
	Mon, 20 May 2024 16:59:34 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2905137C20;
	Mon, 20 May 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224374; cv=none; b=RSjiw3TgOIGEjNLGW5AgFvmcIVN/EZNkPhT3OB/eYBpD5WooFf61WuSHNE3C/TmixGXMhj56FGnw56EZI+oh/Dk15M/YxSB0s7TR2e5sUD5xBD5xh3SHYFZk5eofDH25SNHahlPvxR9b651dEvd+nvz31otoGgDfIYZ5m5VE+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224374; c=relaxed/simple;
	bh=s2YGVwJxCN/d4PGiiaxIL+qR6SuliZtVQJxRKM7iKHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IQbvPPN3PN4pVvWr9NQPIfqEmCD0q32h8k/aH7dKRL5Xkp+2qEqfb2fH4TNOuRCTeK11fQi8qxK72/aEJZvzo9ewPH20t7nPhhSPvq0GIfWkni5yzMKHY9L4qx+k7FpdigAU8mITOACDWJDEzRYBXrdDwyx2HinTbAU8Npj8AV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-084-059-234-031.084.059.pools.vodafone-ip.de ([84.59.234.31] helo=martin-debian-3.kaiser.cx)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1s96Lx-000hmm-1i;
	Mon, 20 May 2024 18:59:13 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] spi: imx: remove empty cleanup function
Date: Mon, 20 May 2024 18:59:06 +0200
Message-Id: <20240520165906.164906-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the empty spi_imx_cleanup function.

It's ok if a driver does not set the controller->cleanup pointer, the
caller does a NULL check.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/spi/spi-imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f4006c82f867..cf0cb52946d2 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1666,10 +1666,6 @@ static int spi_imx_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void spi_imx_cleanup(struct spi_device *spi)
-{
-}
-
 static int
 spi_imx_prepare_message(struct spi_controller *controller, struct spi_message *msg)
 {
@@ -1766,7 +1762,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	controller->transfer_one = spi_imx_transfer_one;
 	controller->setup = spi_imx_setup;
-	controller->cleanup = spi_imx_cleanup;
 	controller->prepare_message = spi_imx_prepare_message;
 	controller->unprepare_message = spi_imx_unprepare_message;
 	controller->target_abort = spi_imx_target_abort;
-- 
2.39.2


