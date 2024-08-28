Return-Path: <linux-spi+bounces-4343-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B5961FD1
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0507A1F21E0A
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEB414831F;
	Wed, 28 Aug 2024 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gWlLXTww"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075912CD8B;
	Wed, 28 Aug 2024 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826703; cv=none; b=Wgfx9NCOCqsJES7ih0YozpXpxoQwGxQ50JDzI8MEEyeoJIDBPR9AYsu2CwvPZkU1FsHw5k8h1S1iRf9W4GW/YKpWwzaevfNCZtxMeYA/YwhYYxUB2xQV9WxdQMHCBArBW2JgEfn4svDHjJiHUzRiUIW1kISeRni1bWtt/jCMHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826703; c=relaxed/simple;
	bh=706jf2NBauU+HYna34mCoZMrCu2OyinSMb5+pw/nikM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOdaNdWue3dbmztmsMOFoGWdhJUV0RrNoQ2J9XQSH/9QLuFzskkVOMuzva/CAwwWZTg1bjTDj9iZ6Jat1vUTrxrqZQn6dRTxTbBV23MSIHe2l6L8mSMkJWhWb3wmskfULEFcF1liDNoJKaF/ATCOTGv2Kws1U7BBM+LSPSWUlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gWlLXTww; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 36BD640003;
	Wed, 28 Aug 2024 06:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724826693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kDGEpNIBtaj4Rf31gNnJB1VhzNmuEVn8ETptfVZFZU0=;
	b=gWlLXTwwWjWWfvnthSlYOKfAoUjSlANxazUeNAlT325Or72QP69rEDSeKCyFS1hiP38fWN
	Qt2x69M+yNSekB8M6i9JQYQBO4cJnXeIdH+DFoWKtX1aAcF8nXi4oK+YXnlcLaXui6udTL
	Wmx4w1Ec3FgMbgdtwZUCS0pq1QlCtYsq3eIbQn2UTHGRa6suejR073XrNNtl8SmxmhSCpR
	0bKn8luyjpiWzA3oablpdBiIaNLui3/erPN0+rHcPYXJ9wVddPr5IqK/bkkM0JnxjCpiAg
	WKdJ5/jKwRzSCVCdiq1ouC8IHXuqiQ0DrtW/2QD1asA1R5mxuG4ydDNh2STR8A==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH] spi: davinci: Adapt transfer's timeout to transfer's length
Date: Wed, 28 Aug 2024 08:31:31 +0200
Message-ID: <20240828063131.10507-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The timeout used when waiting for transfer's completion is always set to
HZ. This isn't enough if a transfer is too large or if the bus speed is
too low.

Use the bus speed and the transfer length to calculate an appropriate
timeout

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/spi/spi-davinci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f7e8b5efa50e..ad26c8409733 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -570,6 +570,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	u32 errors = 0;
 	struct davinci_spi_config *spicfg;
 	struct davinci_spi_platform_data *pdata;
+	unsigned long timeout;
 
 	dspi = spi_controller_get_devdata(spi->controller);
 	pdata = &dspi->pdata;
@@ -661,7 +662,12 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	/* Wait for the transfer to complete */
 	if (spicfg->io_type != SPI_IO_TYPE_POLL) {
-		if (wait_for_completion_timeout(&dspi->done, HZ) == 0)
+		timeout = DIV_ROUND_UP(t->speed_hz, MSEC_PER_SEC);
+		timeout = DIV_ROUND_UP(t->len * 8, timeout);
+		/* Assume we are at most 2x slower than the nominal bus speed */
+		timeout = 2 * msecs_to_jiffies(timeout);
+
+		if (wait_for_completion_timeout(&dspi->done, timeout) == 0)
 			errors = SPIFLG_TIMEOUT_MASK;
 	} else {
 		while (dspi->rcount > 0 || dspi->wcount > 0) {
-- 
2.45.0


