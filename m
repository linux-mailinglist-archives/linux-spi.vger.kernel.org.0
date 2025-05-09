Return-Path: <linux-spi+bounces-8015-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F5AAB118A
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEFB9E4E72
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDB128FFD4;
	Fri,  9 May 2025 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmS/r9Y5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2428F95B
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788822; cv=none; b=KMLW6Z/4/Hm3MHAe6SGZHdDD4kHJYKPmI4mcMzU91Ms+4OWgEMTVHeCQnUpSo0WGtf72SUd70DXMhkfcijLuf4daT0u9mb7GmFTi4tXRLinbz1HgpgM1x7ExPezbxv0BzVj7uO9vqpuvHq2NrmUxFU23/H2oL1EucNdlPyews9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788822; c=relaxed/simple;
	bh=eEjcZlIDJmLV5/jyvCAjQjBuHpvBbYFjopscg3ocaAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHKC6tlbV33M14dSnNzzLFBx7JTaa2g9xnoV/oTsf+Tz0aqgmg9BUzGO1fZ3QEUn6+SI50sLsHXns7JFBifvnqvIyd71tkM5A9sh+rUHHdDIghXLdMmg/CybE27/PTM2qOhu9IAu5ouY9N2y1vC4+q7LfbqzG2J9Jf9PwdrXGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AmS/r9Y5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a1f5d2d91eso612564f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788819; x=1747393619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZ/3VdJhYRpNseu5U9lSFH9HxUE77S8ESF2tbbWAri0=;
        b=AmS/r9Y5uW7x4VbumhhDXBgwmqEk9OiGrr5gsv9+yhNaM6GKvS4L2f7pz2A9vyNVfd
         +Jo7dwcmAyU4jQ3l/iTN3w54QIjQ1Y0hRljRrE+rIOkheHYooYuwoTCf6PndC5yJRmfm
         JXAgvfw9w/GWPesyiiqVT6jg8MihR8PTXYTvw9n+V9oEoVEZdjRhr5rT+6No43r9YUy2
         0qC2yAl+xwxjfHB+fuJGDLf9A6Pu8bTLqsAeIM1KA9ubHIrjmOLwuilJDQb01N0P4lJs
         Zm246RiTTi8YaDAzD2NorjuS11zvYnwmdUGhKeXIL3wAWYrhcGqooupHDg6BJO7rJqPS
         9ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788819; x=1747393619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ/3VdJhYRpNseu5U9lSFH9HxUE77S8ESF2tbbWAri0=;
        b=aQNH3yXdLGsw8n3P08Ud9dXnRzcla69pJoOI5kqinmZVhc//asDMIYDiap3Hb0QQVV
         dpfeG26z+PA0FcTdPLOzWaJw58UswVIoYbjGCeL20FgHwJz6wTjo5HlN6BU/n09XCkBV
         OriXbnsk4yp3vVVFvOrvqAtHMpzGtlcfAq+Oq8kj/miAJLkqcaZcPdq3nQaz5DAzz84s
         dhmeyvHriHKd/ujP4LFGEslD158hyj5JKSMeTG9KtG41MtB+lJkHO9CNle++O+JLTI2c
         JTE3rKrUj6V5Mv7PC72JOSJBQua+zKEJfle9xwSrV5DGaMn/bO9KlKYwuVtMajumQcwb
         g2wA==
X-Gm-Message-State: AOJu0Yw8W56FJ9n5f3fv1qKnqBlzvVk1BKKILqun1ZDqaqUtMKAl7LvM
	55dpWc7k31DwTt9DR75mZlXx6YAgjDtMgZX02p7H8h1dWin6t/ad98R/KVlW4uc=
X-Gm-Gg: ASbGncue7qqIE/IIqYTbM3OzBNpEtai0s00qafE0KiGd1uC9jGQPk3nVyLB/hNz1wne
	ggw5s9NURVC04bRHmTXzUZuILXMA/FxFQVox0/9kbvFHDupE9KpvDWKO/M+//LQF1E7ZzpCqFms
	DesapPMuNRkdxKJoIzZJsDjPZYc4yTy+G1fCLnb/j1+UuZ7tPK5PceNnmdmg5mMtN30A10FCvAA
	JwbFFRTXjqZDlhJkHq9Tgkp9KG0HzYYrV/rzKlCf37vFauJ1PwtdZGUgfu4CJdvLR0D6KzvlC03
	xDFmd0KM5ZsvgV3IiJgwVTCUJhJdFQpf4gdY7dJ+mIa7X8Y=
X-Google-Smtp-Source: AGHT+IFbRxA53PsQ6WEpfLOqgfTczthdryRGHNyvPGYt33prnCWmvz5n1DMnzXDap0L0ElCdAiEfKQ==
X-Received: by 2002:a05:6000:2905:b0:3a0:b9a8:b94c with SMTP id ffacd0b85a97d-3a1f64b5c83mr2393167f8f.50.1746788818691;
        Fri, 09 May 2025 04:06:58 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:06:58 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:05:50 +0100
Subject: [PATCH 03/14] spi: spi-fsl-dspi: restrict register range for
 regmap access
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-3-32bfcd2fea11@linaro.org>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
In-Reply-To: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org, 
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Xulin Sun <xulin.sun@windriver.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

DSPI registers are NOT continuous, some registers are reserved and
accessing them from userspace will trigger external abort, add regmap
register access table to avoid below abort:

Internal error: synchronous external abort: 96000210 1 PREEMPT SMP
Modules linked in: fuse dummy tun hse sch_fq_codel openvswitch nsh
nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
CPU: 2 PID: 18231 Comm: read_all Not tainted 5.2.33-yocto-standard #1
Hardware name: Freescale S32G275 (DT)
pstate: 20000085 (nzCv daIf -PAN -UAO)
pc : regmap_mmio_read32le+0x24/0x48
lr : regmap_mmio_read+0x48/0x70
sp : ffffff801123bb70
x29: ffffff801123bb70 x28: ffffffc873b5c000
x27: ffffff8010b408f0 x26: 0000000000000001
x25: 000000000000013c x24: ffffff801123be40
x23: 00000000000003ff x22: ffffff801123bcfc
x21: ffffff801123bcfc x20: ffffffc873a9e500
x19: 0000000000000024 x18: 0000000000000020
x17: 0000000000000000 x16: 0000000000000000
x15: ffffffc876189160 x14: 0000000000000003
x13: ffffffc873bf73ff x12: ffffffc873bf707e
x11: 0000000000000000 x10: 0000000000000000
x9 : 0000000000000000 x8 : ffffffc83fca4e00
x7 : 000000000000000f x6 : ffffffc873bf7083
x5 : 00000000fffffff9 x4 : 0000000000000002
x3 : ffffff801061f058 x2 : ffffff801061ee18
x1 : 0000000000000024 x0 : ffffff8011490024
Call trace:
regmap_mmio_read32le+0x24/0x48
regmap_mmio_read+0x48/0x70
_regmap_bus_reg_read+0x38/0x48
_regmap_read+0x68/0x1b0
regmap_read+0x50/0x78
regmap_read_debugfs+0x120/0x338
regmap_map_read_file+0x44/0x58
full_proxy_read+0x68/0x98
__vfs_read+0x48/0x90
vfs_read+0xb0/0x130
ksys_read+0x7c/0x108
__arm64_sys_read+0x24/0x30
el0_svc_common.constprop.0+0x74/0x168
el0_svc_handler+0x70/0x90
el0_svc+0x8/0xc

Co-developed-by: Xulin Sun <xulin.sun@windriver.com>
Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index cb0e55a49eea..701cf56d28e7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
-// Copyright 2020 NXP
+// Copyright 2020-2025 NXP
 //
 // Freescale DSPI driver
 // This file contains a driver for the Freescale DSPI
@@ -137,6 +137,20 @@ enum {
 	VF610,
 };
 
+static const struct regmap_range dspi_yes_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_MCR),
+	regmap_reg_range(SPI_TCR, SPI_CTAR(3)),
+	regmap_reg_range(SPI_SR, SPI_TXFR3),
+	regmap_reg_range(SPI_RXFR0, SPI_RXFR3),
+	regmap_reg_range(SPI_CTARE(0), SPI_CTARE(3)),
+	regmap_reg_range(SPI_SREX, SPI_SREX),
+};
+
+static const struct regmap_access_table dspi_access_table = {
+	.yes_ranges	= dspi_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(dspi_yes_ranges),
+};
+
 static const struct regmap_range dspi_volatile_ranges[] = {
 	regmap_reg_range(SPI_MCR, SPI_TCR),
 	regmap_reg_range(SPI_SR, SPI_SR),
@@ -161,14 +175,18 @@ static const struct regmap_config dspi_regmap_config[] = {
 		.val_bits	= 32,
 		.reg_stride	= 4,
 		.max_register	= 0x88,
-		.volatile_table	= &dspi_volatile_table
+		.volatile_table	= &dspi_volatile_table,
+		.wr_table	= &dspi_access_table,
+		.rd_table	= &dspi_access_table
 	},
 	[DSPI_XSPI_REGMAP] = {
 		.reg_bits	= 32,
 		.val_bits	= 32,
 		.reg_stride	= 4,
 		.max_register	= 0x13c,
-		.volatile_table	= &dspi_volatile_table
+		.volatile_table	= &dspi_volatile_table,
+		.wr_table	= &dspi_access_table,
+		.rd_table	= &dspi_access_table
 	},
 	[DSPI_PUSHR] = {
 		.name		= "pushr",

-- 
2.34.1


