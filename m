Return-Path: <linux-spi+bounces-3087-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA77F8CE9D3
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 20:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8954628315E
	for <lists+linux-spi@lfdr.de>; Fri, 24 May 2024 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104F7405D8;
	Fri, 24 May 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="HCrdbbkA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65F3FE55
	for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575289; cv=none; b=SJX+PD6MatbSOZyvty2W6UcmbxxPs/xzecfjB/jM+E99h1bnlxTm4l7vbHx0MYfRRvdS1qYzRBxZL/ft3+dKacOutSNq5n0xqcmfZx1f0HuPyYgek3/Mud2qipvAzwtkpDxSqfMm4izPN6+rnDfl+XgLwyPHBGcj9OtyWrydNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575289; c=relaxed/simple;
	bh=F8/KqPuTA3STsdOrh0OGo7BppxoWY1fWB0fqUmwksXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+ZeQHgQq2KjU5pQuYfObODCvHaUST/D617c4cY+SyOV2GDUhL9uNkZvKduV77jo0EIER6Rkt6uJx5CFQB0pBFIX6U4GNOUrysi8gYeuJ7u2Kzpcb9mRYYYk4sP/56FdZKILxu5mUeOn/+IKtwbF+t2wozSBBC8CBhsraQrH/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=HCrdbbkA; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-354dfe54738so2415477f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 24 May 2024 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575278; x=1717180078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/tSxq6GA4AT2Mm+nWQe3L0M6c7/C4J7O/BV4BAy6ic=;
        b=HCrdbbkAjz1tSpFIwBraoBEQcqzzGcabQBgTv52KLoBobA2t/QS6RtuOifaiwI5G0J
         5O0jn6BKDJmwgu+XfACyb31fSyKoNSNttHo9e+UkptKYOKE+iQlsELMZLZxGIWyP44o7
         ybQu5ZYseUCLyGyGqnBZ8tFfUnoCpu7Ge1JXYbYiNCjHforIsRtz0sH4YvtpDI1bd/+E
         bk/PsZrvZ+YbBo4AhXwA7I7mYGfG55MxEhLau8u9cbPW3EWCDcIHk+FJDCFvqImozoCt
         bDD2Ep8dFJgT8wz1tv5J69punW6kzhkxd3zu7dYxF65boaHmmecBdTnJdUA8iKxuP19R
         tqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575278; x=1717180078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/tSxq6GA4AT2Mm+nWQe3L0M6c7/C4J7O/BV4BAy6ic=;
        b=FIMY2icrjEDW2eFOwgrBqSvSN0+fZQNnnjWcnhvfO+c93id3Qqzy6gY6dmeU6AxovK
         HEBXIIfIojtRkxz2ulxU0gRC2PEtqYNXCjSOI2asSbysg7CrBwVrxnSFCyu4spITuJjh
         omm6wj1WUCZNAytbNuI7pK07vdtsUgoYCOO5N7brlxAnJsjC1qe8uMljrkRQbF7z140A
         MXt0P8o9xpjX/VMYOiIz3VrknDpLPBReffss64nAV0tvefWfTtMGZbxkI6BiqiD/Y1pE
         M/UT/3Y/Ktjh0xReZYMJ2bE9Ls4wVAj/Vbjvb118kIZ4/OZkXoGyeD0BnFZrahNxTU4J
         /D/w==
X-Forwarded-Encrypted: i=1; AJvYcCX4AmO6+JnaXBlB2mo7hYkMGHK1SrsuqY9o2FzUGiwpHQ8t0llCF/MA1lk06svUwAA6HeYj8fZ0+3R5u3J4CiEgJ2IBP2xmNg7s
X-Gm-Message-State: AOJu0YwmFgDE0juEyPDLUrPtjBsXdtkh1CLAn4DZwgI/c3dmi8tsAhT1
	yorkd+QpCACOymLhL6wUq4BEpsvCXNFOuiRnOmJuSd61v0CzHAUK5QXvaXG9v7wQWXji5A1zvnD
	UyobnhlkEjWMHDaLXJeUHy76aW8OsoPe1
X-Google-Smtp-Source: AGHT+IGz+W6dkdCIXw0ZDp1B/MgrtzNbyRrO8ywWOE/qPAQsbvGxItyKlknvWBy72WuD1SEAMZ/Y6JavBjaB
X-Received: by 2002:a05:6000:4597:b0:354:e775:19fd with SMTP id ffacd0b85a97d-355221819d2mr1987214f8f.26.1716575278649;
        Fri, 24 May 2024 11:27:58 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-3557a1c67f0sm61533f8f.70.2024.05.24.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:58 -0700 (PDT)
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
Subject: [PATCH 13/18] arm: dt: Add dma-ranges to the bcm283x platforms
Date: Fri, 24 May 2024 19:26:57 +0100
Message-Id: <20240524182702.1317935-14-dave.stevenson@raspberrypi.com>
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

In order to use the dma_map_resource for mappings, add the
dma-ranges to the relevant DT files.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi | 12 ++++++++++--
 arch/arm/boot/dts/broadcom/bcm2835.dtsi |  3 ++-
 arch/arm/boot/dts/broadcom/bcm2836.dtsi |  3 ++-
 arch/arm/boot/dts/broadcom/bcm2837.dtsi |  3 ++-
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index d64bf098b697..d6f32d32b456 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -42,7 +42,8 @@ soc {
 			 <0x7c000000  0x0 0xfc000000  0x02000000>,
 			 <0x40000000  0x0 0xff800000  0x00800000>;
 		/* Emulate a contiguous 30-bit address range for DMA */
-		dma-ranges = <0xc0000000  0x0 0x00000000  0x40000000>;
+		dma-ranges = <0xc0000000  0x0 0x00000000  0x40000000>,
+			     <0x7c000000  0x0 0xfc000000  0x03800000>;
 
 		/*
 		 * This node is the provider for the enable-method for
@@ -550,7 +551,14 @@ scb {
 		#size-cells = <1>;
 
 		ranges = <0x0 0x7c000000  0x0 0xfc000000  0x03800000>,
-			 <0x6 0x00000000  0x6 0x00000000  0x40000000>;
+			 <0x0 0x40000000  0x0 0xff800000  0x00800000>,
+			 <0x6 0x00000000  0x6 0x00000000  0x40000000>,
+			 <0x0 0x00000000  0x0 0x00000000  0xfc000000>;
+		dma-ranges = <0x4 0x7c000000  0x0 0xfc000000  0x03800000>,
+			     <0x0 0x00000000  0x0 0x00000000  0x80000000>,
+			     <0x0 0x80000000  0x0 0x80000000  0x80000000>,
+			     <0x1 0x00000000  0x1 0x00000000  0x80000000>,
+			     <0x1 0x80000000  0x1 0x80000000  0x80000000>;
 
 		pcie0: pcie@7d500000 {
 			compatible = "brcm,bcm2711-pcie";
diff --git a/arch/arm/boot/dts/broadcom/bcm2835.dtsi b/arch/arm/boot/dts/broadcom/bcm2835.dtsi
index 15cb331febbb..480e12fd8a17 100644
--- a/arch/arm/boot/dts/broadcom/bcm2835.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2835.dtsi
@@ -35,7 +35,8 @@ cpu@0 {
 
 	soc {
 		ranges = <0x7e000000 0x20000000 0x02000000>;
-		dma-ranges = <0x40000000 0x00000000 0x20000000>;
+		dma-ranges = <0x80000000 0x00000000 0x20000000>,
+			     <0x7e000000 0x20000000 0x02000000>;
 	};
 
 	arm-pmu {
diff --git a/arch/arm/boot/dts/broadcom/bcm2836.dtsi b/arch/arm/boot/dts/broadcom/bcm2836.dtsi
index 783fe624ba68..4ab7769c056a 100644
--- a/arch/arm/boot/dts/broadcom/bcm2836.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2836.dtsi
@@ -8,7 +8,8 @@ / {
 	soc {
 		ranges = <0x7e000000 0x3f000000 0x1000000>,
 			 <0x40000000 0x40000000 0x00001000>;
-		dma-ranges = <0xc0000000 0x00000000 0x3f000000>;
+		dma-ranges = <0xc0000000 0x00000000 0x3f000000>,
+			     <0x7e000000 0x3f000000 0x01000000>;
 
 		local_intc: interrupt-controller@40000000 {
 			compatible = "brcm,bcm2836-l1-intc";
diff --git a/arch/arm/boot/dts/broadcom/bcm2837.dtsi b/arch/arm/boot/dts/broadcom/bcm2837.dtsi
index 84c08b46519d..d034d6a8caad 100644
--- a/arch/arm/boot/dts/broadcom/bcm2837.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2837.dtsi
@@ -7,7 +7,8 @@ / {
 	soc {
 		ranges = <0x7e000000 0x3f000000 0x1000000>,
 			 <0x40000000 0x40000000 0x00001000>;
-		dma-ranges = <0xc0000000 0x00000000 0x3f000000>;
+		dma-ranges = <0xc0000000 0x00000000 0x3f000000>,
+			     <0x7e000000 0x3f000000 0x01000000>;
 
 		local_intc: local_intc@40000000 {
 			compatible = "brcm,bcm2836-l1-intc";
-- 
2.34.1


