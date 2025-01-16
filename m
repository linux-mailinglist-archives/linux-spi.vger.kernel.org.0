Return-Path: <linux-spi+bounces-6385-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C75A14575
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 00:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24E63AAA85
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F882442F4;
	Thu, 16 Jan 2025 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oIwp6x3K"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E42442D1
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069702; cv=none; b=m8FlVu0CPQ1Oy9q2nCtqCnYF+6FdxHRNXzmnLWiyHIQszQEB1PxB3mzeTCp9+Z6PyjwrRcKU/KxyMg7DXVgLIVcdp2aRSFcuSja+i/Fv5/m7bIYImn2pAQ2wlO7VsBXhCOVCwxS3NF3kF22BlOpJ+heaOEj701Yi/22O/exoRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069702; c=relaxed/simple;
	bh=a/hVs8iwooQB4HZvJxc3LqBoGut9xuZAmBhzuRizZaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o5Da4vQyGdYm3GlRZs6AwWTY72wBk1k4d+VnxGPcB11+FS681adLZsiRnw4gXE4KEf3lki9wv/vkZOa4LUPL3QMjwlED1zg3GTJ8fQqDv/5p+8pz7SPvPNf/le6ah1njlI25ywtFU/K7r3Qqg0gQR8/YQ02lioCSKOf+4ygNxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oIwp6x3K; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737069688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E5bbPGTI9HeBHp6uft5WuWFGh/pAe7B4U1Dpt+uYsDY=;
	b=oIwp6x3Kkv+fvJ4XRExuOdRI1k31QkJG0LvrOj4QQzEDaPYNTQEsjwSzrQ5Gbo3Ud9EKIK
	08zkwPOEZ/ud+N0uvkuhfSBqder/kTM0MItdCk9ssSSlLWMwv4Th3R/P/5VYcaK8jr3ykW
	FSD5n8WoavVBEIbWkkXN7R6KAllkDpc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 0/7] spi: zynqmp-gqspi: Split the bus and add GPIO support
Date: Thu, 16 Jan 2025 18:21:10 -0500
Message-Id: <20250116232118.2694169-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As discussed in patches 1 and FIXME, this device really has two SPI
busses. Split the existing "merged" bus in twain, and add support for
GPIO chipselects.

This series depends on [1, 2].

[1] https://lore.kernel.org/linux-spi/20250116224130.2684544-1-sean.anderson@linux.dev/T/#t
[2] https://lore.kernel.org/linux-spi/20250116225521.2688224-1-sean.anderson@linux.dev/T/#t


Sean Anderson (7):
  dt-bindings: spi: zynqmp-qspi: Split the bus
  spi: zynqmp-gqspi: Pass speed/mode directly to config_op
  spi: zynqmp-gqspi: Configure SPI mode dynamically
  spi: zynqmp-gqspi: Refactor out controller initialization
  spi: zynqmp-gqspi: Split the bus
  spi: zynqmp-gqspi: Support GPIO chip selects
  ARM64: xilinx: zynqmp: Convert to split QSPI bus

 .../bindings/spi/spi-zynqmp-qspi.yaml         |  43 ++-
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    |   5 +-
 .../boot/dts/xilinx/zynqmp-zc1232-revA.dts    |   5 +-
 .../boot/dts/xilinx/zynqmp-zc1254-revA.dts    |   5 +-
 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   5 +-
 .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   5 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |   5 +-
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |   5 +-
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |   5 +-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |   5 +-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |   5 +-
 .../boot/dts/xilinx/zynqmp-zcu1275-revA.dts   |   5 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  15 +-
 drivers/spi/spi-zynqmp-gqspi.c                | 328 ++++++++++++++----
 14 files changed, 359 insertions(+), 82 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


