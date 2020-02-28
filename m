Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126E1172FAD
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 05:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgB1ELX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 23:11:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:56670 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbgB1ELX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Feb 2020 23:11:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 20:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="272497840"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 27 Feb 2020 20:11:20 -0800
Received: from [10.226.38.23] (unknown [10.226.38.23])
        by linux.intel.com (Postfix) with ESMTP id 77C5558052E;
        Thu, 27 Feb 2020 20:11:11 -0800 (PST)
Subject: Re: [PATCH v11 2/2] spi: cadence-quadspi: Add support for the Cadence
 QSPI controller
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        marex@denx.de, devicetree@vger.kernel.org,
        tien.fong.chee@intel.com, tudor.ambarus@gmail.com,
        boris.brezillon@free-electrons.com, richard@nod.at,
        qi-ming.wu@intel.com, simon.k.r.goldschmidt@gmail.com,
        david.oberhollenzer@sigma-star.at, dinguyen@kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        cheol.yong.kim@intel.com, mark.rutland@arm.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        cyrille.pitchen@atmel.com
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227062708.21544-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227183032.77ef0795@collabora.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <f82e4964-f030-9aac-5895-a715921ed6db@linux.intel.com>
Date:   Fri, 28 Feb 2020 12:11:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200227183032.77ef0795@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

      Thank you so much for the review comments...

On 28/2/2020 1:30 AM, Boris Brezillon wrote:
> On Thu, 27 Feb 2020 14:27:08 +0800
> "Ramuthevar, Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for the Cadence QSPI controller. This controller is
>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>> This driver has been tested on the Intel LGM SoCs.
>>
>> This driver does not support generic SPI and also the implementation
>> only supports spi-mem interface to replace the existing driver in
>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
>> flash memory
> Is it really supporting SPI NORs only, or is it just that you only
> tested it with a spi-nor?

The existing drivers/mtd/spi-nor/cadence-quadspi.c supports SPI-NORs 
only, because the driver is developed

such a way that it does not support other SPI based flash memories, also 
never uses SPI/SPI-MEM based framework.

So we Vignesh suggested me to  develop the new driver which supports 
both SPI-NOR and SPI-NAND based on the SPI-MEM framework.

>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by? What has been reported?
Sure, will remove it.
>
>> ---
>>   drivers/mtd/spi-nor/Kconfig                        |  11 -
>>   drivers/mtd/spi-nor/Makefile                       |   1 -
>>   drivers/spi/Kconfig                                |  10 +
>>   drivers/spi/Makefile                               |   1 +
>>   .../spi-cadence-quadspi.c}                         | 641 ++++++++++-----------
> Looks like this could be split in several patches to ease the review:
>
> 1/ convert to spi-mem
> 2/ move the driver to drivers/spi
> 3/ add support for intel,lgm-qspi
>
> other than that, that's good to see one more spi-nor controller driver
> converted to spi-mem.

Agreed!, will split as per your suggestions.

Regards
Vadivel
>
