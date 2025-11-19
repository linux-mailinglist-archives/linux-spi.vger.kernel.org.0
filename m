Return-Path: <linux-spi+bounces-11289-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A5C6D9AB
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0137E2DA1A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E793358DB;
	Wed, 19 Nov 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qqQm/6ob"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7A3358C2
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543434; cv=none; b=lRdFk16nllT/MWrfaiqu6HmNlUC4a2uVlvr4VPkaHy1jc9gpizqGyFEaBa0psLpNIWK9GPEUoJQjwGZc8Kiz9egPcmjLZbnvC1tCJwLw/IgXkN3pLg/T6AftJrEnNhLFX3Rih14TlKyG5fWzrzGvrrtQFfeBZOA0kCAH2AFAnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543434; c=relaxed/simple;
	bh=4zqRWKe6A91rsanLN+R7KRDQ2S2tcRWB++5yv/JjcNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TfOkq1iTY4RryG2xKHlzoXQLjCWMkY7C/9hpTOpJDyZ341JFldfKWs6IXdlVuQx6jqEL/+l82V2ZPXTk+dZ7jCClQ2xb2r7SVDJ9TlTmpmK15UwBZWBd9kdYWlFT2Wc2zIZnw7TB1uSqJ7Kbv+i/1YCKO7h8BPKbjIz9r9SKxjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qqQm/6ob; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c7869704so4840416f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 01:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763543430; x=1764148230; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YE4EP2vHwAOfDYFjAAxFpiiWrfOWjJkp8nzfRZHx8Kg=;
        b=qqQm/6obGSwwExbGZdwXR0H6I7/AMYMSDozrCoPH0HuxOR5KLTU2zi6bXS+paqzhpz
         3KzLKG2J2UoXn4EYpLwxNAXs3XASSj58JZApFbntqMNkiQoUg/jiT3aaUr831fPDNjpO
         0FWRcrwjYIZJVBET8HGmm41jN2JatciNLJNr6o+sndWspwlqEzzViHQi5s2LxAr5B4EU
         RLDHCFPFSnfR3pUtSXF9hD+vkOVdy3MUxzUOqrw+bVBm9KvpY4egyeT77hCMXYMY28qH
         X4xGtinUQN6Hro+S52ALrEOfeRc0zX14IDXalJrRjw6HfmMjnQCrgFgdSwOPv1ku6NTJ
         m9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543430; x=1764148230;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE4EP2vHwAOfDYFjAAxFpiiWrfOWjJkp8nzfRZHx8Kg=;
        b=pD8QdGUB7OvMKCBuzAsmIktlHg/JR5XwGpWDikHsa5f0z15ncFkEb+FIQD26VrKc4q
         nUipdaD6NFaoXCYoPfxBFNhHqHEZ22f5FK0vCkHTIfUvZCTssE/ey84vELt2HE9f2WZb
         64BtK3xDMsrrPykoqxdCTYuC/gT79yuVtzI/WcBtl+9XCPkxiAm95eps9BlfGvCsivT+
         sEJiJ4mvBKyZYHm2O2/B+AUfn146zjrkfH76SMNE4haQbt9X+v+M+d60SWiy6X+I2plR
         SdsbbLqOd0bCikTWYOxUy2LyKLU75thYSyu6DZEStmj7ZLx4Xr6Ig8OH4jcIxakGgJvm
         f5kQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+RrqPfWzrXqTS2M/ITI2m7GRyMvL8Ob6BDo2+wT8B5xfyerKH7TZ9HUaRJ3rDtr34XN1sMUScP4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRNn/Bw88BiZrzrAUJGWe8nbCT6SA1rxk53PBiXRJtyPI0pU6
	8hgr96Kwh5/NtCQ7gT06gKAsStDF7rpTDiUJCUISSPTtFQqRGQTbBSvR2DBxmp9cgSQ=
X-Gm-Gg: ASbGncu5Hd3Meeu0U5/64fDg9Tu6C6o4Rpv/vgjMqdfWNrON1nuI32HWh+QW6qbeAAs
	J8MyshLkDMaNGbi90gwd9IWAA3GL1k65fzzHCSD75qUlmgdoQgDDSMtXdF8KdOj6qGMcnxADs4H
	N9SO9EwrbLnb7J/AWV6675JPWfUE8ZneRhUVyu3xyPAHMjtQZLwTZhGDeUwoLbBx9qZIi0PKPUP
	nDbI0SJPr6Vf0JCjFWZVvvYnv8Ahg1gwvtfM4bnhrVr3yqpI4HCN6tHlp/i7JlGD6L9smu3Hp+y
	j4yLMSDvr75/GqU3Sbnjjw79hL1z1wsV7bFxPpiz5loTgWyu43qYslbRPjF/RR7H0fQkNl+yDyw
	LsLE7k8R5nCVCr/Zjm6/lWqYO4Y0s9+5R0TsGRLtum3PpyPan8e6vgXaOzOvZ9JBRr+cMgVHi/S
	VwqIP4
X-Google-Smtp-Source: AGHT+IHUqL4AiPh3Lxs/BJo8HrorMM/Yb2oeCQiCieOWqwtZ1l/4ODlTZezCzSvp5hc6qozvX9gQdw==
X-Received: by 2002:a05:6000:1847:b0:429:d3e9:667 with SMTP id ffacd0b85a97d-42b59349872mr18945075f8f.18.1763543430334;
        Wed, 19 Nov 2025 01:10:30 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c10a:203f:120a:d2f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206e2sm37369280f8f.41.2025.11.19.01.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:10:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 10:10:24 +0100
Subject: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH+JHWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0NL3eRiE6McE2Pd9ILMfN3i8rz8lNRiXYsUk0TzVHNjoxQDSyWg1oK
 i1LTMCrCx0UpBbiH6QW7OSrG1tQBa1UAjbwAAAA==
X-Change-ID: 20251119-cs42l43-gpio-swnodes-8d4a7e732d09
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4611;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=o7oQ1XaVb5wC1ZDBDcJbldzYHxr5SKuSoMF0kqHvAK0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHYmBBfvF6ldeycbTuHmYL7zSkv8OFuOn00HZJ
 1o+6FgKdUiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR2JgQAKCRAFnS7L/zaE
 w6oMD/92PuCX/DA05qVNAHA18lQ1nQ9rq/89KQv/B6gLTkk2NxwREQE72VlfEXzAIFKs8Z7TpwN
 6aAtV4M0EqZ+/22ujJMIkJNWwrtRrcFg3cjAEfLkCgIu5M4vKRjT3LuOg66pyI2c8qNYHsZWQo8
 AhGGJ7/+GPMChEska3BERvNbCiYTtjtakVeMx1PmOZ54uMaR4OPHLcSK6fpY8CUILdLXdc6XlTC
 DbqGQwcgjDlZ+HARaCU2M7b/GS13tGVZ2ruyzGL2ngce8oxyxlUyF2SBKsM3k4yV9KL7BykuRy1
 8juUonyNrK+mseoeBoot/hnaaTxflHUq+ibL1GTNBr5UNE5yE5DXlEBf9/bcEQmoOt8/vDZjYnh
 uwT43vAFXk8cY1q7fVV9K3/va4WtIfwyleT5jKgZno0oTrqgnYPiKO465zImteXtutTcqAHDZHG
 wTxUi7n/sSd3R7gt6BxJebBEwls5DMmCZphqoO2xc1KKo0Xp5A5dxoQh/o+YjfoFJKO7m7ViaDz
 zDVwNW5kVSJaaxGb2jlYhYLzvlx92oEepz2vLlA68Tvs165KMsf6RiWsuglRDRbFck+c2wPDMIb
 NumGI5ax9s33LjFRstILQ8+/0IlO6ccd0ApiFqqO+nSnXaWxb7L2FygBaTBj/jLbA6uSQd61QM6
 ke6g8KUYckMdCeg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Currently the SPI driver sets up a software node rerefencing the GPIO
controller exposing the chip-select GPIO but this node never gets
attached to the actual GPIO provider. The lookup uses the weird way GPIO
core performs the software node lookup by the swnode's name. We want to
switch to a true firmware node lookup so the actual link must exist.
Move the configuration to the MFD core and connect the SPI and pinctrl
sub-devices with software node references.

Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Closes: https://lore.kernel.org/all/aRyf7qDdHKABppP8@opensource.cirrus.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Hi Charles!

Please give this a try. It's only build-tested so far. I hope I
understood correctly that it's the SPI driver that needs the "cs" GPIO
from the pinctrl.

Bartosz
---
 drivers/mfd/cs42l43.c     | 25 +++++++++++++++++++++++--
 drivers/spi/spi-cs42l43.c | 33 ---------------------------------
 2 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 107cfb983fec416bbdd31caa1e6a569026467735..629faf8674af651eb64aa63ec768ba18c1c8b311 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -14,6 +14,8 @@
 #include <linux/err.h>
 #include <linux/firmware.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/jiffies.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/cs42l43.h>
@@ -512,9 +514,28 @@ static const char * const cs42l43_core_supplies[] = {
 
 static const char * const cs42l43_parent_supplies[] = { "vdd-amp" };
 
+static const struct software_node cs42l43_gpiochip_swnode = {
+	.name = "cs42l43-pinctrl",
+};
+
+static const struct property_entry cs42l43_cs_props[] = {
+	PROPERTY_ENTRY_GPIO("cs-gpios", &cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node cs42l43_spi_swnode = {
+	.properties = cs42l43_cs_props,
+};
+
 static const struct mfd_cell cs42l43_devs[] = {
-	{ .name = "cs42l43-pinctrl", },
-	{ .name = "cs42l43-spi", },
+	{
+		.name = "cs42l43-pinctrl",
+		.swnode = &cs42l43_gpiochip_swnode,
+	},
+	{
+		.name = "cs42l43-spi",
+		.swnode = &cs42l43_spi_swnode,
+	},
 	{
 		.name = "cs42l43-codec",
 		.parent_supplies = cs42l43_parent_supplies,
diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 14307dd800b744fee17edd864688a68c65666c68..fa844ce6cd7539bf764f792b99e8f8e191fc0c15 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -52,20 +52,6 @@ static struct spi_board_info amp_info_template = {
 	.mode			= SPI_MODE_0,
 };
 
-static const struct software_node cs42l43_gpiochip_swnode = {
-	.name			= "cs42l43-pinctrl",
-};
-
-static const struct software_node_ref_args cs42l43_cs_refs[] = {
-	SOFTWARE_NODE_REFERENCE(&cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
-	SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
-};
-
-static const struct property_entry cs42l43_cs_props[] = {
-	PROPERTY_ENTRY_REF_ARRAY("cs-gpios", cs42l43_cs_refs),
-	{}
-};
-
 static int cs42l43_spi_tx(struct regmap *regmap, const u8 *buf, unsigned int len)
 {
 	const u8 *end = buf + len;
@@ -324,11 +310,6 @@ static void cs42l43_release_of_node(void *data)
 	fwnode_handle_put(data);
 }
 
-static void cs42l43_release_sw_node(void *data)
-{
-	software_node_unregister(&cs42l43_gpiochip_swnode);
-}
-
 static int cs42l43_spi_probe(struct platform_device *pdev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
@@ -402,20 +383,6 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 				return dev_err_probe(priv->dev, ret,
 						     "Failed to get spk-id-gpios\n");
 		}
-
-		ret = software_node_register(&cs42l43_gpiochip_swnode);
-		if (ret)
-			return dev_err_probe(priv->dev, ret,
-					     "Failed to register gpio swnode\n");
-
-		ret = devm_add_action_or_reset(priv->dev, cs42l43_release_sw_node, NULL);
-		if (ret)
-			return ret;
-
-		ret = device_create_managed_software_node(&priv->ctlr->dev,
-							  cs42l43_cs_props, NULL);
-		if (ret)
-			return dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
 	} else {
 		device_set_node(&priv->ctlr->dev, fwnode);
 	}

---
base-commit: fe4d0dea039f2befb93f27569593ec209843b0f5
change-id: 20251119-cs42l43-gpio-swnodes-8d4a7e732d09

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


