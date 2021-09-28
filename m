Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA1041B197
	for <lists+linux-spi@lfdr.de>; Tue, 28 Sep 2021 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbhI1OJN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Sep 2021 10:09:13 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:54523 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240777AbhI1OJN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Sep 2021 10:09:13 -0400
X-IronPort-AV: E=Sophos;i="5.85,329,1624287600"; 
   d="scan'208";a="95435599"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Sep 2021 23:07:32 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A762140061B4;
        Tue, 28 Sep 2021 23:07:28 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/6] Add SPI Multi I/O Bus Controller support for RZ/G2L
Date:   Tue, 28 Sep 2021 15:07:15 +0100
Message-Id: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,

This patch series adds a couple of fixes for rpc-if driver and
adds support for RZ/G2L SoC, where the SPI Multi I/O Bus Controller
is identical to the RPC-IF block found on R-Car Gen3 SoC's.

Note: patch applies on top of [1].

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20210922091007.5516-1-wsa+renesas@sang-engineering.com/

Cheers,
Prabhakar

Lad Prabhakar (6):
  dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
  dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
  spi: spi-rpc-if: Check return value of rpcif_sw_init()
  mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
  memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
  memory: renesas-rpc-if: Add support for RZ/G2L

 .../memory-controllers/renesas,rpc-if.yaml    | 52 +++++++++----
 drivers/memory/renesas-rpc-if.c               | 73 +++++++++++++++----
 drivers/mtd/hyperbus/rpc-if.c                 |  8 +-
 drivers/spi/spi-rpc-if.c                      |  8 +-
 include/memory/renesas-rpc-if.h               |  8 +-
 5 files changed, 116 insertions(+), 33 deletions(-)

-- 
2.17.1

