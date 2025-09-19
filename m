Return-Path: <linux-spi+bounces-10165-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787A4B8A774
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169531C87E8A
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC4031E891;
	Fri, 19 Sep 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="OzzEXMb8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639A31E0ED
	for <linux-spi@vger.kernel.org>; Fri, 19 Sep 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297561; cv=none; b=o3Ah8jvefcsTXLh9J3SxWlZNi37KJ/tt4b0iwZIC1vBu31OZBzXXZxm44oXSKfPSF7qRvyxe/hv8xwANklSh3vWId9/0wNqyePG/eoQtXXPj14Qceurlq0W2A/vQu9TplyYzdYThSkZc7PnGpYTA9gg6iASQVgZxLUvqWjJapt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297561; c=relaxed/simple;
	bh=e6z+FuB07lTrzgCpwwNvKm6kawfyWQVO1KrgqPQyPRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkY2Q1c41v0qQFb2vPX0K9WbxatDwlcOpJAyqP6PWD99VRFeC96/WZWpWE8h0NbgXQOindm0xss0I+LD3EwYmkSOLx+RXApnt4HMjrnC8oIoV+AZe+iMny/rPc8mWdVRaIacMbY8m9ONi9zwX5PcxOTrEZcwY4TcB2H0rOVTwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=OzzEXMb8; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-424197bd073so15890875ab.1
        for <linux-spi@vger.kernel.org>; Fri, 19 Sep 2025 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758297558; x=1758902358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PieohXBDde9aJoeZPffJCOlv0SEwDrquFxpLVqeOn8w=;
        b=OzzEXMb8iNidjAQ+Q1UitYIq2nxiOkbL1kRhIMg9lv1mtiRnQidlYhI+HI01GL6XsS
         EU3y7TxNlSH+MYcQekmlB9SqLWtdP30opbXtyeh3nAb7b1QYPkGNhWPe5QIsbMWzNPed
         wjppShPK7hbqtC4LpoVu1LOb/Q/5uaIXQ+85p7pO+lJD5E3DjZO7k+LOVPzrRkE5YzHN
         PiYD10sThJ5GpTdpM2L4AtaCobexHPUR+fTU1UFXzVm+skc4U2YJBXsKtgMWcKrB7GfB
         EZQ+iyVQgKfConJO3WgTdBv2e+t76+e3pGVbNiUTVUnSgaP8NOHYlwRotMSrn9hNXHZI
         YKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297558; x=1758902358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PieohXBDde9aJoeZPffJCOlv0SEwDrquFxpLVqeOn8w=;
        b=ku8PB17FHYdw7e9UKtyqJbNv1QTDNJDFV+ZJ/7PNFcsziY4mSfjil9sHYiMHyFJwP/
         OdvECXBUBQ5PGjIkcEZbzZ238XhFazQ591KedgdZYntrk6bqcKJ3lx6R2RH5zFapgyre
         39bljnyluVTj9wF1pb6qLQpeAKZYidBji+q2nRmQDlF4MiqitfRJu/gwy2qcDkR2qG1w
         xDbUTAIz+I9vR/70bgbU8DufMIh0jZy3q+HS03GrU5kfdf3cnZbz14Ycovt3Zc5PQHUW
         vBWRIwcVqAu4p93hW036S4B8BNANur0sp2bOJgy8E223xMUA6q8c7nk4Skvu/WF+AekQ
         femw==
X-Forwarded-Encrypted: i=1; AJvYcCUnyS+4V4ZWqxmYc4ZAjV0ywycqXU4jqgOr/1JdLDqu3PDr/DseMroAlRAUZLTieseGbaP8gH+dyA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjplSekFCqG9IrZc4k+KLsoajQRAEqKrjpsL4kIQgL9eCOzH6
	9M7xk7TTu5JTajPuo9zSL/1JkpsE27SSmWwrq3oPHMM1IQfr5UKkwVXit4a9qz44uNY=
X-Gm-Gg: ASbGncsRseR/tzbrxngGQ+7kxc0ivmb9wOdNSu3/RPAahBhSUFf2wApcbzJ7wIiIUu1
	2esXMyuPcYtnMW+2vKQ0BxQ+nXzKJkdhGp9Ss2ff1ODOELh1537krrPaXgW0ub2JKmsR+baodPI
	V8br5+xZTPXtrBgYcHOwAXotTT2jLPOv3x+OEVV69HCDXrztqXVsd3Te/s3XGFs9gh1LkTjbgPn
	EA3qiA5z47DQRqgQ+1kx2UHz3H6to11FHaqRcGZaq5LrdSJpYDISm99VyeM/u+RavFaxu35K4ZE
	8L5Sf81M+rCJvjxkJ0EJYCe3SPWUTfVAuCahdwUEbY6xrE6PpV/K5xeVkwZMW+UPdahGdaf3/PT
	T0LwREZTTuj+SLCIwAKDHt1Bn768e1h47iJi02HvX6h5RHWz+GsQ2ZjmHkjsTzTgTKw==
X-Google-Smtp-Source: AGHT+IEjqrlSFIoeKxmjUweDtrCLwaQpAtyQ3arbMa+ZmRjzpi9BoH5PVFn/nUo5LPbXaE/8/YT8KA==
X-Received: by 2002:a92:c5b2:0:b0:411:6759:bfad with SMTP id e9e14a558f8ab-42441af5df5mr105138315ab.10.1758297558106;
        Fri, 19 Sep 2025 08:59:18 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa460bsm2250898173.52.2025.09.19.08.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:59:17 -0700 (PDT)
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
Subject: [PATCH v2 0/3] spi: support the SpacemiT K1 SPI controller
Date: Fri, 19 Sep 2025 10:59:10 -0500
Message-ID: <20250919155914.935608-1-elder@riscstar.com>
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

Version 2 incorporates changes suggested during review of v1.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/spi-v2

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


