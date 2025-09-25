Return-Path: <linux-spi+bounces-10288-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A04B9F168
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 14:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57286323BDF
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244102FCC0F;
	Thu, 25 Sep 2025 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZPk/anXQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE174040
	for <linux-spi@vger.kernel.org>; Thu, 25 Sep 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802156; cv=none; b=dPCuXHy8iOxq6ApO2NUrePat3mEfDmEcPxTkElLpv77k9jtc7fopOsvjhsdnpj4xEhFePD0uz14zFFlUC/Ry2GqCa/uosnA5SRHKpPJu12qFgwYpvtHb6pPNpC6/OUm3wLZ85aWAdMcD8nm1MbCBWKO3IGdUmz6WXH43ZRVj4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802156; c=relaxed/simple;
	bh=xL1Z2r5mm+gHNer5hMSCPiJPMqVtkr/dKj1QXGEcpMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzrFFWYVMiLNDCER+KHQPgf3Fyp0sjYuADjjRYLRi2ynU2/gOvQEu6zJRost4a5m142bSZ+uJh6rsNVwUSYBPSFbg0/zODiSzYgAl7BnyTK1ON9WXPJlWtQerGtOwvb0fon+ACbQwXWpdMyWAkpYVwWZWPRqmM01gM9lo82PM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZPk/anXQ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88776dcac7aso39811239f.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Sep 2025 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758802154; x=1759406954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHsvn6JN9lNBPv+vuOCqB081gUg4QWTUGs8Fvt4xcvY=;
        b=ZPk/anXQWAO2Q9mjH2A+7rQ9d+6wDCOtNJoW+jC7OW5sRA2Epqzo9x/nLd1yWafNqp
         +ABLK/I93hsLJfWiLXzCcFWA7Jr3lItEf9J1EYzyz1G53zHHSLYOM9KDSUvTE+4KXXIy
         Mh7rbGRitPvxezhsBFL9tmaQiH8pMiwoW1DedJ13nhrOiw4E9MnBUxFtVHkfLDSIRt+I
         2Lxcuf2LNOI2Xe2xHeledj6kAKIWx1LcUZBDCmA13mlWjvsz7bRY0R+IQNF/M13Jz+AK
         YS7XCfwbMaIbyrvrROECZvixrAxdK99e3heQVjZ8QoBgSSZsTMlHNQRpdPayfMUFqcXl
         lfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802154; x=1759406954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHsvn6JN9lNBPv+vuOCqB081gUg4QWTUGs8Fvt4xcvY=;
        b=UdqihPIVTWQgUTXEHJ/lTUeTV0xwqvgOHdlWgoGAIFxmEmVSiBLkkgTp/RTt/I55Y+
         IQdaR7OJgkB1tudmX3h9JQ62HFGzBrkug0En6Jd/fRjNIAvqbIRYCmpipuyPDZyEyLTJ
         YLn8FfIQk0LqLIF5pJYUnvxk+FimvckQbW4+4v/ziZFMPpJJ8DNyiV87uZbGK4m2cZbx
         zQjx6guqbtnC+sw01QL4iBoUBS6f4B9g7hnAqofnJlYkKHPSBkAQnIRGS4tpzBeNZQC1
         gKcQvtnVWL5C2Dg55DSNJ5tg9Gi1aXvYl/P9xfskaIJ6RSG++8hfde0+81xRaaT9gUn0
         fRMg==
X-Forwarded-Encrypted: i=1; AJvYcCUFB1okAVb5XUvV6BsjvSbaWAjqrnDn8k6C50qZ8LLpVNxitUnBCAdsVuxPwNWmCB6g+F8BbN9UsM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0B653f38Q7sp7WWlkkSz/Ff30vUWhh7onZqemUJQZVGLH4/V
	LA1N5Jk838bur+tfJLgBJmORik/lJVioYqwr6cRuFt8wWyKg5LazyD///lpetODnnWE=
X-Gm-Gg: ASbGncsaCkIC0QBENFPoE/wPW3H2EDDgDbYlpOtgHPh/KKuTmxqbRsmyU3JiFqfDHdk
	5Llv9AkD+XxL7buLtlZQhzGyPGNj1E+dfQVIQsluc/qJq60XR3b87sYNyqTVht8stfHroKm+qJg
	bQhDl3ApjVgePAUNCmL8Ap8EgyAiRYxlM6pherrBZzbSMql4D+KtXhWZ8DCC4bo8XZ0DojvM+8b
	QixV7T67YyuTyB1PDO7SLs75X059iEtRuI6seVRdAg7z7kjHmL+TGiQEuJnZWA4a4SY3d9RjWep
	pXEM1+CYAg5m+9zDRbxuM2pHjAcCH+iaq6wE7eInphvD6q64wwP7sg12jsd9Eac5DffqoZXHaeC
	c6yd8AEPlNBJTu/+H5lU/gR6sGaIEXYS8C6FKEfD5t/SdB3hyaEPZnsXwe79tMmOGgA==
X-Google-Smtp-Source: AGHT+IEBJ+drkM79LMDTsVqVSkGDzcPRYyPT9NtjqS/rk0F605YLf1DTbe9+DpHbYdMz9/5APp0ejw==
X-Received: by 2002:a92:2802:0:b0:3f2:b471:e617 with SMTP id e9e14a558f8ab-4259563e04fmr37344175ab.25.1758802154131;
        Thu, 25 Sep 2025 05:09:14 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6a5b29c1sm742821173.62.2025.09.25.05.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:09:13 -0700 (PDT)
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
Date: Thu, 25 Sep 2025 07:09:05 -0500
Message-ID: <20250925120909.2514847-1-elder@riscstar.com>
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


