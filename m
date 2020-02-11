Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579E815900E
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 14:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgBKNeS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 08:34:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57924 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgBKNeS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Feb 2020 08:34:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01BDXqb1085585;
        Tue, 11 Feb 2020 07:33:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581428032;
        bh=qagrc5drcyyqyRVbRzDGijYxvDYbBFyarf0AzXcJ+2A=;
        h=From:To:CC:Subject:Date;
        b=sQVOwcs670HcbphfeOVngpvABQLOHFn45ldwnmTBI7mMZlRsWbsbPitDsWYci/HBJ
         51G45bcxVMxQx0Q+7vngaIwLGNaebtQat0mfr3M8FEo38aArINvdK7JGt/GuU4MPD1
         4eTUhGD+vaha5zSSnCD8JPCxiEYYZFiyi1SoCDnU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01BDXqtS069874
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 07:33:52 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 11
 Feb 2020 07:33:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 11 Feb 2020 07:33:52 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01BDXm5H087522;
        Tue, 11 Feb 2020 07:33:49 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 0/9] mtd: spi-nor: add xSPI Octal DTR support
Date:   Tue, 11 Feb 2020 19:03:39 +0530
Message-ID: <20200211133348.15558-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series adds support for octal DTR flashes in the spi-nor framework,
and then adds hooks for the Cypress Semper flash which is an xSPI
compliant Octal DTR flash.

The Cadence QSPI controller driver is also updated to run in Octal DTR
mode.

Tested on TI J721e EVM with 1-bit ECC on the Cypress flash.

This series depends on [0].

[0] https://patchwork.kernel.org/patch/11355593/

Pratyush Yadav (9):
  spi: spi-mem: allow specifying whether an op is DTR or not
  spi: spi-mem: allow specifying a command's extension
  spi: cadence-quadspi: Add support for octal DTR flashes
  mtd: spi-nor: add support for DTR protocol
  mtd: spi-nor: get command opcode extension type from BFPT
  mtd: spi-nor: parse xSPI Profile 1.0 table
  mtd: spi-nor: use dummy cycle and address width info from SFDP
  mtd: spi-nor: enable octal DTR mode when possible
  mtd: spi-nor: add support for Cypress Semper flash

 drivers/mtd/spi-nor/spi-nor.c     | 595 +++++++++++++++++++++++++++---
 drivers/spi/spi-cadence-quadspi.c | 262 +++++++++++--
 drivers/spi/spi-mem.c             |  48 +++
 include/linux/mtd/spi-nor.h       |  55 ++-
 include/linux/spi/spi-mem.h       |  32 ++
 include/linux/spi/spi.h           |   2 +
 6 files changed, 890 insertions(+), 104 deletions(-)

--
2.25.0

