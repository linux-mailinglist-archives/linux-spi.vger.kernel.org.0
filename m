Return-Path: <linux-spi+bounces-4183-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76422951211
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 04:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13493B208A2
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 02:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3113F42A;
	Wed, 14 Aug 2024 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg3Ygvkh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5313E02C;
	Wed, 14 Aug 2024 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601722; cv=none; b=fW1ONRBm2rF9pua3wpVJ0bVYb7pVKvlxeHC285MCDnIpSxgWtmnLsQrU7WcMcQKM3r7RfPKZW4yEVNcw+z6XkgQKmrw9+ccl9LnB78B8a5N1Q9KcORlNuHuxTAkwSPRlYA/W6hhL9TXdGc+29e6QitZsTewnRslLiy5ENRWYxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601722; c=relaxed/simple;
	bh=fwlmcn5o1BPF1VUgfE84xYkeQ2olPznqF/Ss/KWNePc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTja2KTQx/PigvCcbSjYGh5bFhzqYVPTfWsJY80KEUnJs6+VyaEtVnH/GJwS1dqnkZsPY9ZPRaQvV9B8VNYlj2wWvuHVz5xswLq8s+bUYWXeGoK9zwZs0tW4j/Vb8DJgC1xVmiyDxY+O88NJWzqbr1pzVd3/96WbApBbnvMfiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg3Ygvkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0636C4AF0F;
	Wed, 14 Aug 2024 02:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601721;
	bh=fwlmcn5o1BPF1VUgfE84xYkeQ2olPznqF/Ss/KWNePc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sg3YgvkhbTeD/1rruIC0uvvU2bXGMX2UsFpf2K5PL01maaTPh3/MUC9JjEr3yZIER
	 m8rn3cY0kfTy8QtWaIwc8Ci4WxUlrV+UPnHlXyBBsOaiSij3wDtz05aKXSt/MgFzMa
	 LCf7dEo/wHKsehrJmOuXzvMKpGRtq2Uq1d6uUmLKb4ClDHGwLb3BrVGIpRBWt+s/iK
	 v+QjGgCA5pmm7+XrdLgc6Jbb9VGrKnWDO6izrHsJn3jQSXOPAWntFRRXcr35oeZOh1
	 ZXZnGNBnCb42Cg6LGgMAPIRyNZOHz3NjSG/kP3anzrolcWJmNQnD7rS03yjf4Zwlyt
	 6SWli51KNg6RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devyn Liu <liudingyuan@huawei.com>,
	Jay Fang <f.fangjian@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 2/7] spi: hisi-kunpeng: Add validation for the minimum value of speed_hz
Date: Tue, 13 Aug 2024 22:15:08 -0400
Message-ID: <20240814021517.4130238-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021517.4130238-1-sashal@kernel.org>
References: <20240814021517.4130238-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.45
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


