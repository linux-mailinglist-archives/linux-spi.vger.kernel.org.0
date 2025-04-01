Return-Path: <linux-spi+bounces-7382-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B3A77DDD
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 16:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E629188EF57
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB21F192B;
	Tue,  1 Apr 2025 14:35:55 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5B156677;
	Tue,  1 Apr 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518155; cv=none; b=uBn00t2w+4hZcfNU02vDCQobuKovn5x0pHGPOBJp2xdJOf9kd9P5bwUp2lmNbKVL2Jdm72fCVa7OTPP9sFMpDF6cBn5rPfcCgbEm5pELHPvDvusGATu0Q6P4QpmvOHwBZ9+lpZG39YwRvKyPo+/T5O9FywFsg8oLjPDVc/jla90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518155; c=relaxed/simple;
	bh=ts0F13cvxPwxCn8dq/f9kApgiGo1QTipU8SEbsSvMnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpdEkcxFLxK83dQLyrOJ1Wgu/AYaIQgtXYbEuIACuq1ifw/0UoM22K9maQIZs37Xx0eO+LStXXliltSJF2B1mbmUyMBGf0uV4SGk4DdC0NAuVhpGgP/w5CpbEOv2KFcFEwMY2fbrGlUho9+OOsAc6F27fPxWTrthKJMwyLR8pN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: RHW7XX2kS0e1x8tNLHGloQ==
X-CSE-MsgGUID: bJt5FkCZRiiFYsJzfE+iow==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Apr 2025 23:35:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.156])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 480AD432BC94;
	Tue,  1 Apr 2025 23:35:41 +0900 (JST)
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
Subject: [PATCH v4 0/9] Add RZ/G3E xSPI support
Date: Tue,  1 Apr 2025 15:35:18 +0100
Message-ID: <20250401143537.224047-1-biju.das.jz@bp.renesas.com>
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

Biju Das (9):
  dt-bindings: memory: Document RZ/G3E support
  memory: renesas-rpc-if: Fix RPCIF_DRENR_CDB macro error
  memory: renesas-rpc-if: Move rpc-if reg definitions
  memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
  memory: renesas-rpc-if: Move rpcif_info definitions near to the user
  memory: renesas-rpc-if: Add regmap to struct rpcif_info
  memory: renesas-rpc-if: Add wrapper functions
  memory: renesas-rpc-if: Add RZ/G3E xSPI support
  spi: rpc-if: Add write support for memory-mapped area

 .../renesas,rzg3e-xspi.yaml                   | 135 ++++
 drivers/memory/renesas-rpc-if-regs.h          | 147 ++++
 drivers/memory/renesas-rpc-if.c               | 703 +++++++++++++-----
 drivers/memory/renesas-xspi-if-regs.h         | 105 +++
 drivers/spi/spi-rpc-if.c                      |  16 +-
 .../dt-bindings/clock/renesas,r9a09g047-cpg.h |   1 +
 include/memory/renesas-rpc-if.h               |   4 +
 7 files changed, 919 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml
 create mode 100644 drivers/memory/renesas-rpc-if-regs.h
 create mode 100644 drivers/memory/renesas-xspi-if-regs.h

-- 
2.43.0


