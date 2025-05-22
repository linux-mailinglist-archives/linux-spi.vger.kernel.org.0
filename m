Return-Path: <linux-spi+bounces-8246-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30988AC0ED3
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5AB4E4C3B
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4DC28D8F5;
	Thu, 22 May 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q767goUG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BCC28D8D0
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925566; cv=none; b=pUyMBiuMfAdjwWHYZ01jFeCpRf/hQk1c3uo4XWgV/iOWa4G9SMonR3to59rPCHM9iueGY7f6gaCLijPzcUqaqNQLCKeb8ehp9BE7b1WAgpSkUzltxAWuZ2CMGfnL/Aj2czIdQCpeiRymbTk6Nbt+R0bfdfKajRio/H7P97ZkUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925566; c=relaxed/simple;
	bh=Gr3cboO2VgYqQP244ZhA1hFWwPu7MtqcNmqMsKaVD4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0zyOg/PPnX19788tYgU7fv1H9iuYk8NGFJVMS6huyDpnSa9eKSx+bdEZFAEAwnRSX1wNjaPSdCnXg9rQ82rBljr+R+1oYkvfpVkjC06MkxwW549hj9dYZJ+oYQnElGPGZwp96uWIjFQm8qrB+2VJowvVssv8RSEtaDXZfeDqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q767goUG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441ab63a415so87078955e9.3
        for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925563; x=1748530363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnsHBRMSS57g5A6Zsxv5fUehUSBOq6hPCzrwmSugvPA=;
        b=Q767goUGtzwsNUTnxze5UvPEBfG7fzoVJyLCED935FvsB6lwbzvWxuabklQDnHAl28
         njMFvURZztaFUzhoFCktOd0OPgxcbYlzg3Yy8fEAn4fdB5DO72I/NmFKW68OLyhTa50K
         hk4LL81gPCLqUXWbicGlrnuBN+O64o5e5DFYYReH54Lvz3wYV/jAiVp01MnsASErLfnc
         ZUbvRh35WMNOSb+CgcY2jMn87HAm7dPfjV0BiQAKpHkMdIwQWgSH4JLmCvyblFrngcOC
         w1toT49CTW/05kn7v8i+niLSvtWdsOhPmnou1OYHkapOLkF7e4WEJJfkpDay+xCCPp/d
         57RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925563; x=1748530363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnsHBRMSS57g5A6Zsxv5fUehUSBOq6hPCzrwmSugvPA=;
        b=hzkx/DsNVfByddwzfxxfxLFkF0YAllYMKkEJXxHD5zzEO0VbyE2zj0K1+iIr7tscfj
         t7n6It6qauFmSw3TbPRJ761bQ3kiELyD77hWEcERDQK1OrVJDzdA1JyuVhoDKareJ1Dy
         +Xe+SkhUyDsa/WT0QJnvdlsnviYL6bJTvTbNGcb0NaVEkQZdix6jUV3szikX4yU1Nl1G
         LMAu0UtcdEZFyvl1qP8xbGBX4lO7LLm4X13D4FbprTigVIO0jSPq/V64fUT0wl2zHVpH
         7/AwVX3yfgqP8DDWO6f6fNYI2yQfISyjqV8igodyZVkIWB4j8GFkLWou58rcpbckX7b2
         /FZg==
X-Forwarded-Encrypted: i=1; AJvYcCU+EUTgGD50u4xhmW5zrfhzUGGcqbNUXh3FVRgLinboBRqWNl9DXOWR0w68RofC+kZMOiGjZp+M3hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjHWtK8atTs7lHCVzKwHfJ/YU28HZFyMRsbd+SbXUp2s3di9r
	59oYiS8l3bYyP47jgCLRGwSyKWyoZbfmDYLJC0ivjzAbAJD0FKa/0+sq4LoM7Pn3USI=
X-Gm-Gg: ASbGncsRElaWZHfj1JkUdr2NwXIBgByzK8emuxi6yitlBypkG8gMMOcH+MivOmQZHEt
	zSEsbJuqnGRIklAI0ijkt8kzLMUfusX+roOsoL/Cq+t2oApAdymWlsLzqpM+2+OZyjpuKyoE7Q4
	CICDECOOPdY90r2o5yiGJlIyW452sPpXfvoWreaEfdtxVWGwmV8GE8gTQzQXNXPeQp6iegin1Tc
	n7Lfz7Pda0UJXNwxDgnKNLL5O8/B0KTIjirXQq2kC0ifl1bl6cX8fMXiW20HvGyi/YHjD4NGTmX
	fu7C1TAUnm4QEqZwLmSDMP12C66cyV0r0ysQH6z6PgrsLx15PdI7puVLEtVK
X-Google-Smtp-Source: AGHT+IEm/t82lB7n4D+jawYNq22d+sbqAeLEow+7pvP2Bzn0+lqXr94xgdIsdIfmG8+O8swf/6lS3g==
X-Received: by 2002:a05:600c:3112:b0:43b:c0fa:f9cd with SMTP id 5b1f17b1804b1-442fd606b99mr238110635e9.7.1747925562768;
        Thu, 22 May 2025 07:52:42 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm104965555e9.27.2025.05.22.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:52:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 22 May 2025 15:51:31 +0100
Subject: [PATCH v2 02/14] spi: spi-fsl-dspi: Halt the module after a new
 message transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-james-nxp-spi-v2-2-bea884630cfb@linaro.org>
References: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
In-Reply-To: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chao Fu <B44548@freescale.com>, 
 Xiubo Li <Li.Xiubo@freescale.com>, Lukasz Majewski <lukma@denx.de>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>

The XSPI mode implementation in this driver still uses the EOQ flag to
signal the last word in a transmission and deassert the PCS signal.
However, at speeds lower than ~200kHZ, the PCS signal seems to remain
asserted even when SR[EOQF] = 1 indicates the end of a transmission.
This is a problem for target devices which require the deassertation of
the PCS signal between transfers.

Hence, this commit 'forces' the deassertation of the PCS by stopping the
module through MCR[HALT] after completing a new transfer. According to
the reference manual, the module stops or transitions from the Running
state to the Stopped state after the current frame, when any one of the
following conditions exist:
- The value of SR[EOQF] = 1.
- The chip is in Debug mode and the value of MCR[FRZ] = 1.
- The value of MCR[HALT] = 1.

This shouldn't be done if the last transfer in the message has cs_change
set.

Fixes: ea93ed4c181b ("spi: spi-fsl-dspi: Use EOQ for last word in buffer even for XSPI mode")
Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index effb460d436d..1fa96e8189cf 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -62,6 +62,7 @@
 #define SPI_SR_TFIWF			BIT(18)
 #define SPI_SR_RFDF			BIT(17)
 #define SPI_SR_CMDFFF			BIT(16)
+#define SPI_SR_TXRXS			BIT(30)
 #define SPI_SR_CLEAR			(SPI_SR_TCFQF | \
 					SPI_SR_TFUF | SPI_SR_TFFF | \
 					SPI_SR_CMDTCF | SPI_SR_SPEF | \
@@ -921,9 +922,20 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_transfer *transfer;
 	bool cs = false;
 	int status = 0;
+	u32 val = 0;
+	bool cs_change = false;
 
 	message->actual_length = 0;
 
+	/* Put DSPI in running mode if halted. */
+	regmap_read(dspi->regmap, SPI_MCR, &val);
+	if (val & SPI_MCR_HALT) {
+		regmap_update_bits(dspi->regmap, SPI_MCR, SPI_MCR_HALT, 0);
+		while (regmap_read(dspi->regmap, SPI_SR, &val) >= 0 &&
+		       !(val & SPI_SR_TXRXS))
+			;
+	}
+
 	list_for_each_entry(transfer, &message->transfers, transfer_list) {
 		dspi->cur_transfer = transfer;
 		dspi->cur_msg = message;
@@ -953,6 +965,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				dspi->tx_cmd |= SPI_PUSHR_CMD_CONT;
 		}
 
+		cs_change = transfer->cs_change;
 		dspi->tx = transfer->tx_buf;
 		dspi->rx = transfer->rx_buf;
 		dspi->len = transfer->len;
@@ -988,6 +1001,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			dspi_deassert_cs(spi, &cs);
 	}
 
+	if (status || !cs_change) {
+		/* Put DSPI in stop mode */
+		regmap_update_bits(dspi->regmap, SPI_MCR,
+				   SPI_MCR_HALT, SPI_MCR_HALT);
+		while (regmap_read(dspi->regmap, SPI_SR, &val) >= 0 &&
+		       val & SPI_SR_TXRXS)
+			;
+	}
+
 	message->status = status;
 	spi_finalize_current_message(ctlr);
 
@@ -1245,6 +1267,8 @@ static int dspi_init(struct fsl_dspi *dspi)
 	if (!spi_controller_is_target(dspi->ctlr))
 		mcr |= SPI_MCR_HOST;
 
+	mcr |= SPI_MCR_HALT;
+
 	regmap_write(dspi->regmap, SPI_MCR, mcr);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 

-- 
2.34.1


