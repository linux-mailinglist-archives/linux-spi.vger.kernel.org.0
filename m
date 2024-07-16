Return-Path: <linux-spi+bounces-3884-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7C793306E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B731F22112
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E321A01A1;
	Tue, 16 Jul 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB9NkVkw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7AE19E801;
	Tue, 16 Jul 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154902; cv=none; b=D4UYaWHd8H84mUw+4Od1RC++yoG7qRGo5MT1og+0LS7IP4h0uCqdt6jLP1MxC2voCn6Hi/hItxu6Og1qSotTTvdJD+vdnJbOEr0gVuAJ3l3gYAXNZ73/a3fdYwmJsmHLKzbimDFjl07AsSHnwTJc/0tGliHTu2e1kAZZu0JSVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154902; c=relaxed/simple;
	bh=BHDDvUfmbb9ThQ0yKCEaRd2tBZuGP36V8LN93uq6l2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QSpK+wI4TJ6nvVURFeF4+lp+Sp9fl2IuD/srkXoXEHSxMXA/VPZNYbdHCVGE7D3Jje9i1fI3yUHTrrM9phRONP2O7y0D+BG1xH3JngMmOQmHZ/YnyVbIP9z7OiHmXl7q2ASg6RpDeqJXuUkoKosxEDCAFSJc8rUBbM7eJTnkNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB9NkVkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB31CC116B1;
	Tue, 16 Jul 2024 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154902;
	bh=BHDDvUfmbb9ThQ0yKCEaRd2tBZuGP36V8LN93uq6l2I=;
	h=From:To:Cc:Subject:Date:From;
	b=bB9NkVkwC6J30ZEm0835l9M4uHZ//1E0wNCOlsqHnt/kV6T7DoHwe4Wim4c8wFP0R
	 3waXxh1vRAgLYdk2QqDqS5/nwrOdP1m0etxkz78OEAu4TOW6WVInp9Z4OZqW9scddT
	 3QsqzWU0+F1PwmzEI75Wo85xSQJ6D+SzLBxf/2vDLjiwYArD3UfJs48Wk7HEsgd+F4
	 9ZHG0XmIjyN6uW3T+2xRWqmEA34KzdqRsyY+c3S8Y0/2YzQn0dOLScTlYsa1HxgQDw
	 dy5xNMIX8LAcfl9+4u9WBreKQ+nD/7yPqLx6xponzxdcc1Yv38AcGAX9tggQLDXHpG
	 Fi2JsbWDAl95Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 1/3] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
Date: Tue, 16 Jul 2024 14:34:53 -0400
Message-ID: <20240716183459.2814875-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit ce1dac560a74220f2e53845ec0723b562288aed4 ]

While in commit 2dd33f9cec90 ("spi: imx: support DMA for imx35") it was
claimed that DMA works on i.MX25, i.MX31 and i.MX35 the respective
device trees don't add DMA channels. The Reference manuals of i.MX31 and
i.MX25 also don't mention the CSPI core being DMA capable. (I didn't
check the others.)

Since commit e267a5b3ec59 ("spi: spi-imx: Use dev_err_probe for failed
DMA channel requests") this results in an error message

	spi_imx 43fa4000.spi: error -ENODEV: can't get the TX DMA channel!

during boot. However that isn't fatal and the driver gets loaded just
fine, just without using DMA.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://patch.msgid.link/20240508095610.2146640-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 67f31183c1180..8c9bafee58f9f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -993,7 +993,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
 	.fifo_size = 8,
-	.has_dmamode = true,
+	.has_dmamode = false,
 	.dynamic_burst = false,
 	.has_slavemode = false,
 	.devtype = IMX35_CSPI,
-- 
2.43.0


