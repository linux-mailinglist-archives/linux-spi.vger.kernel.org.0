Return-Path: <linux-spi+bounces-6975-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F838A49E53
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2025 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E48D3AF03B
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2025 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DEE16F265;
	Fri, 28 Feb 2025 16:08:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608ED186294;
	Fri, 28 Feb 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758901; cv=none; b=E5FZUCOoGcOZubO70gofcp9gZowlafjAUjq5USAarXr73g8n2lAEN8+U0E0GMUHq93NtnU/k9QSosderH84adiuL+ooPCjp6p1tuiR67Prf1NINeyPWLWwjczvmB5hrCJ2ao2y4CM5T3LTvlAa+lDBL4eKSylsOgUP5yyTbekR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758901; c=relaxed/simple;
	bh=XpGpno9q/hlI0zZFJXJwrT9k3zLbf4BYFdvdY9dOP6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icAjurrD+2vhwkYEp6Un+19jP3VfAamKizhNJmpNYDqpVrl79LDGQA5FLaDG1YBgPl9r5CBKsCihrYLzF9drMHiPbwQppg+OjY7t5QuYWjcIg5vpSUcI0rtkex4ilDoJQNkTVS92eOiUpI+YqOBTtVSSW/bE279t6LZJ2UXcomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 9GMqdtG2Q9eeeqPG36EMbQ==
X-CSE-MsgGUID: +NCBzf2ZSzqwxe5pEGk0MA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Mar 2025 01:08:15 +0900
Received: from localhost.localdomain (unknown [10.226.92.94])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7F218401C213;
	Sat,  1 Mar 2025 01:08:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/8] Add RZ/G3E xSPI support
Date: Fri, 28 Feb 2025 16:07:54 +0000
Message-ID: <20250228160810.171413-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xSPI IP found on RZ/G3E SoC similar to RPC-IF interface, but it
can support writes on memory-mapped area. Even though the registers are
different, the rpcif driver code can be reused for xSPI by adding wrapper
function to it.

This patch series tested on RZ/G2L and RZ/G3E by overwriting boot
partitions.

Biju Das (8):
  dt-bindings: memory: Document RZ/G3E support
  memory: renesas-rpc-if: Move rpc-if reg definitions
  memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
  memory: renesas-rpc-if: Move rpcif_info definitions near to the user
  memory: renesas-rpc-if: Add regmap to struct rpcif_info
  memory: renesas-rpc-if: Add wrapper functions
  memory: renesas-rpc-if: Add RZ/G3E xSPI support
  spi: rpc-if: Add write support for memory-mapped area

 .../memory-controllers/renesas,rz-xspi.yaml   | 137 ++++
 drivers/memory/renesas-rpc-if-regs.h          | 147 ++++
 drivers/memory/renesas-rpc-if.c               | 667 +++++++++++++-----
 drivers/memory/renesas-xspi-if-regs.h         | 105 +++
 drivers/spi/spi-rpc-if.c                      |  16 +-
 include/memory/renesas-rpc-if.h               |   4 +
 6 files changed, 884 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,rz-xspi.yaml
 create mode 100644 drivers/memory/renesas-rpc-if-regs.h
 create mode 100644 drivers/memory/renesas-xspi-if-regs.h

-- 
2.43.0


