Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31647455331
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 04:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbhKRDOI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 22:14:08 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:51670 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242697AbhKRDOA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 22:14:00 -0500
X-IronPort-AV: E=Sophos;i="5.87,243,1631545200"; 
   d="scan'208";a="100643664"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Nov 2021 12:11:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E9A1E4008C4D;
        Thu, 18 Nov 2021 12:10:57 +0900 (JST)
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
Subject: [PATCH v2 3/3] spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()
Date:   Thu, 18 Nov 2021 03:10:41 +0000
Message-Id: <20211118031041.2312-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211118031041.2312-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211118031041.2312-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

"ret" variable is already declared in qspi_transfer_in() at the
beginning of function, drop redeclaring ret in the if block, fixing
below:

spi-rspi.c: In function ‘qspi_transfer_in’:
spi-rspi.c:838:7: warning: declaration of ‘ret’ shadows a previous local
  838 |   int ret = rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
      |       ^~~
spi-rspi.c:835:6: note: shadowed declaration is here
  835 |  int ret;

Fixes: db30083813b55 ("spi: rspi: avoid uninitialized variable access")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2
* Included RB tag
---
 drivers/spi/spi-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 592682d96562..815698366412 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -835,7 +835,7 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 	int ret;
 
 	if (rspi->ctlr->can_dma && __rspi_can_dma(rspi, xfer)) {
-		int ret = rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
+		ret = rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
 		if (ret != -EAGAIN)
 			return ret;
 	}
-- 
2.17.1

