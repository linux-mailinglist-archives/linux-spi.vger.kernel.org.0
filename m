Return-Path: <linux-spi+bounces-7510-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA3BA83A06
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 08:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B4719E752D
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0820468C;
	Thu, 10 Apr 2025 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHouObMF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BC204844
	for <linux-spi@vger.kernel.org>; Thu, 10 Apr 2025 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268208; cv=none; b=BniznhWAKkWhbAOQCfyuILIpAMFEYet7riW3P67C0tbS3GrZW4+SeOutD3g6If7eObBCQJbcXOjU5pUyeTLCg41sL4/CWzbrCNgvD0sNCnrsg7G/zlyHUd2U8tRC5pC4/e3rdF/JlOpCccc1+uTOO3aGr8JZrW1M5IzwjYH55Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268208; c=relaxed/simple;
	bh=G4sTbhNh1HTjBc3AK7UszlyRR4xFAT2Sr/GT5PBoscw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlmSzULjqZAm8/HhTC6VmR3vaHK8K3BmfLxSOb1OZ3r0mMWpdj25RnoKyIuSYNzHlZ72XbCiOrgXsLuM4a5gyqqMVPZ0B7cGlUWQSStXZc9lhB6XVnU4a+Gq8+tM2UNXZsQh9nQwA15eGOq8Hk2ynGPY4V/YKrVChCsQ4B6MH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHouObMF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c08fc20194so101898485a.2
        for <linux-spi@vger.kernel.org>; Wed, 09 Apr 2025 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268205; x=1744873005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+wsQP3176D0izkxKNDHdPvv/TXJHsloHJ6cokdroh8=;
        b=bHouObMFMah/62tS05v+vJM1B5aWCe0GNQ6ohIK6ZFHCFocDH5QDDOSvu05OWqHmV8
         30XFGhsdoqNyCcDyhQVYgH1odEl1TiW9pP6xZa4KMptYIfQvw41v0MzB3b56sjDAVIYS
         HegcuUBO5crqnXLFbWzawD/AgdWoeF0343yulp/JRAhVcYU+S67pYtjjZWuaEO73FUIE
         hystS9CAF+FUSY8FU8pkUXQNJZUPulcgOxFc3NW0g3Qn4HEB78SxlizZ8KGWmaB0bpVh
         lrj2g0gRxizNUcm7mjF4W4mtMsJJ2gRMOmhBib3Vn+KtDBskS82hvCqdvaZiByWygXOd
         gbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268205; x=1744873005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+wsQP3176D0izkxKNDHdPvv/TXJHsloHJ6cokdroh8=;
        b=neGXObfRQCX3W1WXdsA7gMGYjZvV3gwG//topuNr/tQHtMoBHGElrTPk3RVZspzrRr
         tPKIDGtYB+Do4p9nJiRdy7iENfyqDAJeaI9hb+w/MesI2lQddXXKsGxe2MRVPqb04VdY
         Uaza4o5LxhMac9pDtamNV5ZauGnZLdObDbt2izK24QTJtD7CbC4Lxs7W8C1oxoRdTrVK
         WnWk6ueNHTrA8C3LbKfH07tlikBQ8EHv8T/KkkMGIZ0qt0BfTUAyrGmMpH1/S6Xx1ulk
         sDErv+ka6WngaS/9v8K7IEFVUJsu8VcSEAs5OkZ+8aLAfGr9DyXsPDOqmSGDIS8Rf6BW
         jN9g==
X-Gm-Message-State: AOJu0YymfN4aEIHi7jJX6rLDS1orrpsQwwSMctyp1PTNsmdVEScGuL98
	QTf3QusRqXybL1x3dDTqtVIYa3BKbsGaAZEWxnKwqTi3K31VK4tw8/kTvFZ+
X-Gm-Gg: ASbGnctDFXnlD6HdUpgr4Nk2BIJHKTNy+rPs8wdvNoEgVJ3Sr6xP3jaexgftcoJ+Z8V
	MlGkB7b5i3c0hA0MqE5zdFwKlW+nv5c3uvBpNBzMCor6o1MmCm8DoDq3JbDelK8u35BfS7IkJDJ
	Q9WwtdPfIj7rM3Sg/UPHUT3FHOmjgugVLspcWCmBiPoFvAjkLyPyi8usH5XThc17f9b2LVBO33M
	Nzj9SQP9/NFAG+lG8c5qZj7an5gEiHt3e9z/t0D/SQeGWEAo1kAub0oEv36E5fBpQgeG4Oduzwo
	iPaOfjXWWOsGSpi9oo3UBtACIBuXOP4yVnmGFbrIAVAJAj9WUnKHLcbHVuMQYQ==
X-Google-Smtp-Source: AGHT+IH4InyUfXvFHy9wew0zGMTWWAUknYjQnXzFYFulhKKW5BvpTJXx+LSGl6iMSBJor0GjmjMP+A==
X-Received: by 2002:a05:620a:17a6:b0:7c5:d888:7098 with SMTP id af79cd13be357-7c7a76bffbemr229908685a.44.1744268205265;
        Wed, 09 Apr 2025 23:56:45 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89515e4sm46547285a.26.2025.04.09.23.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:56:44 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 10 Apr 2025 14:56:11 +0800
Subject: [PATCH 3/3] spi: fsl-qspi: Simplify probe error handling using
 managed API
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-spi-v1-3-56e867cc19cf@gmail.com>
References: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
In-Reply-To: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 imx@lists.linux.dev
X-Mailer: b4 0.14.2

- Switch to devm_spi_alloc_host() to avoid manual spi_controller_put()
  calls in error paths.

- Factor out the hardware disable logic into a dedicated
  fsl_qspi_disable() helper and register it as a managed cleanup action,
  removing the need to explicitly disable hardware after
  fsl_qspi_default_setup() failures.

- Move fsl_qspi_cleanup() earlier in the probe sequence to eliminate
  the need for manual cleanup in the irq failure path.

With these changes we can completely eliminate the messy goto labels
in probe function.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/spi/spi-fsl-qspi.c | 73 ++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index b5ecffcaf7955e2ec9bb3e2857f8bc14d73a2f90..f879533535e853dac6bff22a3a5e87431a44a1d2 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -844,13 +844,18 @@ static const struct spi_controller_mem_caps fsl_qspi_mem_caps = {
 	.per_op_freq = true,
 };
 
-static void fsl_qspi_cleanup(void *data)
+static void fsl_qspi_disable(void *data)
 {
 	struct fsl_qspi *q = data;
 
 	/* disable the hardware */
 	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
 	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
+}
+
+static void fsl_qspi_cleanup(void *data)
+{
+	struct fsl_qspi *q = data;
 
 	fsl_qspi_clk_disable_unprep(q);
 
@@ -866,7 +871,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	struct fsl_qspi *q;
 	int ret;
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(*q));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*q));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -876,68 +881,60 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	q = spi_controller_get_devdata(ctlr);
 	q->dev = dev;
 	q->devtype_data = of_device_get_match_data(dev);
-	if (!q->devtype_data) {
-		ret = -ENODEV;
-		goto err_put_ctrl;
-	}
+	if (!q->devtype_data)
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, q);
 
 	/* find the resources */
 	q->iobase = devm_platform_ioremap_resource_byname(pdev, "QuadSPI");
-	if (IS_ERR(q->iobase)) {
-		ret = PTR_ERR(q->iobase);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(q->iobase))
+		return PTR_ERR(q->iobase);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					"QuadSPI-memory");
-	if (!res) {
-		ret = -EINVAL;
-		goto err_put_ctrl;
-	}
+	if (!res)
+		return -EINVAL;
 	q->memmap_phy = res->start;
 	/* Since there are 4 cs, map size required is 4 times ahb_buf_size */
 	q->ahb_addr = devm_ioremap(dev, q->memmap_phy,
 				   (q->devtype_data->ahb_buf_size * 4));
-	if (!q->ahb_addr) {
-		ret = -ENOMEM;
-		goto err_put_ctrl;
-	}
+	if (!q->ahb_addr)
+		return -ENOMEM;
 
 	/* find the clocks */
 	q->clk_en = devm_clk_get(dev, "qspi_en");
-	if (IS_ERR(q->clk_en)) {
-		ret = PTR_ERR(q->clk_en);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(q->clk_en))
+		return PTR_ERR(q->clk_en);
 
 	q->clk = devm_clk_get(dev, "qspi");
-	if (IS_ERR(q->clk)) {
-		ret = PTR_ERR(q->clk);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(q->clk))
+		return PTR_ERR(q->clk);
+
+	mutex_init(&q->lock);
 
 	ret = fsl_qspi_clk_prep_enable(q);
 	if (ret) {
 		dev_err(dev, "can not enable the clock\n");
-		goto err_put_ctrl;
+		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
+	if (ret)
+		return ret;
+
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_disable_clk;
+		return ret;
 
 	ret = devm_request_irq(dev, ret,
 			fsl_qspi_irq_handler, 0, pdev->name, q);
 	if (ret) {
 		dev_err(dev, "failed to request irq: %d\n", ret);
-		goto err_disable_clk;
+		return ret;
 	}
 
-	mutex_init(&q->lock);
-
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 4;
 	ctlr->mem_ops = &fsl_qspi_mem_ops;
@@ -947,23 +944,15 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
+	ret = devm_add_action_or_reset(dev, fsl_qspi_disable, q);
 	if (ret)
-		goto err_put_ctrl;
+		return ret;
 
 	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
-		goto err_put_ctrl;
+		return ret;
 
 	return 0;
-
-err_disable_clk:
-	fsl_qspi_clk_disable_unprep(q);
-
-err_put_ctrl:
-	spi_controller_put(ctlr);
-
-	return ret;
 }
 
 static int fsl_qspi_suspend(struct device *dev)

-- 
2.49.0


