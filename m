Return-Path: <linux-spi+bounces-4182-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0279A9511EA
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346331C22773
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 02:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE181CD13;
	Wed, 14 Aug 2024 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM+LBOaf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92F1CA96;
	Wed, 14 Aug 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601696; cv=none; b=X6UVoBgMlzauTPlSd5BiXvFIgnqU9hnf3LFDDWHydv/e8ipAtBOtnLED/tYhpDAwuFvUvd4Y1HqPvaOt3S6+3QelMArh/SJ/gwcI793IaQa7CtoRQF2TtddoRaP/9lh4los8SVyQq/hKtjkMyV3bwXPe6FHsysTKGOZLdvjLfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601696; c=relaxed/simple;
	bh=fwlmcn5o1BPF1VUgfE84xYkeQ2olPznqF/Ss/KWNePc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMwI+y81Ug5BGfAviA/nng0yZIzY/5PpO4xXRcnMOINoJccO+U+BvoiAT4m3XuoGjNxW6yEs1QEjtup7KVcSAiWuDYHlDHyeiqVvgLMtQbtfe+t/aJ6GVRvv23PXr28W9d2fsyrQb3BhgA8jIeZi0uRjHb2Anx6AvLcdkw7gTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM+LBOaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9811C4AF0F;
	Wed, 14 Aug 2024 02:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601695;
	bh=fwlmcn5o1BPF1VUgfE84xYkeQ2olPznqF/Ss/KWNePc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kM+LBOaf+qc8aez8aRvFhuyVCTCsfDk2rHbFvGM9hAimVy8IMCmMGFPzcwy7y0uYE
	 wBM9CQKWdMJamTGeT16lt/vsctKkh1q++K51hvLUsR4aFcIKvy8gYHSE1BRunC71xQ
	 j278JmKIVWYafroeSk4HOmfTLqzDmAPVycsnVFw7ZUu0yDs2f72JOpuflMWV6rCXS0
	 OkspyaBniOZm+lCbYK1EAVuANmemJyzZi0axxoBHgGrSb5lmz/8UIyUjecv9OSRGIv
	 wm2KtQhwLGV9WiS3AnUw2H+doU/c4nRIEg1Mb/Q4hli9SnDl9LoKTkzE+D+deh3flG
	 Il70/Nd5VgOeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devyn Liu <liudingyuan@huawei.com>,
	Jay Fang <f.fangjian@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 02/13] spi: hisi-kunpeng: Add validation for the minimum value of speed_hz
Date: Tue, 13 Aug 2024 22:14:33 -0400
Message-ID: <20240814021451.4129952-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Devyn Liu <liudingyuan@huawei.com>

[ Upstream commit c3c4f22b7c814a6ee485ce294065836f8ede30fa ]

The speed specified by the user is used to calculate the clk_div based
on the max_speed_hz in hisi_calc_effective_speed.  A very low speed
value can lead to a clk_div larger than the variable range. Avoid this
by setting the min_speed_hz so that such a small speed value is
rejected.  __spi_validate() in spi.c will return -EINVAL for the
specified speed_hz lower than min_speed_hz.

Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
Reviewed-by: Jay Fang <f.fangjian@huawei.com>
Link: https://patch.msgid.link/20240730032040.3156393-2-liudingyuan@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-hisi-kunpeng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 77e9738e42f60..6910b4d4c427b 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -495,6 +495,7 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	host->transfer_one = hisi_spi_transfer_one;
 	host->handle_err = hisi_spi_handle_err;
 	host->dev.fwnode = dev->fwnode;
+	host->min_speed_hz = DIV_ROUND_UP(host->max_speed_hz, CLK_DIV_MAX);
 
 	hisi_spi_hw_init(hs);
 
-- 
2.43.0


