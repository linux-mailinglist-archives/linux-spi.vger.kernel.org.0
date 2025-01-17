Return-Path: <linux-spi+bounces-6400-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB6A153F9
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 17:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E141883A9D
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A591946C7;
	Fri, 17 Jan 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqNZfxnh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A018A6A7;
	Fri, 17 Jan 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130576; cv=none; b=dvoQwMTEwWJw/D8mZ3p1KFhvi9qs6VKsvLRtJV2gpUF1PG9V9rz4j/8exqGQRn+mHfFpjsOnK6ei1SsR8Vr9D61YCWNRZfLix8ogKviChjVuSUrOx5H962AULRLJJTrHxXCzE6V3IlAdrZt0K7RoKn9aNv5y4bV3hr2zkpcFdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130576; c=relaxed/simple;
	bh=SThbwG8MU03tSAQ1QiSj+OihJ9acx2aD5+sejCEuQq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=odbth7AevDRMYjZ8QZx7FdSuPOsE7Wn/8YWQQHyBiwU+4tY4piwXrqJEw6SmBEV24va0JKyYLx5OodmeJ+Ojxpg5CeCjVMjW04kcWPv97x3nI9rGbpUxMYkBktRFH2nv6+/0QMsYcHS2QsP2aeFKNLS07bpHpU//fJmSue39aQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqNZfxnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4659DC4CEDD;
	Fri, 17 Jan 2025 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737130575;
	bh=SThbwG8MU03tSAQ1QiSj+OihJ9acx2aD5+sejCEuQq8=;
	h=From:Date:Subject:To:Cc:From;
	b=EqNZfxnhIFk44mnCkA3ByWZRyz/Zn4XkL4VHObL8fUt2qSOdI4yie4Jz+hvhz/wtk
	 Zod70qvVchZy7G2f21EKsy6it8+oCex5Rl3a4jkvPLsx/kIcxwU8SHkvyHovbgT1S6
	 DEQP7u+rm2W0M/FrlzZzo6lVTzQHP7jQy95patyBcrue+FfbDggYgf0Qh+cyCJ3IkA
	 NFJEWx9yV4bp7x48c95YTdq4vW9QQ/q4GOOL5DgVp+55k4ZLWHRvvxYaKQu4DbSsiG
	 oo7ldyW4B/z4YzL1xRaL2iVJ7lnEaQPAHxE2dvKY5E7z2Zd2JjR5MuABIwM7JnabO1
	 iLzrIJMuCqvoA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 17 Jan 2025 16:16:03 +0000
Subject: [PATCH] spi: omap2-mcspi: Correctly handle devm_clk_get_optional()
 errors
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-spi-fix-omap2-optional-v1-1-e77d4ac6db6e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEKCimcC/x2MQQqAMAzAviI9W3BjDvUr4qFo1YK6sYkI4t8tH
 gNJHsichDN0xQOJL8kSDgVTFjCudCyMMimDrWxdGeMxR8FZbgw7RYshnhrQho0jqp1pfMseNI6
 J1frH/fC+HxMY7OJoAAAA
X-Change-ID: 20250116-spi-fix-omap2-optional-84aa541869e6
To: Purushothama Siddaiah <psiddaiah@mvista.com>, 
 Corey Minyard <cminyard@mvista.com>, Lars Pedersen <lapeddk@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SThbwG8MU03tSAQ1QiSj+OihJ9acx2aD5+sejCEuQq8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnioJNWLaUCZh2oTVn5Bhut2f5hVEhWF65lONlBGZO
 keQtmC+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ4qCTQAKCRAk1otyXVSH0InCB/
 9utvwY2h6YgI+nEkXKLizE9FEFYol0oeqDPR/xyGB6XbSsZvaP8GqqYmC5b/rOITGnwniVRBiGQ/+v
 bC/NkttrUDgbeWv8UA/SVQoMjc2NqNUvjQb/vpbVsUg1gNqMDnaNbDxHirIaPiIybVWVgeX9Ftbu/7
 T6/qzArq3f2qU+8nXiqutc5Jm0cG5F0bPx9Zk2ghOpL5+LpsAYk5c+H4SXQBQfeyz19dgfUTEG74wW
 r4VElYpQv5K3Tdv2OpkY+19oZCZ6JCJdbJaWGq2LV3pQS3tpNSApRAe+XevFJrYfpTapgYKcoACRRA
 4h6Eli0xAcO8PmYW6X4a7yTcbSWy/a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

devm_clk_get_optional() returns NULL for missing clocks and a PTR_ERR()
if there is a clock but we fail to get it, but currently we only handle
the latter case and do so as though the clock was missing.  If we get an
error back we should handle that as an error since the clock exists but
we failed to get it, if we get NULL then the clock doesn't exist and we
should handle that.

Fixes: 4c6ac5446d06 ("spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()")
Reported-by: Lars Pedersen <lapeddk@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index add6247d348190452918900b145c3c5a00e409b3..29c616e2c408cf26b150a853f789128d003db1f0 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1561,10 +1561,15 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
-	if (IS_ERR(mcspi->ref_clk))
-		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
-	else
+	if (IS_ERR(mcspi->ref_clk)) {
+		status = PTR_ERR(mcspi->ref_clk);
+		dev_err_probe(&pdev->dev, status, "Failed to get ref_clk");
+		goto free_ctlr;
+	}
+	if (mcspi->ref_clk)
 		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
+	else
+		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
 	ctlr->max_speed_hz = mcspi->ref_clk_hz;
 	ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;
 

---
base-commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
change-id: 20250116-spi-fix-omap2-optional-84aa541869e6

Best regards,
-- 
Mark Brown <broonie@kernel.org>


