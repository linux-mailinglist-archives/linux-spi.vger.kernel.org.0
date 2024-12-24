Return-Path: <linux-spi+bounces-6161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365DC9FC085
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 18:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5299B1884B4D
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A51D6DCC;
	Tue, 24 Dec 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z0HzeJSk"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D417BA0;
	Tue, 24 Dec 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735059996; cv=none; b=DxkPnKhbtBjWvBtYsxoyJbG2tTmRmAuQKpMmzmJpPl6kYITz3sKz+wScWEOyKCUxljWe7LzOr8P+2U0acy1yXlM1vSPJ8LbU0cD12WrIq3RYq3zPPI1flPc1H1tSlIxFJnPtol3j5Y91BWxF21SMehZqWpGnZUcB8/0e18txe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735059996; c=relaxed/simple;
	bh=L9Q1Jnn+nR1IhScMHFpANoK+2vneQXoFzV/1HfxZ+OA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkJHC8uTVPI9dJ87Mg8J47pT3AW3VfwsnJALxSSmJjYqbN8uc/IUyEG1CUX5Nqf9VcJiQzWWsMuJXOp6yOA5AniIW4FedITqjDK1S2vxHpr8RhUi8uxyAUdsxjeAiYsOVrMELCgdGjn4iBSIg/5jcrd8xRs0At65xk2phn4NhIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z0HzeJSk; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56B8040006;
	Tue, 24 Dec 2024 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735059992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9S+oPEuCyhLEGvNj6fnjb+ZIh78/rEM10hMcWWJezk=;
	b=Z0HzeJSkWJBJAnnLOcrKAORNX+qzBkEihH4Jjz4/IRUc5pm0xpbkE/vtiZKpldy1mV+nsp
	2I1pMlURXp1r/JLH9yot2K48XCGltGgAZpOwbUeQ2wEtDXftm6vf/rBwnsy+7UOZRpVwxR
	tve89iHTqUyJ7Fwt8+3BqNLFEF8rit2S7Ve2mPwKIscx6MWemW1AHDJWrxHRdrbmg5RAGW
	oitqIZA1V2ELYhiNYnEhnoLxcMQftgvGzorm6CHdBriJF80BixVMMVDw+PJwwUL0MCeEgm
	rjDmH6frum0L+Rmx3Zy2UbqsiboJf3myDxaU5ECJEAHuN02NyHSP6zSGzaFR3w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:47 +0100
Subject: [PATCH v2 02/27] spi: spi-mem: Add a new controller capability
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-2-ad218dbc406f@bootlin.com>
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
In-Reply-To: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
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
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

There are spi devices with multiple frequency limitations depending on
the invoked command. We probably do not want to afford running at the
lowest supported frequency all the time, so if we want to get the most
of our hardware, we need to allow per-operation frequency limitations.

Among all the SPI memory controllers, I believe all are capable of
changing the spi frequency on the fly. Some of the drivers do not make
any frequency setup though. And some others will derive a per chip
prescaler value which will be used forever.

Actually changing the frequency on the fly is something new in Linux, so
we need to carefully flag the drivers which do and do not support it. A
controller capability is created for that, and the presence for this
capability will always be checked before accepting such pattern.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-mem.c       | 6 ++++++
 include/linux/spi/spi-mem.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 12299ce89a1cc80495858dbbbaa822f2968bb7ab..96374afd0193ca2cf4f50004f66c36dce32894e8 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -191,6 +191,12 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 	    op->max_freq < mem->spi->controller->min_speed_hz)
 		return false;
 
+	if (op->max_freq &&
+	    op->max_freq < mem->spi->max_speed_hz) {
+		if (!spi_mem_controller_is_capable(ctlr, per_op_freq))
+			return false;
+	}
+
 	return spi_mem_check_buswidth(mem, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 84ec524987921a95963235de4b6f728ef2fc5987..c7a7719c264846ad9fce613ba96d9284ad7893e7 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -311,11 +311,13 @@ struct spi_controller_mem_ops {
  * @ecc: Supports operations with error correction
  * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
  *	    Octal DTR
+ * @per_op_freq: Supports per operation frequency switching
  */
 struct spi_controller_mem_caps {
 	bool dtr;
 	bool ecc;
 	bool swap16;
+	bool per_op_freq;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)	\

-- 
2.47.0


