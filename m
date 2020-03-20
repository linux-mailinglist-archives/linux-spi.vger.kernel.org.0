Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE6B18C75F
	for <lists+linux-spi@lfdr.de>; Fri, 20 Mar 2020 07:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCTGTq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Mar 2020 02:19:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:48078 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgCTGTp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Mar 2020 02:19:45 -0400
IronPort-SDR: rWBzyDUYlohINPA9rbMjTcR2ZklqNVEIvYWmbMekHcyQ+N3Lv+0pK5XDeYQNr8/oSw9nP7xIBZ
 fXMkdWeeLTLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 23:19:45 -0700
IronPort-SDR: Rki1mw11JqeNDFWHxo4Zf/8q35aPR2PshLEnA5kL3XoJiC45euiZkKKZv93+S/dNZ45BJlof8c
 P6N/1746zoWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,283,1580803200"; 
   d="scan'208";a="280330807"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2020 23:19:44 -0700
Received: from [10.215.171.97] (unknown [10.215.171.97])
        by linux.intel.com (Postfix) with ESMTP id A3196580297;
        Thu, 19 Mar 2020 23:19:38 -0700 (PDT)
Subject: Re: [PATCH v12 1/4] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, boris.brezillon@free-electrons.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        tien.fong.chee@intel.com, marex@denx.de,
        linux-mtd@lists.infradead.org, dwmw2@infradead.org, richard@nod.at,
        computersforpeace@gmail.com, cyrille.pitchen@atmel.com,
        david.oberhollenzer@sigma-star.at, miquel.raynal@bootlin.com,
        tudor.ambarus@gmail.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200310015213.1734-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <c2ad909e-9042-6ba0-7213-83346c6b9908@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <13a92ddd-b7dd-0465-d747-cda9bca21dbf@linux.intel.com>
Date:   Fri, 20 Mar 2020 14:19:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c2ad909e-9042-6ba0-7213-83346c6b9908@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 20/3/2020 2:05 pm, Vignesh Raghavendra wrote:
>
> On 10/03/20 7:22 am, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add dt-bindings documentation for Cadence-QSPI controller to support
>> spi based flash memories.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 -----------
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 127 +++++++++++++++++++++
>>   2 files changed, 127 insertions(+), 67 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>>   create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>
> [...]
>
>> +
>> +# subnode's properties
>> +patternProperties:
>> +  "^.*@[0-9a-fA-F]+$":
>> +    type: object
>> +    description:
>> +      flash device uses the subnodes below defined properties.
>> +
>> +  cdns,read-delay:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Delay in 4 microseconds, read capture logic, in clock cycles.
>
> Not its not... See the old binding description please:
>
> -- cdns,read-delay : Delay for read capture logic, in clock cycles
>
> There is no mention of 4us. Range is 0x0 - 0xF
Sure, will update as you have suggested.
>> +
>> +  cdns,tshsl-ns:
>> +    description: |
>> +      Delay in 50 nanoseconds, for the length that the master mode chip select
>> +      outputs are de-asserted between transactions.
> Again see the description in old binding file:
>
>   cdns,tshsl-ns : Delay in nanoseconds for the length that the master
>                    mode chip select outputs are de-asserted between
> 	  	transactions.
>
> Need not be 50ns or its multiple
Sure, will update as you have suggested.
>> +
>> +  cdns,tsd2d-ns:
>> +    description: |
>> +      Delay in 50 nanoseconds, between one chip select being de-activated
>> +      and the activation of another.
>> +
> same here
>
>> +  cdns,tchsh-ns:
>> +    description: |
>> +      Delay in 4 nanoseconds, between last bit of current transaction and
>> +      deasserting the device chip select (qspi_n_ss_out).
>> +
> Same here... Need not be 4ns...
>
>> +  cdns,tslch-ns:
>> +    description: |
>> +      Delay in 4 nanoseconds, between setting qspi_n_ss_out low and
>> +      first bit transfer.
>
> Same here...
>
> Above four values ( cdns,*-ns) come directly from the flash datasheets.
>
> These values are converted appropriate number of cycles depending upon
> the QSPI ref_clk frequency. So, there is no easy way to express the
> constraint (or range) in DT schema. I would recommend to just stick with
> the description that is there in the old binding file without any
> modifications.

Noted, will update.

Regards
Vadivel
>
> Regards
> Vignesh
