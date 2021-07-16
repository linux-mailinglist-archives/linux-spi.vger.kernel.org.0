Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21533CBFAB
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jul 2021 01:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhGPX2G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 19:28:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34282 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhGPX2G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 19:28:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16GNPA7o103012;
        Fri, 16 Jul 2021 18:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626477910;
        bh=Sz71TgTRbAsFaM35xFEf7pMHUbELJxqkH1ImffyDzW0=;
        h=From:To:CC:Subject:Date;
        b=r9e5+BL7z7yFnU2gllupZnv30rnKWEmYa4zMY7wYhOLjU9EEVfBb/dxnBSIWEkv4y
         i7sZER0071y9MHR1yzuxmuJJEgqbIRiJJ+n3xyCqfzt9FVKr2x7HwR32JRfZGFgov3
         hcadRiveqMZsw0is8cNh3kuqoumF3NQl0hx6nSQk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16GNPADw069050
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jul 2021 18:25:10 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 18:25:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Jul 2021 18:25:09 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16GNP5S7105596;
        Fri, 16 Jul 2021 18:25:06 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 0/2] spi: cadence-quadspi: Fix DTR op checks and timeout in SPI NAND write operations
Date:   Fri, 16 Jul 2021 23:25:01 +0000
Message-ID: <20210716232504.182-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,
This series proposes fixes for cadence-quadspi controller for the
following issues with SPI NAND flashes:

- Due to auto-HW polling without address phase, the cadence-quadspi
  controller timeouts when performing any write operation on SPI NAND
  flash.

- When checking for DTR spi_mem_op, cadence-quadspi doesn't ignore a
  zero length phase in the SPI instruction, resulting in false negatives.

This series has been tested on TI J721e EVM with the Winbond W35N01JW
flash.

v1 series: https://lore.kernel.org/linux-spi/20210713125743.1540-1-a-nandan@ti.com/

Changes in v2:
- [PATCH v2 1/2]: Same as v1. This patch has been already applied to
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
  commit 9cb2ff111712 ("spi: cadence-quadspi: Disable Auto-HW polling")

- [PATCH v2 2/2]: Add new comments to explain the DTR check conditions

Apurva Nandan (2):
  spi: cadence-quadspi: Disable Auto-HW polling
  spi: cadence-quadspi: Fix check condition for DTR ops

 drivers/spi/spi-cadence-quadspi.c | 48 ++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 16 deletions(-)

-- 
2.17.1

