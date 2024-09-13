Return-Path: <linux-spi+bounces-4812-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72818978A6F
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 23:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FC5B20A4A
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199F148FEC;
	Fri, 13 Sep 2024 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlo8Ga5z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1AD126C01
	for <linux-spi@vger.kernel.org>; Fri, 13 Sep 2024 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261658; cv=none; b=Sihk2hhyA8l1m4BmUjkuOLgXo/JqizkGaHAmjMNQ2L0QI8VEKXBdEK4Zh+yORN3ICncmkDHYvjYg3Dbj1m7/tesj3ndwYuKHFiVyT/hmlJGHbE1JIYQOOcr3JVlw+NGl/Rk9ercDWVgzA/x975QMvP3fbsLWJF5fXAgDbsMbg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261658; c=relaxed/simple;
	bh=YQLWHS/MsoePx6rxsH4eENXnN+TYWJB2F/5JkR3bs6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2b9qNj55T8uCqJLhPUiHfGIlv61/H0pB+LJp197Q6PWWDU6QJ3rPMCzA5/eHH6JdZ//0w3rmCckgXsvij+qIAyzu9FK0S4n676qCA8h7iqmuwgcMdiVCV9mfrJec0EpMohxOj+nUI4k7oyDhAxP8YhB3JqFdjClBKr4f0++T4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlo8Ga5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BBDC4CEC0;
	Fri, 13 Sep 2024 21:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726261658;
	bh=YQLWHS/MsoePx6rxsH4eENXnN+TYWJB2F/5JkR3bs6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rlo8Ga5zuHd5bgKxfDTXp6yl0pSgelwMH5wCi8zrbsmf+l/7MSIO75bGG399X+O09
	 xacjXexmd7zpAxG688IJKhCQFXoYe4irWMdBjMtiXHnKLPb7ZFAjprDS3uVH8Qka+z
	 e4p/IR5/UL5vMknvDuGLiUIqg6Gho3Y2RXC/9DDO3jw47tJCvRB+ZZ/lMuU3r8k0lb
	 n8BoiEp5UmnODQR7O0BX+4cUN1tbtr5P8lf+hgJ1H8oV7pffrLAIHot7ZBuH5Cet2K
	 bTSlZI3m3x6YwQS5yhvCZL3mcdqQVJVRIUP0FpIR7mOzGxjGb8YdfaItFsiFHJWXgR
	 dgmjnH6tcbWUA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 13 Sep 2024 23:07:13 +0200
Subject: [PATCH 1/4] spi: airoha: fix dirmap_{read,write} operations
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-airoha-spi-fixes-v1-1-de2e74ed4664@kernel.org>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
In-Reply-To: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Mark Brown <broonie@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.1

SPI_NFI_READ_FROM_CACHE_DONE bit must be written at the end of
dirmap_read operation even if it is already set.
In the same way, SPI_NFI_LOAD_TO_CACHE_DONE bit must be written at the
end of dirmap_write operation even if it is already set.
For this reason use regmap_write_bits() instead of regmap_set_bits().
This patch fixes mtd_pagetest kernel module test.

Fixes: a403997c1201 ("spi: airoha: add SPI-NAND Flash controller driver")
Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/spi/spi-airoha-snfi.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 9d97ec98881c..be3e4ac42153 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -739,8 +739,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		return err;
 
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
-			      SPI_NFI_READ_FROM_CACHE_DONE);
+	/*
+	 * SPI_NFI_READ_FROM_CACHE_DONE bit must be written at the end
+	 * of dirmap_read operation even if it is already set.
+	 */
+	err = regmap_write_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+				SPI_NFI_READ_FROM_CACHE_DONE,
+				SPI_NFI_READ_FROM_CACHE_DONE);
 	if (err)
 		return err;
 
@@ -870,8 +875,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		return err;
 
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
-			      SPI_NFI_LOAD_TO_CACHE_DONE);
+	/*
+	 * SPI_NFI_LOAD_TO_CACHE_DONE bit must be written at the end
+	 * of dirmap_write operation even if it is already set.
+	 */
+	err = regmap_write_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+				SPI_NFI_LOAD_TO_CACHE_DONE,
+				SPI_NFI_LOAD_TO_CACHE_DONE);
 	if (err)
 		return err;
 

-- 
2.46.0


