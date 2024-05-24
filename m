Return-Path: <linux-spi+bounces-3072-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E78CE981
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22AD282E73
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707F43AAE;
	Fri, 24 May 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="RXXjQD6d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88D3D966
	for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575277; cv=none; b=cQ/b6gU6fIjpqbZhdHgXfMkmt5j978mp02X/Hioq/4TDl147J/rhZPKVf7IeFsYhCqIRktFLgvq/j1FPq91H/Squ6dYMbhhtTiBJG7Z35JUYQD86GQbeSPZ9HyttoPoeckrFppP6IT4LZ1Y8F59xRGFYrx0NFYf7w13HNTKv+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575277; c=relaxed/simple;
	bh=guK+qXaJ8AZoVR69jRMhph9+Ra3UDqbRnwvqmJc9gsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnpG4Mx23njlknzUiml9nJHblZ8H3PXAKF6Qah6ANCrYj03fvjrmASCwbngn+P+Kswc1fH/FZoRkvFyYxMFOIv9NdybBYVaZ60A0SIpA0GdFJEAnieRdNwD9ASI73w0f9X18MPvF53jzuQtBfvf120jCbJFno6hReNZsIn/sIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=RXXjQD6d; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-42011507a54so20436635e9.0
        for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575272; x=1717180072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSFDj4ol3AWAL0GeTo1h24EE4RwMrFwKLsNkcBtWgJ8=;
        b=RXXjQD6dzwStvDqi+42tP00mk/CVTm2VB2sOJMazc+QH6UwOGZWlZkSHfslgQych+T
         I8TfXS5wDEd2vdmawaUMTmI/Ux1N9sHlZn+FneXjPVb35XSTGVT1M0pWEtMR4JOWkeZG
         MhOZLJvb8KKmbnvA5TTG/O3qAZRp7HGvTZMTgFQhG1eRlIpyhldAZvUHzttyDLJf0DFO
         1M5a19di362OhlMryLr9Ck30vwnekJ5AP7GwPX0u5HgE/p1Skd3SitHMNA/Vcwq6iVyw
         CVpUpQnSARVOdJAPqyqrFn0ZFpO4uhRsmdUjNSqcmq40KoxFLw3v4VPucXK1j1YoP+nl
         lVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575272; x=1717180072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSFDj4ol3AWAL0GeTo1h24EE4RwMrFwKLsNkcBtWgJ8=;
        b=cHP/lKjPU7PNBOx+H8b+LIfg0l7xa6reydZ9qX4wvqRwuDFtL7ORwffSU9pqE7jka7
         Ggw5yw9HHSLRE4fsbt43wkRW6gafyDKsQenFmO6ajB1cV2DRS8WGKV7hWv7EylJSKviJ
         bNOG3hUWdwfU5/ntOfMIKqcamnF8R/dfA0tBaV5DvvOPsIV7Ym1f4CsBshS8T+fG6F9s
         cAIqcboyj5yjA1TD5CQ90euslMTABOg/nCyZFpmzjlcZi41+VN81N8Rl+yJkVwvjPzbr
         6VQa5YrxeK3YGmkWrtPGWcm1z7/cE8YiLgxIxDx9gHz+41+1T7FU9REYkGBIv41TCeDD
         45Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXW2B21p57aX8e4/7P5qAQ0Oi+oWxnBHA62jSw9KvgmUHEM8jzkkZuC8AcY/I/roxIfYR/J6u1o8HhYKog+8rZo9PEGBw0Shmxd
X-Gm-Message-State: AOJu0YxSZ9W0Hm92iiv8W7c8bfD/8Fjc7qcIl5xUq2sSQdP+T4BFZfkF
	9/jcAkTm67h6St5I1LF0sxlgGktZRCPmho7jzRDQDHF0On8tOR/o28eqafRcgTEI6CABccUnGVB
	zu6fyL4ML6W+SaY19qmltp8a0Mo3RKbcT
X-Google-Smtp-Source: AGHT+IGoEzQFTvVJkKaznbn3tsRrsBHXrR2xRBfQSwJwq8OyKLj9sbB3e3hIegjaXdW0XFK+xVpzR1K4PrIS
X-Received: by 2002:a05:600c:4695:b0:41a:4623:7ee9 with SMTP id 5b1f17b1804b1-421015b3ccemr57035725e9.10.1716575271904;
        Fri, 24 May 2024 11:27:51 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4210890571asm1226495e9.7.2024.05.24.11.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:51 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 01/18] dma-direct: take dma-ranges/offsets into account in resource mapping
Date: Fri, 24 May 2024 19:26:45 +0100
Message-Id: <20240524182702.1317935-2-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

A basic device-specific linear memory mapping was introduced back in
commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
preserved in the device.dma_pfn_offset field, which was initialized for
instance by means of the "dma-ranges" DT property. Afterwards the
functionality was extended to support more than one device-specific region
defined in the device.dma_range_map list of maps. But all of these
improvements concerned a single pointer, page or sg DMA-mapping methods,
while the system resource mapping function turned to miss the
corresponding modification. Thus the dma_direct_map_resource() method now
just casts the CPU physical address to the device DMA address with no
dma-ranges-based mapping taking into account, which is obviously wrong.
Let's fix it by using the phys_to_dma_direct() method to get the
device-specific bus address from the passed memory resource for the case
of the directly mapped DMA.

Fixes: 25f1e1887088 ("dma: Take into account dma_pfn_offset")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4d543b1e9d57..916a16959575 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -509,7 +509,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t dma_addr = paddr;
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, paddr);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
 		dev_err_once(dev,
-- 
2.34.1


