Return-Path: <linux-spi+bounces-3385-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B660A90575B
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426B1B27E2C
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D38B180A9D;
	Wed, 12 Jun 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM5rd5EJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685C180A9B;
	Wed, 12 Jun 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207335; cv=none; b=ev7aZmG3LT0oCk7y8Yhye6hDs25MwYjPcVmv8kd0CqO56iibb1RpMmuDyuclyUILegxE5zgIWhu9oGfq/aXMJUEuxoDT8SdZI7UtmOBmoTJtrb1g24g26glqnrA7w/m4ox+V1THwQtzGT7HVCFJd4QoQI7vs7bcH8icMeZcqXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207335; c=relaxed/simple;
	bh=P1vOj2Rn7zuoaBh6AcqrcUTEi1rovxUtpHsy8CmdHr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKH/xprh0/s3EeBnlaCjPCXZIZF9ZKCgbEgrtxNGXnoinssUsFhAfprjTDRXs5x6oWKJ2Rd/cFPfKMZieOyhkprvAg/CpLwU97jGCyo1pTYsKQeUOBYuOIpN/7KXw4a44U48MnJZkspVtF0g1TXE6w5HHqS0/p0HbbICcEP4Lp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM5rd5EJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9393DC4AF1A;
	Wed, 12 Jun 2024 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207334;
	bh=P1vOj2Rn7zuoaBh6AcqrcUTEi1rovxUtpHsy8CmdHr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RM5rd5EJCfJaPHSF6RHPKysoR8lv3CkSLd4g2Berb4nT2sHLtIYnFt6NS60oRpl9g
	 oELj9VAHV47yQv/PW5bqKN4G8Pzc0J1OY+DCv21YxQEmcmfzvEUyCFc6XGpr3gaL8v
	 m42aKyyJ1o1WH/8kPZXWMVyo3tMASfqukyObPz/hrVo29vqFl0+HXgLAaFlXJvcA2h
	 5/zX4wXMTZOpYBUz+HtYelymZidotMFyoqz6B3QVwizDw5s+ubMk2Io9m2dkQ83SVE
	 Jpi6Eyt0tUJpbyJ0XNr/yRaFoytL9m/duTvKpg9sooyAurw9t6/PBbTepntmShB9Rn
	 7x12qvQbD/Rxw==
From: Conor Dooley <conor@kernel.org>
To: linux-mmc@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	cyril.jean@microchip.com,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [RFC v1 1/3] mmc: mmc_spi: allow for spi controllers incapable of getting as low as 400k
Date: Wed, 12 Jun 2024 16:48:31 +0100
Message-ID: <20240612-dense-resample-563f07c30185@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612-brigade-shell-1f626e7e592f@spud>
References: <20240612-brigade-shell-1f626e7e592f@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=tXCkjnYnQevs4Hom30XLCG5d2XL7igKpnQRl5B2TRkw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmZh32YQ6LF1YxuVN44oVfcacC3NEQq8fP2UjmeHOsvU xz69Sd3lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCIsPIwMn456V+r3ir64lrdo KmPhpIDV4u8mNB94t0Rwf1q/maEiD8NfmZ3axzc5JC2xrbjnZyYflvhFedPN8EPp4tfsC9ds3DW BGQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Some controllers may not be able to reach a bus clock as low as 400 KHz
due to a lack of sufficient divisors. In these cases, the SD card slot
becomes non-functional as Linux continuously attempts to set the bus
clock to 400 KHz. If the controller is incapable of getting that low,
set its minimum frequency instead. While this may eliminate some SD
cards, it allows those capable of operating at the controller's minimum
frequency to be used.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mmc/host/mmc_spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 09d7a6a0dc1a..c9caa1ece7ef 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1208,7 +1208,10 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 * that's the only reason not to use a few MHz for f_min (until
 	 * the upper layer reads the target frequency from the CSD).
 	 */
-	mmc->f_min = 400000;
+	if (spi->controller->min_speed_hz > 400000)
+		dev_warn(&spi->dev,"Controller unable to reduce bus clock to 400 KHz\n");
+
+	mmc->f_min = max(spi->controller->min_speed_hz, 400000);
 	mmc->f_max = spi->max_speed_hz;
 
 	host = mmc_priv(mmc);
-- 
2.43.0


