Return-Path: <linux-spi+bounces-8626-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D040ADDA40
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 19:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDF6165C72
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFDD18991E;
	Tue, 17 Jun 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iijXI0mY"
X-Original-To: linux-spi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C42FA62D;
	Tue, 17 Jun 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180100; cv=none; b=Ora72B7YlaWUFhir7uvXlf8rlNOhqO949Rt+Syn4BGO7WFvZkTqVMlDuPX7DLXpX6jtVyP7l5bSe8iEd9CaNx3P9IypqmoOY+lJqRvU161v6ePIDnxkJpi2a3G6GIAARohuyod64lUmBTeDNGlpgGNJv0edHzhxe5MmCLsqKCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180100; c=relaxed/simple;
	bh=BifUbuDtP8CLX+SSmA8FHwV1Mhck8lXhS243dT68e18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcJkK+kcRMPwav0nTueRyoAe/hLyadQhUcxp6/2WN5g7z44qVg13ru6slO9Yfevq2zl6tT3Rivsr38VSp/F2EVqOMAiaP1VlafKJ2lVoc8pOxyQMCOthRYxi4ef9RbxWMMehQAWqH9xcZYgyBtivsaBkVCBFgqXtf6xnVaIbOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iijXI0mY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750180095;
	bh=BifUbuDtP8CLX+SSmA8FHwV1Mhck8lXhS243dT68e18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iijXI0mYBGdEOUcbaRTjjLLtqpoGVMIb6VKHJrtP1NfAWi58cBdpBtyTKGsBssKo9
	 x5zEOxUpU8cSZXucZV9dvxWSxCxUHmlr1zFCDXTc2vjNl6k8VWmYu325ybVW1RlBq3
	 RkHxhuG8vEN57HdlebcvyqU6l2/gtwOXP2wkOBsA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 17 Jun 2025 19:08:13 +0200
Subject: [PATCH v7 2/3] leds: lp8860: Check return value of
 devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net>
References: <20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net>
In-Reply-To: <20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>, 
 Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-leds@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750180094; l=1129;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BifUbuDtP8CLX+SSmA8FHwV1Mhck8lXhS243dT68e18=;
 b=80MqI6sR99BIQb1YVYOfJ+0gi5QJKk6qvrAw7V7T8mRff9hl5gLsjDaR+ssQk4IPo6L6n7PtH
 XSYnuu5Oy2pCZ98VcjabXnl4QR4FOfVOAlCIjZljKvmWi8N71M+ofRJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
marked as unusable and trigger errors on usage.

Add the missed check.

Fixes: 87a59548af95 ("leds: lp8860: Use new mutex guards to cleanup function exits")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Andrew Davis <afd@ti.com>
---
 drivers/leds/leds-lp8860.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index 52b97c9f2a03567aa12d4f63a951593a5e7017d5..0962c00c215a11f555a7878a3b65824b5219a1fa 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -307,7 +307,9 @@ static int lp8860_probe(struct i2c_client *client)
 	led->client = client;
 	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
 
-	devm_mutex_init(&client->dev, &led->lock);
+	ret = devm_mutex_init(&client->dev, &led->lock);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to initialize lock\n");
 
 	led->regmap = devm_regmap_init_i2c(client, &lp8860_regmap_config);
 	if (IS_ERR(led->regmap)) {

-- 
2.50.0


