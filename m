Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC91A375B91
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 21:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhEFTTs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 15:19:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54826 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbhEFTTs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 15:19:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 146JIYdC080646;
        Thu, 6 May 2021 14:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620328714;
        bh=1wiZrWzcyNZj6lpRovJTnOwElMwQbWA/q/MvRyb+uZM=;
        h=From:To:CC:Subject:Date;
        b=TWfZf4q6lTgL/3z5HO3tshxouBbFYdaawlN1EuvFHy/O0FmvT46SoPQQ5VlSq3ZPn
         zMXTGKIVmbviL/8gaZd4jXzNWDCtC3FYt5AGTYDVIjqNQjbYKbzZUy/cqG75eeghGS
         6cpubmwf3dpVnjSRs/t/33j7p51PMUsIZt+XWUyE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 146JIYGX016536
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 May 2021 14:18:34 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 6 May
 2021 14:18:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 6 May 2021 14:18:34 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 146JIUNC026052;
        Thu, 6 May 2021 14:18:31 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 0/6] Avoid odd length/address read/writes in 8D-8D-8D mode.
Date:   Fri, 7 May 2021 00:48:23 +0530
Message-ID: <20210506191829.8271-1-p.yadav@ti.com>
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


Pratyush Yadav (6):
  mtd: spi-nor: core: use 2 data bytes for template ops
  mtd: spi-nor: spansion: write 2 bytes when disabling Octal DTR mode
  mtd: spi-nor: micron-st: write 2 bytes when disabling Octal DTR mode
  spi: spi-mem: reject partial cycle transfers in 8D-8D-8D mode
  mtd: spi-nor: core; avoid odd length/address reads on 8D-8D-8D mode
  mtd: spi-nor: core; avoid odd length/address writes in 8D-8D-8D mode

 drivers/mtd/spi-nor/core.c      | 157 +++++++++++++++++++++++++++++++-
 drivers/mtd/spi-nor/micron-st.c |  22 ++++-
 drivers/mtd/spi-nor/spansion.c  |  18 +++-
 drivers/spi/spi-mem.c           |  12 ++-
 4 files changed, 194 insertions(+), 15 deletions(-)

-- 
2.30.0

