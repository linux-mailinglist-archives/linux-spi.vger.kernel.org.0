Return-Path: <linux-spi+bounces-10786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88743C02CFD
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFF81A67B65
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BAE34B405;
	Thu, 23 Oct 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="CX5aE2BB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3533446A3
	for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242368; cv=none; b=BGmAhLshOCdIp/3GbY1CpMGLJCe1nYVFcghMC3Qi9P4oWMrqmOzEe8Z2Rmwk9HrG+O336c4QCTXEUvkEo+n7BBXgT32yetYfvUuayN9ljxR0UK9IfjxX8MtACK9EZhofQyvImAlzbsSsXp7viJLqyAWpETreFrGBed/e/18GAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242368; c=relaxed/simple;
	bh=cmoQL7/EOLRFUL/HDkJZjuFWcItHG3aLGx55fZGpJDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtmRhIGYOD/9XI1+KM5p6dR+vf7OLhYs7bYvZauXzNaDiziag+Mu4yFcTIfIsw8V8gQxCAXqME8u+1jheo0AKzw/BFnLjkAS+d2EmzOZM2Ld/Z2VOsfUW1AmlgT9t3NObv1snzIVl1VMSJPMEPP5rLSDIPqGMbOvyyyacnAKq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=CX5aE2BB; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so812844a12.0
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242365; x=1761847165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZKnZFdnM3oZwGqheXR0h641QYDnGOp0D351J3S+oms=;
        b=CX5aE2BBNKN74+HDW2YndtKOFsSy4X+rslQnz5Kpdk/25xIV6Gu7jS5k1YjS9UPSje
         nm6JRSrqNT9ATEDog+u5mUYQ92TxlFX+pQb4yuwGqOYQmcW2aF+ZN1suntTHPncdtBwM
         SMfC9LyhHoAVUD6Nr/EbjQBys+4y7FxOb7Cahl09wO/ANp3AZsxLGkhr+FJApMO+Q2TD
         2HOS9R9UyT5DH4yi4g4DCdFQLTLa/leGBrf4JY+5pb0pAiTYmpsrdt0DRTtnAVUWe0hC
         EYi6N87JwvF+VdA8ZliBIqLTJqMG5F8+OowviyCsAqu9DfmPcy8H4bN43zIj+h6idTAO
         dOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242365; x=1761847165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZKnZFdnM3oZwGqheXR0h641QYDnGOp0D351J3S+oms=;
        b=v3yJ3vhuHlBtYSvtexzKp19aL589Ba1v2O4pzRaQQ6reucupBIPYV9fwhS7usWUJ2y
         ii76tP+0PanTdjhkpLBEat5iV/EUD580udovqbKICXpPiPbwU1Q/J5x9gQ9SIjlKphuN
         FIKV/g7g9vtWBInt6dgIoMtpUVBFZYvxIuupcVKPRSimJuf1ri84QgPo662UExkb61K4
         J8KJ9uNDw5qmNR+wlpRU9lvodTztkf1XqN4og9x8++A6oUuTV/eybEUYvzELgwI9AQos
         pgpl7G9pN2SfSENRQxaFIcsmLll/Q4W7G2eZn/YFoCmmaCvMcrj0brm87bb92Df0DHt5
         FUAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSJ7+F6/lXGNZv9HWBKbX2Hc6pieMgfVxI+hlfsLDPFj6uA4YwAhXnmLoR2LSnC/CgSlKnhco5c4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJMOetnncMjxb1ZAHRSjVWFS1Px8aJT/66e6w5zzMv57jYk/8
	QAOZoiSPrlPWgV/EEEVS9lZWm/+ar/0TifNJ2W+BBVtMYQ2ejIBgnv0DT7r33GCYguA=
X-Gm-Gg: ASbGnctHJwaBuFhp08VPpJQcxGalIc3L5eigN6KBuA0tIhplvu4mgsTgyRQB6Wa5F6y
	FGc/2MhCFOQJ5Em2aQ2nWQnB6GafZyT6RPy/Y5eoh0tv5SeHxmKmQS+zX6CyqFvvDlwvBkHt+t6
	5BRO0tnBAsef/o/YHnbPxK5N0yks+WyNYmdi34+xJktHKVfLFaF6zNkX61ViXmntNLDH0MbKaHk
	ymeRcC68UKHQtWTHUEilY/fHU6hX0U/7g3eFN/q8GqW0QOXcrJZuR1gGtoJk3U/KPNsgGSWbR5G
	/HXvS1+GjqrRQJQuIDzcMNFV9uq9x2tUNoWI6PgH8SERoLIecl+YjpigqhJWoZy6bBbSfGlbHMX
	Mhp5GMuV+jOeBt6lkCXco5Q1O91tH2yugKgHTgz/vckD/OMW0vbpkWdYAluP6mqrNiTfaMWHhLd
	aM01060EhJOlN5XMwKDS7VoFffOAA8/Sr9Dg==
X-Google-Smtp-Source: AGHT+IG8JoJ2ND1pyiQh1ApMIuQ8AB6jOUuqQ1+8XSa1Ou2nNF3k3D9kPXQ1PKRoMYU7/mYJQIadTQ==
X-Received: by 2002:a17:902:cecb:b0:27e:ec72:f6d with SMTP id d9443c01a7336-2946de3d929mr41775405ad.11.1761242365381;
        Thu, 23 Oct 2025 10:59:25 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:24 -0700 (PDT)
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
Subject: [PATCH v2 0/9] spi: enable the SpacemiT K1 SoC QSPI
Date: Thu, 23 Oct 2025 12:59:12 -0500
Message-ID: <20251023175922.528868-1-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the SpacemiT K1 SoC QSPI.  This IP
is generally compatible with the Freescale QSPI driver, requiring
three minor changes to enable it to be supported.  The changes
are:
  - Adding support for optional resets
  - Having the clock *not* be disabled when changing its rate
  - Allowing the size of storage blocks written to flash chips
    to be set to something different from the AHB buffer size

    					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/qspi-v2
  
Version 2 addresses comments recieved during review of v1:
- The "reset" property now only applies to spacemit,k1-qspi compatible.
- Patch 1 (previously patch 2) now points out that this is the first
  non-Freescale device using the binding.
- Added Frank Li's Reviewed-by on patch 3.
- A quirk flag has been renamed to be QUADSPI_QUIRK_SKIP_CLK_DISABLE.
- The predicate for that quirk now returns bool type.
- All other similar predicates now return bool type; this is done in a new
  patch (patch 4).
- If non-zero, new field fsl_qspi_devtype_data->sfa_size defines the
  size of the serial flash regions, rather than ahb_buf_size.
- A continued line in the Kconfig is now aligned.
- Patch descriptions are wrapped at 75 columns.

Alex Elder (9):
  dt-bindings: spi: fsl-qspi: support SpacemiT K1
  dt-bindings: spi: fsl-qspi: add optional resets
  spi: fsl-qspi: add optional reset support
  spi: fsl-qspi: switch predicates to bool
  spi: fsl-qspi: add a clock disable quirk
  spi: fsl-qspi: allot 1KB per chip
  spi: fsl-qspi: support the SpacemiT K1 SoC
  riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
  riscv: defconfig: enable SPI_FSL_QUADSPI as a module

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 16 ++++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 ++++
 arch/riscv/configs/defconfig                  |  1 +
 drivers/spi/Kconfig                           |  3 +-
 drivers/spi/spi-fsl-qspi.c                    | 87 +++++++++++++------
 7 files changed, 124 insertions(+), 26 deletions(-)


base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
-- 
2.43.0


