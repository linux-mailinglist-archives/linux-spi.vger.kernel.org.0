Return-Path: <linux-spi+bounces-10848-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB4C0DCBA
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A6E64FD7AE
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2E24503C;
	Mon, 27 Oct 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZvqER0x0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F3244668
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569712; cv=none; b=qRfJC9gNgK/P7Gg/Pz6zqOiY8p0RHVjNkhGci1GUbpADL7UCVA5Odih2HxGnjD9DHVaal41UXBLAtl0GczkvKSmOnmvIK8aojNjKsBhAAra8F8iZZ6FLlk5ql1cSnrvl5t7mapc1PeywSLmqncAtASxrOgXDcRzb8mZtSpLQ8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569712; c=relaxed/simple;
	bh=Y1P+Ko6EypVqbiO04L0KXvr1REByV8AEUux9zAD3i0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQyN0l/6wSnosRpvg/DClTG6V47ZlRNK/Q7wEOjIyeDga47Ppu/g4Ljulb0YFWxUjfG4r6JtwM/bH9EOeyorbz6lOXqsyGFpoJx5pcqp8zrpcBTL1EjEs2h+Po14yjuvo+vKDYKgRz9LeEK0NYs3UBeX8+MzcIid0b7IRrQG4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZvqER0x0; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-9379a062ca8so189484039f.2
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761569709; x=1762174509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nAF82uQdqoZ+b3y8tjZiPVkCVKQg6rD1LcHeZvN9hk=;
        b=ZvqER0x097OGPM9gQejW4oG4u0baRK2jM+AZOW6u7qGKku4U63SMkcVKZ+Q9y/946m
         GpPCrvhw96mASkQpftNQYTsrmxpF7Agbez83rZhEJOU6qwEHQiLkfRQf++mG0EeNaq1M
         vdaX5daqywna3CU+4W3n3bWha7WVp51oGWJCjsilQ3dhQD1PxcoAsp5kelW7/XjIcqJ3
         3PJFgHrRv8m59H1Vt/Ay4KGLT5hYuZ7txhqnf7x90S0ce992X6cscrJPbTkAElvAh2gb
         fvgt+sqxqu3aMVViXfSnY3IZ4KsJtaraon57gx/mr3560lUZaSrrA/uSWaX4oHkd0AEn
         p5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569709; x=1762174509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nAF82uQdqoZ+b3y8tjZiPVkCVKQg6rD1LcHeZvN9hk=;
        b=hT4N5RtfldfY6LQFTcl5HwLeIJGn4WAEBbXxCQ929h1qazVHc0R8QNAce58d7QOAV3
         k14s59KOJQcSDgqzZZQvtuK/SobMND8UScAGxpCNv/1EcucxxHHQxWT8kHxPch94RjO8
         /V6ur/wjh0RidHBnw5u335UQLkiFTdxsLapc2V0KEmfGkyQt1h60RjecuRHOgn/GAaZ5
         wUzJLqAAPkPqowM3p7qyImS8q9zgCJMVD4PfO+A+vrKKtAucIQbrrxs0u0xXFhG+9mVb
         A8ehc0VhHiHS2Y044S1kxPX8Iy3TXMlaYcwHfwjzqrwGuCVRndX56oJ6k1QzgyG2nN6L
         GV7A==
X-Forwarded-Encrypted: i=1; AJvYcCU5fhIGaggxrDw7bBw4kQQIJMnDDVb9+Q1ycCVFeC4719jKUGtd/CnKwJfC2+8FX0wdqimBDc/Bu1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXD+fRX4N3mH3LYArlR3FR+n7PiidpkvBc9DqbDpFw4xSXn/l8
	MVLhqBs29Nd65tXGixB5pYv+I/IbldSsh03HNjw35eulSWVokw6cDcmT0DFFmXoQqtA=
X-Gm-Gg: ASbGncu5ykOXcqzaMwbf3DcUlHT7+GUbm1Yjw8sZnKVXIahbjmgVvi8y3eQzMXiCkr0
	YZz/C5a6VVsdcPd3gtdP6zZDNUyhP5r/Qi2M02DewpDFUUAaq37Ag4IG9mX//HF9dnIg9Dislx+
	cOaSh9ed2zIXTTD83aqeJfVFrOaCpE7hNlMkVJ7z5oqNTKYCNH5r4gPVyQT2H930r84vqI2p/HH
	oa7yjKiALO1lcp/1W6WI4MLRrMDaLEbc96e539/q0TZrueXKP0Ad3BEbigQ7M6LZffQ0C9hWueb
	ov7OcVQ7ndO0RYZl6v1ct1OHGsc3vQ+5Cf/RVEz7wrgbyISw+oarG3O/2mFzOCvgrMYtY4HM4M2
	h3dfSWaFo61eGVM4bm8AC/8ZQOUOrPOo0B62whA8ctCriEeiET8BxefiSo/LApWCVs56hhWkwjT
	/apzODQkEVCrlHGOQXnYb7d4/+I13DoQjewWcgURchCjpWPlEIzD2Lhw==
X-Google-Smtp-Source: AGHT+IF9dogLPfu3KKBrg4aJADxwDW+rw89Jp80NmbsD4vytQNTH3nxBh7Ne+iAACQ+ZbrAmLBB0QQ==
X-Received: by 2002:a05:6602:29d2:b0:93e:871f:b060 with SMTP id ca18e2360f4ac-93e871fb6b2mr5001344339f.15.1761569709430;
        Mon, 27 Oct 2025 05:55:09 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359e742efsm249121639f.7.2025.10.27.05.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:55:08 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	dlan@gentoo.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] spi: support the SpacemiT K1 SPI controller
Date: Mon, 27 Oct 2025 07:55:00 -0500
Message-ID: <20251027125504.297033-1-elder@riscstar.com>
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

Version 6 is identical to version 5, other than being rebased onto
a current linux-next/master.

                                        -Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/spi-v6

Between version 5 and version 6:
  - Rebase only

Here is version 5 of this series:
  https://lore.kernel.org/lkml/20251013123309.2252042-1-elder@riscstar.com/

Between version 4 and version 5:
  - Added Yixun's Reviewed-by tag on patch 3

Here is version 4 of this series:
  https://lore.kernel.org/lkml/20250925121714.2514932-1-elder@riscstar.com/

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
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  15 +-
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  15 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spacemit-k1.c                 | 965 ++++++++++++++++++
 7 files changed, 1105 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c


base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
-- 
2.48.1


