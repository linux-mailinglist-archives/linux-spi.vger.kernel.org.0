Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6228FB5E92
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2019 10:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfIRIFj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Sep 2019 04:05:39 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:42668 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbfIRIFj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Sep 2019 04:05:39 -0400
X-IronPort-AV: E=Sophos;i="5.64,519,1559487600"; 
   d="scan'208";a="26877426"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Sep 2019 17:05:38 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF00B41CA6D1;
        Wed, 18 Sep 2019 17:05:36 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v2 4/4] spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller
Date:   Wed, 18 Sep 2019 09:04:36 +0100
Message-Id: <1568793876-9009-5-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
additional registers for software CS control and DMA. This patch does not
address the changes required for DMA support, it simply adds the compatible
string. The CS registers are not needed as Linux can use gpios for the CS
signals.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2: no changes
---
 drivers/spi/spi-dw-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index edb3cf6..3640b01 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -225,6 +225,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
 	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
+	{ .compatible = "renesas,rzn1-spi", },
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.7.4

