Return-Path: <linux-spi+bounces-3873-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C763B932FFB
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FB71F23179
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631711C2A8;
	Tue, 16 Jul 2024 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3CUcyJc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD171643A;
	Tue, 16 Jul 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154746; cv=none; b=cCH9lsamekDjwmSfA5P6/cAeVx6samGWqLbiIa4sZBnK4sPkwnbLh00zPFxChIBsVlRvC8EQUYGP+fp8XwcULKc+lBzY3YCvv8h/SaJhQZq/k8lSog9HoVTvH9CeSWqktVFXNyfZaQ3P3671gmIcL3YF2M52qqJDF1FNFTszza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154746; c=relaxed/simple;
	bh=GCyw3wZavAMC99QfaxVM5H72XYf2IXkOHKGfTxLKjDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UkeS6ElSIydo0gbHKeNnFfiRjE0iq3IRHNALVBbO9PY96/PDLaaBuavyUSSwgWxzLzOGQIXkDR9hL82HobCr9n3LyZZx5LYfXSbAZGgDF8U0+NZQBFc4uWjY081z/eJ271UhffuQ+/7Mu7AFBgZCDpfnCYyzx/mPKmxRY/6AOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3CUcyJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8324EC116B1;
	Tue, 16 Jul 2024 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154745;
	bh=GCyw3wZavAMC99QfaxVM5H72XYf2IXkOHKGfTxLKjDw=;
	h=From:To:Cc:Subject:Date:From;
	b=b3CUcyJcRgnmsLwZyI6oQxHUVztGAgrD79TQzlX9xayt1o7WFanNNxaR3zQw56R3N
	 +R/JMuG9vb9y88Wy7iuUYDm0FjEjfj2QGbcQnjNnSopaMFeXMl8bZTwwjWx4N/KFSl
	 phweh2r/FZBOUbUIB+yQhffQUetxJcFCM4R9sNs79jdzAQR5vC/iQC66Imokzi9D9e
	 +F+p6XYkkYTgdGQ03Sqj1qXOuh0XzyIAXcGEkY6Q7eVXfSTAvoOEQC+dYCTQy6Quvt
	 heuyl1q/36x7sq/ep5Lo1JKqmBUCFBvqjH3BMoiL6a9ZR4vAJUyobtwdjnhr7kMbIP
	 Hpz+jRYZ5IbaQ==
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
Subject: [PATCH AUTOSEL 6.9 01/11] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
Date: Tue, 16 Jul 2024 14:31:45 -0400
Message-ID: <20240716183222.2813968-1-sashal@kernel.org>
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
X-stable-base: Linux 6.9.9
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
index 09b6c1b45f1a1..09c676e50fe0e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1050,7 +1050,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	.rx_available = mx31_rx_available,
 	.reset = mx31_reset,
 	.fifo_size = 8,
-	.has_dmamode = true,
+	.has_dmamode = false,
 	.dynamic_burst = false,
 	.has_targetmode = false,
 	.devtype = IMX35_CSPI,
-- 
2.43.0


