Return-Path: <linux-spi+bounces-3443-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006190DABF
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB281F230B0
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCDC142652;
	Tue, 18 Jun 2024 17:34:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123D13B5B8
	for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2024 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732073; cv=none; b=Yj0WNraMu5MpK/2g6otcosvPIWZ/g136lLwOPaCwfca0lajwHX6ab2vMHfTLZKUaqgby3bZk2759NXWRjSORNWpNUvO9VRA5VNk4EEfyAnBi5M5Dm9ks09NWSvB/pXsu5DlWDbHX9CiI4DkcMXOQYxRYXs0es1AcKEUWcxgsL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732073; c=relaxed/simple;
	bh=elNphyW/ol4aozwHns160mjwIukNaGErNRGUXtOS99c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rSJ1OnQAqri8a+WR5wnIudEd5brEtXdV6Dxcj9/8EeH/2vAPxnI6Toc4/mIPbeBTyX7MfGCv9ifaJdRgMM3EDt4tZ+bnXa3TWgu5bARw0mKrhQ/RYcTHBOl6EpeF2Mt2cvcLPNbZqDf9uv7mRKnqH4jBAzjZ0bZaVoPeSsgptoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sJciz-0000gK-BJ
	for linux-spi@vger.kernel.org; Tue, 18 Jun 2024 19:34:29 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sJciy-003HLG-Ug
	for linux-spi@vger.kernel.org; Tue, 18 Jun 2024 19:34:28 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9CFAB2EBACC
	for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2024 17:34:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3D6032EBABA;
	Tue, 18 Jun 2024 17:34:24 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1c36f098;
	Tue, 18 Jun 2024 17:34:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 18 Jun 2024 19:34:18 +0200
Subject: [PATCH] spi: spi-imx: imx51: revert burst length calculation back
 to bits_per_word
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-spi-imx-fix-bustlength-v1-1-2053dd5fdf87@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIABnFcWYC/x2MSQqAMAwAvyI5G6jFrX5FPKiNGtAqjYpQ/LvF4
 8DMBBDyTAJNEsDTzcK7i5ClCYxL72ZCtpFBK52rMqtRDkbeHpz4weGScyU3nwuaSuWDnqxRpoA
 YH56i8Y/b7n0//gDa4WgAAAA=
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Stefan Moring <stefan.moring@technolution.nl>, 
 Benjamin Bigler <benjamin@bigler.one>, Carlos Song <carlos.song@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Adam Butcher <adam@jessamine.co.uk>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Stefan Bigler <linux@bigler.io>, Sebastian Reichel <sre@kernel.org>, 
 Thorsten Scherer <T.Scherer@eckelmann.de>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=3829; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=elNphyW/ol4aozwHns160mjwIukNaGErNRGUXtOS99c=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmccUcNxYqOSfc86+T5Y8lQ+0f4S+7ZiW2d0n2z
 PDvJ9XGwHuJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZnHFHAAKCRAoOKI+ei28
 b6CjCACD6kmrXgt2PL68SI8FmIL4q54HM2FQ3J4bstblZaBDzOQ9J69hA89VRBm6Ry++lpg3sb8
 poZyc6hYLa1NRXVNaNuO8TTULYKOfiBMDbOCBaRQrHMvXPzUnStw3zpUAXkdYqpmHZfvzKC0MGh
 lf0nCqZm6qyv0LZphvcbO7e8iqn1sPm0Ny+wiegUCrlUluEbNUO1v0V/lmqawzG/lIVNwSFpHZr
 IRdHoWRm5lpC+mPu28I8lWxq0olOKThEd7thbIb2MgKp4HQjFLuJIpYOP/5CmK0Td5/wQ4FqFBg
 +XzGq9PfHL8dHIjllzTEv2m40ojP248lZB0ulA13pQmaZ+eN
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The patch 15a6af94a277 ("spi: Increase imx51 ecspi burst length based
on transfer length") increased the burst length calculation in
mx51_ecspi_prepare_transfer() to be based on the transfer length.

This breaks HW CS + SPI_CS_WORD support which was added in
6e95b23a5b2d ("spi: imx: Implement support for CS_WORD") and transfers
with bits-per-word != 8, 16, 32.

SPI_CS_WORD means the CS should be toggled after each word. The
implementation in the imx-spi driver relies on the fact that the HW CS
is toggled automatically by the controller after each burst length
number of bits. Setting the burst length to the number of bits of the
_whole_ message breaks this use case.

Further the patch 15a6af94a277 ("spi: Increase imx51 ecspi burst
length based on transfer length") claims to optimize the transfers.
But even without this patch, on modern spi-imx controllers with
"dynamic_burst = true" (imx51, imx6 and newer), the transfers are
already optimized, i.e. the burst length is dynamically adjusted in
spi_imx_push() to avoid the pause between the SPI bursts. This has
been confirmed by a scope measurement on an imx6d.

Subsequent Patches tried to fix these and other problems:

- 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of assuming 8-bits")
- e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when using dma")
- c712c05e46c8 ("spi: imx: fix the burst length at DMA mode and CPU mode")
- cf6d79a0f576 ("spi: spi-imx: fix off-by-one in mx51 CPU mode burst length")

but the HW CS + SPI_CS_WORD use case is still broken.

To fix the problems revert the burst size calculation in
mx51_ecspi_prepare_transfer() back to the original form, before
15a6af94a277 ("spi: Increase imx51 ecspi burst length based on
transfer length") was applied.

Cc: Stefan Moring <stefan.moring@technolution.nl>
Cc: Stefan Bigler <linux@bigler.io>
Cc: Clark Wang <xiaoning.wang@nxp.com>
Cc: Carlos Song <carlos.song@nxp.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Thorsten Scherer <T.Scherer@eckelmann.de>
Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on transfer length")
Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of assuming 8-bits")
Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when using dma")
Fixes: c712c05e46c8 ("spi: imx: fix the burst length at DMA mode and CPU mode")
Fixes: cf6d79a0f576 ("spi: spi-imx: fix off-by-one in mx51 CPU mode burst length")
Link: https://lore.kernel.org/all/20240618-oxpecker-of-ideal-mastery-db59f8-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-imx.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f4006c82f867..33164ebdb583 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -660,18 +660,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 		ctrl |= (spi_imx->target_burst * 8 - 1)
 			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	else {
-		if (spi_imx->usedma) {
-			ctrl |= (spi_imx->bits_per_word - 1)
-				<< MX51_ECSPI_CTRL_BL_OFFSET;
-		} else {
-			if (spi_imx->count >= MX51_ECSPI_CTRL_MAX_BURST)
-				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
-						<< MX51_ECSPI_CTRL_BL_OFFSET;
-			else
-				ctrl |= (spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
-						BITS_PER_BYTE) * spi_imx->bits_per_word - 1)
-						<< MX51_ECSPI_CTRL_BL_OFFSET;
-		}
+		ctrl |= (spi_imx->bits_per_word - 1)
+			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	}
 
 	/* set clock speed */

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240618-spi-imx-fix-bustlength-9704b2fd9095

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



