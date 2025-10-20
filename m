Return-Path: <linux-spi+bounces-10726-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8428EBF2871
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2BE188FC1E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFED32F75E;
	Mon, 20 Oct 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="KxmtWahr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D432F74E
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979120; cv=none; b=lPqgqAiENiwWja5E1eEFVVNe2ZIKofhz/C+626ltHIDEgfzifKOK0N0bhf/IMjQSNoP8eQ+e7lT+9dOLlwLJzLVh+L69ctkQAfOZO6Pa1G7LFuVN4hXoUeTNTDqBl8kjewf9aO5wzbCaVobFw/bNiKoqRkS7PVkg7330P+aWk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979120; c=relaxed/simple;
	bh=3G7mlblq1IkMV+TQeAC9F7TUri+6TwMa0SOSWvsCMmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWohUgwrRjlfXRqMG8mj9nSUaXVHQqhpfIckjNVdGVNrrru3dD3ToQic38g3W+f575n7i9Ux3n5vO77aOKq2PQMjOicZG+xSpvC+r4wzee1kWklb49gX4qMavbeyj0Jq2g7EPg5Ne+ycFM197RlleLw7G9Y1iGMjVFzFywXk2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=KxmtWahr; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-940d25b807bso84861639f.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979117; x=1761583917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AvuDUU8XTDFjTkk8uCzrLoeu+wpmzYKrOcfQ084FIs=;
        b=KxmtWahrPOwMjWh2SGJg+td+XbWnXF3DKm87bH7y7Am6+J2aJQNbjSb8DKsrh7uj/I
         1ywfMwIqYRgJ7oL79u0+rEA24+g4TJWqZDFYvkfOZTwyVBWgRcNK5rWgD5fW5LW+VwHO
         8LAoWiQWpgOP5tIqNuxr3I1ghr98UfQWjCNUaEG8fUcOgkOHs+L9TzEGbxJK2MI/V+En
         Rmp0MODDivH6aIaJyRLi0aPLWKTLrg9TGuErjq2I8oDdsy78MYdo/qNsJqC3mr2wHvty
         /SlwTxejlxd/4iFiO244jL1+b0jOI/0tC7nipRSsu5kRqHPTqufGIPYPOJ1e80LJlw2l
         Ubtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979117; x=1761583917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AvuDUU8XTDFjTkk8uCzrLoeu+wpmzYKrOcfQ084FIs=;
        b=Qz8ftNPR+BRNK0C5JQMIP6hg+g3VGcK+kMDmL/PcZH2kb2FM8NwCTRzx/hWUEnUYHi
         TBDmCQR2yNTsCX6bKLQUYTBPQTUSdRSDcr3vE/BFWS4U7p8Z5+HIQwCxrbqAsDGEIw72
         6pTpsMoI+1K+s5ZRpEhR7AaurEbefP/hDgIUEYYikJkeP7SuPwMmHuO0fnwotCgmssf9
         OF+8UBWmhGJRvs0NCZ/izk5o+UffIU+sURlnG9ncV25VBYJcwXevjo9gSQm0kFF3jusC
         Ck4h2BBN9CMJbsl2DCARvG0DuWz7iIuuYCYpeHFZAyyEMypVKmP9mpYYPEp7T4PD3D7u
         +Qyg==
X-Forwarded-Encrypted: i=1; AJvYcCWe6obJ9DCodFBp1CJN8/n2nmq9plgA85TuajcpF0mU6jkTGknebatjvnlr4vl4evAQvsWPck+f/28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQqxb2uiar9Nj8we1kcyLy7Y8y+CXnPjKnwi97ykfq0bsii0xK
	SvbhiwSiRwkwzikOBvly7o6K0CsGtR0wUq5/JDfcj3PkvKVpsLp41pL4XsEbYEqqQro=
X-Gm-Gg: ASbGnculFfEIGeeXRqZ7AAnRnRn/4MafW9M0qJGkJTxGWj1htLYTc8xIDByQYU5XKK5
	on+GT6Io+OiF89QI2RNZB+K+Qoj7qcJFxpW7GC0vwapVRSp8fUKryNfw5HX54b6WRBthqxwx6Ba
	VDiZG/EoH3CVxR4Z1pCYRE7/HkVPkhRmQ+VsoyERDUNFm4TZUl2UvGItwQn5Iv9WCJueWA8mJNJ
	sSWv+0x8W958tO3rj1JyhV9cG/4G113VQ66xXYRCbdPGbT4Thqe9JqNLG1IEeiI8O/blQ9k30II
	bKglavM4fBhjrnm5sG8PjW60JWP5QKcdVCw0GI8nUdJwZN4uwPyLWOn0szmGounjmXqoOhHKPPj
	HgkVclqc0j8iEJKqLhwrdE2cnvuLhMyB3eokpZKu5mFDk2unp83pS/5PB99WLOYvm2AHzWrxSHM
	i/BljehqfivLUVrLyq45uS4YE8ITpi8ihp8iopsXSQjkQ=
X-Google-Smtp-Source: AGHT+IHkIIUwLfapdvbPcRnsD5CACrEJj9nwaBI41U0v+K+kXPy5pHBwBsF94Q6SPwfqvwS+pU3GAQ==
X-Received: by 2002:a05:6602:13c6:b0:940:d808:8a09 with SMTP id ca18e2360f4ac-940d8088d03mr748582839f.11.1760979117170;
        Mon, 20 Oct 2025 09:51:57 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:51:56 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	geert+renesas@glider.be,
	fustini@kernel.org,
	ben717@andestech.com,
	apatel@ventanamicro.com,
	joel@jms.id.au,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] spi: enable the SpacemiT K1 SoC QSPI
Date: Mon, 20 Oct 2025 11:51:43 -0500
Message-ID: <20251020165152.666221-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
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
  - Using a fixed 1K size for flash chips rather than having it
    be related to the AHB buffer size.

					-Alex
This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/qspi-v1

Alex Elder (8):
  dt-bindings: spi: fsl-qspi: add optional resets
  dt-bindings: spi: fsl-qspi: support SpacemiT K1
  spi: fsl-qspi: add optional reset support
  spi: fsl-qspi: add a clock disable quirk
  spi: fsl-qspi: allot 1KB per chip
  spi: fsl-qspi: support the SpacemiT K1 SoC
  riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
  riscv: defconfig: enable SPI_FSL_QUADSPI as a module

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        |  6 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++
 arch/riscv/configs/defconfig                  |  1 +
 drivers/spi/Kconfig                           |  3 +-
 drivers/spi/spi-fsl-qspi.c                    | 60 ++++++++++++++-----
 7 files changed, 98 insertions(+), 15 deletions(-)


base-commit: 606da5bb165594c052ee11de79bf05bc38bc1aa6
-- 
2.48.1


