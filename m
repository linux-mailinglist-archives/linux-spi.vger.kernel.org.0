Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9E13967AC
	for <lists+linux-spi@lfdr.de>; Mon, 31 May 2021 20:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhEaSUF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 May 2021 14:20:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59202 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhEaSUE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 May 2021 14:20:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14VII2qb078793;
        Mon, 31 May 2021 13:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622485082;
        bh=HsbRxHmzurwf7J0PNrAE7LrJRA57/L7yoP2/CM+aImU=;
        h=From:To:Subject:Date;
        b=dzscoPH5ucskoi9X8RByttDJfSEw27wj15tKxGlVyBv2jaJnBAPs+647MwhDj0fln
         bNh03cQ2X3ZTq3qxcdgE3/d0rmCLWcqz3kf0CuVESravHFlsDads3JmVKrwQuOUAOv
         nFRTvcMbBuaa/8AX2zj1SVOuIA5IgdkDbC0nQRoo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14VII2qG026763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 May 2021 13:18:02 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 13:18:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 31 May 2021 13:18:02 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14VIHwdF118543;
        Mon, 31 May 2021 13:17:59 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 0/6] Avoid odd length/address read/writes in 8D-8D-8D mode.
Date:   Mon, 31 May 2021 23:47:51 +0530
Message-ID: <20210531181757.19458-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Octal DTR flashes like Micron Xcella or Cypress S28 family, reads or
writes cannot start at an odd address in 8D-8D-8D mode. Neither can they
be odd bytes long. Upper layers like filesystems don't know what mode
the flash is in, and hence don't know the read/write address or length
limitations. They might issue reads or writes that leave the flash in an
error state. In fact, using UBIFS on top of the flash was how I first
noticed this problem.

This series fixes that problem by padding the read/write with extra
bytes to make sure the final operation has an even address and length.
More info in patches 5 and 6.

Patches 1-3 fix some existing odd-byte long reads. Patch 4 adds checks
to disallow odd length command/address/dummy/data phases in 8D-8D-8D
mode. Note that this does not restrict the _value_ of the address from
being odd since this is a restriction on the flash, not the protocol
itself.

Patch 4 should go through the SPI tree but I have included it in this
series because if it goes in before patches 1-3, Micron MT35XU and
Cypress S28HS flashes will stop working correctly.

Tested on TI J721E for Micron MT35 and on TI J7200 for Cypress S28.

Changes in v2:
Collect R-bys and cosmetic fixes. No functional changes. See the patches
for detailed changelog.

Pratyush Yadav (6):
  mtd: spi-nor: core: use 2 data bytes for template ops
  mtd: spi-nor: spansion: write 2 bytes when disabling Octal DTR mode
  mtd: spi-nor: micron-st: write 2 bytes when disabling Octal DTR mode
  spi: spi-mem: reject partial cycle transfers in 8D-8D-8D mode
  mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode
  mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode

 drivers/mtd/spi-nor/core.c      | 159 +++++++++++++++++++++++++++++++-
 drivers/mtd/spi-nor/micron-st.c |  22 ++++-
 drivers/mtd/spi-nor/spansion.c  |  18 +++-
 drivers/spi/spi-mem.c           |  12 ++-
 4 files changed, 196 insertions(+), 15 deletions(-)

-- 
2.30.0

