Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2B3862CD
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2019 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfHHNPg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Aug 2019 09:15:36 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40654 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732990AbfHHNPg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Aug 2019 09:15:36 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x78DEorj024395;
        Thu, 8 Aug 2019 16:14:50 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id E4AFE628F1; Thu,  8 Aug 2019 16:14:49 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        vigneshr@ti.com, bbrezillon@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/2] spi: add NPCM FIU controller driver 
Date:   Thu,  8 Aug 2019 16:14:46 +0300
Message-Id: <20190808131448.349161-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch set adds Flash Interface Unit(FIU) SPI 
master support for the Nuvoton NPCM Baseboard 
Management Controller (BMC).

The FIU supports single, dual or quad communication interface.

the FIU controller can operate in following modes:
- User Mode Access(UMA): provides flash access by using an
  indirect address/data mechanism.
- direct rd/wr mode: maps the flash memory into the core
  address space.
- SPI-X mode: used for an expansion bus to an ASIC or CPLD.

The NPCM750/730/715/710 supports up to three FIU devices:
- FIU0 supports two chip select.
- FIU3 supports four chip select.
- FIUX supports two chip select.

The NPCM FIU driver tested on NPCM750 evaluation board. 

The FIU controller driver using direct map API SPI-MEM
interface and tested with the latest m25p80 driver patch
https://www.spinics.net/lists/linux-mtd/msg07358.html

According a conversion about direct SPI-MEM API
https://www.spinics.net/lists/linux-mtd/msg08225.html

The m25p80 driver will merge to the spi-nor driver we
need to make sure the m25p80 direct SPI-MEM will merge
as well.

The FIU controller driver tested with the latest spi-nor driver patch
https://www.spinics.net/lists/linux-mtd/msg08472.html

Changes since version 1:
 - Support spi-mem no data transferred option (SPI_MEM_NO_DATA)

Tomer Maimon (2):
  dt-binding: spi: add NPCM FIU controller
  spi: npcm-fiu: add NPCM FIU controller driver

 .../bindings/spi/nuvoton,npcm-fiu.txt         |  47 ++
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-npcm-fiu.c                    | 761 ++++++++++++++++++
 4 files changed, 819 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
 create mode 100644 drivers/spi/spi-npcm-fiu.c

-- 
2.18.0

