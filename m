Return-Path: <linux-spi+bounces-8413-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2DAD27CB
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 22:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8845B7A682C
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 20:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B4221708;
	Mon,  9 Jun 2025 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OyJQr67L"
X-Original-To: linux-spi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE022170B;
	Mon,  9 Jun 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501544; cv=none; b=UYHIb10q/kIcysjxAdMgg/N3o7EDavlay7QpxXXg9kynGTvEWIqBSt3f+muzeWpR0GG7wvXD7m7Kl6K8Op9oZB3nWv1rrlwp+L6rLPh3t3tM3mY0KW7WC7i/77NuLtwlPWeGmUx22EKagsjpYopt0UiqWUoLkt0H6ZzE0DnTlU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501544; c=relaxed/simple;
	bh=azLvpNS6ccFIPAjwzhhSs7C802wsRdQiR7hKzlK9MIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7zQrfdCeWp27Kg1WUkiwSL4i4K1UUGBK2fWqGDnf0BXJix+ulIzPelJaSE4bVegEOlvT8jF4eJdQkAYcp5ktIkSgoTi5h2vLbx+zG101by+5eBGdDLIdMTIomKe77RNmjBK1hiyos6zV2g8Wr/jFNNcYj85uDLDKkOJpWfmIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OyJQr67L; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749501539;
	bh=azLvpNS6ccFIPAjwzhhSs7C802wsRdQiR7hKzlK9MIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OyJQr67LA/qATwAcM2WhqumB6/h5LHabx1HOOqJJj/4aqgOxt4mQCoNGLeTYJ3tq0
	 mw8KIqLu9J10stqYLvrCn/XJNHttRJc/1Azmxulg1VSZC2Ob3A4/pH5LpCNyZe9K53
	 RZqdxzQIjcTm/Idkzmw9hiYYqMALgBTqK12YJROU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 09 Jun 2025 22:38:37 +0200
Subject: [PATCH v6 1/3] spi: spi-nxp-fspi: check return value of
 devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250609-must_check-devm_mutex_init-v6-1-9540d5df9704@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749501538; l=1078;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=azLvpNS6ccFIPAjwzhhSs7C802wsRdQiR7hKzlK9MIE=;
 b=7Tex+6NkzoKF+8wCbpZPkHLLVD1gTer+8CN7AMvXQEYZbIKYLsA0sVqRAYKiDEmbz5Dzf9VG4
 NNarAPkm1mbBgfavw87ucpapLycpxvVCZSoxqzH7ufaohe9/dLEgjBG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using devm
variant of it. Tomorrow it may even leak something.

Add the missed check.

Fixes: 48900813abd2 ("spi: spi-nxp-fspi: remove the goto in probe")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/spi/spi-nxp-fspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index e63c77e418231cd0698ffb73eeeebfbe63cc3065..f3d5765054132cd18b7257439ece971f58e9ceb2 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1273,7 +1273,9 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request irq\n");
 
-	devm_mutex_init(dev, &f->lock);
+	ret = devm_mutex_init(dev, &f->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize lock\n");
 
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;

-- 
2.49.0


