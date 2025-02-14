Return-Path: <linux-spi+bounces-6821-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226AAA355D3
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 05:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F8116C552
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 04:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C21B18C039;
	Fri, 14 Feb 2025 04:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp7+i/xR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD818B464;
	Fri, 14 Feb 2025 04:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739507650; cv=none; b=eY0if94wgtiWHFCMMUAsa5Y0p/skcEJhTQYdeFwlZiUlm2i7TlnazUkFkSbtiydFC/zkdze7FF798jYOqSha19GRGFfLuPlA22TxlcJTmc1wGAJR8nJQZ8IPBgwiCLw1xLSg4JM8Xg+8Hjs1qK8qe/CMVlA0xYi2vD3U5IFYUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739507650; c=relaxed/simple;
	bh=Z18PozScWRRZIqUbYJfgRupryg4MSQPPCbfbr7Li/SY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WS58/GocJ+rGdYNuC3YO71mIgQqGxwDtDIfvuPu7z2kQ8EL35yZgwLOz7o/6mqsZMilyTw3T0AW1fmRx7dQoQUA7uXGcb3sEM7vsk5uwNBPY65ifN20fP96lr/dm6aaWkRi/LaVw957TFyi0PdPVsuNQcH8mUQ1/Xz1fqPeIzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp7+i/xR; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8641bc78952so403699241.0;
        Thu, 13 Feb 2025 20:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739507647; x=1740112447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pABNnyGxDf0HWJPslows1Wypf0nJAcgv8KSSagBrIHM=;
        b=Rp7+i/xRpYgqJahneIpupRGpY8kUa0RSgmE023C6vcTaLoJ+H0mymIG+8461/spgyq
         vRi+JDtfD56ujKbTK9fa+kYWD97hVu9iyIhYuy0Tn8pmUKzYAbSVaB0oxvqnYgf1gb11
         teLl3TF5WTNq45fj0Raa+7ZVShXeCHgPsHeWqRsqy/ZHKI3SJhM2dzwLrzySCZ3hZVP4
         yqrvCC5w5RkiswSVZ5bhXYvKYN+jMZGX5ZUw+oeva/q5AisKbGy5YBAIvRBItDoHApxb
         nhR3Rrt41QGrqvBmow/4i0XOlqvlBhkAYpkTc50WiWTFvbMBLne4bY7U6/QeJKZLTk4n
         aIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739507647; x=1740112447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pABNnyGxDf0HWJPslows1Wypf0nJAcgv8KSSagBrIHM=;
        b=LBdu1bqPP+woXjBDE63vTCurEZDeaxgHhMz4eOwDiJx3GM/qPliF+UwNUcg4QkgKte
         fsVfO88/UAX9YiBPhuzx8bxWvo5aIqcnL7AgxQvzQTUQk8ySSWk0XaY3tGFzynu+Dyuw
         Ghzq8qDHySIM5i+8SdjLJqacjQed1Hex2mLth6S0LNaKgdVIxi9dT3PuAQRBWAwToCLj
         kqkUUb56DRMDu23/yzXKeDL0Z8QgyYAIY3HVm1vIQUltDvUz3vVzYY76Izfx7dai8iTj
         CDT2J+6jha/dbMfrBlgMbPtIze3+JkGvcODeQvaZJ221YKa0KKwSaa0B6KJhz6GnEGxJ
         sWVg==
X-Forwarded-Encrypted: i=1; AJvYcCU20ZLOlv27vvJuDzNx/dbtxu8UWX0C9z2T1t43XrILHKn2iF69jZLTCnVjHT50mzlZlwDFJmvneCCT@vger.kernel.org, AJvYcCUCZLwndJoEb5WvD92wcyMZBLcX08YsewobDMLLELW2iL7JJT00G70TY2KPJ47Nxg7+pUVvhtO427HzNOq2@vger.kernel.org, AJvYcCWCoLOrmTEOFmExBodSsatbc9XdCN5mu8EWZV5Ms7XCVQ7MVBnfN5PDj05NLZdZiccVceWF+FX1R146NS9bhQqZp4U=@vger.kernel.org, AJvYcCX+VXg6YTRT8eeWdh3oAwFeiK72CfSdXXM2Bfj9YFH3HCPAgSaRlBTiwAcloIEHiD1ko9XizIJkfTBO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RTUqq0RyeqcktiVMys3A8CpZ3RI+iGoEU+YstbZUIEMxCakd
	9OJlNz6BOMOYiSOQk8xm8mVQ1jjMBNoScqQmKeObOYWsk2u5vPU2
X-Gm-Gg: ASbGnct9AD7hMOaGpbFNlzQYfHgz32jTxvn3GwkM61GlUXhkNbFWW+LKeT5oydGQZQQ
	myTpfE/mYBVIAeySJLnY9fhwjRH/wUNGtpcs/M7vBWf3d3S1wULfD7dnCQ30VdTti+CiabGbDR8
	QzoVhULhF+07u9N+NrrtTMp5Bg4eCLyDy+bPShso93QTJLJVF0GYyaTRiRtIU1qxbvoH/ZUGtUm
	Y7O7xY13383ZX+v76de4WBvKbGA0k5GBL+H5dCONsSVn04PQWY+S4kEWOv2KUgVryx/+EYk/fzJ
	aJM34T/7pVo7wBuRB248UOeHj8SlEb62SrDvtoYm2Q2aDFUqSAgRE+wIEgBkeRciHwQwYozjx+f
	k2g==
X-Google-Smtp-Source: AGHT+IGYT0xEanrn1VszJ1wJSKytc/CMY4TaQR5OCqX/LZsid53fc32kk2bD91HzBNyw8KyfmgwniA==
X-Received: by 2002:a05:6102:4191:b0:4bb:c24b:b623 with SMTP id ada2fe7eead31-4bbf568bd5amr8493930137.19.1739507647222;
        Thu, 13 Feb 2025 20:34:07 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e857f2desm422800241.10.2025.02.13.20.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:34:06 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v3 3/3] spi: s3c64xx: add support exynos990-spi to new port config data
Date: Fri, 14 Feb 2025 04:33:43 +0000
Message-Id: <20250214043343.263-4-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214043343.263-1-wachiturroxd150@gmail.com>
References: <20250214043343.263-1-wachiturroxd150@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos990 uses the same version of USI SPI (v2.1) as the GS101.
Removed fifo_lvl_mask and rx_lvl_offset, and changed to the new data
configuration port.

The difference from other new port configuration data is that fifo_depth
is only specified in fifo-depth in DT.

Exynos 990 data for SPI:
- The depth of the FIFO is not the same size on all nodes.
  A depth of 64 bytes is used on most nodes,
  while a depth of 256 bytes is used on 3 specific nodes (SPI 8/9/10).
- The Exynos 990 only allows access to 32-bit registers.
  If access is attempted with a different size, an error interrupt
  is generated. Therefore, it is necessary to perform write accesses to
  registers in 32-bit blocks.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index dae63a105..88d751c69 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1588,6 +1588,20 @@ static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static const struct s3c64xx_spi_port_config exynos990_spi_port_config = {
+	/* If not specified in DT, defaults to 64 */
+	.fifo_depth     = 64,
+	.rx_fifomask    = S3C64XX_SPI_ST_RX_FIFO_RDY_V2,
+	.tx_fifomask    = S3C64XX_SPI_ST_TX_FIFO_RDY_V2,
+	.tx_st_done     = 25,
+	.clk_div        = 4,
+	.high_speed     = true,
+	.clk_from_cmu   = true,
+	.has_loopback   = true,
+	.use_32bit_io   = true,
+	.quirks         = S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
 	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff, 0x7f,
@@ -1666,6 +1680,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos850-spi",
 			.data = &exynos850_spi_port_config,
 	},
+	{ .compatible = "samsung,exynos990-spi",
+			.data = &exynos990_spi_port_config,
+	},
 	{ .compatible = "samsung,exynosautov9-spi",
 			.data = &exynosautov9_spi_port_config,
 	},
-- 
2.48.1


