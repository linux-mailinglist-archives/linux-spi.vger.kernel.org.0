Return-Path: <linux-spi+bounces-6016-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5473E9ED543
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 19:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC085188B2E3
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3745020A5FD;
	Wed, 11 Dec 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHnVvbS1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B62446BD;
	Wed, 11 Dec 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943106; cv=none; b=tOQ0YTdnGQeYppCFrKhESKh9oMcTOki8tSVWgOvMSw+WeXe4rkyxt3ij/0VKflIvIiq8n5Xjm0K9z/Oa4wQ8KGjDtRkkK884ax5gG06lXHUgQjI5L/1ji4dObDC5CflU/yjJnz224sGXW/6CMX7vYRXVwQAXKBpaisd7VUYe9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943106; c=relaxed/simple;
	bh=yLHfV8ngkXxhgtHKKyFXreDxZ0ZXQvQnWW97XSfdb98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpUmhP7YikiC6bwB+0knrhAFcbMCLdmP0faVN47rN5+SbcXBH/gzdf3GTvMxMvQr/Up/A1lLEOGgKX1Qj811off0nmo0tUBkhawJWQ4mQJu4++DDcPJhyn2+OnHNvqIDYNE7k0wV6UiI0GbSY0zPywceWQ/UrAIPDyr9KLQpnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHnVvbS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F6AC4CEDD;
	Wed, 11 Dec 2024 18:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943105;
	bh=yLHfV8ngkXxhgtHKKyFXreDxZ0ZXQvQnWW97XSfdb98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHnVvbS1XB97kpLzTk+1XMagYUCyxC2XQKdqIPD+YRSyVJeKVVovhWljEs/pmWnCO
	 7ec/udzdaQpn6H1UDUosbAZ2tP+6uQBXYiQuKmfv1OPlFXChovIEW3GTFX9sWlLdQh
	 wJ13+Drw8prnjqFCT/WJ3+EA/TyBsTKGlURKa0U+KsRQEpbkobvB/PRtzcoiYSpCA2
	 FTXc53PgXH4czAxu1NE52q73hJdHmA+qgnTZRBMQ5EN0ewh2ewgL2Hfm1cUYjH+Vl2
	 HGTym8lptC0FAz6Xya+wNx+QPgjHT6erIUkT5V0JRDagNSXBREVe2/OOMCAZ/x/JQ3
	 SwEKSfBsIr13Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Purushothama Siddaiah <psiddaiah@mvista.com>,
	Corey Minyard <cminyard@mvista.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 31/36] spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()
Date: Wed, 11 Dec 2024 13:49:47 -0500
Message-ID: <20241211185028.3841047-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
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
index 2c043817c66a8..4a2f84c4d22e5 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1561,10 +1561,10 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
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


