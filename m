Return-Path: <linux-spi+bounces-10851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D8FC0E0EF
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014744F89F4
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93E1E412A;
	Mon, 27 Oct 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="UXOa9zl7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB001DB127
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571817; cv=none; b=I/LR4Cp/dzgYuYSXBW0vdjhoih4XeoCEo0LpBIyii7ppUV17TVp/dgLiEnoXebOaxvHap5Yh3hxOg+3Vy5zWJddjmLsJ2AjI79sZKAbKyVPjbGOCflRY3Zj78LQH1phAukx3JP8B3PRNlc1qEmWuv8yaA/I1a5FaWf1E25XGxqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571817; c=relaxed/simple;
	bh=owwF/c1ZnVCPR3jIiSSB/1idNxMdC9jtjVdIBYaeNLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQ7rD73HmxgdCd0Fy+aC8pOdsAGLiyl/cNtmDov+No8K5NKEx3JLvP4adzclSOX3uzLgDbaohUEDRtwSGvxzdQvbu+spNIxgB47lZ7OoOk1CzpxhwVCntJ1HGklLSh8c0LX7/jiyLfjr/UaUE2vt7+LcYTLQ64p5YTb8DsbMZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=UXOa9zl7; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-430aeaffeaeso19392245ab.3
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571813; x=1762176613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJjnQ8pdDtk39CSCRJz3s2YRDUVOeo1DO713ElfxvCI=;
        b=UXOa9zl7kmPLTQRHsyGrXNDHB6TN1EFakWy7s2sYohzNmhqJBSedda82G5wJ0KsX76
         RQdx6yqG/TvLmvHt9G1MpdmNN8qTWLh84tyEtfz1eGmb3LovFo1qRfhHbCb37lKbEK9k
         SntjcXa+tZqzHkmU8P/7wPMFF6ekShq8IoGJl3UDKD5i7+hp7bVOJZv0bsgPQWHL2710
         ueodzFrgh2rKFfXLOwPDDvC1tK6jRqShpi5jphA+qmRx8xMGqrpS9YNGTSBhgogKj36G
         0mvKlWLZdrqdff306iOGo1Jg5qnstlcta1Dx2GeOZ93s4k/N0v90UNIyRW3Kc3o1EzsI
         ew8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571813; x=1762176613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJjnQ8pdDtk39CSCRJz3s2YRDUVOeo1DO713ElfxvCI=;
        b=aiywU4GlpMARFZjTbiDEUuJzgQFYIMUGiG7luvNZg3+fvetKedpv2t4Jr0EWe3iNfo
         wYKjTRanVD6x214m2OSH+pXEhS3G+3Hmlc3jxnnr8TkTkiDCeemSWMsVKkf68LdPN4q1
         xlUYqnt5uThy/s8GxvJQrKl7m4DiXMT0gAGHl/7KWWeCGQ1rtVcrIQ695TDFr/HIEX2N
         jLSHRT3Y521RK0HCraixyxUlB6ajvukZAepbQfOm8qAv9UtIfuaUB9YqC9Cyf4hKUL1O
         w7jTU2tIDR8ZBR2jEyqhqMxduBaodcJFfJwJJqflyosYAtIsh79Vqnxxlyl4ADPsp+Ga
         /Kcw==
X-Forwarded-Encrypted: i=1; AJvYcCVw62psB4zSrUx6Jj6yW19nprXDfzbLeu2aCSDwg27MrQqoj+4VPOj8G06yrZiT0TmIjbnvZ10QyG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2p59OhLOVandThQAbO+r4eiGTClHr2vmf5PE2cfnQGVkLgdqg
	wpIv8SZnxb8Egj+Wd3Kontx6N0dXsg76BhZyKt5nzO7i4agIasvYc6BlYHHEtdyzUsg=
X-Gm-Gg: ASbGncupiOJuGJxUSKH4K9vgWOa9mebWMoAn79BvOStF07vF45pjkCMRKlBOHq67EkQ
	W9JcLtt14rOrgaQ9d0tXg8HCp6s1dSZh3eLM3zRtCNi6DZ3V/z5j6t9F5pjQoi9dx/F1USWWMX/
	L6l+SHKbGkPTVWLf1F+DNEOdmfmy/Zeqr+bpaSn4h2hisPMsrUCNhZLPIt0vMryFfeprhE0X0rk
	mayonX7vM0KsrW+Em2m5bPIwPjRA6hpwvjzD9aLMrdFD/u+8DWRYBsFkhRw1OiTEYcbacnMgYGP
	AB5stre7WxvEyhveDrlD+wfEPpAaHF9RudWx72UOdA2+l47WrWFxeCtNjExsmiAYNzzor4EQ2qr
	pqqqEKdgow2T+nTarQMdHULu6s21j+6/1c1/Tj5IFsS9BP8A9y3Dgkx0Z4n/lu4u7KMBcnAhg+n
	CYzlEVGnn/TCoxK+LCgSagWwW0HbvijWgXSDjR+fHdLNM=
X-Google-Smtp-Source: AGHT+IFP3NJHkfNDLkwaf4zEjacSbOyB2CKC3rVjLUaScafS/uUg5QntItE3fUUUdGBa9LYYuVS1mQ==
X-Received: by 2002:a92:cd8c:0:b0:431:d951:ab97 with SMTP id e9e14a558f8ab-4320f77104dmr1324625ab.15.1761571813243;
        Mon, 27 Oct 2025 06:30:13 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:12 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org,
	dlan@gentoo.org,
	pjw@kernel.org
Cc: Frank.li@nxp.com,
	p.zabel@pengutronix.de,
	guodong@riscstar.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	apatel@ventanamicro.com,
	joel@jms.id.au,
	geert+renesas@glider.be,
	cyy@cyyself.name,
	heylenay@4d2.org,
	conor.dooley@microchip.com,
	fustini@kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] spi: enable the SpacemiT K1 SoC QSPI
Date: Mon, 27 Oct 2025 08:29:58 -0500
Message-ID: <20251027133008.360237-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the SpacemiT K1 SoC QSPI.  This IP is
generally compatible with the Freescale QSPI driver, requiring three
minor changes to enable it to be supported.  The changes are:
  - Adding support for optional resets
  - Having the clock *not* be disabled when changing its rate
  - Allowing the size of storage blocks written to flash chips
    to be set to something different from the AHB buffer size

This version of the series mainly adds sign-offs provided for v3.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/qspi-v4
  
Version 4 incorporates comments recieved during review of v3:
  - Moved the allOf block below the required section in patch 2
  - Added Frank Li's Reviewed-by on patch 2, 4, and 5
  - Added Paul Walmsley's Acked-by on patch 9

Here is version 3:
  https://lore.kernel.org/lkml/20251024191550.194946-1-elder@riscstar.com/

Version 3 addresses comments recieved during review of v2:
  - This version fully tested and confirmed to work on BPI-F3
  - Added Acked-by from Conor on patches 1 and 2
  - Added Reviewed-by from Frank on patches 1 and 6
  - Moved the reset property conditional under allOf in the binding
  - In patch 5, needs_clk_disable() is no longer inline
  - Tweaked the description in patch 5
  - Renamed a local variable to be "sfa_size" in patch 6
  - Changed the subject line in patch 6
  - The sfa_size field was not being assigned in spacemit_k1_data;
    now it is set to SZ_1K

Here is version 2:
  https://lore.kernel.org/lkml/20251023175922.528868-1-elder@riscstar.com/

Version 2 addresses comments recieved during review of v1:
  - The "reset" property now only applies to spacemit,k1-qspi compatible.
  - Patch 1 (previously patch 2) now points out that this is the first
    non-Freescale device using the binding.
  - Added Frank Li's Reviewed-by on patch 3.
  - A quirk flag has been renamed to be QUADSPI_QUIRK_SKIP_CLK_DISABLE.
  - The predicate for that quirk now returns bool type.
  - All other similar predicates now return bool type; this is done in a
    new patch (patch 4).
  - If non-zero, new field fsl_qspi_devtype_data->sfa_size defines the
    size of the serial flash regions, rather than ahb_buf_size.
  - A continued line in the Kconfig is now aligned.
  - Patch descriptions are wrapped at 75 columns.

Here is version 1:
  https://lore.kernel.org/lkml/20251020165152.666221-1-elder@riscstar.com/

Alex Elder (9):
  dt-bindings: spi: fsl-qspi: support SpacemiT K1
  dt-bindings: spi: fsl-qspi: add optional resets
  spi: fsl-qspi: add optional reset support
  spi: fsl-qspi: switch predicates to bool
  spi: fsl-qspi: add a clock disable quirk
  spi: fsl-qspi: introduce sfa_size devtype data
  spi: fsl-qspi: support the SpacemiT K1 SoC
  riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
  riscv: defconfig: enable SPI_FSL_QUADSPI as a module

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 21 ++++-
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 ++++
 arch/riscv/configs/defconfig                  |  1 +
 drivers/spi/Kconfig                           |  3 +-
 drivers/spi/spi-fsl-qspi.c                    | 88 +++++++++++++------
 7 files changed, 127 insertions(+), 29 deletions(-)


base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
-- 
2.48.1


