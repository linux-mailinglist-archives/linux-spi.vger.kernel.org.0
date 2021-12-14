Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD01474C34
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 20:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhLNTpD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 14:45:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35436 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhLNTpC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 14:45:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BEJiZOt066021;
        Tue, 14 Dec 2021 13:44:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639511075;
        bh=QbwF9PvySlAZfWMCGJJbnCKtJrdFlG0AGV6tD/F+cHs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gpfPvF7NS0zI8sji9Wk7g2XGGb/wDoV6YEAgZTnDnYx/IbhdqcuG9gpPFZrVdZfBL
         xf/7+MWFJfmqvrlUcWHtgKsTxTJoJgP5/AL8SLj3GbbB32L3jY8yMyfIaxZRI9O0sM
         J2H8t65E8CThk6qO3LZ1di76C/FZcKFBxhHEHysU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BEJiZr1102883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Dec 2021 13:44:35 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Dec 2021 13:44:34 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Dec 2021 13:44:34 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BEJiYQh083577;
        Tue, 14 Dec 2021 13:44:34 -0600
Date:   Wed, 15 Dec 2021 01:14:33 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <20211214194431.4kpwfgvju6msh5d4@ti.com>
References: <20211210201039.729961-1-miquel.raynal@bootlin.com>
 <20211210201039.729961-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211210201039.729961-3-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel,

On 10/12/21 09:10PM, Miquel Raynal wrote:
> Describe two new memories modes:
> - A stacked mode when the bus is common but the address space extended
>   with an additinals wires.
> - A parallel mode with parallel busses accessing parallel flashes where
>   the data is spread.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/spi/spi-peripheral-props.yaml    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 5dd209206e88..4194fee8f556 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -82,6 +82,35 @@ properties:
>      description:
>        Delay, in microseconds, after a write transfer.
>  
> +  stacked-memories:
> +    $ref: /schemas/types.yaml#/definitions/uint64-matrix

Why matrix? Can't you use array here? Sorry, I am not much familiar with 
JSON schema.

> +    description: Several SPI memories can be wired in stacked mode.
> +      This basically means that either a device features several chip
> +      selects, or that different devices must be seen as a single
> +      bigger chip. This basically doubles (or more) the total address
> +      space with only a single additional wire, while still needing
> +      to repeat the commands when crossing a chip boundary. The size of
> +      each chip should be provided as members of the array.
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      maxItems: 1

Thanks. This looks better to me.

But before we go ahead, I think there has been some confusion around 
what exactly your patches intend to support. Let's clear them up first. 
What type of setup do you want to support?

  1. One single flash but with multiple dies, with each die sitting on a 
     different CS.
  2. Two (or more) identical but independent flash memories to be 
     treated as one.
  3. Two (or more) different and independent flash memories to be 
     treated as one.

In our earlier exchanges you said you want to support 2. And when I 
wanted you to account for 3 as well you said we should use mtdconcat for 
that. So my question is, why can't we use mtdconcat for 2 as well, since 
it is just a special case of 3? And if we are using mtdconcat, then why 
do we need this at all? Shouldn't you then choose the chip at MTD layer 
and use the respective SPI device to get the CS value, which would make 
this property useless?

I can see this making sense for case 1. For that case you said you don't 
have an existing datasheet or device to propose. And if there is no real 
device doing it I see little point in figuring out a binding for it.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
