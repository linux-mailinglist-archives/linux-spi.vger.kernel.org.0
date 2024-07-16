Return-Path: <linux-spi+bounces-3882-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E4D933061
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3101C224C5
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD41A08C2;
	Tue, 16 Jul 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLFNU4eM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65F1A08AD;
	Tue, 16 Jul 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154886; cv=none; b=hb8/a1ndrA+MRi1o2m8fM/Qn8HGxNrjDfgKeKD6wLsQEvYdbUGk9VYam/f57vbgjfWG8sUj9b+jUUXneM85+/tsYJomdtsTm71bfrR5q1ShBvRqn/OEg+8WRiq6Fh+1Cg23hprTCAcBDMm+5pdx2eQxRHrflSGMw8Hr27P49Re8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154886; c=relaxed/simple;
	bh=E1spAak1GIDfHhmoaZTykJRIXR72EBgWlpy2wKn63Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aImM1vNN+WdTmO6OsLfOnPeNTIFchz58TkU9vab6WjWERPbE6dNTUR/rlEBKp9kkyT5aBmOZT+WkVvKOsoWsI/3/oDhu/1Kqbwj8cXPaWhU+W0MUYsnFs5nVeQF4kKZDcTq0tPJzL6gO6Yz7WvnSKPTmGuBExKuCSi33Q+6K740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLFNU4eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D961AC4AF0B;
	Tue, 16 Jul 2024 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154886;
	bh=E1spAak1GIDfHhmoaZTykJRIXR72EBgWlpy2wKn63Hs=;
	h=From:To:Cc:Subject:Date:From;
	b=RLFNU4eM3Gk2H7oXXVwO6vUJ6vLEDAaQP3lcMS3BCUG36NMH8NEAKTfbjBygvtqOV
	 CSQKS4A1agK5LH81cWQ77Fce6GNDQgow5oAfBoBhJqY0tk91nUogTMjXRttDcf/yFo
	 e8j2oeEGCpGyMfmfyC/9j41fUkEP91wZqiIfMcijabBLOTc30fZLnvfG5cEPsTBjAD
	 PlccOlmIeaqoVWiJ23L3PPZDgsTqKquX4fXf/e/RxhxuWMdSRZ+zy52aCB13QHqpI4
	 tXoGZwzG9wrO+SDWpL1hJaxbIzKIFqLX1buybQgoy1oNVC9XRkWz9x2kNaVqSfrLYC
	 V1CJtN1uaqxUQ==
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
Subject: [PATCH AUTOSEL 5.10 1/4] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
Date: Tue, 16 Jul 2024 14:34:36 -0400
Message-ID: <20240716183443.2814769-1-sashal@kernel.org>
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
X-stable-base: Linux 5.10.221
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
index 21297cc62571a..8566da12d15e3 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1001,7 +1001,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
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


