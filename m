Return-Path: <linux-spi+bounces-3069-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EDB8CE109
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 08:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571D91F22009
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 06:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E752230C;
	Fri, 24 May 2024 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuiGhPX8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A302207A;
	Fri, 24 May 2024 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716532535; cv=none; b=HSpUy73TYBUyYxwuaIgUm6IMV/yVmT97q5Up6EdbXSl0dSu1mnFEgJZgSqSdec7+81n3E9FXJu3VVXlTre0aEsH/gd9LczZoc4fhqaMkiTrJWy8aIadq2KlG9M/cKf9NEpusVKxpeXSvy6xgXtb2XvzrR5HX8QRpswyP7uU03g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716532535; c=relaxed/simple;
	bh=ks0yyEHzhf2hoBGsWlNtWBNlJ0xLFKy7RtVEWtXzxmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B9BxGWxeyUT9Q7th9EYdeIPaYNbw3axeWM/DqIDUbmG7YX2Yiv7azy0VgmvM8g2BLM8XRJ/nECgtEDFJtzLcEWL+0fLbQ5H10sMC1dAbxy2OShjXaEUvx8rdYnWJ5Ma+OB4HrgI7ya6YmuS/S6BjfKcy0OAXChRXnOm8gjErpTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuiGhPX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E9DAC2BBFC;
	Fri, 24 May 2024 06:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716532534;
	bh=ks0yyEHzhf2hoBGsWlNtWBNlJ0xLFKy7RtVEWtXzxmo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OuiGhPX8IeGhydH4T5uM2zrVtgddGh8fRBotyAOxMasXGLObsKIxYovpv7KZuHbhI
	 qet+0+kKOdUjb0okaM/7ksfSOmZGQ1V1L2x4xpalN1ttcnleXF+CPqwkJsLtwy5H7B
	 fg6fifz2lR0tHcK8KOK2lory+rX5ce31y2ov9CyuVp2OS2Lh6dEkx+5NTjVrEA7IyK
	 ZzrdDpruIyyDgkEmAI1Lo6LnzlQeIcRuWXfbFAkQQToCXbkr5psW0az6Bwp0Sk0uvt
	 OZq8ib7hJZRD+Pwm4sBlot6OiYdCMCJbZEO/lLy93gU3RbTOBRz8KaJq9bxQKtJqc8
	 S7/J4UpUCxpIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E97C25B74;
	Fri, 24 May 2024 06:35:34 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 24 May 2024 14:35:09 +0800
Subject: [PATCH] spi: meson-spicc: set SPI clock flag CLK_SET_RATE_PARENT
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-spi_pclk_setparent-v1-1-99e0ce70b66f@amlogic.com>
X-B4-Tracking: v=1; b=H4sIABw1UGYC/x3MQQqAIBBA0avErBNyyqCuEhFiUw2FiRMRSHdPW
 r7F/wmEIpNAXySIdLPw6TN0WYDbrF9J8ZwNWGFTGWyUBJ6CO/ZJ6Ao2kr9UO1vsajRO6xpyGCI
 t/PzTYXzfD52+YXpkAAAA
To: Mark Brown <broonie@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Sunny Luo <sunny.luo@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716532532; l=1803;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=i2kf4hjt27aFCniu/cvi7M+Wdce80gPI7LhS2KX7ULY=;
 b=ehUpQ96FcIL43Duzap4N1C5TOSDRp6ZTDXvwx0+NTo1ezJmCXPgZdeqeFOUDsub3YptIpzR9q
 oATZyZAAqSYC18IypOtnO7eSAWfPzir+KMzfpkM//iyvrIIRc6AhJXK
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add SPI clock flag CLK_SET_RATE_PARENT for using pclk as parent clock.
This gives SPI more flexibility in frequency selection.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
---
 drivers/spi/spi-meson-spicc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index fc75492e50ff..8a4a8ba9dfed 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -644,11 +644,13 @@ static int meson_spicc_pow2_clk_init(struct meson_spicc_device *spicc)
 	snprintf(name, sizeof(name), "%s#pow2_fixed_div", dev_name(dev));
 	init.name = name;
 	init.ops = &clk_fixed_factor_ops;
-	init.flags = 0;
-	if (spicc->data->has_pclk)
+	if (spicc->data->has_pclk) {
+		init.flags = CLK_SET_RATE_PARENT;
 		parent_data[0].hw = __clk_get_hw(spicc->pclk);
-	else
+	} else {
+		init.flags = 0;
 		parent_data[0].hw = __clk_get_hw(spicc->core);
+	}
 	init.num_parents = 1;
 
 	pow2_fixed_div->mult = 1,
@@ -708,11 +710,13 @@ static int meson_spicc_enh_clk_init(struct meson_spicc_device *spicc)
 	snprintf(name, sizeof(name), "%s#enh_fixed_div", dev_name(dev));
 	init.name = name;
 	init.ops = &clk_fixed_factor_ops;
-	init.flags = 0;
-	if (spicc->data->has_pclk)
+	if (spicc->data->has_pclk) {
+		init.flags = CLK_SET_RATE_PARENT;
 		parent_data[0].hw = __clk_get_hw(spicc->pclk);
-	else
+	} else {
+		init.flags = 0;
 		parent_data[0].hw = __clk_get_hw(spicc->core);
+	}
 	init.num_parents = 1;
 
 	enh_fixed_div->mult = 1,

---
base-commit: 3aac9f4885922ad0fc01b86f85903768219475a3
change-id: 20240524-spi_pclk_setparent-6da29325c113

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



