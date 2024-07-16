Return-Path: <linux-spi+bounces-3880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEB1933055
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5691C2254C
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD81A08AC;
	Tue, 16 Jul 2024 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOoZ87mg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891B182B9;
	Tue, 16 Jul 2024 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154872; cv=none; b=fDSQ7IgDVGWf8ywAmj67ERIA6LjR+p0r/nuMf14pK7/sSsTltoi02E94UzGhVA0K/G89nCdTqPGfkRmgv/JAKYcwhlxswmg5JxdXFdWrfYnSHuC6/HUw8NBwOatY+xblSqZttUNquVvrR4yIhisuxWPPwRQNrUOrtPccudG0zRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154872; c=relaxed/simple;
	bh=hqnJeSaPQO5SFRt/bAfqmzR4G9Has0SnV56u/O3vOD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ntah/Efdu+VxoRJA+ZpvhFTh5uuJgPVDMEv97l6rzCiFcLQq0jplXImFblEhrBimSjonGChGeSoUrAoWn2J155kqUTPs6G/NORWTY/cr+PZB24xi21B7XY0k5koFg0FldzyFQUdVy4ATh25LLbjNUsUW35pGyBCH2v6vJRatcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOoZ87mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D129C116B1;
	Tue, 16 Jul 2024 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154870;
	bh=hqnJeSaPQO5SFRt/bAfqmzR4G9Has0SnV56u/O3vOD8=;
	h=From:To:Cc:Subject:Date:From;
	b=HOoZ87mg40FJwCp2ZRCIfcnVO5OE6NmmzfJpjrS8K5JI/6Y7LtKF4hcHLkbly/sfm
	 yuFAnSJtVQ7nP6jGRwsvEXnRXhGpcNhoprS4a6uhL74cF2ocOEnxGQT8xUoZ1ZkcVG
	 GNJCOaeyrubnqxqQqCGQZ6dRRYbslLU6uBI1D2H25/fTY45nJeFyV15Fzp/KPgebsm
	 bKpxiaa85M+uyzMs03KwYCjJ28UFLp5/cWFRqOxmVukAgaDvAIzClRjPC2+hJRLgys
	 nH7KCnDzeeJ1cZGUPHUgsgmY/dPgwrDDoR8IDDGj+iX/Z1TqJ7m+bfRWAgGUV2iyuQ
	 oq7QQt1zPUuqQ==
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
Subject: [PATCH AUTOSEL 5.15 1/4] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
Date: Tue, 16 Jul 2024 14:34:20 -0400
Message-ID: <20240716183427.2814662-1-sashal@kernel.org>
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
X-stable-base: Linux 5.15.162
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
index f201653931d89..c806ee8070e5a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1016,7 +1016,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
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


