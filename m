Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574E146B37B
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 08:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhLGHSQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 02:18:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34396 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhLGHSP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 02:18:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B77EQD7060239;
        Tue, 7 Dec 2021 01:14:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638861266;
        bh=whcxoM1kCXnWL/iG1rx1dwf/31jfNAf7VHubgohBgmY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UxhoNauK1cK5FgrTx0EjzT1jlUCJiS6GGuU15QVm1pO5pRCIS7WaOvLx6lPuRRX5+
         QBM2h0Kd+RxSb54GjD64csJbB7483Ju9lOfkwtIipAsJxXnHmkDI3+II0U2ji6dr/1
         3v2mPC8mynLvnkr6ibo8qYEvOIF7haNsnIl9m+RM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B77EQXi009192
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 01:14:26 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 01:14:10 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 01:14:10 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B77E97J061738;
        Tue, 7 Dec 2021 01:14:09 -0600
Date:   Tue, 7 Dec 2021 12:44:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <20211207071406.c2ajc3shqybevvjj@ti.com>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
 <20211206095921.33302-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211206095921.33302-3-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/12/21 10:59AM, Miquel Raynal wrote:
> Describe two new memories modes:
> - A stacked mode when the bus is common but the address space extended
>   with an additinals wires.
> - A parallel mode with parallel busses accessing parallel flashes where
>   the data is spread.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/spi/spi-peripheral-props.yaml    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 5dd209206e88..13aa6a2374c9 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -82,6 +82,27 @@ properties:
>      description:
>        Delay, in microseconds, after a write transfer.
>  
> +  stacked-memories:
> +    type: boolean

I don't think a boolean is enough to completely describe the memory. 
Sure, you say the memories are stacked, but where do you specify when to 
switch the CS? They could be two 512 MiB memories, two 1 GiB memories, 
or one 512 MiB and one 256 MiB.

> +    description: Several SPI memories can be wired in stacked mode.
> +      This basically means that either a device features several chip
> +      selects, or that different devices must be seen as a single
> +      bigger chip. This basically doubles (or more) the total address
> +      space with only a single additional wire, while still needing
> +      to repeat the commands when crossing a chip boundary. XIP is
> +      usually not supported in this mode.
> +
> +  parallel-memories:
> +    type: boolean

With this I assume both memories have to be the same size?

> +    description: Several SPI memories can be wired in parallel mode.
> +      The devices are physically on a different buses but will always
> +      act synchronously as each data word is spread across the
> +      different memories (eg. even bits are stored in one memory, odd
> +      bits in the other). This basically doubles the address space and
> +      the throughput while greatly complexifying the wiring because as
> +      many busses as devices must be wired. XIP is usually not
> +      supported in this mode.
> +
>  # The controller specific properties go here.
>  allOf:
>    - $ref: cdns,qspi-nor-peripheral-props.yaml#
> -- 
> 2.27.0
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
