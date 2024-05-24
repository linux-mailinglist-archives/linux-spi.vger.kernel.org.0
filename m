Return-Path: <linux-spi+bounces-3082-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19758CE9AF
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 20:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0271C216BC
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC4947F4B;
	Fri, 24 May 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="M65Q5Uek"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD693FB1B
	for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575285; cv=none; b=DPZ3/yYxopRFy0vzwIWZnXx0KqE2EU53MMfbsNsYYrE/KejBPKTOqgIo2aAOR3V5Yixun0KUt/uWmivUXLuo6yh4n9o27l7RA9Qcpe8eJ/SD9SV5wHRY6NMDdvB/RyrtxdLP8VQcWGcAN9rlLW6SzZf14Y/Fq89AnjqKqrn9XqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575285; c=relaxed/simple;
	bh=5nrl5uVGiAQbueZrACpZq8a6cFbZpWvV3c8a8/I60FE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwL3jMqL38yMPMZMu/q/M3vVWFgC8ZC7WQtLAHxn90bt1hpzijvBCZdXhlLc/RruSNHV8bv6pLKylEbKTlFo1F1INAnqGk4D7pUZdR2LgffYMYW0F0O3Dx+8/lRoUmeSQz5+3/FVdwVf1ziQU/7SkMpiQJ+lw0Y+6xcmuFv33D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=M65Q5Uek; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-4200ee78e56so33901755e9.3
        for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575277; x=1717180077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsDDNY/QwJvf47dmHC7PRu5uL7JEaRYA48sLf9OqOOY=;
        b=M65Q5UekziG+lHvXQ/hI4nw4upU5bbNJVfgaHqEmGJLfmLg/wnt5OLrm1bsxi3HXHe
         hMi+LCte6mD6ONooYUmb9MJGl6n3IO0se3b14h68fuMTOAqkPm2JK3TWzOvNuHEVa8Md
         vNqC01pAGWD0D4ZY7ILTvYgxGTLmHYTdqM0IhIQwdzsEb5KbMbI0I/NQ7QIQaRlqERmf
         LNPrD7IrxfR6TeGLsMCnZfRaym/deOUkUAGgaKZvovawuN3PG3YHcKVtAWzw/TNDMOv/
         4VSeuFQ2ODyw0fdTrGMkIbOvFA2AsMEfAVghVKJwElD2ONrMLZVAmj+yW2wwG43+xpzg
         jhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575277; x=1717180077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsDDNY/QwJvf47dmHC7PRu5uL7JEaRYA48sLf9OqOOY=;
        b=Pxyx3IuAWE54AHHjdfzZJcyWJqlRdkywtk+2cZ9wN1sa3SM9QSlXfmnWv4d0vs8kDc
         WMfWp57fjsluDdAb2ZDASBc1doEyt0ab012JLY0ujX633e4of1AmpBuj1afzGRcBrccB
         JdwRfb9hk7JfAJdYVN4vetvr/c8N5Ry6/STCPEEpf0xiiN6MOoiweYoTNtqtcI2wGZrK
         Sl8jSZY3mnbHil0li/fm+dPHvg1XTLPlJe6qaU86lKlfVSOYhE4xz4ThF0RqKXsp8eJ+
         1CUms7+oRWJt4zl8t1DWrhBWJt94ICaRK/V07v+dJ3MO7UYXYcL67TbT+Y1HmkyJG7Cb
         WTXw==
X-Forwarded-Encrypted: i=1; AJvYcCXVfcaiYgI9xiaoY1IDC47LDjNJ1eSmIA/OcnvJG/Qgupe0KiUiT4J2iDXnZzPny1/2fvna4Q3924iax6CwhP05fsBCsrXFh0p5
X-Gm-Message-State: AOJu0YwH/Nc0zNA+j//wG8jlMps917mZubIajVERYkdGVQcrCds4TB6N
	wWDFPYdh8A8Q0tQfihmmlZUFeFeMtXneToQUS+gkOYhC85N3PNBpnY6ZeY+GvIDYx6LABKWfeDI
	bdq4dBiWZ0Pl7dwgN3V8q/w3JFpmFTW8D
X-Google-Smtp-Source: AGHT+IEXHyAwczg+VXo+M67fY0mVhzt5oPk36AjtQ9lYPMdZoLz7U9U+HdeHdCJz5d472HFdCSVQwmE4fQK0
X-Received: by 2002:a05:600c:3106:b0:420:29dd:84d5 with SMTP id 5b1f17b1804b1-421089ebf63mr23274805e9.5.1716575277312;
        Fri, 24 May 2024 11:27:57 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4210a964067sm979275e9.31.2024.05.24.11.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:57 -0700 (PDT)
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
Subject: [PATCH 10/18] dmaengine: bcm2835: Add backwards compatible handling until clients updated
Date: Fri, 24 May 2024 19:26:54 +0100
Message-Id: <20240524182702.1317935-11-dave.stevenson@raspberrypi.com>
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

bcm2835-dma has been (incorrectly) expecting dma addresses to be
passed in, not CPU physical addresses.

In order to fix this up, add temporary handling of clients still
passing in dma addresses until they are fixed up.
This will be reverted once all clients have been fixed.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index ef1d95bae84e..9531c0b82071 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -283,9 +283,23 @@ static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_dma_chan_map *map = &c->map;
 
-	map->addr = dev_addr;
+	if ((dev_addr & 0xfe000000ULL) == 0x7e000000ULL) {
+		/*
+		 * Address is already in the 0x7e... peripherals range.
+		 * Assume this is an old client that hasn't been updated to
+		 * correctly pass a cpu phys_addr to the DMA subsystem.
+		 */
+		map->addr = dev_addr;
 
-	return 0;
+		return 0;
+	}
+
+	/*
+	 * This path will be updated to handle new clients, but currently should
+	 * never be used.
+	 */
+
+	return -EINVAL;
 }
 
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
-- 
2.34.1


