Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48787D1F73
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2019 06:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfJJERs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Oct 2019 00:17:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60484 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfJJERs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Oct 2019 00:17:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9A4HdLr058247;
        Wed, 9 Oct 2019 23:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570681059;
        bh=QHazZt/jJXetzG21t0LVNq/9EDjdrd1jn3eQIFdPMj0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ulTDj83CLfxyc2MSq4Dfvub2CpYK4DhyIwlMSfyKblBnHLHLXyt+yVPU1XBqXdMWq
         3tP3Gkfpt9qtSjSeNd7OOymC/F+joSkFDPER7HR/XRmGg7/vHb9Xgyv+QNfXb+/hP5
         wilSsdabjaV+qSMX2faP8CUUwuHxQjc0ZA+n2mwQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9A4Hd5j003637;
        Wed, 9 Oct 2019 23:17:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 23:17:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 23:17:35 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9A4HZJi110197;
        Wed, 9 Oct 2019 23:17:36 -0500
Subject: Re: [PATCH v1 0/2] spi: cadence-qspi: Add cadence-qspi support for
 Intel LGM SoC
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>, <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cheol.yong.kim@intel.com>,
        <qi-ming.wu@intel.com>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <c4555df5-89d5-e8a6-bed4-887c23ac4f0f@ti.com>
 <89e49834-8697-2917-d666-769969f074a4@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <21cb17ab-b272-ce35-67fc-abce56969fee@ti.com>
Date:   Thu, 10 Oct 2019 09:48:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <89e49834-8697-2917-d666-769969f074a4@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/10/19 7:04 AM, Ramuthevar, Vadivel MuruganX wrote:
> HI Vignesh,
> 
> On 17/9/2019 12:50 AM, Vignesh Raghavendra wrote:
>> Hi,
>>
>> On 16/09/19 1:08 PM, Ramuthevar,Vadivel MuruganX wrote:
>>> patch 1: Add YAML for cadence-qspi devicetree cdocumentation.
>>> patch 2: cadence-qspi controller driver to support QSPI-NAND flash
>>> using existing spi-nand framework with legacy spi protocol.
>> Nope, you cannot have two drivers for the same IP (i.e Cadence QSPI)
>> just to support to different types of SPI memories. This is the reason
>> why spi_mem_ops was introduced.
>>
>> Please rewrite this driver over to use spi_mem_ops (instead of using
>> generic SPI xfers) so that same driver supports both SPI-NOR and
>> SPI-NAND flashes. Once that's done drivers/mtd/spi-nor/cadence-quadspi.c
>> can be deleted.
>>
>> There are few existing examples of spi_mem_ops users in drivers/spi/
>> (git grep spi_mem_ops) and materials here on how to write such a driver:
>>
>> [1]
>> https://bootlin.com/blog/spi-mem-bringing-some-consistency-to-the-spi-memory-ecosystem/
>>
>> [2] https://www.youtube.com/watch?v=PkWbuLM_gmU
> As per Mark Brown and your suggestion,  I have started adapting
> cadence-qaudspi driver with spi_mem_ops framework to work
> QSPI-NAND/NOR as a generic driver(completely removed the legacy
> SPI-XFERS),  is in progress on Intel LGM SoC.
> QSPI-IP on Intel LGM  do not have DMA  support and also not part of QSPI
> IP, so couldn't able to validate DMA related.
> will adapt the DMA things which are existing in cadence-quadspi.c as it is.
> 

Great, appreciate the effort!

> currently TI and Altera SoC's use this Cadence-qspi IP , both are not
> using DMA as per my understanding (correct me if it is wrong).
> confirmed through device tree entry.
> 

TI platforms use DMA to read data from flash in memory mapped mode
(direct access controller) using mem-to-mem DMA channels. Mem-to-mem DMA
channels are requested as and when needed and are not part of DT
description (as they are not bound to a device)

> what is your opinion on DMA related stuff? 

Not having DMA support would be a regression. Please keep the DAC + DMA
part as is. I can help you will all the DMA related testing...

Regards
Vignesh

> also using macronix(QSPI-NOR)
> flash/Micron(QSPI-NAND).
> ---
> With Regards
> Vadivel
>>> Ramuthevar Vadivel Murugan (2):
>>>    dt-bindings: spi: Add support for cadence-qspi IP Intel LGM SoC
>>>    spi: cadence-qspi: Add QSPI support for Intel LGM SoC
>>>
>>>   .../devicetree/bindings/spi/cadence,qspi-nand.yaml |  84 +++
>>>   drivers/spi/Kconfig                                |   9 +
>>>   drivers/spi/Makefile                               |   1 +
>>>   drivers/spi/spi-cadence-qspi-apb.c                 | 644
>>> +++++++++++++++++++++
>>>   drivers/spi/spi-cadence-qspi-apb.h                 | 174 ++++++
>>>   drivers/spi/spi-cadence-qspi.c                     | 461
>>> +++++++++++++++
>>>   drivers/spi/spi-cadence-qspi.h                     |  73 +++
>>>   7 files changed, 1446 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
>>>   create mode 100644 drivers/spi/spi-cadence-qspi-apb.c
>>>   create mode 100644 drivers/spi/spi-cadence-qspi-apb.h
>>>   create mode 100644 drivers/spi/spi-cadence-qspi.c
>>>   create mode 100644 drivers/spi/spi-cadence-qspi.h
>>>

-- 
Regards
Vignesh
