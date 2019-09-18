Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F4BB5E85
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2019 10:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfIRIEt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Sep 2019 04:04:49 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:16147 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbfIRIEt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Sep 2019 04:04:49 -0400
X-IronPort-AV: E=Sophos;i="5.64,519,1559487600"; 
   d="scan'208";a="26658074"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 18 Sep 2019 17:04:47 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 079B341C9BD7;
        Wed, 18 Sep 2019 17:04:44 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] spi: dw: Add basic runtime PM support
Date:   Wed, 18 Sep 2019 09:04:32 +0100
Message-Id: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI. This
series enables power mode in the driver so the clock domain will enable
the bus clock, adds the compatible string and updates the associated bindings
documentation.

v2:
 - Note that pclk should be renamed when using a clock domain in the
   bindings documentation.
 - Set spi_controller.auto_runtime_pm instead of using
   pm_runtime_get_sync.
 - Added pm_runtime_disable calls to dw_spi_remove_host and the error
   condition of dw_spi_add_host.

Gareth Williams (1):
  dt-bindings: snps,dw-apb-ssi: Add optional clock domain information

Phil Edworthy (3):
  dt: spi: Add Renesas RZ/N1 binding documentation
  spi: dw: Add basic runtime PM support
  spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller

 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt | 11 +++++++++++
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt  |  3 ++-
 drivers/spi/spi-dw-mmio.c                                  |  1 +
 drivers/spi/spi-dw.c                                       |  8 ++++++++
 4 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt

-- 
2.7.4

