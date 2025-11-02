Return-Path: <linux-spi+bounces-10968-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E565C295C7
	for <lists+linux-spi@lfdr.de>; Sun, 02 Nov 2025 20:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C58C4E2416
	for <lists+linux-spi@lfdr.de>; Sun,  2 Nov 2025 19:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF902836F;
	Sun,  2 Nov 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0ZVuVhp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA252EACD;
	Sun,  2 Nov 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110565; cv=none; b=lMFj7xEYmdTbm3EYd3Yvkmq8WiUFb5wd8WFz4A8rhCN0SOtxlDgyLfUak7roZP1BF+Dm4aP6AH+vefQFo7SMDz6yb+M+BJv0FODVcBh54XWSmd8UD9IYvWHyOapyIxLHilM2uSJLAT6N7e+595A6QU/sqR/4voleYlIXO4/U4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110565; c=relaxed/simple;
	bh=hSDa3Ob7t/jjRsVUFtoLq051kKlgUvm3l0kJPGaxjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q40bEtRn2GByZbxJ/MoFM4FA+TAjhsuOSgy8VnhDiwDvk/NyTO2qhUue5GOq4yiMEXfI5wvfUn7l9o4lRJlvb9OhDPRyzfPRrshMoBsWreadPORj+k9zfP+Czp04P129YTJW3FkusKJZXKBJV+OaJi/JzZpxF1CgvXfeJxxeoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0ZVuVhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F7DC4CEF7;
	Sun,  2 Nov 2025 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762110565;
	bh=hSDa3Ob7t/jjRsVUFtoLq051kKlgUvm3l0kJPGaxjQo=;
	h=From:To:Cc:Subject:Date:From;
	b=d0ZVuVhpR2YhaCWXArsCPe5Hcfj1EuIKUP4Tlw34oYwvGYsVTYqbyN2wv7HcJqUE/
	 fNyMKJO/jgTWoLLxada70CKeyrz4drLB54ALSRTK8Eoru834MgC1CIRf0jn9p3cajp
	 V0ee78CoCLtKARdvjTvzZinttjxaqGamdsU4JGxYqqKmrufy8+AND0mpokgE5bLP6g
	 AtPOnvSStb3k79JVt3q+8cWTIwQ9LLZhN0ZUGWC08weNsG4uaUVRsBURImOSZzqWCB
	 amSgxI9nUtbvbeJd7nTez7kOquPBnCIdsTPZjYyQH5p+OfRYJqk/VJx42hcrVXmIQI
	 kwnJiWzmVLEig==
From: Hans de Goede <hansg@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
Date: Sun,  2 Nov 2025 20:09:21 +0100
Message-ID: <20251102190921.30068-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit d24cfee7f63d ("spi: Fix acpi deferred irq probe"), the
acpi_dev_gpio_irq_get() call gets delayed till spi_probe() is called
on the SPI device.

If there is no driver for the SPI device then the move to spi_probe()
results in acpi_dev_gpio_irq_get() never getting called. This may
cause problems by leaving the GPIO pin floating because this call is
responsible for setting up the GPIO pin direction and/or bias according
to the values from the ACPI tables.

Re-add the removed acpi_dev_gpio_irq_get() in acpi_register_spi_device()
to ensure the GPIO pin is always correctly setup, while keeping the
acpi_dev_gpio_irq_get() call added to spi_probe() to deal with
-EPROBE_DEFER returns caused by the GPIO controller not having a driver
yet.

Link: https://bbs.archlinux.org/viewtopic.php?id=302348
Fixes: d24cfee7f63d ("spi: Fix acpi deferred irq probe")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/spi/spi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2e0647a06890..8588e8562220 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2851,6 +2851,16 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	acpi_set_modalias(adev, acpi_device_hid(adev), spi->modalias,
 			  sizeof(spi->modalias));
 
+	/*
+	 * This gets re-tried in spi_probe() for -EPROBE_DEFER handling in case
+	 * the GPIO controller does not have a driver yet. This needs to be done
+	 * here too, because this call sets the GPIO direction and/or bias.
+	 * Setting these needs to be done even if there is no driver, in which
+	 * case spi_probe() will never get called.
+	 */
+	if (spi->irq < 0)
+		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
+
 	acpi_device_set_enumerated(adev);
 
 	adev->power.flags.ignore_parent = true;
-- 
2.51.1


