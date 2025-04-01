Return-Path: <linux-spi+bounces-7381-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C1EA77C8F
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 15:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FE51890794
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF9A1EF37C;
	Tue,  1 Apr 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZAT7Hhw+"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2D20485F
	for <linux-spi@vger.kernel.org>; Tue,  1 Apr 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515283; cv=none; b=Y00kh54SosBPDJrC6z59mf/76ZPQKFk2Z4P7S7ryThwEIWrxX47VRQYZ0wwd3wTuZVLIWDo9MAkuEQaus+ioEuYe+sCBpJpkU3F7J2p8lZa0BYRS/CQcsIH03FXEHVLx/6PUbW8aAErBmlm/b7cTHv389gmr8q1BiSNxF9MVmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515283; c=relaxed/simple;
	bh=/ym8cvjuHsb1Ds08H5CNRdklN3y/CltZnxzPKatc2N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYrwDibR7bhfoZI2DpluuWyFGwaVTMerCuRedtyvHBg0k+8dzD5VhpCI6QRYtF9lEz/JY/5B0xsibZAlf/S8SDL7ZwYxWvjprTl2lxoVpRljBsIVKO2YYAmllTMZbEJ7HpqfugtL3//zlZNGmB8ddJjEbWF65YQI5dRLNqZauoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZAT7Hhw+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C57AA2047D;
	Tue,  1 Apr 2025 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743515278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/jNLk2YzhRD5e1B6AbUom+9W3W3S4BlqDMiej6xeu2I=;
	b=ZAT7Hhw+IvJW2BFSIWaajOfObD+xAk/hRKQFkPiXouSah8yPZuCxEl/B9GyoMB69pO198D
	ZQcF4loIpLQD8iqb/kDFHAjPBeHr+JBXjn7msHVAyb0RzI5qwyYiDDtET23ipKB0SQBLmy
	duEnOv5nb49mXzJdSRnztAki6C8V3L4oNq9ibB7XXTXASCdUa0XymZryhZ6RJWedWldvLD
	h0BsRjoJEDf4nhQw+s83OKIFTmErTFLyU0ieHB9HBhWy18O73JaM/i3oI9ovIfIf3aIANE
	cDnUrElcWKP4OPooPxsw03q1lqXlhJuQb6nO2xQS5+YwvKJ6qBtI1ofRmWesxw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Steam Lin <stlin2@winbond.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2] spi: cadence-qspi: revert "Improve spi memory performance"
Date: Tue,  1 Apr 2025 15:47:47 +0200
Message-ID: <20250401134748.242846-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeetfeduleefjeffheevleeggfdtvdduhfdugeeuieejveejiedvhfdugfettdehnecukfhppeelvddrudekgedruddutddrudelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddutddrudelfedphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehsthhlihhnvdesfihinhgsohhnu
 gdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

During the v6.14-rc cycles, there has been an issue with syscons which
prevented TI chipid controller to probe, itself preventing the only DMA
engine on AM62A with the memcpy capability to probe, which is needed for
the SPI controller to work in its most efficient configuration.

The SPI controller on AM62A can be used in DAC and INDAC mode, which are
some kind of direct mapping vs. CPU-controlled SPI operations,
respectively. However, because of hardware constraints (some kind of
request line not being driven), INDAC mode cannot leverage DMA without
risking to underflow the SPI FIFO. This mode costs a lot of CPU
cycles. On the other side however, DAC mode can be used with and without
DMA support, but in practice, DMA transfers are way more efficient
because of the burst capabilities that the CPU does not have.

As a result, in terms of read throughput, using a Winbond chip in 1-8-8
SDR mode, we get:
- 3.5MiB/s in DAC mode without DMA
- 9.0MiB/s in INDAC mode (CPU more busy)
- a fluctuating 9 to 12MiB/s in DAC mode with DMA (a constant 14.5MiB/s
  without CPUfreq)

The reason for the patch that is being reverted is that because of the
syscon issue, we were using a very un-efficient DAC configuration (no
DMA), but since:

commit 5728c92ae112 ("mfd: syscon: Restore device_node_to_regmap() for non-syscon nodes")

the probing of the DMA controller has been fixed, and the performances are
back to normal, so we can safely revert this commit.

This is a revert of:
commit cce2200dacd6 ("spi: cadence-qspi: Improve spi memory performance")

Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v2:
- Fix the commit hash.
- Fix the commit title.
- Fix the wording around the commit being reverted.
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 559fbdfbd9f7..c90462783b3f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2073,7 +2073,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_NEEDS_WR_DELAY,
 };
 
 static const struct cqspi_driver_platdata intel_lgm_qspi = {
-- 
2.48.1


