Return-Path: <linux-spi+bounces-3545-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C4591436E
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DA8284D80
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508BA18AE4;
	Mon, 24 Jun 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I3rsCYgT"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E745F9D9;
	Mon, 24 Jun 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213479; cv=none; b=k3kBptwSkFj1gIYhAEsn/G52m3BESmSNL8IlpRqFA0CHukl8fLwVWjyZVEGiqtliNHSClkpGjQ611LtCnYjjn9oLukCRvI2q+G2WOH7dygLwKOmvzc3aM8bRLUMaDBpb+YkFOV52fSmSa7IUimMJUZgaQJay6vLN1c8lrNnbzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213479; c=relaxed/simple;
	bh=6oS5SW09U8iQI6kzm5UHdHG/LGzrzqRPipDYAs+0mRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pc1pdKJWuXIBArXiUgy0LPzOM7+mEJpeZkL/gCqlbqfPc2o/N9jqsA80Mw86xKdjUyiBgjl4nnLhGF0y6PYSwEK4H3K726e079B/n0c5w/xKpr2UhnJDbSmRhM38aqz0l4fUu3IoxHyskKgjjAXXjVyKKmI46meAwsoHTqQrjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I3rsCYgT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 40086FF80A;
	Mon, 24 Jun 2024 07:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719213468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o8kSx2joD+PfTxvQH91rVyfBDjegpaIQB2A5DqXaBqI=;
	b=I3rsCYgTACtO0hu4hIlg+9neNw7RITs6XGjwsQOGBCTS3KAQPsDmjtUdYVqImJM13KpsF/
	RGJujrYd8CV8EQFaPWEND7tNJtpchOVleEiSKXTPX9Xucs90AB/UFXXHLy1O6VCHBnO3D1
	YlQAcpB82prKFHk8pdq3jp5wcX2uioVIxv3sPVyyhVNPw6nnfLSlUWfE9qNvDFVHq/IqU4
	w6B45XwkT1iPc6umNDNPZxute9ApB8ih68/OAbi24ZJ9NoOk27AmyV+hckg+delXcxMs6u
	rQT/jIaaCulIx6LOWpu0BafIOEwwPBXZ6Uu3X25pIsY19LBgxpG61EbzRdiDFg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH] spi: davinci: Unset POWERDOWN bit when releasing resources
Date: Mon, 24 Jun 2024 09:17:45 +0200
Message-ID: <20240624071745.17409-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

On the OMAPL138, the SPI reference clock is provided by the Power and
Sleep Controller (PSC). The PSC's datasheet says that 'some peripherals
have special programming requirements and additional recommended steps
you must take before you can invoke the PSC module state transition'. I
didn't find more details in documentation but it appears that PSC needs
the SPI to clear the POWERDOWN bit before disabling the clock. Indeed,
when this bit is set, the PSC gets stuck in transitions from enable to
disable state.

Clear the POWERDOWN bit when releasing driver's resources

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
Hi,

I ran into this bug by enabling the 'cs-gpio' property. It causes the
probe to fail at first with -EPROBE_DEFER because the gpio provider is
not ready. So the clock gets disabled. In the clock controller's driver
(drivers/clk/davinci/psc.c) the clock_disable() calls a
regmap_read_poll_timeout() with an infinite timeout. This poll() polls
a transition bit status that never goes down so we end stuck in the
middle of the boot sequence.

 drivers/spi/spi-davinci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index be3998104bfb..f7e8b5efa50e 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -984,6 +984,9 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	return ret;
 
 free_dma:
+	/* This bit needs to be cleared to disable dpsi->clk */
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
@@ -1013,6 +1016,9 @@ static void davinci_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&dspi->bitbang);
 
+	/* This bit needs to be cleared to disable dpsi->clk */
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
-- 
2.45.0


