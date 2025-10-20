Return-Path: <linux-spi+bounces-10729-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D9BF2889
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E1D426630
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE7330310;
	Mon, 20 Oct 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="AF1rsUlx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753D330319
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979124; cv=none; b=oJHC3F5KOTIX3YBAjGvzSHVgn/IaUOx8Jpt2PVOJrij/6waJ8cxIwvP9DgG8Wk1qQOAszfcc4ZiV2735l88CmjLwTguKbOxfTqitSm7pJPLjdVgof8mrxDzjAk8SdXAp5CORi2nMfWwATEFroJtoBeqM1+CJEm+X8hSmjIJ+S40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979124; c=relaxed/simple;
	bh=NVCZabHEL1WTH8+GxShWLpaijc+G+GBkOY3veIVd+BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5aKDFWp4hDqtUyGHinrZ5ngadaJoXE0fcKI7gMrFA35TLlv/BkQTUgHyJwfXZ1ZssVF1N6+4CE7/yJoV/+JXIUCX3IIiO281vvtmytDJtHbc1ylrf1ihezWrJnyKM/44nofQhy0b0Y17B77+z5AT2KVgMIDbL7FrjcL0oUbekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=AF1rsUlx; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430da72d67bso8197065ab.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979121; x=1761583921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AztIAt2eykX0RjbkZdmQk0KjjmCuZftCSORZ8HPCkE=;
        b=AF1rsUlxzwByVYo7a3QdnCcZtcF/1/hCbHwpOiHXUr9Y1GWSW7Fa//nMZYWcJQyVNn
         trTzaf9+tRvvCGSqh2gdH3qmkSYS1ahXG5KlNLWGY1jmGPEqH1Qn4RGiA6xoiiWaVgbX
         wvOKrlOPRgfl2imZPNhHNJFmozJRwaMHkKRNI7IJde2FODNQAfyHlWIY1eByjLyTLSyE
         YrbjQnjZ2Os+dycpfEc/iL67+HVDYg44/EomzwgcBdegy6BUt2lAtZ8pFx5oDNfoc6wz
         CCDs9RpjTKhizV8ltmqlsI23y5q2iPtAphJ2GN3qYd2XIlgPh6iSHkoacpitr6YOjs1q
         Fykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979121; x=1761583921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AztIAt2eykX0RjbkZdmQk0KjjmCuZftCSORZ8HPCkE=;
        b=HK9EFJRZilTsyI4gruvx7kEOuxLyGbHkjwcHP1fiWXXdmdPy63Em6kUCdLcDCRZhzS
         Ob1pozgfeV0pUM0HnSJY521MNUroRBlaKay8VxMNHa5P5apPrTh/mjQ7Odd6FKX5K3VG
         /qsHXPHYLFgxlQYdC21Pp/i52ZArIk+WPxy7nKiq0CGw1SLiWlzqE38ZylAhM9FQa1Xi
         CFczEj9MwAi5H4qnWdJQzcblD0UaP1QsHH9NLIMAel8pt9+X4cgl/MGYKedzuGfR0S5N
         pIO9DMp26s32iQzOZ6u5aCeWkd6xwA3tHOoGD6O/49tQBtk3tW82Xncw6JoieixHz2Ih
         Smwg==
X-Forwarded-Encrypted: i=1; AJvYcCUlZts2rT4m4zEm0FIUUaXduGIURsAm8b0+Nc6gpBcRiyeWRxRaEVj4SkUrBvEXVZu2QBtYY0biJsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybvbnom5xe6dkokdaIR4QOtZyHXkkKIw/PdZ+EVad7VEanmjwE
	vGvGeuVJaJUNtxoUsRVCMIR06cCG+pzne9ShRjMTdWbNnWxQ4M16UkGj1285etC6oa0=
X-Gm-Gg: ASbGncuRRQdOjphSJNshFptdNDuYGz0VpvaG237Yz3El5I95XOelzkGje6cqLYMQaIg
	xxm6GMmJYgTm/1bxRnq3XDQ3UzMj1StDoj3xvmHSGbOMtDnKPfM22SaxmbzUlGw+eA+I4vb6z3I
	xs0GmNCSUzi+0eGAG1Nt/OiKG/74RPBvX0F9I+f09K/IviVsuA716Ug6L3GCC4fa6g4RmCd2lbT
	Y6iLxmxcJMusRvXcBE4o9OJWpyDDVY1w5jtEh5Ck0RXqnZot2QgBdcs8QB12/6UiDL9AITdyjuO
	WWFpd4+XtHdx0QEIZ/n22ZVtX4Cahzbq3NXuScfyFwJgy/kMbP7Ya7Z/GPtD06dPQ2PjB8XuHQ/
	s6zHMhmxL/ppRLLQPYxoDoaHNIQ89ifRvFm4CTKQdW0rZ5DzVTtypGSZoeEl+b9lC5trFfXbs+g
	rTIruraZa+Zq47wGsXWFQsyVg99WcuC+0gM8FeByPT7mri6HlVmONZWQ==
X-Google-Smtp-Source: AGHT+IFtVH7UjM/87oCHJ6DUbsAetp8PBWDPda8ZOgIZ6EU4bkSIEhABKs7/sgWo14aF9mEKEUu9sg==
X-Received: by 2002:a05:6e02:1745:b0:430:e5a4:6f26 with SMTP id e9e14a558f8ab-430e5a4724emr31688155ab.6.1760979121057;
        Mon, 20 Oct 2025 09:52:01 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:00 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	p.zabel@pengutronix.de
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] spi: fsl-qspi: add optional reset support
Date: Mon, 20 Oct 2025 11:51:46 -0500
Message-ID: <20251020165152.666221-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for one or more optional exclusive resets.  These
simply need to be deasserted at probe time, and can remain that
way for the life of the device.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
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
2.48.1


