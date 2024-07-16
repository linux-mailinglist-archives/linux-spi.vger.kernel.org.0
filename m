Return-Path: <linux-spi+bounces-3876-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B194093301A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5547D1F22CD7
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75D019DF7D;
	Tue, 16 Jul 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq64GPEk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF771B52;
	Tue, 16 Jul 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154807; cv=none; b=UgFx4MU6jXay/MhCsF3Q8tir2vT2P/Qh5XFUo6KuyO8aTdB4zlcT64+iaJG56wTzLbCwAl2f0ydjJ1Syrpk1f5ylzY9V+PVe12YB2c1Opdkqi7jJY0Cq9WWEYZcNR0OSDCX96Nrz0RJktnOmRNQ5LNF2bmy/pfRhd3kGHqhAz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154807; c=relaxed/simple;
	bh=+ZjjXCpnv2L1bukZQGUpMxc6CKL0bIEWM85lXFdFRDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ud6FXtHp8I3p6cMXGZVAB588jyM7bswftSyZRt96HRylCEsWEP3Ewuwx9iUJMszrLRlFlFx2frceq1rIc8RP+bFvJOce7yMG8K2a6kwPMR6U5Ghsf1QPxgYoVWarq/ZODZ9z6FBqpKC8xl36hf35NMHGZbrMa+lfjgL+VyG1L5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq64GPEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6318AC116B1;
	Tue, 16 Jul 2024 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154807;
	bh=+ZjjXCpnv2L1bukZQGUpMxc6CKL0bIEWM85lXFdFRDo=;
	h=From:To:Cc:Subject:Date:From;
	b=Cq64GPEklFg9eU0lY3fgMM+CNsKkpneUsKLKqCdhjL22cWtOB31QrG0NNNRMCRsI1
	 bm4trC8duJwafUip/1qXxxpvACU2QJP1ILIg1lmGmBhIANS/BMeffeXNt50Vpqv0Rs
	 9ybjer8kRXJH6H3sEs9ASYD+ieLUglKczC5CrakHN7HmWaVdOqNdzN/5Fg6w7PC7Al
	 F0TbwyCe+cqzhYczz2dzrEnijvx4DoBanLw09RCgKMIrmyTqS2nXt6CWAWj1LhNYfP
	 xD8MvRMu8fFiULaBn8R/KIb/icmc9F6kzjvEmzguW+/ftc3f4bMFCF1kRD57LizYIP
	 y/yO60svnD4SQ==
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
Subject: [PATCH AUTOSEL 6.6 1/8] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
Date: Tue, 16 Jul 2024 14:32:58 -0400
Message-ID: <20240716183324.2814275-1-sashal@kernel.org>
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
X-stable-base: Linux 6.6.40
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
index d323b37723929..006860ee03ca0 100644
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


