Return-Path: <linux-spi+bounces-8415-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9ECAD27D5
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 22:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A607A3A7969
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E48322259D;
	Mon,  9 Jun 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AfQ6FJ5f"
X-Original-To: linux-spi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D1221721;
	Mon,  9 Jun 2025 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501545; cv=none; b=f8gSYLmPgBYn7zrXViPDkPo1RY9nVpRTHnOe6zNi+5dpJlYB/McTjpXAZG4cXBW+EzcfDna1Zah98u3xgZiBIYUTz4j6UGfCyZQB7OT0+I9P73xD+RjDLeHoRCNXAJqUDfkThhM6/dLifC5F5zDGNRiDi03+XJD6sYoutARv+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501545; c=relaxed/simple;
	bh=G5wPqDXS58NnrzSV5vgw2JHG+OHUUSaZGYOXaC8tXy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D02aiTfAT35Q2iIiBGEfIuRgtcdR5fUp8LdkVqj6zIqAgQ9HdIhYpsoOinx41wAGEJIDqaKaN7XwHpQgc30jiB6k6eTUNP4xFhr+PJfGZlvWIVmvgVdOaXBsVXxLSviSt4UY3Kcj4uuH3k+6r8mv+kZ68ezCnvVAZhHfv7Xwqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AfQ6FJ5f; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749501539;
	bh=G5wPqDXS58NnrzSV5vgw2JHG+OHUUSaZGYOXaC8tXy0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AfQ6FJ5ffdnEG9K0pTjGqAbq21xj9jXoU57iahPD5Nx9r9BeTroAB90BDT8QdQWVy
	 oKkI1UIY6PSUHgSJBDEkMLFxrUEXq+mh0P2aIaANH10FOJEDCsbeXDzZ79aGdG09Xk
	 4xOXl8lAhjRk6MW8nnuorQNmrRmgwdMe9bto8fJM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 09 Jun 2025 22:38:38 +0200
Subject: [PATCH v6 2/3] leds: lp8860: Check return value of
 devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250609-must_check-devm_mutex_init-v6-2-9540d5df9704@weissschuh.net>
References: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
In-Reply-To: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749501538; l=1160;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=G5wPqDXS58NnrzSV5vgw2JHG+OHUUSaZGYOXaC8tXy0=;
 b=JOy/hussvTbGS4IAwYip3ZRXXIumOP1ljb9PL4bWOiKX3BAwcYeQ/qv6YgJV1rmGIiioleS6f
 6tDWP2BK4uGBiOFZPjS/EGPQVt7jiSfjg0p+AAahpkM40NyDHkO4eES
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using devm
variant of it. Tomorrow it may even leak something.

Add the missed check.

Fixes: 87a59548af95 ("leds: lp8860: Use new mutex guards to cleanup function exits")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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
2.49.0


