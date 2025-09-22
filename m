Return-Path: <linux-spi+bounces-10214-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C20B922CD
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1AD190338F
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A813112C3;
	Mon, 22 Sep 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="a6zfVrgK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563C3112C0
	for <linux-spi@vger.kernel.org>; Mon, 22 Sep 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557845; cv=none; b=CJymCu0a3almENVv3wYIig6hP7MIv4O/D1PKJ4aGT8I69wIOgVw/Iy4VrwMf297boJQbufjC+Frhi+Zo/B+pvntZnGeVdYTRFa9B2HhOSbWhC/EZXR7X2snK85cHKVAjBsBULr3nBP6ScLRdNOzvuF6fYzedbOAQuBb0JL3YZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557845; c=relaxed/simple;
	bh=7vVewiqA0e2iwP/eAxuh7WA4OQg2jToWd9kLbbhtNC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Artqcw6LCC8RgIL2uq4T0UGQPOiSo0RkwEhWytfs2lnD1Fo2F8zt3VwXUaZqVGEk1v6wYmOuPh7YaJo09ZIgQskcX4D4FPpfL01IHAwJqFoPorIZ+s2kCpbSEqcUccmcGNZqwBcLMM9Hsfxb9tzDt54tTCbzKCpNlaih35NvSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=a6zfVrgK; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42480cb42e9so18962485ab.0
        for <linux-spi@vger.kernel.org>; Mon, 22 Sep 2025 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758557842; x=1759162642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VY+UeuZTbe4DuOfkxt1V9gHqp7+wtqNRHgcn1ay/Mt0=;
        b=a6zfVrgK3lKpIMkoZA5S7FL67Q2pkzemmCSD/Il3RTfiF+DFVxODWzI00tJxJL0X5c
         9Uowix6h6tY5K3kNiwZp8DREyhMmAym8V35HZkNdzoKhb0YytuHJ1qnzdmZKB6X3MGdL
         puCcY/YemMVh8cxJSXZG/KR6ttWawENE+j2gT31PCT4y3CBgSsH7xu8XSGnsXSpVprfo
         JDscoGTR7pudfNn2sP2xSEgVc48ZvmGcvVA1HJ1iEAge6XxXez4nNywrnOi9/sxJ0TGA
         iW46kKy+gW0OCDi12xq+AkeWDV+a+ikNCwGHd4wLNR2yuEywblRwfjkHKgjhcfXn3iGa
         RtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557842; x=1759162642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY+UeuZTbe4DuOfkxt1V9gHqp7+wtqNRHgcn1ay/Mt0=;
        b=uX7nWUdOXHtfqQhS5e7T8Laq7xxOStojgzfNUDkEBAfwIveztQbfhuBjeLFKAQcoh3
         VeMFeiQRsvE63zf91kYWkZl4QyzZxXRDgTYGA+d5IIkh2dANTs8ZJKwWwIsPQAv4xO29
         w4o9wl9XZGv6Fyze6LG50cBhO+QlCOd+BMXk3RXGRQASwOnr/ydNJdIYn670KnVk2K8O
         1LxE9DXnQWLNGLfLlkB2od+wXP/S9a7vwRsLs5L6DLx1LV6lrWFMO2pdl2h8RTHOo6lG
         XLGoT2b4D2UU6IK9FA6Z+Rrciwkcfou5CaoZRvcR3LMTmiw8XtlfVT7jCU5fooPq6Zdn
         NRzw==
X-Forwarded-Encrypted: i=1; AJvYcCUaMG9IHeUDcD7t7LX94OIdzbqKkyxUtXKVwmDiRfw2TzTroR4g52mnHjNV7mpe12sqN4B3sHBoAyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKs8+K8q6MBDfSf1RDLYP0H475vHn2SSV9e76wFG1geHdoYaDa
	n702Z9EBgV+BOZuKytCnOj1lD5EENRsKQsKEoe6rGeUbzFJzEg1+DdA/xdjdGWYOkDo=
X-Gm-Gg: ASbGncsWBFgYd50lEZ1Bxe8MQJUMyXJnVtNDtl1AI9nn6+n3JL0MKc5SLY2u2LAnJ75
	bMPBMB2ruRUbLKIYLWXdHdYYVjrku6uIc5m4j3Z4OrztwWyuQFMk95G09mMgeUTfpPaMcxduQG4
	vIIixIvJFzOfkpeAtGiVdiwbDPBvx13NPsvZ253/qfcgw1bYi5yc8MIXUvUN3YTysaf/qqf6DZV
	N+6kDzzkTy5ujZZRz6D+6nZw36XQQ5GQ9zKw27hVlDorGpQwHFMjA4DOuYQipmcb7riDb8iQduy
	GV3Sr1TNDDt/Qgc9XcpdZbs3pzrEiccr1tVeJBJycLaHce8lgr6seGvEIDNR463ZZm2bTlRIlmS
	fxTFVAo7aJ1xWZnr1+6pOmafEsyYhxvEkfHNzdWarWkkaFzupxl5+qvObL4JMai5ysA==
X-Google-Smtp-Source: AGHT+IGacLGMErLcsONCaQ7tVN/QLr7qDvYuMf/IioCcbyv5ZtFG8CwlnJVAkhCLzpWTG1DzdwCTxg==
X-Received: by 2002:a05:6e02:1a8d:b0:3f2:a7ef:bd88 with SMTP id e9e14a558f8ab-42481911aadmr188245465ab.5.1758557842154;
        Mon, 22 Sep 2025 09:17:22 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425711d9aa0sm25207185ab.48.2025.09.22.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:17:21 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
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
Subject: [PATCH v3 0/3] spi: support the SpacemiT K1 SPI controller
Date: Mon, 22 Sep 2025 11:17:13 -0500
Message-ID: <20250922161717.1590690-1-elder@riscstar.com>
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

Version 3 incorporates changes suggested during review of v2.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/spi-v3

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

 .../bindings/spi/spacemit,k1-spi.yaml         |  87 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |   7 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  16 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spacemit-k1.c                 | 968 ++++++++++++++++++
 7 files changed, 1107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c


base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
-- 
2.48.1


Alex Elder (3):
  dt-bindings: spi: add SpacemiT K1 SPI support
  spi: spacemit: introduce SpacemiT K1 SPI controller driver
  riscv: dts: spacemit: define a SPI controller node

 .../bindings/spi/spacemit,k1-spi.yaml         |  87 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |   7 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  16 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spacemit-k1.c                 | 965 ++++++++++++++++++
 7 files changed, 1105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c


base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
-- 
2.48.1


