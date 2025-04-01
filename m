Return-Path: <linux-spi+bounces-7386-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E49A784CA
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 00:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC3116A7AB
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 22:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9979212FA7;
	Tue,  1 Apr 2025 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WAGbrPll"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA01E51EE;
	Tue,  1 Apr 2025 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743547390; cv=none; b=bP+zZXxDowHyc0Tax87wMZtV/zsws7Qdimuc4e5/YghZOUaldastl+wDg5DWL7snUv6SbYI5nk5C0TkCVtkIhMlduJOKo8pV4vxXquqaBnn/vpReFaJs2c/ZCDjUoMfr6i+MeLfDtWpwTW44VgWXyViI/xALDSSZGmJEU4/7Q0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743547390; c=relaxed/simple;
	bh=OXgiqBm85z4tWCR8EwZh57yh1Zl0z2cB7ncr9Tk25Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVGW9Nt+7Gz6BhHRddIoH7OkUOcv8rcfscHTF3HaONkEylk1xpN1q1T+Sh4EMBNICTHAYGQRn067+RRkhzbDMKUrypK7tByUa/ZZcVfPDaZXu3vakpdfh/ae9cXlwrgke6vFfHjTcniZs7ItHupXtJztEFHAtozBfvNwCqaSJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WAGbrPll; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4AFEAC000928;
	Tue,  1 Apr 2025 15:43:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4AFEAC000928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1743547382;
	bh=OXgiqBm85z4tWCR8EwZh57yh1Zl0z2cB7ncr9Tk25Ck=;
	h=From:To:Cc:Subject:Date:From;
	b=WAGbrPll6tu8Nrubq8NZTYHf6nlQe24BbQgsn3+SE01sXIHLq4UgXsQ4wNCSrJzEC
	 C8r/95ORDBo6+P5wIg+0TZtjEaoA8fwLT+iJ3ZnlLT2+mGHILQ+IMYu4qDASy9kZpl
	 Sv3XafIvtkJB61xlQrpaEqmMUOVQUPoWLXQzGG/E=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 1FEB44002F44;
	Tue,  1 Apr 2025 18:43:01 -0400 (EDT)
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
Subject: [PATCH] spi: bcm2835: Do not call gpiod_put() on invalid descriptor
Date: Tue,  1 Apr 2025 15:42:38 -0700
Message-Id: <20250401224238.2854256-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we are unable to lookup the chip-select GPIO, the error path will
call bcm2835_spi_cleanup() which unconditionally calls gpiod_put() on
the cs->gpio variable which we just determined was invalid.

Fixes: 21f252cd29f0 ("spi: bcm2835: reduce the abuse of the GPIO API")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/spi/spi-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e1b9b1235787..a5d621b94d5e 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1162,7 +1162,8 @@ static void bcm2835_spi_cleanup(struct spi_device *spi)
 				 sizeof(u32),
 				 DMA_TO_DEVICE);
 
-	gpiod_put(bs->cs_gpio);
+	if (!IS_ERR(bs->cs_gpio))
+		gpiod_put(bs->cs_gpio);
 	spi_set_csgpiod(spi, 0, NULL);
 
 	kfree(target);
-- 
2.34.1


