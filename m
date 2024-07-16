Return-Path: <linux-spi+bounces-3878-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840E933046
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FA01F215F4
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B31A2575;
	Tue, 16 Jul 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2FUi6qo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04101A2569;
	Tue, 16 Jul 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154853; cv=none; b=t2+CtZhgseteiq2XdppoiiZ7AJKd4bf13WIbOxr2cbpYD6fwEn+IGGxbQcEb6NAh8HthIzGq9WpnEHc3mIJincFxkCHQW3Je0rR6PYWNUs/OT69+kzW9UhOfPpc69a19V8KjxV/+YWsg382vK5qEfEbYHNkIHEATArfBmYUWwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154853; c=relaxed/simple;
	bh=3Tf1x5+YEUrva0pfI8d/8TUvqHPptl6saPq8nrj86AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TrXKrGpBpKQkR6gEKoBVkye/MuSv3pvrNWLTV23wyBtuvvFVu4pqXvxifS4lM7x/5QR1k5Q/1sSOSAWkmI20iSlMPHJE7BjClTZ1XonXH3Y0d79YnYnxdKr/J4r0QlpqsIaxQR0Q04Da6fDaf3Di1gKn+TaG5R5PKfwhDThvqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2FUi6qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9829C116B1;
	Tue, 16 Jul 2024 18:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154853;
	bh=3Tf1x5+YEUrva0pfI8d/8TUvqHPptl6saPq8nrj86AY=;
	h=From:To:Cc:Subject:Date:From;
	b=N2FUi6qo8mm6J8LwCYMBv/by6CaoH1Ig2o657OUeIkCVLm3a8ZqFhrVYCiL/+KQHv
	 4vZOaBu2az333hVXJQ5VmFTXSLPQJ1ByhrEYtaoyjDUYyVRS7wV6LG7qRfOi6Nj9ku
	 wcDsi/HC2QhOzcpAlMA08uvMw5Phj577uyWvrZ0OelU6VvJJIffP7Uw1frh2CaU1D/
	 YoG7mmPJmospE654GOusMzAUtpgpuNPA682l3tCGG5Nne4p4fd76OMcBprdVgMDUxK
	 3HUJ+EWEbM3qe8912x8T+ykWfPuZNI3xWvIcLBcpp5aXpHdnXMEaKWf4L8HXWcc97p
	 vzZdoi5xQg5aA==
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
Subject: [PATCH AUTOSEL 6.1 1/5] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
Date: Tue, 16 Jul 2024 14:33:58 -0400
Message-ID: <20240716183409.2814531-1-sashal@kernel.org>
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
X-stable-base: Linux 6.1.99
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
index 2c660a95c17e7..93e83fbc3403f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1040,7 +1040,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
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


