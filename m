Return-Path: <linux-spi+bounces-10828-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA008C07DC2
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92EF84E122F
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F2636A5F5;
	Fri, 24 Oct 2025 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="FA0uE7G4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A24836999B
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333357; cv=none; b=XON2Zt+m0NtXrR89+ncABKL6wO7AnpiRP5I5Z8eSrja1bxlCF7iQpycs84RYF5qGh+IbnWGm6fsRgru2mW6FiUMnZTXUh2v5CLQr5Ad+YH8aQAsRnmsmlxe8GpOF+MuUhR3b0YpIWhgTUAlGdWcodM3VL+rqhmn3amTU74SGj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333357; c=relaxed/simple;
	bh=pYEC/hTDDpoyfVbfoYHFpH0exPsJY0khjjaveQnHtzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krXu0XGCeulyW1Cjqn3zTZFSnr/uWhoikgqJKDAmOGCk1m56Dg0LavdRAL9Af42p08CsGytwiBAr4iMlv3s+iIOTtBxX15vM9ZoDVEc2xX0GRUtX4H9D1XK0bJaJAj/mbaCTurRduUdm0tA+A6mAp/UTzhMJnoNoJYf+DaYEWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=FA0uE7G4; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-430e1f19a1aso12492745ab.1
        for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333355; x=1761938155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hqIIxYoJfbzcFUkevnIvDyYXIbJhiiIxZ4aEshcKOg=;
        b=FA0uE7G4uBaE1x4q+5S28JrSi2UrKzWJ609Ni40Wb+NwKgNm9oBPQdQpXle5FngFUn
         PVBWqZePgLN5OWAHkHnLYAKFy6DPYy+uURjW2QpyV8V7UgGwUGiq3oDoEuDGHqvGmXPa
         A27bh5f0xXnpEqIzFuqazSYmu/eM4tiGZb1GS2gHv1Muz1RtLmVMqzNd5Cttt84+1o2c
         Ms8uur4vm94K3ZzQVEOUXPHfix7cRpm8ilE6O4EKYiJ8c0/0qT2dwLk2C3I5kohDNP9d
         MEpg2cpwU5YURBbyOCbToQWpppGcR06jst1b9cE3k7bpmG2IIzmzill1vvw8ksToyEZS
         y4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333355; x=1761938155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hqIIxYoJfbzcFUkevnIvDyYXIbJhiiIxZ4aEshcKOg=;
        b=AwxmW86TXufARWu5HHvqcHIq+bjarCHFzbpzajlG4mRiyHVMuqea/T/mDF4wX4TuUm
         JSMJSSSXg2goKRtFp6Gb0eqwFQAjmzPx85ZyRjW3eKBZuRscS1DmQ1Cp/VZ51qJlAV9b
         84HBDV0/zrMsiU4uOZCHk5aF4iQJbn0yoR8nFG9BDgTWQ0ld/CQKxq+f3yV4eCz9664c
         gG1QtB+8CiJbbBg9fV97V7DpZDrhDpe7yLh9wAAhVRZVvAp+sKoMZvdIl+loG9rYDb0T
         2tjCatb0RKYw1ZWaSe1QVCtmpTEHihkZpsaKNGvQFwzxLGoo7nDl8tKQzbBVqZi+Z2uP
         Ptbw==
X-Forwarded-Encrypted: i=1; AJvYcCWXuSFJi+g63tMc5zu9o+PmVCXZ/Ovs6pZ4/zY2Wmp+1hL77blhlzV95z8UWV35U7pCK5nypA56hX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrBa7bUJJtInBt1LmuDOCF6lHLH5wT6N7c58EIZVhyFPTIQbT
	b6f/Er5q9auA95IAU1pNRewHvqdr9w8M56093mulCnto8rCN0oEaE5YZFrl+QlJ/JiY=
X-Gm-Gg: ASbGncv4nRNvKnOWfZQdEkeyWLXR/6GYy8Tpsys6BDobDyoCKCYMvUO4AMzJhiL0Sw8
	SrCOCiV1h94tyioO3sbn8foT96x0bu/CAFV1p32NHrTCGULyfJqRyfW7rkPsJtqt3WXGcULuxZN
	oYUbRz4KnmGeIhBiHi/8PeXJutLksvFGw2AFBFzylUom7Dhz8c6gLf67uqsz3/PdEprWSaVEfPd
	MAy9Gb8/HZ0AjEi+DmRXU/F7dFngxGxuAeDYkbWsDCiMEKn6t869VYcPKFP6FC0qON272K5kHhQ
	kZMFTV/gDGULZuiw+mu9ZhQuwmv2lIJu+2oCbouCh1ggJo2hszK0LJ8ic8qkQU7LHQz5I324D0D
	b7OllaHfg7hDWZI87kvaZxGlMS/ixs1TrSniW/qCT07554eibW8lmNfOX874+4wthlC80+z7/x0
	zTx5ulaxUFjuiVKuQnifOKxTR/v4DVJM0eLGwA4QUL5tfHtJYDWPrTMg==
X-Google-Smtp-Source: AGHT+IFf6y19COM4VMTPijjo8N/XwohbmjTEdQxUdhW3R9LdR2ndKIPLgXKS2XAlzSenv51Gg++n7g==
X-Received: by 2002:a05:6e02:2502:b0:431:d678:fcb with SMTP id e9e14a558f8ab-431eb668375mr53003245ab.9.1761333354916;
        Fri, 24 Oct 2025 12:15:54 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:15:54 -0700 (PDT)
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
Subject: [PATCH v3 0/9] spi: enable the SpacemiT K1 SoC QSPI
Date: Fri, 24 Oct 2025 14:15:40 -0500
Message-ID: <20251024191550.194946-1-elder@riscstar.com>
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

This version of the series addresses comments received in review of
version 2.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/qspi-v3
  
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

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 15 ++++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 ++++
 arch/riscv/configs/defconfig                  |  1 +
 drivers/spi/Kconfig                           |  3 +-
 drivers/spi/spi-fsl-qspi.c                    | 88 +++++++++++++------
 7 files changed, 124 insertions(+), 26 deletions(-)


base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
-- 
2.48.1


