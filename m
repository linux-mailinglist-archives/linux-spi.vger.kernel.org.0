Return-Path: <linux-spi+bounces-4985-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3D2986F03
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 10:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9861F234D0
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EDE1A7255;
	Thu, 26 Sep 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Fkqf9ZCd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0CE39AD6;
	Thu, 26 Sep 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339909; cv=none; b=YTTfeICgVEfB4EioI4MUDpJ+Z0cXklFeT/FIcOQ7o8noNfnlbu77RJBeEwQlVDpVLdDRauDh78xyTNtTQYU/zr4U9CothU7FTflEFk+GJOJCVvkhcxlyDWJmIgXfpVWZOsg4sGnA+PKgxxnKBkob/wX4l4vG2j4cNYEBQaTclLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339909; c=relaxed/simple;
	bh=pzJ7mKNqQw5gkoS9FXyW9xaAO7Jfqin+RPHbMq/9LGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjnvyhQgczAjr3AdQifpjklB+xKB66aXq+dfKVN4a6dWjaG4B5ikdthwY7H2jfwKr5koYonlZKUOLnKgoSdvfY2k13AKoIEOqzBkZtHahGXZcIJXbcgRCtLNQ+IqPA4bj/eyUA4BjQvX+B5O6Wa/3gxxtqaVHQJ0Z7DwFdo1A14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Fkqf9ZCd; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727339906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TZTm9G40QKJombFH2v6+fmEe7Da2EmVAJMyeMXsFnE=;
	b=Fkqf9ZCdiec98LA9/HwKlLSiB0j8z4f0hddfGgtUwE9BYcI0+TtHuF7cOjYh8Bp+EYUZ/i
	qsEKvJYxUS+1s7uB9p4LeI9sBbuc7ez2DFupsdAXS/fxhJFTMzF6yGv8YxHb/s1mI0ZEI0
	TDa55UcVlONeE6issvBih62aBiltlBwW4mV6dW7tehrOgAuOJH/cnmZI9Yqr3Uxj9wnlQJ
	7Abw3DGMf1iWgTpF61w7Be71XCHCMm+UuIW+24NZo/2ji0HX1NNI76dNcNCX4gM4MhEyXh
	GKXRojS8xm0S5lm0ZxdfB2jPVNhira7SUlfExjWHU6xxSciUq1R4qO175Uewvg==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] spi: rockchip: Don't check for failed get_fifo_len()
Date: Thu, 26 Sep 2024 10:38:14 +0200
Message-Id: <ce2e7f90e62b15adc2bed1f53122ad39c3a9b5ac.1727337732.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727337732.git.dsimic@manjaro.org>
References: <cover.1727337732.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Since commit 13a96935e6f6 ("spi: rockchip: Support 64-location deep FIFOs"),
function get_fifo_len() can no longer return zero, so delete the redundant
check for zero in function rockchip_spi_probe().

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/spi/spi-rockchip.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 81f2a966c124..28879fed03f8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -816,11 +816,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	rs->fifo_len = get_fifo_len(rs);
-	if (!rs->fifo_len) {
-		dev_err(&pdev->dev, "Failed to get fifo length\n");
-		ret = -EINVAL;
-		goto err_put_ctlr;
-	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ROCKCHIP_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);

