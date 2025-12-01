Return-Path: <linux-spi+bounces-11680-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92758C97A95
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B013A20EF
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E13128BF;
	Mon,  1 Dec 2025 13:43:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5331196F;
	Mon,  1 Dec 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596601; cv=none; b=L2dHyyRvZP12ifmXUcHSaRjKdSpJh133s4/bbUzo0f7eD7OVxP6AO/8Z8bF3l1EwPWp4nOvgOl6E8a97TJp1cKplUGzCBxzU5w13v/nFGLdG69rLjWFzesWwE+sBLmKFuXVq+7bKVCSmdFh7/jxZSexUk222a6+c+KXhv6xnSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596601; c=relaxed/simple;
	bh=UduQhKpjeoFKF49bj5p2nR7G2awJrs9fav2W0M3xvI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyfiKJSTHiRoJEg6l3A8PWScxxPgRbSYyXlJkbz3pw75EoRwEf6//Isc30ok1dka2vSp496ofyDVqU9M/h2TiUlfGZHFU18+trnSmwvhas3PnOWSj9Xn3f4B5eqGNQht+KpGNw6oRVYmV4KkSGHGh3LG0rb9hgdFiEZ4Htj4yGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: U4vlG3ZMT56R/XE6V7piHA==
X-CSE-MsgGUID: 0AfbhGg0TOKaKoUKrJ/5yA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2025 22:43:17 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C672E4215A52;
	Mon,  1 Dec 2025 22:43:13 +0900 (JST)
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
Subject: [PATCH 00/13] Add DMA support for RZ/T2H RSPI
Date: Mon,  1 Dec 2025 15:42:16 +0200
Message-ID: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA controller can be used to transfer data to and from the SPI
controller without involving the CPU for each word of a SPI transfer.

Add support for DMA mode, and do some other cleanups while touching the
same code.

The dts changes in this series depend on the DMA series [1].

[1]: https://lore.kernel.org/lkml/20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com/

Cosmin Tanislav (13):
  spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
  spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
  spi: rzv2h-rspi: do not set SPI_TRANS_FAIL_IO
  spi: rzv2h-rspi: use device-managed APIs
  spi: rzv2h-rspi: store RX interrupt in state
  spi: rzv2h-rspi: set MUST_RX/MUST_TX
  spi: rzv2h-rspi: set TX FIFO threshold to 0
  spi: rzv2h-rspi: enable TX buffer empty interrupt
  spi: rzv2h-rspi: split out PIO transfer
  dt-bindings: spi: renesas,rzv2h-rspi: document optional support for
    DMA
  spi: rzv2h-rspi: add support for DMA mode
  arm64: dts: renesas: r9a09g077: wire up DMA support for SPI
  arm64: dts: renesas: r9a09g087: wire up DMA support for SPI

 .../bindings/spi/renesas,rzv2h-rspi.yaml      |   8 +
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |   8 +
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |   8 +
 drivers/spi/spi-rzv2h-rspi.c                  | 281 ++++++++++++++----
 4 files changed, 242 insertions(+), 63 deletions(-)

-- 
2.52.0


