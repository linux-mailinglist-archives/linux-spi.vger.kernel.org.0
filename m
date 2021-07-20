Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC83CFFCA
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jul 2021 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGTQNd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Jul 2021 12:13:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33150 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhGTQNV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Jul 2021 12:13:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16KGrdTq019628;
        Tue, 20 Jul 2021 11:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626800019;
        bh=TaK7R0mjL5/VT6dRFfVDZ/pEHiudlKEld0G5KlWnQpQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CePaMeb07/3Pp4cD+wPZvikEZyTFfkTwlQAAV5KfEA3ZdvuDpZeKuQoDoOmc+5TCA
         VFWPvmMdStLbcJBnLp+/xEKBrq0d0Tfuje/ytHhxhIsqQZ7vto8nnyKX/Mm3rXH133
         uK5QM0MGSjxDluYSkKypPxhyxyVr21nmjEsQeJlw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16KGrdNT068883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 11:53:39 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 11:53:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 11:53:39 -0500
Received: from [10.250.234.142] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16KGrYBT028752;
        Tue, 20 Jul 2021 11:53:35 -0500
Subject: Re: [PATCH 00/13] mtd: spinand: Add Octal DTR SPI (8D-8D-8D) mode
 support
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
From:   "Nandan, Apurva" <a-nandan@ti.com>
Message-ID: <b10bbb90-2bc6-90dd-f82a-a2c62b5dfa99@ti.com>
Date:   Tue, 20 Jul 2021 22:23:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210713130538.646-1-a-nandan@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 13-Jul-21 6:35 PM, Apurva Nandan wrote:
> Hi,
> This series proposes patches for adding the following functionality
> in SPI NAND core:
> 
> - Octal DTR SPI (8D-8D-8D) mode support
> 
> - Winbond W35N01JW SPI NAND chip support
> 
> - Power-on-Reset instruction support
> 
> This series has been tested on TI J721e EVM with the Winbond W35N01JW
> flash with following test utilities:
> 
> - nandtest
>   Test log: https://textbin.net/raw/fhypoz63f9
> 
> - mtd_stresstest
>   Test log: https://textbin.net/raw/0xqjmqntj7
> 
> - UBIFS LTP stress test (NAND_XL_STRESS_DD_RW_UBIFS).
>   Test log: https://textbin.net/raw/pyokws7wku
> 
> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> 
> Apurva Nandan (13):
>   spi: spi-mem: Add DTR templates for cmd, address, dummy and data phase
>   mtd: spinand: Add enum spinand_proto to indicate current SPI IO mode
>   mtd: spinand: Setup spi_mem_op for the SPI IO protocol using reg_proto
>   mtd: spinand: Fix odd byte addr and data phase in read/write reg op
>     and write VCR op for Octal DTR mode
>   mtd: spinand: Add adjust_op() in manufacturer_ops to modify the ops
>     for manufacturer specific changes
>   mtd: spinand: Add macros for Octal DTR page read and write operations
>   mtd: spinand: Allow enabling Octal DTR mode in the core
>   mtd: spinand: Reject 8D-8D-8D op_templates if octal_dtr_enale() is
>     missing in manufacturer_op
>   mtd: spinand: Add support for write volatile configuration register op
>   mtd: spinand: Add octal_dtr_enable() for Winbond manufacturer_ops
>   mtd: spinand: Add support for Power-on-Reset (PoR) instruction
>   mtd: spinand: Perform Power-on-Reset when runtime_pm suspend is issued
>   mtd: spinand: Add support for Winbond W35N01JW SPI NAND flash
> 
>  drivers/mtd/nand/spi/core.c    | 196 +++++++++++++++++++++++++++++++--
>  drivers/mtd/nand/spi/winbond.c | 186 +++++++++++++++++++++++++++++--
>  include/linux/mtd/spinand.h    |  67 +++++++++++
>  include/linux/spi/spi-mem.h    |  87 ++++++++++-----
>  4 files changed, 494 insertions(+), 42 deletions(-)
> 

Hi,
Can anyone please provide some comments/suggestions/reviews?

Thanks,
Apurva Nandan
