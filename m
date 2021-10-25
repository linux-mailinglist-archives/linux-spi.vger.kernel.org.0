Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5243A52E
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 22:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhJYU7E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Oct 2021 16:59:04 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:33583 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232690AbhJYU7D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 Oct 2021 16:59:03 -0400
X-IronPort-AV: E=Sophos;i="5.87,181,1631545200"; 
   d="scan'208";a="98385682"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Oct 2021 05:56:39 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8AD4441003BB;
        Tue, 26 Oct 2021 05:56:35 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/7] Add SPI Multi I/O Bus Controller support for RZ/G2L
Date:   Mon, 25 Oct 2021 21:56:24 +0100
Message-Id: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,

This patch series adds a couple of fixes for rpc-if driver and
adds support for RZ/G2L SoC, where the SPI Multi I/O Bus Controller
is identical to the RPC-IF block found on R-Car Gen3 SoC's.

Cheers,
Prabhakar

Changes for v2:
* Rebased the patches on linux-next
* Split patch 5 from v1
* Included RB tags
* Fixed review comments pointed by Wolfram

v1:
https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Lad Prabhakar (7):
  dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
  dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
  spi: spi-rpc-if: Check return value of rpcif_sw_init()
  mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
  memory: renesas-rpc-if: Return error in case devm_ioremap_resource()
    fails
  memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
  memory: renesas-rpc-if: Add support for RZ/G2L

 .../memory-controllers/renesas,rpc-if.yaml    | 54 +++++++++----
 drivers/memory/renesas-rpc-if.c               | 80 +++++++++++++++----
 drivers/mtd/hyperbus/rpc-if.c                 |  8 +-
 drivers/spi/spi-rpc-if.c                      |  8 +-
 include/memory/renesas-rpc-if.h               |  8 +-
 5 files changed, 124 insertions(+), 34 deletions(-)

-- 
2.17.1

