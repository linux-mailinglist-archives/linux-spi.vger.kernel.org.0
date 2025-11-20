Return-Path: <linux-spi+bounces-11402-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB269C744D8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB3924E5F1B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597B32C94A;
	Thu, 20 Nov 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="urPHQq2B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589C33A715
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645061; cv=none; b=W0aHe6Qb/nwcYTv+cw6drMmMpzJTtoTTC0eX2LptXPk4GDErKpY7H3gANS1OQs59DdkmKnPneBYqQKJ5NrpDXebxQ+SAfovoYQAxpdBUP2i0qY8EzdN4oFIupQslJDcY32oi32nXeuqE4nzhyMp193MUoI9l333T63+ZpqoSmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645061; c=relaxed/simple;
	bh=DAh7GJYihto1rb/7izzaWNy0krHQiRwe/MsGu2gJbwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CE4a1THeu5ImpXkZlkLWC7VoAv3CUf55Oo9XhqZBbhcpEs1wmX9mhBsyQTNjrLW4xOWcMyGYMKqSg6yHNbQ7V0ZwcWxqL5c982AuGixjQmnJm2GkrPZfvJFUVHkNjOibta1CcZnEc+rv/qqz++Mz395uNhTuf66n8R46WAZzEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=urPHQq2B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779a637712so5936015e9.1
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 05:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645054; x=1764249854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6c4R4ZR/mmanidIpFqY9K6Mkfp/rNBIc8Ut3S49/Rs=;
        b=urPHQq2BnXPoZn5GWSb+UIUlLXpVVVWHV3zO9mSeowOXZj9LK6Ft3j3cxy+yJNW11M
         SumN4RtwHCkI/DsiLmGIAKab577LyWf8QEkXMDhY9MoH2zwNN6sOjt9j61LaJuBi3wWv
         /LsOnsZJmofID0SxLrMEC6raA6s5FE4aIAP76rnyESw+J6Myu4p8LTuR+nzTWNW9ru1o
         wjzD9nlEmLh/i+EYy8iKd9ypowAM0cGs0/VEPdwtVlKxdMcDBP5HEntQuVoIWbIBg13A
         a3kUamD8B9LpqySwku5t08sQZNpi7P1Kt70z8pvEZn1yAo5hdjNey+jKCpPVtSl50TT3
         uIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645054; x=1764249854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T6c4R4ZR/mmanidIpFqY9K6Mkfp/rNBIc8Ut3S49/Rs=;
        b=SlVwAuBkWOnkX5KeRosza+OEDCK8D6OWrZvww17E9eSW9qQmCZt1B6M4apVU8YjrVi
         HAylbvHUJo/5uPrXcjKTF8zy28kdrPAodJfnPmYFJETv1xt46kMaAcL2N/AVSciRSjHU
         7Jxc/nFq5hqSbuqdSNuWY8UJfObJZ41n3vb+oXhNJ0rBJiabBdeHOrnxbD8j+8xep+BY
         t3e5U9kh8aFaIwgTuGRG4NQ28mRc+K1Eces/1eRLLEGj9TnK9Q9NlrFWnXiqvuBgpOJv
         K9EIIFTMoVENnc6loAZctb+4qaDWX23wl9mQWsohwfWFDX52R8xE1KWT0rcKw7s040YB
         J7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcUOWqHDDhoVZ6Qj3jSOIJkh6r4AJFpP66nciBPYLz0xqQSY2jwns/MGmt2xo2LDGvZvHipbeYSOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnoHDr184li4dYpdP6zL+J4/NB+pWYActjkM5yu5kWOzRIl7I
	eyRaJzHG6uIrUK+cHX7Fnt9rB05vtPmeuOPbvi/n/tn7uag61AMl5OsYX/rwf1LChuk=
X-Gm-Gg: ASbGnctv/UHtz7woKkS8w8R8sxuOCiZg0w7Py8/7tgrqVE4wQlo0ePwxKzhrsBa8luv
	IiOySgmpX53T5iVTaJZyIVNr70VMsxCvqstz3hPnFpSbayR6ovHfx+kVzFNSxA4GYn0dZpjgh9w
	L6I8kwcev88SWUjv4IBHBKrMJIeyyY08/9SxbLTihA5CiruRa0zpqtLVFdFY2ixoqBmhmjmodVt
	0641gLUU0MgWh6SVRKCM+PTc0erIOloycL/UAP9h2UlOhV+CnByxUawDBFLU1GRAXeA0G6c89LM
	7b8/8RjyiZH9GO/qoNiPJyc//s/qqqmaSi1UsCEwZnKXJDsHdvFjxUh/N1ErDlnHxmYHwaiwCPN
	vr1jEcQBw7zMsRRqTmMug1jSndl5PTBzeQgHBFnNaT6KkGnsl2zbMBdmt6HKGGYd3/pKNmFkgJw
	ZwZUQ=
X-Google-Smtp-Source: AGHT+IFF7rV6uBva+BQRyBrCj38/4077uancqKeUXViRLWTSQtvD46FVILY+Uc8Srf05smNtarypTw==
X-Received: by 2002:a05:600c:1c02:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-477b9e377cemr28611695e9.23.1763645054075;
        Thu, 20 Nov 2025 05:24:14 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc72dsm46762935e9.1.2025.11.20.05.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:24:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 14:23:59 +0100
Subject: [PATCH v7 4/9] spi: cs42l43: Use actual ACPI firmware node for
 chip selects
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
In-Reply-To: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4326;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=d76VHZwIwnB+K4dfBzZLwy1CDep3KCUqEcn4QrJ+rFU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHxZzNvrgBP2H3ds0pVhTuGe6OzgZgzq1W6R0L
 /mn/TbtxyCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR8WcwAKCRAFnS7L/zaE
 wxXbD/0SblSbNyyKOZkdAfFJSkmxgHZXxNFq3JE7HL0wgdCi0AO66QupG/HPcKXjULfDqHhCGwd
 4Kjne31/UiQLfV4KublOc+BgyLqpUB8TyFdDpjBVo6sFTKUi+ZsFURo7zYDLtY6ngMIkF4SAqjx
 vEKdX/5ipoqSxKY8ZuYceFNcy53UC7Zo41qPOSz5ZNgB9+aWlx/DxTpztI1sC2ljYROdeEtPcd7
 T8se4oUz8DvyzCxNyFa/cJ/Xa20jmqNH7ELcKGG2gixZfJScOFak5rdnxUPPG0yq/RpkuSANFIU
 8Lqn638HDK2hH0lgEpJ2XqCi/4pEZGCeFIDf23LF6Tz4d2tO/LAIgfcEwy0SbzbR7RxQVT9qJeD
 ktQWF4LQ1th9Cg1Oz8e+vovSyTbSKZh1c5entNqpyk9VqcHpLKltFXF98Sx4JCr9aEH9NaOmCwF
 jPExra5JKYuRn6RkI3/0otuXH7sqEY7CWSCjP7Aw3JH1QsMAI/b/jArv90+WqjpMlmFt9Z23ilo
 ZP7J7mxpg5tjXd9OcTNU/ztnRyvBSmd/g+KXBrVlWMMXaXTx4Ous1Upj4XxDBS4+kIhZ9Z4oy8B
 Ky67aBRO8dFoMYwv+LfLT7OXtOobdvnqiVa1DMiUZpRLP7s5k9Z2o3uyjvVt4jGcnWbdhgoRzMg
 8pldvv8LYKz0nHw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Charles Keepax <ckeepax@opensource.cirrus.com>

On some systems the cs42l43 has amplifiers attached to its SPI
controller that are not properly defined in ACPI. Currently
software nodes are added to support this case, however, the chip
selects for these devices are specified using a hack. A software
node is added with the same name as the pinctrl driver, as the
look up was name based, this allowed the GPIO look up to return
the pinctrl driver even though the swnode was not owned by it.
This was necessary as the swnodes did not support directly
linking to real firmware nodes.

Since commit e5d527be7e69 ("gpio: swnode: don't use the swnode's
name as the key for GPIO lookup") changed the lookup to be
fwnode based this hack will no longer find the pinctrl driver,
resulting in the driver not probing. There is no pinctrl driver
attached to the swnode itself. But other patches did add support
for linking a swnode to a real fwnode node [1]. As such the hack
is no longer needed, so switch over to just passing the real
fwnode for the pinctrl property to avoid any issues.

Link: https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org/ [1]
Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
Cc: stable+noautosel@kernel.org # Don't backport, previous approach works, fix relies on swnode changes
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[Bartosz:
  - remove unneeded Fixes: tag,
  - use PROPERTY_ENTRY_REF_ARRAY() instead of PROPERTY_ENTRY_REF_ARRAY_LEN()]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spi-cs42l43.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 14307dd800b744fee17edd864688a68c65666c68..4b6b65f450a86c238ba0c66e03462c775d12b8cd 100644
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
@@ -391,6 +372,15 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
 
 	if (nsidecars) {
+		struct software_node_ref_args args[] = {
+			SOFTWARE_NODE_REFERENCE(fwnode, 0, GPIO_ACTIVE_LOW),
+			SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
+		};
+		struct property_entry props[] = {
+			PROPERTY_ENTRY_REF_ARRAY("cs-gpios", args),
+			{ }
+		};
+
 		ret = fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-val", &spkid);
 		if (!ret) {
 			dev_dbg(priv->dev, "01fa-spk-id-val = %d\n", spkid);
@@ -403,17 +393,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 						     "Failed to get spk-id-gpios\n");
 		}
 
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
+		ret = device_create_managed_software_node(&priv->ctlr->dev, props, NULL);
 		if (ret)
 			return dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
 	} else {

-- 
2.51.0


