Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C592D000D
	for <lists+linux-spi@lfdr.de>; Sun,  6 Dec 2020 02:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLFBT2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Dec 2020 20:19:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35643 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLFBT1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Dec 2020 20:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607218696; x=1638754696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mp60X6pVJHdNQ6KKEVMrQ8erghAKgUH/2GXLx1/0VT8=;
  b=f/+gJCBbaaYwXYnku/n/C6g6TLBbdrTqLnPxCzZcTU7VE6HSplCVtEUv
   GLauAMrGfhdfrMp3z7sQ7/ePicUHYouDoAW3UcR0stNcz/aRzrX20vf2p
   q8McsX1XJm7yEvsmQFWpE7TPzktwDazRuRdgIe1bLBz4HFpvdEBO3p193
   mWCkUyrRDloTfYVD/NdOkfyB7q/Ys46aOlOyn/Qar/DmgfpL7wxV7R7xy
   w1c7crc6p/w4Eja0E+gjNAqmaPfRosq6LaqjG5v1SQ5Lr3fQ7mpPcRNHw
   Z60QBsFJw/e6wuN0zdJOw/pTOt0i1g2vnQxdvpTLPH8+qTVqv9OlzHhQS
   Q==;
IronPort-SDR: uw9picmSVQ+Ew1pSQ/tg8wIlW1xIQYDutSufnXrHMUbRjppsF777d+8KUT8aFL05IW60lO5jmJ
 BY4FFo6Vc3wwxbulqEH9JzAratT+TIWuq8/65FWTZ9MRCjjjGu5dmEZasZ9/cQAP+z+RaYGQeq
 HBUCg3lIOJOBl7f+hO3RACKUtyymDBhSQzbEJ8AWmavFd0rSkTtgXphzD+3GtWxkMspppwL/oJ
 4HdImu2Jzw7Y71Q/Dm2CBr3oWHH768CghxYihlLcCjLlpd5v66Po6F8eHAbXfBqzZLSfImh/3b
 NlU=
X-IronPort-AV: E=Sophos;i="5.78,396,1599494400"; 
   d="scan'208";a="258231901"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2020 09:36:37 +0800
IronPort-SDR: XXuZrISZiLzCc0zXN9/dcd0HAF/jKXplO9fY6LudkZdb0dXLqURdS4NthtzZkXq6JsaCjkRCug
 ZXAwnNEctGHWolpV+5k1rtGZ1D0l/uczQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 17:02:25 -0800
IronPort-SDR: RzPr34tM78+V6IcU0XcLxMSSGvSCsA8PwSA4WGw3YlKEDhq2whb1noHR/Pm/W8qgD56WSRMnio
 /qYh8qxXJwnw==
WDCIronportException: Internal
Received: from cnf005296.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Dec 2020 17:18:20 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 0/3] DW apb_ssi V4 support for Kendryte K210 RISC-V SoC
Date:   Sun,  6 Dec 2020 10:18:14 +0900
Message-Id: <20201206011817.11700-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Canaan Kendryte K210 RISC-V SoC includes a DesignWare apb_ssi V4
SPI controller implemented with a maximum data frame size of 32-bits
(SSI_MAX_XFER_SIZE=32 synthesis parameter).

This series of patches adds support for this SoC by implementing support
for the 32-bits xfer size configuration. This is done in patch 2.

Patch 3 introduces a workaround for a HW bug on this SoC which triggers
RX FIFO overrun errors when the RX FIFO fills up to its maximum detected
depth of 32. The patch manually reduces the fifo depth to 31.

The first patch documents the new compatible string "canaan,k210-spi"
used to identify this SoC.

Changes from v2:
* Moved DT bindings update patch first in the series
* Tweaked comments for the DFS32 detection code as suggested by Serge
* Added Serge's Acked-by tag to patch 2.

Changes from v1:
* Fixed patch 1 as suggested by Serge: change capability flag name to
  DW_SPI_CAP_DFS32 and fixed the capability detection to use the regular
  position of the dfs filed rather than the new position with DFS32.
  Also enable DW_SPI_CAP_DFS32 for SPI slaves.
* Added Serge's Acked-by tag to patch 2 and 3.

Damien Le Moal (3):
  dt-bindings: spi: dw-apb-ssi: Add Canaan K210 SPI controller
  spi: dw: Add support for 32-bits max xfer size
  spi: dw: Add support for the Canaan K210 SoC SPI

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 +
 drivers/spi/spi-dw-core.c                     | 44 ++++++++++++++++---
 drivers/spi/spi-dw-mmio.c                     | 16 +++++++
 drivers/spi/spi-dw.h                          |  5 +++
 4 files changed, 60 insertions(+), 7 deletions(-)

-- 
2.28.0

