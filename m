Return-Path: <linux-spi+bounces-5851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD169DAF39
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 23:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E901660D9
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 22:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48441193078;
	Wed, 27 Nov 2024 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8yswWud"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD9145B38;
	Wed, 27 Nov 2024 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732745941; cv=none; b=TFfon8S0nCzcgNjeu/IjUOgdY+FJo7m02kjn357YVqpSUWvn39KLKtPvBFjtMFdvNGWH9gKt8mm1/hUeLE0ZbeYQWIQQbYYqHR4kG6OHpyaxhSb5vqbpdajSCAdumicpnFMvfZXBMl/UpdcwLaJH2RGL+hhH8uVh64I7LoTgu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732745941; c=relaxed/simple;
	bh=WZnU28JF4oFrvTkupZqUD8b1N8FTJzSk9hnwMjxi+Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JbX5l1yaxkXnWSDlSgX+KN/5slMTh59IUqPo7fphl4Dy8FFeaN9HRH89vIef/fzT3L+A06jyl7E3lk7p9oLN5xqFFWZQGk75EG54aFEF2yQf0EctbuAqJxvn7+47/Ebv37SZ9EzHi40sdG8wB6ND95HDKp9ccgcpRidi/jnv3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8yswWud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7495AC4CECC;
	Wed, 27 Nov 2024 22:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732745940;
	bh=WZnU28JF4oFrvTkupZqUD8b1N8FTJzSk9hnwMjxi+Ms=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Y8yswWud1mYBNDzqaQAwLvfUZ9fosBRLAU7j8a0q2WxQPFPrh7DASYWCrBn6ol2ko
	 t/UysSPBVtmxkw8GlSDX4+CWE6zAyHdC1Pr7tGoxpON+OBzeF10pnqMCKGEv5kahWR
	 l9CujQNJ9hS0MOHglwTbXNF9Z8fQhRewmqj4mYlZPlR8t3jYaryu6eNjuGYUwXuebA
	 WDECnMozD0JC7IPoHxRAaLDx+jahwqMmQ7/Z6eGqhkB2HZWvX7Gq7wLq5cUV2NVaFs
	 qhWsE1pBaD2q2ovFpcYsQ8fplKDmxRlrEZdsi0PFrJdYC+1XSMf4no/FUpVBM8zjfa
	 FnuksC1xEGheg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC8AD6D246;
	Wed, 27 Nov 2024 22:19:00 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 27 Nov 2024 23:18:29 +0100
Subject: [PATCH] spi: apple: Set use_gpio_descriptors to true
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-gpio-descs-v1-1-c586b518a7d5@gmail.com>
X-B4-Tracking: v=1; b=H4sIALSaR2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNz3fSCzHzdlNTi5GJdU4u05DTLRAOTZJNkJaCGgqLUtMwKsGHRsbW
 1AJl8XwxcAAAA
X-Change-ID: 20241127-gpio-descs-58fcf9a04c4c
To: Mark Brown <broonie@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: linux-spi@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732745939; l=929;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=I6RiQB/DHHaeohSxMjebLzpsTxP8yPVRu7SXWDHE5HI=;
 b=/c8gIuS+kh48ubs1Hq95yjV5JOPYIofMQzBlghiIjcZ++7rwW+QsSWZFb/XN5GWexuYZSF5OA
 sWKRxaSe7FrA7BQwIUEQI917LkvvL0yiRlsr6455o2So3QzqAhT9nIK
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

There is at least one peripheral that is attached to this
controller and can not use native CS. Make it possible to use
a GPIO instead.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 drivers/spi/spi-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-apple.c b/drivers/spi/spi-apple.c
index d4b126c8701a67083e7247d1c82fb56f1725d9cb..6273352a2b2861c9da0976a46ec2adbc4c71d3d2 100644
--- a/drivers/spi/spi-apple.c
+++ b/drivers/spi/spi-apple.c
@@ -493,6 +493,7 @@ static int apple_spi_probe(struct platform_device *pdev)
 	ctlr->prepare_message = apple_spi_prepare_message;
 	ctlr->set_cs = apple_spi_set_cs;
 	ctlr->transfer_one = apple_spi_transfer_one;
+	ctlr->use_gpio_descriptors = true;
 	ctlr->auto_runtime_pm = true;
 
 	pm_runtime_set_active(&pdev->dev);

---
base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
change-id: 20241127-gpio-descs-58fcf9a04c4c



