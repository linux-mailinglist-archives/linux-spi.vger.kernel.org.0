Return-Path: <linux-spi+bounces-10834-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF1C07DE6
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2CA7355E49
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A2536C258;
	Fri, 24 Oct 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="K4Z2PhCI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58236B99D
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333365; cv=none; b=q7qKnDW2vB3Ii9Vg/stb7w7M0m2V5fFrRhzCyta33Bm81kT5WKafZcGiKcaar8QPBWySNsrQWgKyyGv0XbtuQupbHma5U6KCrmw+rR2pfgVpDIEudUUKegNkkHXLrL0gZgcL8t88tVjBby9axdAfkMeD6sXUARRb8YImZF5ta0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333365; c=relaxed/simple;
	bh=k6atjC1oTdr7ZwQ+JAP+shvhvXbx3KJya4cA+9vZLWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FID68+fN4JGQDSzH9uJYcJmo0ICRm9Fy2VPlbBZCPdhQwwizgSK8Hv3pZkgi55ajJ82HmKAo+RWs6UeSAk406o+P9519TxGxc2yIVV9kPLiCkTIIRONAjf4rSf7awiTQpcO7uZKDS6yayOqqxoFIfFrarIz2qmdNY741QE31BHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=K4Z2PhCI; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso22587255ab.2
        for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333362; x=1761938162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9XwB4LXCLiaym4oip8K88EQHxoBTQxTfCvmH5+Ipi8=;
        b=K4Z2PhCIIsmwXTNX18JC/loy9BzNr30kIgRdKsaByUBmwsZNouPuD2f8RE3/wjPd2U
         9wHWvi6u17qHx5yFw+vwmfYd50MHdLrzkZypTLzCh7ecD21BRrXzXcquNL3lfLOSYmjv
         kgsiXkA831/puw39DGYqLwqj1EK5FzGMdBH4z1izbYou2RgHeQipTAXWm5e+UpPaTFOx
         5cOGvagCwQk7NE8yjyqTocvRx4ELitIBWq6zFX74gVf6NzjFkE4ImAfv/M26H2aQn2pv
         XgIi7Y5EeIMMzMf2LGORc4n1KKKv08LTVWRTfE0wMtOQlaZAVH6zd4FytACjFvyT/xVe
         6M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333362; x=1761938162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9XwB4LXCLiaym4oip8K88EQHxoBTQxTfCvmH5+Ipi8=;
        b=hrTGhfaaqx+qGT0DreTGcya7xhyefFEeG232CUhLW9+mk6zZrql8hQm1b65uq8hesI
         7Uo2Ox7AVK9TogVhmh4nmEkDFn2OblP2PGwg85qXwBEVa33u5zboti9m/rr1W8t7BCUV
         Z3oeXd+sXNtpEhGT0n0x1EjOo6t+MVGKmgcqK+LmGd3n8vX6sn/ya/S2LNg7hUZXbQ7M
         sBEZsdZqgdXYQQak9B57WjebtYCE+jBZnLkeKAvmGf4i0oKZhD/JYqyRDDulFTryexYZ
         7Sgee4NNURPWuX5CETxQkU4LBvSAIjuMzIBZbdm5tRWC6RZP9lTI6sagKoYqA8oNWOpO
         sdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFNlK1tUcqX05Jp3VMEm/2X+G9cpGAYAzE9Z0xKF/aQP9yj7FUczAKtEyWxS4esKQcHpZXzGqwpjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzefB0oN4lOKJ7XZUX3kHiJK+7GyyQW9YCHAF6pTEkv1IbaMT5s
	WIDGCNlWB/jnsSwhkK8iTSVQcTTdnaJxsOH4hkykm2LrqqatUlSOB8Rcn5E36zKM+Ic=
X-Gm-Gg: ASbGncumCytLsXhDEmRmZldszgFMmZOV/biu0aNBSX/ZSIdv6WAt6fjW354BB4WOQEq
	ohMnKHQpNsySbTtsFQE7EmVGufyMu69SY0NUhp/g43zAW7gZ0/+tf1gzD6Eled1vZKQe8Csv7I2
	MkHiAIgG6PkUL1ibCqOR/mITqTAPZ3Ns6/pgWIWyS29pnFqTLLgD/yU8VU6sFbHZZB6bDun1R07
	qm3tmRDLILgChNduEg1E/3gNSvgyYd7L0PWCGeg2CaG5HK7pW3NvI/XFF6NyG/7wNB2ZIYvG2Us
	xuDMA5mWLaef2aJc+yEeoitXhjk6wgu4gd2mrk3/UdAR6WxfuG/JP/tPuaUTWYJgK6wo1aGWHl/
	3BC/wccgklg7jFXCIxdEBLWrGLfi+XYJnm6UPHFjp46UXNDmdbpO4MDTpnkkMioixfXxJvgUQ+M
	VLUAgiTNZUPJOptE2bcVbeWFlGB371jnGD5tDaEUeQCps=
X-Google-Smtp-Source: AGHT+IGDjCZrbwlwcYCrEqEaKTTyt1rgAZl540PN69Agvv1E5bOXHHhIHceJWXZ0grnxWP0ubmH72w==
X-Received: by 2002:a05:6e02:3712:b0:430:ccc7:68f1 with SMTP id e9e14a558f8ab-431ebf6dc57mr41093245ab.28.1761333361639;
        Fri, 24 Oct 2025 12:16:01 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:16:01 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 6/9] spi: fsl-qspi: introduce sfa_size devtype data
Date: Fri, 24 Oct 2025 14:15:46 -0500
Message-ID: <20251024191550.194946-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fsl_qspi_default_setup(), four registers define the size of blocks of
data to written to each of four chips that comprise SPI NOR flash storage.
They are currently defined to be the same as the AHB buffer size.

The SpacemiT QSPI has an AHB buffer size of 512 bytes, but requires these
four sizes to be multiples of 1024 bytes.

Define a new field sfa_size in the fsl_qspi_devtype_data structure that, if
non-zero, will be used instead of the AHB buffer size to define the size of
these chip regions.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - The variable used in fsl_qspi_default_setup() is now "sfa_size"
    - Changed the subject line

 drivers/spi/spi-fsl-qspi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 2c030dd6facc7..46a3187b33548 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -207,6 +207,7 @@ struct fsl_qspi_devtype_data {
 	unsigned int txfifo;
 	int invalid_mstrid;
 	unsigned int ahb_buf_size;
+	unsigned int sfa_size;
 	unsigned int quirks;
 	bool little_endian;
 };
@@ -737,6 +738,7 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	u32 reg, addr_offset = 0;
+	u32 sfa_size;
 	int ret;
 
 	/* disable and unprepare clock to avoid glitch pass to controller */
@@ -795,17 +797,17 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 	 * In HW there can be a maximum of four chips on two buses with
 	 * two chip selects on each bus. We use four chip selects in SW
 	 * to differentiate between the four chips.
-	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
-	 * SFB2AD accordingly.
+	 *
+	 * By default we write the AHB buffer size to each chip, but
+	 * a different size can be specified with devtype_data->sfa_size.
+	 * The SFA1AD, SFA2AD, SFB1AD, and SFB2AD registers define the
+	 * top (end) of these four regions.
 	 */
-	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
-		    base + QUADSPI_SFA1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
-		    base + QUADSPI_SFA2AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
-		    base + QUADSPI_SFB1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
-		    base + QUADSPI_SFB2AD);
+	sfa_size = q->devtype_data->sfa_size ? : q->devtype_data->ahb_buf_size;
+	qspi_writel(q, addr_offset + 1 * sfa_size, base + QUADSPI_SFA1AD);
+	qspi_writel(q, addr_offset + 2 * sfa_size, base + QUADSPI_SFA2AD);
+	qspi_writel(q, addr_offset + 3 * sfa_size, base + QUADSPI_SFB1AD);
+	qspi_writel(q, addr_offset + 4 * sfa_size, base + QUADSPI_SFB2AD);
 
 	q->selected = -1;
 
-- 
2.48.1


