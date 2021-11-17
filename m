Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55173453D6F
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 02:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhKQBIh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 20:08:37 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:15400 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229543AbhKQBIg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 20:08:36 -0500
X-IronPort-AV: E=Sophos;i="5.87,239,1631545200"; 
   d="scan'208";a="100509775"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Nov 2021 10:05:37 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 11243400A897;
        Wed, 17 Nov 2021 10:05:34 +0900 (JST)
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
Subject: [PATCH 0/3] SPI driver support for RZ/G2L
Date:   Wed, 17 Nov 2021 01:05:24 +0000
Message-Id: <20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Lad Prabhakar (3):
  dt-bindings: spi: renesas,rspi: Document RZ/G2L SoC
  spi: spi-rspi: Add support to deassert/assert reset line
  spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()

 .../devicetree/bindings/spi/renesas,rspi.yaml | 13 ++++++++-
 drivers/spi/spi-rspi.c                        | 27 ++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.17.1

