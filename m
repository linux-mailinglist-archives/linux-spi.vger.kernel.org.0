Return-Path: <linux-spi+bounces-3885-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E087933077
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEED281685
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217C41A0AF7;
	Tue, 16 Jul 2024 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVpH4aBD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F601A0AF2;
	Tue, 16 Jul 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154916; cv=none; b=YGMCmqEGGTc87/WSKHd5mnDBOIZ4KtyqSvf+KvKWx4oFfiQF0IDpnPCoVOpUv1W5V7pxDKyZf4NHWvEd9P0PdhNapbpXyDaQfwC4QppL/nIROBhXvp5ewZpuJeEujDUs532CHELwPos33YiB+Gu8ms4lUAdcy6zZrsnZpCrKbGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154916; c=relaxed/simple;
	bh=SBYrAkqv84dVvEbUsoTvLPS9PdMvlFOSaor4FSxESvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=szo2BB0ye3Ff+9y/Dojpgb5A/LQ89SzTv9RTQxuhNeoCB1wrOcVFqt56RUXQoaSNOBay69v9OGzG9ncV5wjV2IwXtdWS4E9Rc6v0pSBCW/Wr991dyP0/CThHN0jcSZnSgXjwFB63UlxtMvWhnRCwOzH/OmquiNSqZli4GOqYSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVpH4aBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E73C116B1;
	Tue, 16 Jul 2024 18:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154915;
	bh=SBYrAkqv84dVvEbUsoTvLPS9PdMvlFOSaor4FSxESvY=;
	h=From:To:Cc:Subject:Date:From;
	b=iVpH4aBDLK9ti7qpfr5U1YNLhsygX4O+mO7CxEMrtoVn64GOfh3IeAOm09ocV8Ige
	 lyqsdE5QvFa4v60MHTlDg+ZdAxED+RYHezVCOlSb/16UUEImJpmnRShSTeHPmkfZLp
	 iKctQxA/0ulDkL9md1lSJvmKnGxmfR3KqjMLJSuLb9tS9YzkwfXqxswR+nDX0fnHrS
	 Jp4pl//xmhXuW5YOKrBqDmaleXPOMgxeHlKrMH93apLP1rbZhMChMAx1GncTYiMS3e
	 hWZfuzinZvkIEgI95mYCjzUjdhFw2xz7PgTpmOVWGLW4x7DpMdkGuTC9M7gn1esL8w
	 TgJO+jOY6LWNA==
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
Subject: [PATCH AUTOSEL 4.19 1/3] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
Date: Tue, 16 Jul 2024 14:35:07 -0400
Message-ID: <20240716183513.2814965-1-sashal@kernel.org>
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
X-stable-base: Linux 4.19.317
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
index 0078cb365d8c2..adcd519c70b19 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -968,7 +968,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
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


