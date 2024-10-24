Return-Path: <linux-spi+bounces-5367-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C775B9AE761
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B4F1F2158A
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516551E32CF;
	Thu, 24 Oct 2024 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DohlH3wl"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F71E284B
	for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778693; cv=none; b=ifV56lXIVKX9v/TGLfaGgK3L9F0vuYREGrqXdpxubTvheHnbHnNWyQaPiTn3jRqbmvKKqS5E1VOq66sOumqToy2zTco8ArEbKznQU+kmWLRjmKy3s9uVq5WvH+2ZU6Q5ZprrRyBau3XVGAro5kacpj1Xwt25Lp/aVq809oaTV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778693; c=relaxed/simple;
	bh=bPfOkhab+RdZJQo4Bgv6xEBR2RHMOFXjrb4S0KcA874=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SC+C+6yfoYqdswFOjwkq+JtKy1hnbP40H4cvUzENyCpVslkObC2hxP8xKwqrAAUjkFkgC0QrphJA4qEflZl9xjmtrIw5t0KIAwevVHXvhVbZJMvSvqX6/6itUDw3JU6TKhY2dhFFVNdn5NJZ+UwdejDb3Po+3XHTuCqxgORL9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DohlH3wl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hQSm1B/bBPEQI6fCzkx9lfLG7DkGTIpXzv4hP+8MIq4=;
	b=DohlH3wl+lWfKDmDFjr4Dg/pWGb1s4MwzPHNgTDN1/QEl1mCo/2kEb7yEE78VerR/kWqHc
	aowEKVbxzIfpI/O3LSJ/8s8BQ/KjVoPTym9fBnoBFZnjFwMyUQCnm6/QGgxEsw1H6Xjx/u
	ku4tfVb+ctz02kg1guJHoTZsVJ9dt0s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196--Bj9XlWXMcuUu0vJ9fZJcw-1; Thu, 24 Oct 2024 10:04:48 -0400
X-MC-Unique: -Bj9XlWXMcuUu0vJ9fZJcw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539f067414fso764269e87.2
        for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2024 07:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729778687; x=1730383487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQSm1B/bBPEQI6fCzkx9lfLG7DkGTIpXzv4hP+8MIq4=;
        b=eBvIArK+mj4ZHIHt8AoigYbfby8o/73bIdcTU6J67t36pMdpG0NqEWqTD0IXm9iccf
         Kn+HgLH5yy1Xz1b1k7kb/vpR3GI8xcEXQvmUZ1QDorYCRbQYvThM06EtWdkITpiiSOev
         feeBbaGkoecUY2H+wtD/F5zzFEAT+G5fe/sOjcp2XRVHUfS/KXCD/JSADClmkNyCjhfG
         S9Az+kSu9wg6HqTKRRRMGhNmrpHlCuAq0+5/0blWL3jnWvVYh4ertRvA07w0KNmpXJLM
         hoPSrcWNQMoaaZNPcVTDxjcrr35ZMaT5ZKbJlcc7gVFqttJV+PeliGY/zHSnFLkEAb0j
         Bi3w==
X-Gm-Message-State: AOJu0YzKFwirlIyxfnzbYiGl/NNbspEcJK+d98T3c3gIc+uGRpV7Jour
	BkadU5jzlxG+2XhJHwAzUanUCQHX0Nk+g+olXHmsudqb+42g3/TqjI4OSMgF7iLVVAKB11Nu1CD
	P5oPRwPXCF71aZOTZbP3swykNenjlLY5OaA9HRiHc5Se8Jrp/G3KgK59fiw==
X-Received: by 2002:a05:6512:114b:b0:539:f9b9:e6d2 with SMTP id 2adb3069b0e04-53b23e33c6amr1060382e87.35.1729778686857;
        Thu, 24 Oct 2024 07:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK+Aa3uTsskL25IZrDrkMj9fVpwcg2FaoD/X/Iae1N1I2ol9nC/eMbTbhx8ycQe9G8SPKiMA==
X-Received: by 2002:a05:6512:114b:b0:539:f9b9:e6d2 with SMTP id 2adb3069b0e04-53b23e33c6amr1060343e87.35.1729778686258;
        Thu, 24 Oct 2024 07:04:46 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bde267sm46655925e9.13.2024.10.24.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:04:45 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Mark Brown <broonie@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] spi: Replace deprecated PCI functions
Date: Thu, 24 Oct 2024 16:04:27 +0200
Message-ID: <20241024140426.157444-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

pcim_iomap_table() and pcim_request_regions() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/spi/spi-dw-pci.c       | 9 ++++-----
 drivers/spi/spi-loongson-pci.c | 5 ++---
 drivers/spi/spi-pxa2xx-pci.c   | 8 +++-----
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 7c8279d13f31..6b8cc26e06f8 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -98,15 +98,14 @@ static int dw_spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *en
 	dws->paddr = pci_resource_start(pdev, pci_bar);
 	pci_set_master(pdev);
 
-	ret = pcim_iomap_regions(pdev, 1 << pci_bar, pci_name(pdev));
-	if (ret)
-		return ret;
-
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
 
-	dws->regs = pcim_iomap_table(pdev)[pci_bar];
+	dws->regs = pcim_iomap_region(pdev, pci_bar, pci_name(pdev));
+	if (IS_ERR(dws->regs))
+		return PTR_ERR(dws->regs);
+
 	dws->irq = pci_irq_vector(pdev, 0);
 
 	/*
diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pci.c
index 134cda0c13a5..892cf1eba1cf 100644
--- a/drivers/spi/spi-loongson-pci.c
+++ b/drivers/spi/spi-loongson-pci.c
@@ -19,12 +19,11 @@ static int loongson_spi_pci_register(struct pci_dev *pdev,
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "cannot enable pci device\n");
 
-	ret = pcim_iomap_regions(pdev, BIT(pci_bar), pci_name(pdev));
+	reg_base = pcim_iomap_region(pdev, pci_bar, pci_name(pdev));
+	ret = PTR_ERR_OR_ZERO(reg_base);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request and remap memory\n");
 
-	reg_base = pcim_iomap_table(pdev)[pci_bar];
-
 	ret = loongson_spi_init_controller(dev, reg_base);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to initialize controller\n");
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cc8dcf782399..e51c1b492283 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -273,10 +273,6 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = pcim_iomap_regions(dev, 1 << 0, "PXA2xx SPI");
-	if (ret)
-		return ret;
-
 	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -284,7 +280,9 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	ssp = &pdata->ssp;
 	ssp->dev = &dev->dev;
 	ssp->phys_base = pci_resource_start(dev, 0);
-	ssp->mmio_base = pcim_iomap_table(dev)[0];
+	ssp->mmio_base = pcim_iomap_region(dev, 0, "PXA2xx SPI");
+	if (IS_ERR(ssp->mmio_base))
+		return PTR_ERR(ssp->mmio_base);
 
 	info = (struct pxa_spi_info *)ent->driver_data;
 	ret = info->setup(dev, pdata);
-- 
2.47.0


