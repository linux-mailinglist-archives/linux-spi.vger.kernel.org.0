Return-Path: <linux-spi+bounces-7737-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E9A9A738
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 11:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6F0172090
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B7B210F5A;
	Thu, 24 Apr 2025 09:00:11 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB27081C;
	Thu, 24 Apr 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485211; cv=none; b=YNNrEONOriaRa8ypcD3HgBSZC1ziwH8LdNJwIb49Dhw1pShY72Vi9ajeJ79ta0A4kc3n1YyrEwcqNpyOK5b+/x0aVQMPBq3zjI9UZSRyc2ukdyqLjRBVCS1/ae/+wPbOkFnbYbu3JkP89VIncy/CXT/Hut2MwlPGhvfUuHHqXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485211; c=relaxed/simple;
	bh=I36nmJxzkmh56uVLncjH6JZL3Kh7/MhbMXvJV4tBJ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NhhwYPg6YXyvcfOTbBsBdM5QmIBvEOG2LZNK24FX+/JaPUe3fmaQe6rvCMmOY0ZiOjt5S44tIsNVyaVth2E259NbX6EFAnQ8ExVAEr9MYg8dkkrOe7Fjo+MI3i34ZtoO+g6LAANiF0puWXshXVp/P5yBSoxLsJR4nPKl6dUWT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: QcnZHJBAT8CmY61VDi2bHA==
X-CSE-MsgGUID: o3QVQmcvTDqI4kRkZvdNtA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2025 18:00:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.69])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 56084401109C;
	Thu, 24 Apr 2025 18:00:03 +0900 (JST)
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
Subject: [PATCH v5 0/7] Add RZ/G3E xSPI support
Date: Thu, 24 Apr 2025 09:59:48 +0100
Message-ID: <20250424090000.136804-1-biju.das.jz@bp.renesas.com>
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
functions.

Merge strategy:
 Patch#7 in this series is spi related patch and has build dependency on
 patch#6. Maybe an Ack from SPI maintainer is required so that it can go
 through memory subsystem.

This patch series tested on RZ/G2L and RZ/G3E by overwriting boot
partitions.

v4->v5:
 * Added merge strategy in covering letter.
 * Dropped patch#2 and #5 as it is accepted
 * Removed CPG bindings header file changes from this series and posted
   with [1].
 * Updated example replacing R9A09G047_SPI_CLK_SPI->9 in bindings, so
   that there is no dependency with clk.
 * Replaced EXPORT_SYMBOL->EXPORT_SYMBOL_GPL and added kerneldoc for
   newly added export function xspi_dirmap_write().
 * Moved *_write() after *_read().

[1]https://lore.kernel.org/all/20250424081400.135028-2-biju.das.jz@bp.renesas.com/
v3->v4:
 * Added a definition for the spi core clock in the R9A09G047 CPG bindings
   header file.
 * Updated the example with spi core clock
 * Retained Rb tag from Rob as these changes are trivial.
 * Fixed the duplicate most outer set of parentheses in patch#2.
 * Updated commit description for patch{#4,#7,#8}.
 * Renamed the functions *_helper()->*_impl().
 * Replaced ssize_t->size_t as the return data type for
   rpcif_dirmap_read_impl().
 * Renamed the local variable length->read and it's data type
   ssize_t->size_t.
 * Added comment for addr_nbytes in struct rpcif_priv.
 * Added struct rpcif_impl for holding the function pointers and data to
   handle the differences between xspi and rpc-if interface and added
   suffix _impl() for functions.
 * The enabling/disabling of spi/spix2 clocks at runtime leading to
   flash write failure. So, enable these clocks during probe() and
   disable it in remove().
 * Collected tags.
v2->v3:
 * Fixed RPCIF_DRENR_CDB macro error.
v1->v2:
 * As rz-xspi is too generic, replaced file name rz-xspi->rzg3e-xspi
   and dropped generic compatible rz-xspi.
 * Dropped prefix spi from interrupt names.
 * Updated the example with above changes.
 * Retained Rb tag from Rob as these changes are trivial.
 * Fixed the build error reported by bot by dropping 
   EXPORT_SYMBOL(xspi_dirmap_read) and restoring
   EXPORT_SYMBOL(rpcif_dirmap_read).
 * Replaced enum XSPI_RZ->XSPI_RZ_G3E.
 * Replaced compatible rz-xspi->r9a09g047-xspi and device data
   xspi_info_rz->xspi_info_r9a09g047.

Biju Das (7):
  dt-bindings: memory: Document RZ/G3E support
  memory: renesas-rpc-if: Move rpc-if reg definitions
  memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
  memory: renesas-rpc-if: Add regmap to struct rpcif_info
  memory: renesas-rpc-if: Add wrapper functions
  memory: renesas-rpc-if: Add RZ/G3E xSPI support
  spi: rpc-if: Add write support for memory-mapped area

 .../renesas,rzg3e-xspi.yaml                   | 135 ++++
 drivers/memory/renesas-rpc-if-regs.h          | 147 ++++
 drivers/memory/renesas-rpc-if.c               | 674 +++++++++++++-----
 drivers/memory/renesas-xspi-if-regs.h         | 105 +++
 drivers/spi/spi-rpc-if.c                      |  16 +-
 include/memory/renesas-rpc-if.h               |   4 +
 6 files changed, 909 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml
 create mode 100644 drivers/memory/renesas-rpc-if-regs.h
 create mode 100644 drivers/memory/renesas-xspi-if-regs.h

-- 
2.43.0


