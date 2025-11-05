Return-Path: <linux-spi+bounces-11020-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC9C35256
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDBF14E8D63
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA330594D;
	Wed,  5 Nov 2025 10:42:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACB32FC87E;
	Wed,  5 Nov 2025 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339360; cv=none; b=RtG6j0ZpHKeSgm0T1sbtVib9ciK2QSlnffcE1LvZ9RB4x1vJgqHFAwE2SHyNfUV/ovjhrrbN6HrQQKXHDC6ROV2JChtH1THOpJ43gmo8rkBeAHYc4/ivfO/zYTw5cGyhqkQ2BNTxn29HiD3CDnVzNXZba0ljQy9R1/mP+awWdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339360; c=relaxed/simple;
	bh=qWYGY9jSWRV4WPylypVIGcofAeidLvHQeKwWxtvV6dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DG6/FPLaEshmu3QbomSR25WQFHCCfdPykvVuB/9Sb5QALc5SDZvJ7aCdEHT+gItt3H7nCs27HCQWTZX87MWUya9eN0lYqzXg+v8aNeD3ciN/JR823cBFSZvBEeW17rzNpoTIIPn07Z7lV7/MNwxgqdhieo3dGtoBDHWhv7zpq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: qGeiEhQiS1C4SoqEKw4xjw==
X-CSE-MsgGUID: M8ZeluIfShO80g0V1CXzDA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 19:42:36 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0EB074001DCB;
	Wed,  5 Nov 2025 19:42:31 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 00/14] Add RSPI support for RZ/T2H and RZ/N2H
Date: Wed,  5 Nov 2025 12:41:37 +0200
Message-ID: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.2
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

V3:
 * no changes

V2:
 * fix missing unwind goto quit_resets
 * add resets: false and reset-names: false

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

 .../bindings/spi/renesas,rzv2h-rspi.yaml      |  65 +++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  72 ++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  72 ++++
 drivers/clk/renesas/r9a09g077-cpg.c           |  22 ++
 drivers/spi/spi-rzv2h-rspi.c                  | 339 +++++++++++++++---
 5 files changed, 501 insertions(+), 69 deletions(-)

-- 
2.51.2


