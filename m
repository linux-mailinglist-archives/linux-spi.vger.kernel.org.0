Return-Path: <linux-spi+bounces-10875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6EAC14DC2
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D104FC649
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32AD272816;
	Tue, 28 Oct 2025 13:32:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E5A217736;
	Tue, 28 Oct 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658350; cv=none; b=Z8qqI1ccfO5Km2xPHGql/gQSv5XvW4J8s17mkSJ00e+PqDi0AzU5L2SEL7K4WjOhmkU+qAl6o+H1HThMBkznzgn87qERJ9+p4hN7U9qMieOPA/hEZEM7QLYkFZQ1o5adQVvNyG+XvPK4qG4ANkduPiwMkvL9iQOqddA+H4QRcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658350; c=relaxed/simple;
	bh=7xzSZEKPMcMr6ZLDcdxFVSipxoAqy3mVToNORHLTl3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ImwX8HChwTnAWoLbPScyhqUMwTdQ/PDP3YhSZb206MPqDeYBevN6KfPSvBeom17jdzKqw8BfhfKBXaFS/6jO5iGRHlXMPjawVhNlVGUjiFpNMErXLISgQC8xdHN3nUHfXqM1bd9NcEhdY5b3g8tVXwTq84Q0ik7THSerQF7Aljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: yAzQ4Cw7T8+IvhaCA/kGHg==
X-CSE-MsgGUID: 38qbawjiTh2L8qoZHAb/sg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Oct 2025 22:32:27 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 65B5E41B5F52;
	Tue, 28 Oct 2025 22:32:22 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 00/14] Add RSPI support for RZ/T2H and RZ/N2H
Date: Tue, 28 Oct 2025 15:31:31 +0200
Message-ID: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared to the previously supported RZ/V2H, the Renesas RZ/T2H
(R9A09G077) and RZ/N2H (R9A09G087) SoCs have a smaller FIFO, no resets,
and only two clocks: PCLKSPIn and PCLK. PCLKSPIn, being the clock from
which the SPI transfer clock is generated, is the equivalent of the TCLK
from V2H. They also support generating the SPI transfer clock from PCLK.

Cosmin Tanislav (14):
  clk: renesas: r9a09g077: add SPI module clocks
  spi: rzv2h-rspi: make resets optional
  spi: rzv2h-rspi: make FIFO size chip-specific
  spi: rzv2h-rspi: make clocks chip-specific
  spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
  spi: rzv2h-rspi: avoid recomputing transfer frequency
  spi: rzv2h-rspi: make transfer clock rate finding chip-specific
  spi: rzv2h-rspi: add support for using PCLK for transfer clock
  spi: rzv2h-rspi: add support for variable transfer clock
  spi: rzv2h-rspi: add support for loopback mode
  dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
  spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
  arm64: dts: renesas: r9a09g077: Add SPIs support
  arm64: dts: renesas: r9a09g087: Add SPIs support

 .../bindings/spi/renesas,rzv2h-rspi.yaml      |  62 +++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  72 ++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  72 ++++
 drivers/clk/renesas/r9a09g077-cpg.c           |  22 ++
 drivers/spi/spi-rzv2h-rspi.c                  | 335 +++++++++++++++---
 5 files changed, 494 insertions(+), 69 deletions(-)

-- 
2.51.1


