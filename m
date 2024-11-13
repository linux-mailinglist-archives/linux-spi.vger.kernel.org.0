Return-Path: <linux-spi+bounces-5693-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BDE9C6F29
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 13:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6188B2386F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515ED1FF046;
	Wed, 13 Nov 2024 12:24:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937B1F8906
	for <linux-spi@vger.kernel.org>; Wed, 13 Nov 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500691; cv=none; b=IhT2UCziy9TSzEnKAM3g3y2ppKj8EccPJHT8VMq8uC/fyxvoW8gm24/0amt7oDc1r6lMj4yKGk1SZ1SDFhQ7T/L/lIbNccqgHc2dXpBbDcSwU1YWzusC5nb80186NCXdrQbzUJ6kuzrcaCbtDFBgH/A9kc88/6Cbx+w9YroAn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500691; c=relaxed/simple;
	bh=tZGNi/z9iX3qW1qh+hyrUffDenpNLquRG7rp41ALlkw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bJWVo/smkupEm6BDxERowGlL04tnWr251hcLiMvG/oqbCTYUjlrqUTSlaKUgQcGHDANYrp1O4jLsWT+ONwETJPZfVDF3mQD13Gsy1ZlE58q7Xo8uCsq4wpn9O/LBiaDZWxUDLhhHLHgG8FzU0fiUohXhuw+zO8m6RghzcE2Kz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1tBCKg-0004eO-WF; Wed, 13 Nov 2024 13:18:51 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v2 0/2] spi: imx: support word delay in ecspi
Date: Wed, 13 Nov 2024 13:18:30 +0100
Message-Id: <20241113-imx-spi-word-delay-v2-0-2b65b737bf29@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABaZNGcC/22NQQ6CMBBFr0Jm7ZhpQ8C68h6GBWkHmERb0iJCC
 He34tble8l/f4PEUTjBtdgg8ixJgs+gTwXYofU9o7jMoEmXisigPBdMo+A7RIeOH+2KWjlLqiN
 zsRbycIzcyXJE703mQdIU4np8zOprfzlF9b/crJBQt6YyWpWuNtVtZN+/phi8LGfH0Oz7/gEdz
 Rl3uQAAAA==
X-Change-ID: 20241009-imx-spi-word-delay-21dc01f098cc
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=tZGNi/z9iX3qW1qh+hyrUffDenpNLquRG7rp41ALlkw=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYkg3malp7Kn/nLHILMjk/NSINDtPp3mZxt8f/9jnYPBuv
 cDMrD2sHaUsDGIcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgIm4nGdkeLZGXa43QKxlmtbq
 lKSP8YuWXT4rMbOYq3NyQmpE0pWCBwz/vU+2TzLQ9zl/88avjmhLs8PTI6dtFp+zSWfB2gOejlf
 DOAA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The i.MX SPI controller supports inserting a configurable delay between
subsequent words, which is needed for some slower devices that couldn't
keep up otherwise.

This patch series introduces support for the word delay parameters for
i.MX51 onwards.

The SPI clock (CSRC=0) was chosen as the clock source over the also
available 32.768 KHz Low-Frequency Reference Clock (CSRC=1). The sample
period control bits (SAMPLE_PERIOD) are set to the selected word delay
converted to SPI clock cycles. A deviation from the requested number of
wait cycles and the actual word delay was observed via both software
timings and oscilloscope measurements and accounted for.

The Chip Select Delay Control bits in the Sample Period Control Register
remain zero.

Behaviour on i.MX35 and earlier, where the CSPI interface is used,
remains unchanged.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Changes in v2:
- Remove accidentally added CCs
- spi-imx.c: Add missing includes, Rb kernel test robot
- Link to v1: https://lore.kernel.org/r/20241107-imx-spi-word-delay-v1-0-2a969214d796@pengutronix.de

---
Jonas Rebmann (2):
      spi: imx: pass struct spi_transfer to prepare_transfer()
      spi: imx: support word delay

 drivers/spi/spi-imx.c | 108 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 16 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241009-imx-spi-word-delay-21dc01f098cc

Best regards,
-- 
Jonas Rebmann <jre@pengutronix.de>


