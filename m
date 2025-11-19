Return-Path: <linux-spi+bounces-11334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354DC701C9
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC0173506ED
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47102327C12;
	Wed, 19 Nov 2025 16:15:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C8286897;
	Wed, 19 Nov 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568922; cv=none; b=egYGvMOceT/7Iv1XBj+ZupHynQLLp0wPFGGxo3jBYEsh95NwLmTCbrVaPCEAQPvPqpc8i6mEleqgOrk6snzwJb0eaEeXMr1nqcOBxEEYmXv+odp8ZsyUBRbng0rGnvw418iidGOQgzyVLixxAz9eat/29UshIiyPJUPwSH8TfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568922; c=relaxed/simple;
	bh=aDmXt65Jw7DdU8vOnexX7L1CteIb4sc930TblcmDeYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YxDKlKJt43H09IXTlMql1bVRlSYty/vXm9dbVN0sia1FSzAlo6syQBOu9OAum6TQHNdXljRKm7p8kHftHL2LYLe5q1DLn4xxgy4r4IN1BHkpB477vgZAeo3WKgIcaU0HGNwjJG3r3Qn0rO1uHHE0PG7Biie4TNtbPYBwLVYJLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: V7yB0ZKGT2WJAP6dVlf9+Q==
X-CSE-MsgGUID: tqKWyjA6ScmGVfXZ8qR9CA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Nov 2025 01:15:17 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.87])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D8CB5406C477;
	Thu, 20 Nov 2025 01:15:13 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v4 00/13] Add RSPI support for RZ/T2H and RZ/N2H
Date: Wed, 19 Nov 2025 18:14:21 +0200
Message-ID: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V4:
 * remove conditional minItems: 2 and maxItems: 3 for clocks property
   since it is already set to that
 * remove renesas,r9a09g087-rspi check since it implies
   renesas,r9a09g077-rspi
 * replace contains: enum: with contains: const: since there's only one
   compatible to be checked against

V3:
 * no changes

V2:
 * fix missing unwind goto quit_resets
 * add resets: false and reset-names: false

Cosmin Tanislav (13):
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
 drivers/spi/spi-rzv2h-rspi.c                  | 339 +++++++++++++++---
 4 files changed, 476 insertions(+), 69 deletions(-)

-- 
2.52.0


