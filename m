Return-Path: <linux-spi+bounces-6285-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3494A093FF
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87043AADE3
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF73C211710;
	Fri, 10 Jan 2025 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QaykDlSw"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CB20DD74;
	Fri, 10 Jan 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520329; cv=none; b=Fmh3yuL/ow3j3ihQzt0GYvuOL0rSLcYkyAxcLLFqo0HpO01wgjwTqkOSGXKd8hkQFZ6MMCY+/Rb90DlDw21Lyqy6u1i2UY8Tgl0b9kZFbD/o7Cc4WPlOM0g+aWWQrTHjaHquaZZX6WdzRazjCbnduBE7PR/YK7G+wDCGHw4r9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520329; c=relaxed/simple;
	bh=TQ8aXk2UITTF0V87m8Kpdw316O05nWgk6I0dD8XK6mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5/Vkt8sESKG8tFrByNMMAmbZzaAPEr90C8TA/rup2uCtystJl2rbKdLlD0CnNvSdSbLexVARwPTqzAZM8C1E81NOxReb6ZPVFgndsZ+U/gIh1/PRAJ93wN1kFO9agdUo7yGG8HADioj9iVc4o1M/C2mxOz5xQ3VtnafgiVkcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QaykDlSw; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54FB5FF809;
	Fri, 10 Jan 2025 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHPofq5XZq7az/ZH3pSbnokgc8b9g3SIFoGkVNSo6iM=;
	b=QaykDlSwtQxbTXSFx/WQbVyeesPYBW12EuQ2e83119ikzKXwERkm59oGK8cQtYV6jA7uyt
	nr0ZCtAn6FdPe6RrgAHZUYM5u6MoLPdP9IIAGGaJSQAmLzW3vc+a8hwSFBOZwUzvG9d5N1
	RjjVie2+9GL+I2Tptx7o5sBeHjizza20bxGbLeeGet2CiAEMHRZkLBeEbDnOHiRhGwYr5Y
	ItlINRNMCLBiOuXDN1+EGarnTO9PBFL6oX9U+iDjUsW7jHNbW8kimAtb9fed96Wwmrt6BB
	EBm+jPCNzi6JMVBbchseGwpaeMN7nYjD9MwmTcRdl7W6F45psfhShwxgJ9a7uA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:06 +0100
Subject: [PATCH v3 04/27] spi: amd: Drop redundant check
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-4-7ab4bd56cf6e@bootlin.com>
References: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mtd@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

Both spi and spi-mem cores already take care of checking the minimum and
maximum speed for transfers depending on the controller
capabilities. There is no reason to repeat this check in controller
drivers.

Once this possible error condition removed from the function, it makes
no longer sense to return an int.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-amd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 485ae1e382e3eb8f4d72ebb0fb15c51b9a118d3b..fbe795bbcf507abcbbd973b226b5db0de1584898 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -298,19 +298,16 @@ static const struct amd_spi_freq amd_spi_freq[] = {
 	{ AMD_SPI_MIN_HZ,   F_800KHz,         0},
 };
 
-static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
+static void amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 {
 	unsigned int i, spd7_val, alt_spd;
 
-	if (speed_hz < AMD_SPI_MIN_HZ)
-		return -EINVAL;
-
 	for (i = 0; i < ARRAY_SIZE(amd_spi_freq); i++)
 		if (speed_hz >= amd_spi_freq[i].speed_hz)
 			break;
 
 	if (amd_spi->speed_hz == amd_spi_freq[i].speed_hz)
-		return 0;
+		return;
 
 	amd_spi->speed_hz = amd_spi_freq[i].speed_hz;
 
@@ -329,8 +326,6 @@ static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 		amd_spi_setclear_reg32(amd_spi, AMD_SPI_SPEED_REG, spd7_val,
 				       AMD_SPI_SPD7_MASK);
 	}
-
-	return 0;
 }
 
 static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
@@ -679,9 +674,7 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
 
 	amd_spi = spi_controller_get_devdata(mem->spi->controller);
 
-	ret = amd_set_spi_freq(amd_spi, op->max_freq);
-	if (ret)
-		return ret;
+	amd_set_spi_freq(amd_spi, op->max_freq);
 
 	if (amd_spi->version == AMD_SPI_V2)
 		amd_set_spi_addr_mode(amd_spi, op);

-- 
2.47.0


