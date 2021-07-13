Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F4E3C70C5
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhGMNAk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:00:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41320 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbhGMNAj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:00:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DCvmuZ006781;
        Tue, 13 Jul 2021 07:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181068;
        bh=1ZZ9zjal5f/2Vjv3oKPjd86SEpDc740fHxWVRQS+DvE=;
        h=From:To:CC:Subject:Date;
        b=KPi74tjEqNBFtdZfMaWl/q/rjzqW8bF1jl0Z63CD8SHQtYkMjdgLH3m3stQPBr9en
         6A7rZikBpI6s40NDKfmRlNljgIlGnGSGsVEYx2YGiMFItyhIPiinHOyFkAEmHRBIrp
         WZz68NngnQtMyG3vcWsr5x7M67fEk6wpZvWe6AQU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DCvmU3121170
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 07:57:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 07:57:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 07:57:47 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DCvh0V067892;
        Tue, 13 Jul 2021 07:57:44 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/2] spi: cadence-quadspi: Fix DTR op checks and timeout in SPI NAND write operations
Date:   Tue, 13 Jul 2021 12:57:40 +0000
Message-ID: <20210713125743.1540-1-a-nandan@ti.com>
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

Apurva Nandan (2):
  spi: cadence-quadspi: Disable Auto-HW polling
  spi: cadence-quadspi: Fix check condition for DTR ops

 drivers/spi/spi-cadence-quadspi.c | 39 ++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 16 deletions(-)

-- 
2.17.1

