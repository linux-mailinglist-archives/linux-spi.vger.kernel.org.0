Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C761CD1E0B
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2019 03:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbfJJBeu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Oct 2019 21:34:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:50444 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731134AbfJJBeu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Oct 2019 21:34:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 18:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="393873539"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 09 Oct 2019 18:34:48 -0700
Received: from [10.226.38.27] (unknown [10.226.38.27])
        by linux.intel.com (Postfix) with ESMTP id 9DAFF5803E4;
        Wed,  9 Oct 2019 18:34:45 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] spi: cadence-qspi: Add cadence-qspi support for
 Intel LGM SoC
To:     Vignesh Raghavendra <vigneshr@ti.com>, broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <c4555df5-89d5-e8a6-bed4-887c23ac4f0f@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <89e49834-8697-2917-d666-769969f074a4@linux.intel.com>
Date:   Thu, 10 Oct 2019 09:34:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c4555df5-89d5-e8a6-bed4-887c23ac4f0f@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

HI Vignesh,

On 17/9/2019 12:50 AM, Vignesh Raghavendra wrote:
> Hi,
>
> On 16/09/19 1:08 PM, Ramuthevar,Vadivel MuruganX wrote:
>> patch 1: Add YAML for cadence-qspi devicetree cdocumentation.
>> patch 2: cadence-qspi controller driver to support QSPI-NAND flash
>> using existing spi-nand framework with legacy spi protocol.
> Nope, you cannot have two drivers for the same IP (i.e Cadence QSPI)
> just to support to different types of SPI memories. This is the reason
> why spi_mem_ops was introduced.
>
> Please rewrite this driver over to use spi_mem_ops (instead of using
> generic SPI xfers) so that same driver supports both SPI-NOR and
> SPI-NAND flashes. Once that's done drivers/mtd/spi-nor/cadence-quadspi.c
> can be deleted.
>
> There are few existing examples of spi_mem_ops users in drivers/spi/
> (git grep spi_mem_ops) and materials here on how to write such a driver:
>
> [1]
> https://bootlin.com/blog/spi-mem-bringing-some-consistency-to-the-spi-memory-ecosystem/
> [2] https://www.youtube.com/watch?v=PkWbuLM_gmU
As per Mark Brown and your suggestion,  I have started adapting 
cadence-qaudspi driver with spi_mem_ops framework to work
QSPI-NAND/NOR as a generic driver(completely removed the legacy 
SPI-XFERS),  is in progress on Intel LGM SoC.
QSPI-IP on Intel LGM  do not have DMA  support and also not part of QSPI 
IP, so couldn't able to validate DMA related.
will adapt the DMA things which are existing in cadence-quadspi.c as it is.

currently TI and Altera SoC's use this Cadence-qspi IP , both are not 
using DMA as per my understanding (correct me if it is wrong).
confirmed through device tree entry.

what is your opinion on DMA related stuff? also using macronix(QSPI-NOR) 
flash/Micron(QSPI-NAND).
---
With Regards
Vadivel
>> Ramuthevar Vadivel Murugan (2):
>>    dt-bindings: spi: Add support for cadence-qspi IP Intel LGM SoC
>>    spi: cadence-qspi: Add QSPI support for Intel LGM SoC
>>
>>   .../devicetree/bindings/spi/cadence,qspi-nand.yaml |  84 +++
>>   drivers/spi/Kconfig                                |   9 +
>>   drivers/spi/Makefile                               |   1 +
>>   drivers/spi/spi-cadence-qspi-apb.c                 | 644 +++++++++++++++++++++
>>   drivers/spi/spi-cadence-qspi-apb.h                 | 174 ++++++
>>   drivers/spi/spi-cadence-qspi.c                     | 461 +++++++++++++++
>>   drivers/spi/spi-cadence-qspi.h                     |  73 +++
>>   7 files changed, 1446 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
>>   create mode 100644 drivers/spi/spi-cadence-qspi-apb.c
>>   create mode 100644 drivers/spi/spi-cadence-qspi-apb.h
>>   create mode 100644 drivers/spi/spi-cadence-qspi.c
>>   create mode 100644 drivers/spi/spi-cadence-qspi.h
>>
