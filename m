Return-Path: <linux-spi+bounces-8414-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E0AD27CF
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 22:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567C11713DD
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672F221F2E;
	Mon,  9 Jun 2025 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kC3dYwm1"
X-Original-To: linux-spi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061222154B;
	Mon,  9 Jun 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501544; cv=none; b=SNzjZTt4qDOy5kD3yeTE1QOp83DXaGlOymfei2hhjn7TccwIOYppVigcbhl95p50YvGRYO/EGIM/r23em1jqyY7eyhf1CMoe9hq/8G9nSIQw6YDril0drl3lbVPhba9JlPZohHBZaN3c/YulmxbG9hnw7q3pvKjLB84FAhXFCNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501544; c=relaxed/simple;
	bh=C/pblvplmlqteIcRC9Cj7zptfNiOwA02a4YbPNKlgGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KNG+P2Qh4YU7co8DXnVAMDWtLx9sPrLHC1XdeLrR31CfxgqO6gSd/7tyCrnVd40BC08A281VQBM9EWGG4CDjloEeGL4pRPfZUsJMIkVYnvi45tQNyYXmfyzX2fwFKoQ2MCgJWsErISDOLpicD7sijM3aLhq+Uet0l/EtKc2nfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kC3dYwm1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749501539;
	bh=C/pblvplmlqteIcRC9Cj7zptfNiOwA02a4YbPNKlgGA=;
	h=From:Subject:Date:To:Cc:From;
	b=kC3dYwm171fp/VRlEcywt+TifB1aPZgk8kG9o2ekc3xUd9vdYx05JRaC1dD+2ohs0
	 ofWbuEByeBc3VKLA+uF1bX5igB8ZC1DfwPXjv+SJnbUvmseL2ItuLfImuol778t73y
	 7funn6GqjWl3AmRjCgx5NxOJvjKdvwuBx5jPJFx8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v6 0/3] locking/mutex: Mark devm_mutex_init() as
 __must_check
Date: Mon, 09 Jun 2025 22:38:36 +0200
Message-Id: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAExGR2gC/33P22rDMAwG4Fcpvp6Hz052tfcYJcSKspiRdMRO2
 lHy7lM7RgcLRiD4dfFJurKEc8TEXg5XNuMaUzxNFNzTgcHQTu/IY0eZKaGMFFrycUm5gQHhg3e
 4js24ZLw0cYqZQwu20qFrqx4ZAZ8z9vFyx9+OlIeY8mn+uu9a5W36w1IrsavkkqMTGGofKvDq9
 YwxpQTDMjxPmNnNXtWvZ4USpugpLrgPTnkJJnh0u57+61VFT5OnjEUjfQdQ465nHp4RvugZ+td
 WPrSE9S7oXc8+PKqiZ8mrVd/Ss7UG9/++bdu+AQiyE7MJAgAA
X-Change-ID: 20241031-must_check-devm_mutex_init-cac583bda8fe
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749501538; l=1793;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=C/pblvplmlqteIcRC9Cj7zptfNiOwA02a4YbPNKlgGA=;
 b=dujZfz5fwa8CGJhCepivI+/1HSX9H0lWYFoleQaf8mBz6J0qC8Dr8x7biuhPUf240/1MZA3oj
 gJr617uHIUEDtXsc3vZmGbKokRXP0CgYlZwP4T7mbHkYGnuuHgFIIPI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

devm_mutex_init() can fail. Make sure everybody checks the return value.
All patches should go through the mutex tree together.

It would be great if this could go in through a single tree at once.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v6:
- Rebase on v6.16-rc1
- Pick up review tag from Bartosz
- Fix up spi-nxp-fspi
- Fix up leds-lp8860
- Link to v5: https://lore.kernel.org/r/20250505-must_check-devm_mutex_init-v5-1-92fa4b793c6e@weissschuh.net

Changes in v5:
- Pick up review tag from Andy
- Link to v4: https://lore.kernel.org/r/20250407-must_check-devm_mutex_init-v4-1-587bacc9f6b3@weissschuh.net

Changes in v4:
- Drop already applied leds-1202 driver patch
- Rebase on v6.15-rc1
- Link to v3: https://lore.kernel.org/r/20250208-must_check-devm_mutex_init-v3-0-245e417dcc9e@weissschuh.net

Changes in v3:
- Introduce and use helper macro __mutex_init_ret()
- Link to v2: https://lore.kernel.org/r/20250204-must_check-devm_mutex_init-v2-0-7b6271c4b7e6@weissschuh.net

Changes in v2:
- Rebase on 6.14-rc1
- Fix up leds-1202 driver
- Link to v1: https://lore.kernel.org/r/20241202-must_check-devm_mutex_init-v1-1-e60eb97b8c72@weissschuh.net

---
Thomas Weißschuh (3):
      spi: spi-nxp-fspi: check return value of devm_mutex_init()
      leds: lp8860: Check return value of devm_mutex_init()
      locking/mutex: Mark devm_mutex_init() as __must_check

 drivers/leds/leds-lp8860.c |  4 +++-
 drivers/spi/spi-nxp-fspi.c |  4 +++-
 include/linux/mutex.h      | 11 +++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20241031-must_check-devm_mutex_init-cac583bda8fe

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


