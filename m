Return-Path: <linux-spi+bounces-10789-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA02C02D0C
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 19:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4DA84E04F8
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180D34B68C;
	Thu, 23 Oct 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kvb7XYB3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D334B41F
	for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242370; cv=none; b=gN+dyXvn/316gUytKtGrhiYqwxvK6SPQpBi9Z7faoIMtSrw0CQ9khyKhJKJ4WbCl3/PnOMmsQZIKhAK4xBF26x1ENLQ4GH5bPfTPVj4YyfdauyJzXykjVJrPWtbUd/Ok2H4ETeQm8xJ9oa/iu79qROUslJNsn23wULB+oMdoXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242370; c=relaxed/simple;
	bh=7lcSZM0dC9g4v/BNnBxiVygQKnTYtxHeK/OZIIXwV00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEB51NvEpcQ95HRu9jOb3OfyAajpZQC1meRAajhfUn8f9CY9BP70YgC8KYotStYkTd3difRgk7sp7uoTGaSXNpiiXyu0wmMOv8rX69xZ2PMJ4cnfqJOinYVNgbYNJdeqJ9apw2lC8AXTAtZsp2UShMC0+zorbaNU6b8eFn4TVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kvb7XYB3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-330b4739538so1088637a91.3
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242369; x=1761847169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On265SWIIsjj6cFhkQLuouFdBySNyVnfLyhJagcyMrU=;
        b=kvb7XYB3HbP+XqgyX64WJvz9k6k9lQO+gNLdeXEIE/mhHRsI/2feXrOKw87J0jkVDq
         zMlTBgI0IwiDUENWRU8j8afAsPhtoPNlfi2BxrXJWyod880jt5QRy13mgo+8aK1vOM17
         i8qF0+QL1b3VpUbY4jtcHGXNjZaUuLFDM/zIsF5zFubEbk68wuUk2vJ7FeybLIqG0PkE
         +ld/zVd6O3S/lq3/o3B9V5YVHRRJBgOB8dU3Q0uQydw37thWnB6IvtKPrK/XMwIHqXGw
         gKrEKD9pEl6s8SgUF/TVXItuyJPjQCwo5xruTh5P+cKvCTq5YzIiGCxvhEpLSntUC9yV
         XogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242369; x=1761847169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On265SWIIsjj6cFhkQLuouFdBySNyVnfLyhJagcyMrU=;
        b=TFFf2FcxMwcrJqyhM3lPTDPBediu+joEEtRAEQJ0vJoVQdlEpq9n5tfqKQxdYT2p1q
         kBPZqqTWz7VjcqHdXHFXXMR1CBdv8797qfwndtfW93nEW0TFteTlhdZDbG13C3WzCFHu
         9lhiMJDKC9HAmCcpqmwlnJe1Y3hjSJQMAo76LX2Mk8CBfMvDUWhFhvdNxctQaECgWe9h
         UbA4wUNIduiVy2OkfOm3bt8OD1YSwEYWioASTYKQP2bg/vPwRZK6TPj4DmwYJlfV+fSl
         583mETCNxSzJSEUVX6PsyJU7e6pbqIJF5+fMKUrvYWE+dpS7eEHKmZ7UCHtt6H8vx757
         paqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKfLHBWLUwlnKjUly36mXpvUlF6KSFzrECLR74D/wYMfyjAiJ2rzIu2Ca7KJygytuc4Nr06XyMuyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+H17K4m+h0CqhZnCuhdxsqVAmBOSBY1spDiabtmyp5VqtbKq
	u63ZWpYZrwCoqqq+qPzufiKtckp/dHsdz/BQ6U7WcX9z3CA3Nq2ZDAyoBdxAy+NMEN8=
X-Gm-Gg: ASbGnct4Lfh3V1SKLE+dr10ua01bYD0bonXLM0AH5YYVAS/F9Nxgsd17LoffOqqb+3b
	lUC22dgcGZ+kubYU1wnhvOJYeST/QmgHPh2wFVt54u9HcAM0AjjjrCC10CtA89jdEhv6/s1WCz3
	0A3bBLWybLwX0oqfhXOFdiQPwDBcJh5tjIMYT44J7ooPIUhaHwf62NHKdoDFLqDXj1hWYFsPEWN
	je7+N2efwjfYugRNSy6EmQXtMI+rXpckCeiBIucDhs/D4+Fryb8O02YeNLRiVbDpf3Bl8FuMRvR
	n80CWnrBU6Uh4T7rmLMakVZJawUxW1L2p1kbhrcMt7CueHqw+W2ErjTVX+AzYFmnPbQVx2MHAyd
	yoR+0YhWvaF2s70isWovTGiEd+A4eHuB1T0RKLAZ186UtgebqMl0YV/3nNSr68ciZO3JwCp37CS
	h7drsQvPM/AcUfl1zd/Mtf5EQ=
X-Google-Smtp-Source: AGHT+IHMRWTLOcYt9GF5JwdHPs17n3sdItQgiLvosy748nQ99rSr70fD9GfdnC6xjLJTc4YsYnnuZA==
X-Received: by 2002:a17:90b:248f:b0:33b:cfae:3621 with SMTP id 98e67ed59e1d1-33bcfae47d8mr20130607a91.32.1761242368668;
        Thu, 23 Oct 2025 10:59:28 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:28 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	p.zabel@pengutronix.de
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 3/9] spi: fsl-qspi: add optional reset support
Date: Thu, 23 Oct 2025 12:59:15 -0500
Message-ID: <20251023175922.528868-4-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for one or more optional exclusive resets.  These simply need
to be deasserted at probe time, and can remain that way for the life of the
device.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Added Frank Li's Reviewed-by

 drivers/spi/spi-fsl-qspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index c887abb028d77..1e27647dd2a09 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
+#include <linux/reset.h>
 #include <linux/sizes.h>
 
 #include <linux/spi/spi.h>
@@ -267,6 +268,7 @@ struct fsl_qspi {
 	const struct fsl_qspi_devtype_data *devtype_data;
 	struct mutex lock;
 	struct completion c;
+	struct reset_control *resets;
 	struct clk *clk, *clk_en;
 	struct pm_qos_request pm_qos_req;
 	struct device *dev;
@@ -857,6 +859,8 @@ static void fsl_qspi_cleanup(void *data)
 {
 	struct fsl_qspi *q = data;
 
+	reset_control_assert(q->resets);
+
 	fsl_qspi_clk_disable_unprep(q);
 
 	mutex_destroy(&q->lock);
@@ -902,6 +906,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (!q->ahb_addr)
 		return -ENOMEM;
 
+	q->resets = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(q->resets))
+		return PTR_ERR(q->resets);
+
 	/* find the clocks */
 	q->clk_en = devm_clk_get(dev, "qspi_en");
 	if (IS_ERR(q->clk_en))
@@ -923,6 +931,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(q->resets);
+	if (ret)
+		return ret;
+
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-- 
2.43.0


