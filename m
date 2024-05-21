Return-Path: <linux-spi+bounces-2967-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D98CACB0
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 12:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620901C21A29
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030DA73539;
	Tue, 21 May 2024 10:52:56 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CCB73186
	for <linux-spi@vger.kernel.org>; Tue, 21 May 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288775; cv=none; b=twIGCsnom4vCfBkClODcadqXEe3NJSjOejnJUnvgRs6Vb1tC/f4+qvn1z52c58Z4vqm3QRU24fey9RTca1+Ys/URDIn6Y+kXuZrMCYdUZoT4XWXl0FMdejJIMRKyeZDNPdxqk1z0Q3dOQtGGVFAsuYRBEpvXrDMhJPHGxEYyFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288775; c=relaxed/simple;
	bh=MKRBktUB7DJPxWyPs7B+40mEZWemSDrhbFQtQ2v8A6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UvugfJ7hmI+yTwGTCpoI95Gl8Z4nq7l+rCkTBeY9lKPoUlxmTJOx6AxXbjdieiJjQbOju3nmHYjVfRU6CPmBiujykTDBW3K11w4nd//bqsFF75KPueU4SAXpYEzGENxvTTpaNHXzLmTWgAf2Us6jRBD1Yu7Z0NhrpYN5lckw+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9N6u-0006ZR-8F; Tue, 21 May 2024 12:52:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9N6s-002NUk-LM; Tue, 21 May 2024 12:52:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9N6s-009OvQ-1q;
	Tue, 21 May 2024 12:52:46 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Mark Brown <broonie@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	kernel@pengutronix.de
Subject: [PATCH] spi: stm32: Don't warn about spurious interrupts
Date: Tue, 21 May 2024 12:52:42 +0200
Message-ID: <20240521105241.62400-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MKRBktUB7DJPxWyPs7B+40mEZWemSDrhbFQtQ2v8A6I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmTHz6zhFHHgveD+aiwQkOcd8uGhhFWHBRcPgKG hrOQ/nmHr6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZkx8+gAKCRCPgPtYfRL+ TlH1B/9VEF5hMtrrQvxbQsv5RD3zIGhRyjRVkMWcWUqaIE5q14SaJ2SdPvqhR2FF3r4dT1jQWKx hA7rZepbO8863mVj3kcLeyvF72w//HCtLLgqr/F7tX3mPHkE18MY0Ee9cmkRPSP8tZBx8FCUUfu 7prPYFZzGnqvQfIp6lmSkrqKGVhTGeZoSvZEhC6796r2yPYa9oyl+EChk/aQehhlhzvlPYXbwz+ geRoZRdNjacZDDot+wAkVsECEsFd1+M2nnDdQBxJ2ohjt8Z9nSr7S5MwMemCMWH1YrB56qSWneA e8vTKF7OHN14waTBpDKTGLLIR0B9nabSRRkkKjAInj7mCDed
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The dev_warn to notify about a spurious interrupt was introduced with
the reasoning that these are unexpected. However spurious interrupts
tend to trigger continously and the error message on the serial console
prevents that the core's detection of spurious interrupts kicks in
(which disables the irq) and just floods the console.

Fixes: c64e7efe46b7 ("spi: stm32: make spurious and overrun interrupts visible")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4a68abcdcc35..21b79dcd8399 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1055,7 +1055,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		mask |= STM32H7_SPI_SR_TXP | STM32H7_SPI_SR_RXP;
 
 	if (!(sr & mask)) {
-		dev_warn(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
+		dev_vdbg(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
 			 sr, ier);
 		spin_unlock_irqrestore(&spi->lock, flags);
 		return IRQ_NONE;
-- 
2.43.0


