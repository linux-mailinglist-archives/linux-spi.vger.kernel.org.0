Return-Path: <linux-spi+bounces-3073-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AF98CE98D
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6252D282E65
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDCF47F78;
	Fri, 24 May 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="TXjTMPjv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561F3FB01
	for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575277; cv=none; b=gQXkpm35Ez3FnuTInupm7EOdkJtFKP5hEBRdz3VeIE6pcrMZ37590Xrp27mBPAUWYT3xtzVKZqPXALZ0AUl863acM//nGK16hRCIap94cI1tI3FqSBtiJFqzh0nk5S7VQgTdhn2weUDFvtHnkCYXJzUqgmwVZtQPh3twd9geqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575277; c=relaxed/simple;
	bh=KzZ2/ILylgxy50sk/StCVlBR9s2jedRDn061bSZ6QRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxceezYc5DIUnZ9Z9DGCqoKdRchQexUPjm2x38j5MhcXH4PzycTFkXVxGoJjb/1WWDc9pjUcYGRm5x7jRuNyu4t5DhC2Yd3tO+lsEGwgnOWfIpHPeGezjHHdUxFOfp9KGQPL3QrwRulYZrW3wJON6cUCv8VFnB+HNnqM36gECvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=TXjTMPjv; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so64558375e9.2
        for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575273; x=1717180073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MV7QZf2fhH+OEhBA38QGxT92fUaASU1Nxo1nxUSVd8=;
        b=TXjTMPjvEB/mpo5ZJFhiMaaLnozrvLslAQ+8QJMzQMCPL24NoORbh/iE+2u0VB2MfZ
         1EfFvNlEv3pYHOX3PLnPH81gO8rl+M3C9pwpf76F3Ym4Cmroc3xhPvVpSak5XcrMHzHm
         D5mZhstvelzEAdDlKGhTP6mZHGx2SL2LLuA04oOSyJeQ+FQhAeR9LYDZn2a0FSVJcOeD
         W5NC7dvCF5W0HL2IU8T53zi9BLYm9nBfyYCdJDv1I0XaAJ2lJvQom18lNOpjx5B8xXTs
         qytn/30BOA7mU5yGUg/NF7guE60VaGTNLsr7ROhtnuCRWtpSC6DJpuLb4qAgg1xJpb67
         HmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575273; x=1717180073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MV7QZf2fhH+OEhBA38QGxT92fUaASU1Nxo1nxUSVd8=;
        b=Z/W9qcuP4ZvjyVR7BbLuFdA6oD/E926sQHOCZWMwRT5l5+2KfmcILlxH+lv35zu9Zo
         2g62b7prmvi9kqXfC9+ucIiQBKLB+llPPyCc7m2GxaWrPEbF7BRQoMsHa5GGgxw+wCJ2
         Gt3IjtBeOJlOFRZzBvP6wn1/rROkc8wGuGdlSZEu75d2Mc+kR27VPmfhGctCexCNJKc6
         tPgoNxkzUusIBSSxNHvlrAeMYtMocIMtJRFUUaUim9Lenmleh0e5BPXYYBsjejZ9hSuS
         9QeiMv4/oPguieN+lsEst1JpTMsyeMYizny+X+dtlD/xygPbbYIPA/E1sBkxnhRq0z3b
         SQIA==
X-Forwarded-Encrypted: i=1; AJvYcCVMSU0P+qyPqYiKWirq5nG1Jn7m/5v7sDNCjo7p+moJ1mMWGOGkqRIL9qfaeUwOlI5VrHnimHsuU1fOv34X6ZXoPi0MMsEjc+OG
X-Gm-Message-State: AOJu0YyiupEP2EUvAjp4l0gFbEbeWPojOrex5SNhheweSckGEp2y9VGh
	xG/77gGaGvO5dLu2mmR9+xK5xL2cmQ5AYpeSOj/GFmOhiZCW2+w8yAfAtU8cT5YXw4cqSan+wCk
	YFv1CEldmMZtrG7yNqpqSj01iQKPcsUtg
X-Google-Smtp-Source: AGHT+IHWZ0JTRBQwe/XochchvTJaAoc7r7/ijNNUJ35CDCjZA7ALjlPQSMAk7tENe+DW/f85sGYNAcbTrrfr
X-Received: by 2002:a05:600c:5799:b0:41b:f2ca:19cc with SMTP id 5b1f17b1804b1-421089f93b7mr26088945e9.34.1716575272958;
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4210891c6edsm1217615e9.20.2024.05.24.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
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
Subject: [PATCH 03/18] ARM: dts: bcm283x: Update to use dma-channel-mask
Date: Fri, 24 May 2024 19:26:47 +0100
Message-Id: <20240524182702.1317935-4-dave.stevenson@raspberrypi.com>
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

Now the driver looks for the common dma-channel-mask property
rather than the vendor-specific brcm,dma-channel-mask, update
the dt files to follow suit.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi        | 2 +-
 arch/arm/boot/dts/broadcom/bcm2835-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index e4e42af21ef3..d64bf098b697 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -103,7 +103,7 @@ dma: dma-controller@7e007000 {
 					  "dma9",
 					  "dma10";
 			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x07f5>;
+			dma-channel-mask = <0x07f5>;
 		};
 
 		pm: watchdog@7e100000 {
diff --git a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
index 9261b67dbee1..3ba8db8eed0f 100644
--- a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
@@ -46,7 +46,7 @@ dma: dma-controller@7e007000 {
 					  "dma14",
 					  "dma-shared-all";
 			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x7f35>;
+			dma-channel-mask = <0x7f35>;
 		};
 
 		intc: interrupt-controller@7e00b200 {
-- 
2.34.1


