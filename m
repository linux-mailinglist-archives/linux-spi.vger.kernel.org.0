Return-Path: <linux-spi+bounces-6794-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606CA32F51
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 20:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC72188A177
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D5262804;
	Wed, 12 Feb 2025 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUozqEiP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E919262811;
	Wed, 12 Feb 2025 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387590; cv=none; b=mzDKeyeHCBC47twRzCtPZwLw+rpHIog3Ns/RwRw/NvRT/Dl2Ydig0kNP9vbrjwE5/JS929Z3KNA1HERHP/Gf7S7as0QQPBejhIMpwR2s/4rCFDSRFZWe5A00hDBm+dKDNdU2TlIhhLSzi0ub3iNedZw0ueCUNjQIFflMCFnHo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387590; c=relaxed/simple;
	bh=QRJMDWMRwBbNb9MWkTSD/P68br/F3G/DgekDxzEdzIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8Uam11uoxlQ2SHG7+9zPHCI5Qpvg2LPXZYestNNVIHoXTI4T45SS+NX+uWjo8IAGLVvsRYPjMuSKNDMwABWG2TrDBEy2uZjDwXs+1zXpeL6gWNv8BRjUpjJIiMjyo84/bwVT/+JPGvledl+rC0GwCq8fKx3opK94hf3ZITqKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUozqEiP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c665ef4cso73275ad.3;
        Wed, 12 Feb 2025 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739387588; x=1739992388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAcZy7EP1wYymX+WTQasCXu23XJ3kyVzZE5V/ow6XtQ=;
        b=VUozqEiPNgd+mbC0PQWYSXXZEk76Xk7ZeSkfyEKR7uTmSu7F4J4g9SldUhX3t5Yalm
         XHUYMDUlMPFlhJt/DsxbviDLHF9PH+aMdvZnz3ZzGGlRWxqJZq/rLEvQgvG6+GA5jybA
         j8P0zEcwirHG3NxaPhrSb7I59qM4MgmoaNnfrZCNCAfpE0wbL3uF+aFHpO0cRK+gr1ZC
         LKDjAj8phO6D0Vv4G6UxJCifrZx7UIwcRLoLYJQ0pBT+cmngNB2JIFqJO1ZF0JeMp/Fg
         jm3iECTmln1i8EuvtnQPobWO3HcQWuRiVGs5O+e+FHNXbQhokpxNfrzp6RnDIXBTfVNP
         FCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387588; x=1739992388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAcZy7EP1wYymX+WTQasCXu23XJ3kyVzZE5V/ow6XtQ=;
        b=kJ0v1FXI7JZagBQFeXTQT3AzGGEaHtMUUd9AD03cEtKMrxHxJZhGJ+kLs5lb39vb3O
         1B0rWc+CneA1DXrT91JbwLAPyMS3TECWFPvwWm4YSEIuw9FuK1RmonnDnp3dxHHHTh51
         AJva3Bln/T80ozZPc0XguSUqC0WNxQdgqN+btkTnLjD6rxtNQld62MSRad51dJY4/7di
         2OwMfdf/pBxBfq/HOSvrNQR7qN0tAhK7vJ0PyZED0lTcRPw8lWNTJ+/9uk7Tz1zCmBqx
         sT6s4fhJWpGt4xR4wYJhckVtmnZtuim2gmBqezdftmLARlCBELZo7uUGLu/neIvJEHFo
         dOzg==
X-Forwarded-Encrypted: i=1; AJvYcCUaGzV8AbacQCdot03F+55uR3CYYlzBHDoiUswFTpnEHd2sgRfEjQGZn01jJwlTelL2TnLVMdJ02VSGCbzvP7WnEWE=@vger.kernel.org, AJvYcCVDANfNs11IitlxYA6UDbrw4qrT7HyLctpUQPaH/Ee4ZN/9TXMogyG3wcancnmEAtg0zv/mDAMCRqk5@vger.kernel.org, AJvYcCXKE3MLxuW1TNlWEiXjRR/eCum9hDsA4YiUYts5XQBXzoLI0lIRMyM0lU9PxIse/Qh4gcbE0iVwaw9l@vger.kernel.org, AJvYcCXQVg0ukDUaEC9OjmVkYKB21ZCk6hK6HA9GTh35PbbWMjFH3F3ihMZg+0yNgfY5dbgsrz0MJzRXyzX92/EX@vger.kernel.org
X-Gm-Message-State: AOJu0YxD6J+kUqL/m1h+n7ISXAtvNpn0vxIEqVkliJhX01uKNkrKdqt8
	T44Ue9eYsRBRLXtVJBjA3ODisoNG77uB5aMgzE7yRj+RP9dgNNll
X-Gm-Gg: ASbGncukLXP3BGIQaQ3ZOqgpWWUgPYcyJiNunrgGLQNFPL80zkjCZbrIyIItlQDIFVk
	16Mo6Ji7/922p0c5+urSGQYZ7iCiIArAb016E3oFra83992MnKyz9mf34G+4UYsCERtiz/yOJHR
	dk/J+9n9gXusIEAthQzifT34xWirUKKkeUUwRsIx9D7K1ZUl1IjR4WIOOJ2gE1kWqshdgtNqaSs
	OuveG8FV6/Aqb+6gi71hh7XLIG2PDuRqmnb1A3YfRlJBSV9pVrorCfMwI9mQhgGSuGKMdPsyV6L
	oVVvaLEB8Z8fum/B4S0WomF8y4hBp0mhGN6zsF3E+y1c/riFZ+MKrzjo+x5bmpRa3fI/sR0LxLl
	xyQ==
X-Google-Smtp-Source: AGHT+IES8zzy1yn8GqIWJCTaFt+Q+QP4q0ZQlGuxDgXLN2Jp97ZBCOEbgBu+OmwDFI8AnMw/Zk7ZPw==
X-Received: by 2002:a05:6a20:7345:b0:1ee:3576:7299 with SMTP id adf61e73a8af0-1ee5e530c55mr7739207637.3.1739387587650;
        Wed, 12 Feb 2025 11:13:07 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f79sm11536944b3a.77.2025.02.12.11.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:13:07 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	peter.griffin@linaro.org,
	andre.draszik@linaro.org,
	tudor.ambarus@linaro.org,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v1 2/2] spi: s3c64xx: add support exynos990-spi to new port config data
Date: Wed, 12 Feb 2025 19:12:41 +0000
Message-Id: <20250212191241.280-3-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212191241.280-1-wachiturroxd150@gmail.com>
References: <20250212191241.280-1-wachiturroxd150@gmail.com>
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
index 389275dbc..790034d2d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1586,6 +1586,20 @@ static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static const struct s3c64xx_spi_port_config exynos990_spi_port_config = {
+	/* fifo-depth must be specified in the device tree. */
+	.fifo_depth	= 0,
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
@@ -1664,6 +1678,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
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


