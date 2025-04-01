Return-Path: <linux-spi+bounces-7387-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858C6A7854A
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 01:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B7A1891477
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 23:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807332153C5;
	Tue,  1 Apr 2025 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S1a/Ccmd"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50A217647;
	Tue,  1 Apr 2025 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743550578; cv=none; b=ni4UR6LgWam9VarFZioXAzOmimqqBH7R3g50jJHTzDFl6j6VY+S2U0YA/JCWUY9xNMhIPB49AP4YHoSCASY5MXjqYgMyBkcc1powha4DH/1C4rEHm+j3m+YHugfOZ2FLEQvZWwdriKxSuNeSZJ5KwUtkt8JDY9H+x/IVnPujBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743550578; c=relaxed/simple;
	bh=mAjA0JnWOIbx2Fv6Om83zFHlYcQyGvwfkcmAcNYO5Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=njfYKWInXCzQx2xZRQpzGGzd0Zt3syOO13PMdraGtumBRdHItkZJSzFup8k+Rj/+S7NV14NQw011nwWtS2QhyhMsaVzt296Rg1N9EnYNgC8+akjFPCcGBKUvhjaQcYRt3j/6L9aZeqcSrMWjRxIhTXFs07v5y1Hj43gzyFTrKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S1a/Ccmd; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7CD26C0025A2;
	Tue,  1 Apr 2025 16:36:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7CD26C0025A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1743550570;
	bh=mAjA0JnWOIbx2Fv6Om83zFHlYcQyGvwfkcmAcNYO5Lk=;
	h=From:To:Cc:Subject:Date:From;
	b=S1a/Ccmd4KJy/A1kCM1cUD9k2tPpQYur3/oCQJlDeQLeh8q6UrtJbBZUE3cGc5YPG
	 79qMq0NFieuhe/iZGSNj35jknX1H45zb4ayyLpjzeHU+ePsDctdC+kuRKQMNREaT4x
	 P5e9HsfDKaFhnHbgaz2koP4Kg69yiCaHnqiLpvNc=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 8AB524002F44;
	Tue,  1 Apr 2025 19:36:09 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH] spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent
Date: Tue,  1 Apr 2025 16:36:03 -0700
Message-Id: <20250401233603.2938955-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lookup table forces the use of the "pinctrl-bcm2835" GPIO chip
provider and essentially assumes that there is going to be such a
provider, and if not, we will fail to set-up the SPI device.

While this is true on Raspberry Pi based systems (2835/36/37, 2711,
2712), this is not true on 7712/77122 Broadcom STB systems which use the
SPI driver, but not the GPIO driver.

There used to be an early check:

       chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
       if (!chip)
               return 0;

which would accomplish that nicely, bring something similar back by
checking for the compatible strings matched by the pinctrl-bcm2835.c
driver, if there is no Device Tree node matching those compatible
strings, then we won't find any GPIO provider registered by the
"pinctrl-bcm2835" driver.

Fixes: 21f252cd29f0 ("spi: bcm2835: reduce the abuse of the GPIO API")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/spi/spi-bcm2835.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index a5d621b94d5e..5926e004d9a6 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1226,7 +1226,12 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
 	struct gpiod_lookup_table *lookup __free(kfree) = NULL;
-	int ret;
+	const char *pinctrl_compats[] = {
+		"brcm,bcm2835-gpio",
+		"brcm,bcm2711-gpio",
+		"brcm,bcm7211-gpio",
+	};
+	int ret, i;
 	u32 cs;
 
 	if (!target) {
@@ -1291,6 +1296,14 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		goto err_cleanup;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(pinctrl_compats); i++) {
+		if (of_find_compatible_node(NULL, NULL, pinctrl_compats[i]))
+			break;
+	}
+
+	if (i == ARRAY_SIZE(pinctrl_compats))
+		return 0;
+
 	/*
 	 * TODO: The code below is a slightly better alternative to the utter
 	 * abuse of the GPIO API that I found here before. It creates a
-- 
2.34.1


