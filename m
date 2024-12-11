Return-Path: <linux-spi+bounces-6018-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE3E9ED593
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 20:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD1188624F
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 19:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFD224A837;
	Wed, 11 Dec 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4tXRiXC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EAF24A839;
	Wed, 11 Dec 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943173; cv=none; b=Rko/YEdiosGYzO8ZdSK+yL+i4DAf7rlLZfE8Ru1nSzIc4u7NxGgFOBO8NtrBCQMpxeYvp1WjpzrX0KB7lRE1kTJ59ASsjHRuH6PZQwB5TxgXDvx6Y0qVv2KuxhfQXyTNflulXTs56lvtiOkI57zb0lV/5kETAxox6cROdd6JWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943173; c=relaxed/simple;
	bh=FG+mEMEsLOooDcPQbueLNeh6pj7pkkQvyu3TNfxp0zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqzMSMyLeTZhZuGNQYNSkhlMF/2Lr1Y9ynKwmJs8Nfeji5Pb/1YCINak0vOnT9q4zXk30v1fe1m4rg/1ya7yqPAk0AFn8vL/tm+h+FJoko/eZCULraEpDWEE8ejYK8TJyIMwPTskWmPmV20FdPi8XpaXVkYopOxWJHK47gPVJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4tXRiXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9815C4CEDD;
	Wed, 11 Dec 2024 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943172;
	bh=FG+mEMEsLOooDcPQbueLNeh6pj7pkkQvyu3TNfxp0zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4tXRiXCdDPMLHUgwMPuIp9I5NvSxfRt8RAkdt7NANz3qSPiT6GsqQNYcjY9eEttF
	 ZTaRPGhFh7yNxsp0lHrRO4JXsDIb55pWC6VvZTnn0RQWgsdotKeMQGsB+ua2CKCd7O
	 qu/WG6Sc4oEg2iiRURP6jmXVwgRHxVdaNFsnm/DZbqJ0E+7SWPfzqoLwaPc8nDPpv5
	 TfBQZp+s2iniqL5yk+5AGYyP+stabQ4SX4gzsCZvLIj1O10xIFF4VocmY+0C2F3yok
	 GyowElZH+RQkQfP0V0E2s5nBF5DHmFyWjUIFTOxm+FmKUoWmzV0q8AIJ94+JTFzbOM
	 gqD/2uOiRRlLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Purushothama Siddaiah <psiddaiah@mvista.com>,
	Corey Minyard <cminyard@mvista.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/23] spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()
Date: Wed, 11 Dec 2024 13:51:55 -0500
Message-ID: <20241211185214.3841978-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
Content-Transfer-Encoding: 8bit

From: Purushothama Siddaiah <psiddaiah@mvista.com>

[ Upstream commit 4c6ac5446d060f0bf435ccc8bc3aa7b7b5f718ad ]

The devm_clk_get_optional_enabled() function returns error
pointers(PTR_ERR()). So use IS_ERR() to check it.

Verified on K3-J7200 EVM board, without clock node mentioned
in the device tree.

Signed-off-by: Purushothama Siddaiah <psiddaiah@mvista.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Link: https://patch.msgid.link/20241205070426.1861048-1-psiddaiah@mvista.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index ddf1c684bcc7d..3cfd262c1abc2 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1521,10 +1521,10 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
-	if (mcspi->ref_clk)
-		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
-	else
+	if (IS_ERR(mcspi->ref_clk))
 		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
+	else
+		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
 	ctlr->max_speed_hz = mcspi->ref_clk_hz;
 	ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;
 
-- 
2.43.0


