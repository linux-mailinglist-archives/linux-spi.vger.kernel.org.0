Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF36318C753
	for <lists+linux-spi@lfdr.de>; Fri, 20 Mar 2020 07:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgCTGGr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Mar 2020 02:06:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48604 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTGGr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Mar 2020 02:06:47 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02K667HF013962;
        Fri, 20 Mar 2020 01:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584684367;
        bh=54+jme14f9l+F5m+jvtM+/CK152iu0QJDNvmuwSkKso=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dF0p6Szc2W4e1lfCb0KUwKB5d934NjsUCmhvtLSgw3fGFK78HNvmwRI9UneGh7grT
         L/+MFnIw4JRXSgnGwaWBq4eqRlrnNFAT5GHTlXyWVPPYVwoMR499A8VY3GbMrWIg/H
         7odLbJCtgHV8ri0MfbVTUaaeCO0QJdwvUqD3xOpg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02K666rY003898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Mar 2020 01:06:06 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 01:06:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 01:06:06 -0500
Received: from [10.250.132.43] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02K65wsQ029497;
        Fri, 20 Mar 2020 01:05:59 -0500
Subject: Re: [PATCH v12 1/4] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <boris.brezillon@free-electrons.com>,
        <simon.k.r.goldschmidt@gmail.com>, <dinguyen@kernel.org>,
        <tien.fong.chee@intel.com>, <marex@denx.de>,
        <linux-mtd@lists.infradead.org>, <dwmw2@infradead.org>,
        <richard@nod.at>, <computersforpeace@gmail.com>,
        <cyrille.pitchen@atmel.com>, <david.oberhollenzer@sigma-star.at>,
        <miquel.raynal@bootlin.com>, <tudor.ambarus@gmail.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200310015213.1734-2-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c2ad909e-9042-6ba0-7213-83346c6b9908@ti.com>
Date:   Fri, 20 Mar 2020 11:35:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310015213.1734-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/03/20 7:22 am, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add dt-bindings documentation for Cadence-QSPI controller to support
> spi based flash memories.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 -----------
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 127 +++++++++++++++++++++
>  2 files changed, 127 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> 
[...]

> +
> +# subnode's properties
> +patternProperties:
> +  "^.*@[0-9a-fA-F]+$":
> +    type: object
> +    description:
> +      flash device uses the subnodes below defined properties.
> +
> +  cdns,read-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Delay in 4 microseconds, read capture logic, in clock cycles.


Not its not... See the old binding description please:

-- cdns,read-delay : Delay for read capture logic, in clock cycles

There is no mention of 4us. Range is 0x0 - 0xF

> +
> +  cdns,tshsl-ns:
> +    description: |
> +      Delay in 50 nanoseconds, for the length that the master mode chip select
> +      outputs are de-asserted between transactions.

Again see the description in old binding file:

 cdns,tshsl-ns : Delay in nanoseconds for the length that the master
                  mode chip select outputs are de-asserted between
	  	transactions.

Need not be 50ns or its multiple

> +
> +  cdns,tsd2d-ns:
> +    description: |
> +      Delay in 50 nanoseconds, between one chip select being de-activated
> +      and the activation of another.
> +

same here

> +  cdns,tchsh-ns:
> +    description: |
> +      Delay in 4 nanoseconds, between last bit of current transaction and
> +      deasserting the device chip select (qspi_n_ss_out).
> +

Same here... Need not be 4ns...

> +  cdns,tslch-ns:
> +    description: |
> +      Delay in 4 nanoseconds, between setting qspi_n_ss_out low and
> +      first bit transfer.


Same here...

Above four values ( cdns,*-ns) come directly from the flash datasheets.

These values are converted appropriate number of cycles depending upon
the QSPI ref_clk frequency. So, there is no easy way to express the
constraint (or range) in DT schema. I would recommend to just stick with
the description that is there in the old binding file without any
modifications.

Regards
Vignesh
