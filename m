Return-Path: <linux-spi+bounces-8752-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C323AAE6F6E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 21:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5165C189CF60
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 19:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411002E92AC;
	Tue, 24 Jun 2025 19:23:27 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345A2E62BE;
	Tue, 24 Jun 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793007; cv=none; b=BHo/G4+5qqwoOf+T52dAz9F61EUYZZo+h4YwCJTzPUNHxS/ppLfwFmnq9JV7yhz0gyXhOxyiVjw5/O+v7feUxtBpOrUkR9kzd+RkxfvSfx69eTHx4rv/6RwmaJyjWiQkyyVTC6+ZvhiPdQ4pN0d3RpzGV4Uh7EBy7r6FdpfgKyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793007; c=relaxed/simple;
	bh=lRg2yD0YRvBeJgxAk9IC2Wm9scxw49RaWa3XYU7R7Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5eFS4o6FWU+S8lS154iwT6tEbSJNqrLwncNEkG04Yj1CSFo4ISl1cBxRz4EMZ8eVIE+mzjIkekGlHYYC3CDCTgPDZCDUT3Insk0NsBgU7yCS6I1C8lKjPJ6KadF/AXbuIjtQsb26hU2QLHLCOQHYbZJqXuDoYDGUqrRqtHk13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: HNxtWYZFS3mEGe6CVO+Xvw==
X-CSE-MsgGUID: lEOIOdy8QFOaRWKO2t9hxw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Jun 2025 04:23:16 +0900
Received: from mulinux.example.org (unknown [10.26.240.23])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5DCF3400F738;
	Wed, 25 Jun 2025 04:23:08 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: SPL2 Bot <spl2-bot-eu@lm.renesas.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nishanth Menon <nm@ti.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Eric Biggers <ebiggers@google.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 0/6] Add RSPI support for RZ/V2H
Date: Tue, 24 Jun 2025 20:22:58 +0100
Message-Id: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SPL2 Bot <spl2-bot-eu@lm.renesas.com>

Dear All,

This series adds support for the Renesas RZ/V2H RSPI IP.

Cheers,
Fab

Fabrizio Castro (6):
  clk: renesas: r9a09g057: Add entries for the RSPIs
  spi: dt-bindings: Document the RZ/V2H(P) RSPI
  spi: Add driver for the RZ/V2H(P) RSPI IP
  MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
  arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
  arm64: dts: renesas: r9a09g057: Add RSPI nodes

 .../bindings/spi/renesas,rzv2h-rspi.yaml      |  96 ++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  63 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g057-cpg.c           |  24 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rzv2h-rspi.c                  | 469 ++++++++++++++++++
 8 files changed, 670 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
 create mode 100644 drivers/spi/spi-rzv2h-rspi.c

-- 
2.34.1


