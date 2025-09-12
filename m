Return-Path: <linux-spi+bounces-10002-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE5B5438B
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0163B1DA0
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C996F2BDC16;
	Fri, 12 Sep 2025 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WCMsg6Dw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D229C327
	for <linux-spi@vger.kernel.org>; Fri, 12 Sep 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661042; cv=none; b=KZ8PEGFvxnIbIP0uf2bvEYF8aAJa4J3lXf1CNu+OSHWgOoxpzuEWSutUqkpqQ+0mPkwwU+7dk0twUbB5Vj1yzO+aYAzEjWiOEz9Rve19xGT+MQ26tMU5c6RuNEE013K5KjPlVzGSWIN/IgODAMVLeOy5N19HvVLhVsUf4BuHYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661042; c=relaxed/simple;
	bh=eDNTP88Ukeq1W+ShdgUMNqfP16gb+eG5BnK7igyhDdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GJ9j/xqXpS2m+QVMoD3XiXIP30X5ykptbamBrSzzDTDwBhYozCR2sIvE63tXkZ+PpN/Urpr3/qKiP5WE45PMewPD+J9nmMb/DqC8WLgcG7AnGb4HNyTwz9cdEZ4k7S+3lS9fhfcbFKvs2V/yhMuGfVzBIhQmgWiYt9VtteBYA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WCMsg6Dw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6539A1A0DAD
	for <linux-spi@vger.kernel.org>; Fri, 12 Sep 2025 07:10:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3CEC660638;
	Fri, 12 Sep 2025 07:10:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32F4B102F28B1;
	Fri, 12 Sep 2025 09:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757661035; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=iW2aMY9sAB8aU6zVlyiI46o4UAd6hKvhx3b7UgU75NU=;
	b=WCMsg6Dww5glGk/oEt2b0DF64BAN407Zg6P+6Sixvc4xvPux8stx6kkdHCnXHmImh/Plnq
	C+dXoanINaUN54H7+d/yxaqI2lb0w/x7nfwaHERL1gmfBf/hYtScVjHqIa5wB+hwg2Zbej
	WJV95lSI9eGBE1UVi3DA3IduNux47L68RS7vLdPRw9AAo0LMkkn+s+mMMOtnPTTKei3quR
	dl3Rl0ew3JKKtty0XmPJ0xNuiIxTwvLtxggTKi+yZcjjMHFgXUmg4sCH116PMyGl375YoM
	EzRKqVhiFgAHPlZFJt2+vBhtETQYajYzhyY5KTS7Ic5bbeh2lsH9zg5/uVOr8Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 12 Sep 2025 09:08:58 +0200
Subject: [PATCH] spi: omap2-mcspi: drive SPI_CLK on transfer_setup()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-omap-spi-fix-v1-1-f925b0d27ede@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAnHw2gC/x2MQQqAIBAAvyJ7bkFFg/pKdNhsqz2kohBB9Pek4
 wzMPFC5CFcY1QOFL6mSYgPTKQgHxZ1R1sZgtfV6MAbTSRlrFtzkRlq24HvtnKMeWpILN/3vpvl
 9P3upkA9eAAAA
X-Change-ID: 20250911-omap-spi-fix-abfc560444a6
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

If the cached contents of the CHCONF register doesn't have the FORCE bit
set, the setup() function failed to set the relevant idle state of the
SPI_CLK pin. In such case, the SPI_CLK's idle state is reached later with
set_cs(), but it's too late for the first SPI transfer which fails since
the CS is asserted before the clock reaching its idle state.

Add a first write in setup() that always sets the FORCE bit.
Keep the current write afterwards to ensure the FORCE bit won't stay in
the cached contents of the CHCONF register unless it's intended.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Hi all,

I ran into this issue with a mode 3 SPI device. When the omap2-mcspi
driver probes, it sets mode 0 so the CLK is down. Then when the mode 3
SPI device probes, it asks for mode 3 but the clock doesn't go up.
Afterwards, when the first transfer occurs, the CS is asserted
before the clock actually reaches it's high state. This is interpreted
as a clock rising edge by the SPI device that samples one 'fake' bit
making this first transfer fail.
---
 drivers/spi/spi-omap2-mcspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 6dc58a30804a12d16295a7ffc2edb192e6cc4a54..69c2e9d9be3c380327e26f94e82e05e6357f5384 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -988,6 +988,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	else
 		l &= ~OMAP2_MCSPI_CHCONF_PHA;
 
+	mcspi_write_chconf0(spi, l | OMAP2_MCSPI_CHCONF_FORCE);
 	mcspi_write_chconf0(spi, l);
 
 	cs->mode = spi->mode;

---
base-commit: 31623e6ce46bcdce751c0d242fbb1502746d1a7c
change-id: 20250911-omap-spi-fix-abfc560444a6

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


