Return-Path: <linux-spi+bounces-3071-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF8F8CE97C
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62817282E5A
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B141C73;
	Fri, 24 May 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="dxrqh2Dl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75383C485
	for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575276; cv=none; b=pEZyD/Igf2QbK3pNICn2nwAnRq10S2ux0ZiVjz77UmY3wp+3n7xischtymUL9njIRVffsNYwF0e7jUaFUJRceDK/u2lKPbbhQguxTap6fuC+XzENRKdXjvnqx6JqHv7NN7j2WY6KIBRuCQ4X8/y9zndNU9blUsNSfU/Spw8StLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575276; c=relaxed/simple;
	bh=td/Vk7YkZYHrVt/nOdJ0BOQkIAcpR2c/B2eHAhBjQLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Axl4kN82OSjHjvpF1Wb2qb2lHfFnfGF2t/C5nGtgxqtluhu6NwwdEsE141Yl9hEBz1L00yJxUTZQdjYno/V2fYKK1SrabwlmJfLoP/5i8H+33/jK8mJIKz/adpWBxFbY9FYZXdaGKN4Fs+vHnQVE/ZALb/fBwm/ycC8pe98zBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=dxrqh2Dl; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-42108856c33so6188895e9.1
        for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575271; x=1717180071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xql1CWOkqvawpbosdHCKSvgqjnwNVKxpQqZxh7tM+T4=;
        b=dxrqh2DlxIVia43NACZLda+CTXfnSS7U4U3G5ZWpxu5FyGVH2d39QrQv0aqklsfeEr
         9IWlHdJyqSA/pPsrsx19+OvL+pg9kWdnARtf/lNOaXC5EzhRx2u46d6fbSS2kgfp+B4n
         2P+3I/kfASS6IlWSQyVu0/akO8qupmHF97J4G8s3b3lPBDcqj0BmMqoLMQcpDq+PisnA
         BAh4FhNuhj7gcDZh9V57WyF0bZXeKJLIQqJf8uPD4bci7Fp4QVVrO9gylpMYMon84cs5
         VY8wYLrgrh4blrEh3cdnb3TFAePY1zWBoo15rfq9t2rpTwsM+j9XL1Lto+MXFkB1itAk
         WH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575271; x=1717180071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xql1CWOkqvawpbosdHCKSvgqjnwNVKxpQqZxh7tM+T4=;
        b=kuh+rMLWOq8QXmMP6+g5/PC+wK3p350Ppv15qBMQYt/xwXVXM5/AULheVYP3aP2ShP
         PkIPqhhMSJKE148qFNmceTYp3Tfy1KzK/Qg8StioSaPx/76hgIYaWQyxQOfJlcor9Q02
         u0s+E7MOWyq1ZXw6gK0TjqQ1wenV02flG0W7QORVhE0wXQACitnRSGtl2UsuuyBK8+5s
         gnqMgjPx+mPckNoF6TZJzH514QJFseaVBDgU2VNNG7WwaxFXuU5VvZNbbnuOJRJsa1p3
         ra8/8zFP0+yUJaSaK8tf2ZALlFkheDo0znq2DDe6kKaQCRDZKgMf5EL/xh70Jp7RqehM
         1RJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX32Y6q4GNwhmoEo70gdi3rOlQOiLwkBvkrj4oexyqxujmYzlTkp50jswenA3AFAjRzxfW3AGFTNDw/qpcX0BaN7l35hLOj4F/3
X-Gm-Message-State: AOJu0YwIN5VvfVHJN1cFfIdTvhO19dCv8r27Pz6+5bLpd+9Yplspcyr5
	QZxrtYzY1hGzQSZCGQauqNmKthYAyVLQ9kWHcnhOud3QkXotuY0S4r8SGiRBLv2/8aGXdVr2uRk
	pUjm1vLn5IzJbsS0QWsJTsoXWC3uYOEAb
X-Google-Smtp-Source: AGHT+IEv4pOsw1zoXJUhXCDnkIg536hPcEoYyVLGKEBIg1WFslqr8Kj1DBgMYFhuBxYsZGvlD4sKieE6j1gT
X-Received: by 2002:a05:6000:1753:b0:354:fce5:4cc3 with SMTP id ffacd0b85a97d-354fce54d2dmr4599736f8f.19.1716575271168;
        Fri, 24 May 2024 11:27:51 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-35579d7b436sm63138f8f.14.2024.05.24.11.27.50
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
Subject: [PATCH 00/18] BCM2835 DMA mapping cleanups and fixes
Date: Fri, 24 May 2024 19:26:44 +0100
Message-Id: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All

This series initially cleans up the BCM2835 DMA driver in preparation for
supporting the 40bit version. It then fixes up the incorrect mapping behaviour
we've had to date.

The cleanups are based on Stefan Wahren's RFC [1], with a couple of minor bugs
fixed, but stopping before actually adding the 40bit support. If we can sort
the mapping issue, it avoids having to have workarounds in the 40bit support.

The mapping issues were discussed in [2].
Up until this point all DMA users have been passing in dma addresses rather than
CPU physical addresses, and the DMA driver has been using those directly rather
than using dma_map_resource() to map them.
The DT has also been missing some of the required mappings in "dma-ranges", but
they have been present in "ranges". I've therefore duplicated the minimum amount
of of_dma_get_range and translate_phys_to_dma to be able to use "ranges" as 
discussed in that thread. I'm assuming that sort of code is not desirable in the
core code as it shouldn't be necessary, so keeping it contained within a driver
is the better solution.

When Andrea posted our downstream patches in [3], Robin Murphy stated that
dma_map_resource is the correct API, but as it currently doesn't check the
dma_range_map we need Sergey Semin's patch [4].
There seemed to be no follow up over the implications of it. I've therefore
included it in the series at least for discussion. If it's not acceptable then
I'm not sure of the route forward in fixing this mapping issue.

I'm expecting there to be some discussion, but also acknowledge that merging this
will need to be phased with the patches 1-13 needing to be merged before any of
14-17, and then 18 merged last to remove the workaround. I suspect that's the
least of my worries though.


I will apologise in advance if I don't respond immediately to comments - I'm
out of the office for the next week, but do appreciate any feedback.

Thanks
  Dave

[1] https://lore.kernel.org/linux-arm-kernel/13ec386b-2305-27da-9765-8fa3ad71146c@i2se.com/T/
[2] https://lore.kernel.org/linux-arm-kernel/CAPY8ntBua=wPVUj+SM0WGcUL0fT56uEHo8YZUTMB8Z54X_aPRw@mail.gmail.com/T/
[3] https://lore.kernel.org/lkml/cover.1706948717.git.andrea.porta@suse.com/T/
[4] https://lore.kernel.org/linux-iommu/20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru/

Dave Stevenson (7):
  ARM: dts: bcm283x: Update to use dma-channel-mask
  dmaengine: bcm2835: Add function to handle DMA mapping
  dmaengine: bcm2835: Add backwards compatible handling until clients
    updated
  dmaengine: bcm2835: Use dma_map_resource to map addresses
  dmaengine: bcm2835: Read ranges if dma-ranges aren't mapped
  arm: dt: Add dma-ranges to the bcm283x platforms
  dmaengine: bcm2835: Revert the workaround for DMA addresses

Phil Elwell (4):
  mmc: bcm2835: Use phys addresses for slave DMA config
  spi: bcm2835: Use phys addresses for slave DMA config
  drm/vc4: Use phys addresses for slave DMA config
  ASoC: bcm2835-i2s: Use phys addresses for DAI DMA

Serge Semin (1):
  dma-direct: take dma-ranges/offsets into account in resource mapping

Stefan Wahren (6):
  dmaengine: bcm2835: Support common dma-channel-mask
  dmaengine: bcm2835: move CB info generation into separate function
  dmaengine: bcm2835: move CB final extra info generation into function
  dmaengine: bcm2835: make address increment platform independent
  dmaengine: bcm2385: drop info parameters
  dmaengine: bcm2835: pass dma_chan to generic functions

 arch/arm/boot/dts/broadcom/bcm2711.dtsi       |  14 +-
 .../arm/boot/dts/broadcom/bcm2835-common.dtsi |   2 +-
 arch/arm/boot/dts/broadcom/bcm2835.dtsi       |   3 +-
 arch/arm/boot/dts/broadcom/bcm2836.dtsi       |   3 +-
 arch/arm/boot/dts/broadcom/bcm2837.dtsi       |   3 +-
 drivers/dma/bcm2835-dma.c                     | 432 ++++++++++++++----
 drivers/gpu/drm/vc4/vc4_hdmi.c                |  15 +-
 drivers/mmc/host/bcm2835.c                    |  17 +-
 drivers/spi/spi-bcm2835.c                     |  23 +-
 kernel/dma/direct.c                           |   2 +-
 sound/soc/bcm/bcm2835-i2s.c                   |  18 +-
 11 files changed, 383 insertions(+), 149 deletions(-)

-- 
2.34.1


