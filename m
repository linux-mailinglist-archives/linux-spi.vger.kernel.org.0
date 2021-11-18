Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03D6455323
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 04:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbhKRDN4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 22:13:56 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:52439 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242654AbhKRDNy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 22:13:54 -0500
X-IronPort-AV: E=Sophos;i="5.87,243,1631545200"; 
   d="scan'208";a="100984197"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Nov 2021 12:10:51 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9D1C1400F2C2;
        Thu, 18 Nov 2021 12:10:49 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/3] RSPI driver support for RZ/G2L
Date:   Thu, 18 Nov 2021 03:10:38 +0000
Message-Id: <20211118031041.2312-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,

This patch series adds RSPI driver and dt binding support to RZ/G2L SoC.

Cheers,
Prabhakar

Changes for v2:
* Fixed review comments pointed by Geert.

v1: https://patchwork.kernel.org/project/linux-renesas-soc/
cover/20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Lad Prabhakar (3):
  spi: dt-bindings: renesas,rspi: Document RZ/G2L SoC
  spi: spi-rspi: Add support to deassert/assert reset line
  spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()

 .../devicetree/bindings/spi/renesas,rspi.yaml |  4 ++-
 drivers/spi/spi-rspi.c                        | 27 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.17.1

