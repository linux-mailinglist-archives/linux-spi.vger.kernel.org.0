Return-Path: <linux-spi+bounces-10292-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBBB9F36E
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 14:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9445E09A9
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4962FD1A7;
	Thu, 25 Sep 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Ggt+hbDe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98E2FD1B8
	for <linux-spi@vger.kernel.org>; Thu, 25 Sep 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802642; cv=none; b=aPvZZbhl/6xX8QUCc3Msy3RN7qysJpfQhbJukuq+zN1ghchDw7m8UZQcSCup6qv5o4ELFk0Qp7lVe9sIcq9iC9kLJkk879wmO+f/oOVcKnUzHS3UR/P/NMauYur3iRoYaUeOB2L/e+qvVek13fANIWqb7tZ70NgdhUZ5HJcYSdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802642; c=relaxed/simple;
	bh=xL1Z2r5mm+gHNer5hMSCPiJPMqVtkr/dKj1QXGEcpMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chutLhHC5E6bYjeV+spqnW8dGpavI5ziGbPoTCQbO78JNTSHwhM/kgW4EuhYnzTbL24EFj0+AZgTNW48lfYh1fLwpTWU62qFNvd4i2He7pOjUbsYOlVLIB1XwtM/5dM2aR1IvxfKBc3jkX3zPGFKYZJRtDARVZ/AXTGkiypyc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Ggt+hbDe; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-893630dba34so43012639f.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Sep 2025 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758802640; x=1759407440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHsvn6JN9lNBPv+vuOCqB081gUg4QWTUGs8Fvt4xcvY=;
        b=Ggt+hbDeaCxF4F8g6l+R4d/J4b3ARa8GBTNkj72WiJpSAGnzP8T9Tvso+cZU+84V8G
         C54YVJ7yrd+leshZi5oRUfL4hXhRmbAbJjEuwvNrorPg0lmAf37SeDmgQVCKtL7Y3ztd
         DJA1eL7C74BhJPyRdCq+biGWHTe/znF/IliKlFWQQIhnHQ0fXZku/uu9salhQafQXGN2
         W2csnd0aBC0O1hsZOj+Fapp7tiiTEmW1Nrm3Gt1ybvU+lvWeCcpD24efNSkV0omjl14l
         tEKNo0fU6pxGfsKaBxH6uwaDvJ4Ej+QV8SXK5NLRkag/NoNL2rVqGREUPlK6szrwxjtL
         xpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802640; x=1759407440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHsvn6JN9lNBPv+vuOCqB081gUg4QWTUGs8Fvt4xcvY=;
        b=lRLiSRr8CctrHNlnJzAzk7UtJ93bIiqJ6yaGDcQ4WOsr3ZFyFirdPuKx8Ic0Hsfigi
         gWeBb/QOreYlq6YRDVGMno/q1uzL6a5OoXZzJyFrZ6QQeD3oeF/GvxbsZQVLnW6NkIvx
         JJk4qBMyT+KowrWQR/AmGJ7jG7FwxuYzvE6leZE5qTShuvfx5Hkr3PCdxmWjhG+N4hl6
         erVnKRjSRDfkuhA11AZz5vmxkErmfmOAPwZEyx3J49IIIFjs56EI0xj6RUHBN5lQdaeu
         eaHQ6bcOS7/SlKKrpMPJOVbda8lqmLkxztogXIN+nJe0aunaaozoFJwSREdL6ew1+mPm
         TN9g==
X-Forwarded-Encrypted: i=1; AJvYcCXyz94gj66b7QQIbpZLh8OFx87hwygdM80althdxR2JhsTQqnNPfkPjqrydXtvb+XKsifLFyuhfPGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+c99Yq69DNipD7a1WMMH81M8bH51iDBEWx1gRvAp1LLRcajK
	dEpcq3oE57mvSf5q+5doL7w5ObG2YEnOOeFSkbesLS+TCD2m3B/KmF39EXWI5/mha5A=
X-Gm-Gg: ASbGncuwp8WXXLMKuYhmoL91PBXonKwRRSe2grWIwIUzSfSdYVLIS6DnA5EA4oTX244
	PJd8kjalZoa2PiQginUc1SFQ0/fxOcgErGmjNRgFLq3gsuLKCCTA1QrhgK6aqAGtV0GXrD5uDp0
	dzpWkGW/6YpeVAH6mF2cYFF6e/fc18PKKLIKC+evKFQytFh+ubo1MqFo5dzmumDYZ/KHCBPSg05
	CbZearcrVvjOrdAgAzGi9w2eM9FJb+FHRnMokilLkJDIN3XpxeOvrouzDsJ5no9i4sHvW2Ed6sn
	s8eql6ud03PBF1QrwJnVY6t3mdx44P1mmhOza4DOuWnazE5QZpKzElL2Ga5KXGBoaVduBukys1I
	XfxPiVIfzAfEWwwY5Js1oiE4ycSJPxqkwH6kcAE6ntzgYzYCgpeWRiAjcwORuxBcoIg==
X-Google-Smtp-Source: AGHT+IFItDx0CgAF9/fDAUUs6ylh3g4EswI9rpEOCYIuQ62NnMT5cMivYNjp0gufj/IrIj6FyCAjzQ==
X-Received: by 2002:a05:6602:6d01:b0:887:690b:2594 with SMTP id ca18e2360f4ac-90375bc2ccamr342646339f.5.1758802639509;
        Thu, 25 Sep 2025 05:17:19 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9040c57fa59sm66918439f.16.2025.09.25.05.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:17:18 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
	junhui.liu@pigmoral.tech,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] spi: support the SpacemiT K1 SPI controller
Date: Thu, 25 Sep 2025 07:17:10 -0500
Message-ID: <20250925121714.2514932-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the SPI controller found in the SpacemiT
K1 SoC.  The driver currently supports only master mode.  The controller
has two 32-entry FIFOs and supports PIO and DMA for transfers.

Version 4 incorporates changes suggested during review of v3.

                                        -Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/spi-v4

Between version 3 and version 4 (all suggested by Yixun):
  - Fixed an underrun/overrun comment error
  - Renamed a pinctrl node
  - Formatted dmas and dma-names properties on one line

Here is version 3 of this series:
  https://lore.kernel.org/lkml/20250922161717.1590690-1-elder@riscstar.com/

Between version 2 and version 3:
  - Add Conor's Acked-by to patch 1
  - Add Rob's Reviewed-by to patch 1
  - Added imply_PDMA to the SPI_SPACEMIT_K1 Kconfig option
  - Fixed a bug pointed out by Vivian (and Troy) in word-sized reads
  - Added a comment stating we use 1, 2, or 4 bytes per word
  - Cleaned up DMA channels properly in case of failure setting up
  - No longer use devm_*() for allocating DMA channels or buffer
  - Moved the SPI controller into the dma-bus memory region

Here is version 2 of this series:
  https://lore.kernel.org/lkml/20250919155914.935608-1-elder@riscstar.com/

Between version 1 and version 2:
  - Use enum rather than const for the binding compatible string
  - Omit the label and status property in the binding example
  - The spi-spacemit-k1.o make target is now added in sorted order
  - The SPI_SPACEMIT_K1 config option is added in sorted order
  - The SPI_SPACEMIT_K1 config does *not* depend on MMP_PDMA,
    however MMP_PDMA is checked at runtime, and if not enabled,
    DMA will not be used
  - Read/modify/writes of registers no longer use an additional
    "virt" variable to hold the address accessed
  - The k1_spi_driver_data->ioaddr field has been renamed base
  - The DMA address for the base address is maintained, rather than
    saving the DMA address of the data register
  - The spi-max-frequency property value is now bounds checked
  - A local variable is now initialized to 0 in k1_spi_write_word()
  - The driver name is now "k1-spi"
  - DT aliases are used rather than spacemit,k1-ssp-id for bus number
  - The order of two pin control properties was changed as requested
  - Clock names and DMA names are now on one line in the "k1.dtsi"
  - The interrupts property is used rather than interrupts-extended
  - The order of two pin control properties was changed as requested
  - Clock names and DMA names are now on one line in the "k1.dtsi"
  - The interrupts property is used rather than interrupts-extended

Here is version 1 of this series:
  https://lore.kernel.org/lkml/20250917220724.288127-1-elder@riscstar.com/

Alex Elder (3):
  dt-bindings: spi: add SpacemiT K1 SPI support
  spi: spacemit: introduce SpacemiT K1 SPI controller driver
  riscv: dts: spacemit: define a SPI controller node

 .../bindings/spi/spacemit,k1-spi.yaml         |  84 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |   7 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  15 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spacemit-k1.c                 | 965 ++++++++++++++++++
 7 files changed, 1101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c


base-commit: b5a4da2c459f79a2c87c867398f1c0c315779781
-- 
2.48.1


