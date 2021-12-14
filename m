Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5325A474974
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 18:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhLNRdB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 12:33:01 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:35622 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhLNRc7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 12:32:59 -0500
Received: by mail-oi1-f171.google.com with SMTP id m6so28132359oim.2;
        Tue, 14 Dec 2021 09:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rvxtIzimXcRFfXqGjLWdjv+5BSddZaMd3oDAYyxaZ+g=;
        b=BNCoFkIBF/qVJ6VZ4a8T3Zp8DRYi98KAcbXNjkRhsi/DxghJR7ryLAuUJ8O36PpKRZ
         JC1Z28QSDdyfTIGBFXn1q/AkDs+tHUChsgN3ngaiCO5VJQ9jrecre2dWDM6ezx+nk4Q+
         WOErSXoxS0xB3Ayr5gG6RegVNwrD6Re9in7TCOUxokhuZz6GKU28zuoRfxcmPrUfE8gR
         RQN0HW/U9gGgmfJaZPzEp0wrkHKc5fzyL61WRJMc/h6BvR4TVhx92Sw2gJb6iPqPsoEX
         b4aNz5TM62i6DVEmaR7wqOBkLwOvEY9NvUWiiCunR0NOFPlghdHlU07FVueDuH/jLJA+
         Q5cg==
X-Gm-Message-State: AOAM530WSAqgaKucsZ76Uf7Cbb/A8QN64FH8IiERFYPSAh7AoY4Thk+g
        Kk3VIYFDikEm3KilRl3o0w==
X-Google-Smtp-Source: ABdhPJwQp4AZp2XOUAaV2qtbp/48O9D/BKWTdzem70zoKVJJucdUhKwJfN/sJ+DOanODQduj+8PsAg==
X-Received: by 2002:a05:6808:2187:: with SMTP id be7mr35137900oib.97.1639503178303;
        Tue, 14 Dec 2021 09:32:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i16sm92679oig.15.2021.12.14.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:32:57 -0800 (PST)
Received: (nullmailer pid 3597381 invoked by uid 1000);
        Tue, 14 Dec 2021 17:32:56 -0000
Date:   Tue, 14 Dec 2021 11:32:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <YbjVSNAC8M5Y1nHp@robh.at.kernel.org>
References: <20211210201039.729961-1-miquel.raynal@bootlin.com>
 <20211210201039.729961-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210201039.729961-3-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:10:38PM +0100, Miquel Raynal wrote:
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

matrix or...

> +    description: Several SPI memories can be wired in stacked mode.
> +      This basically means that either a device features several chip
> +      selects, or that different devices must be seen as a single
> +      bigger chip. This basically doubles (or more) the total address
> +      space with only a single additional wire, while still needing
> +      to repeat the commands when crossing a chip boundary. The size of
> +      each chip should be provided as members of the array.

array?

Sounds like an array from the description as there is only 1 element, 
the size.

> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      maxItems: 1

This says you can only have 2 64-bit entries. Probably not what you 
want. This looks like a case for a maxItems 'should be enough for now' 
type of value.

> +
> +  parallel-memories:
> +    $ref: /schemas/types.yaml#/definitions/uint64-matrix
> +    description: Several SPI memories can be wired in parallel mode.
> +      The devices are physically on a different buses but will always
> +      act synchronously as each data word is spread across the
> +      different memories (eg. even bits are stored in one memory, odd
> +      bits in the other). This basically doubles the address space and
> +      the throughput while greatly complexifying the wiring because as
> +      many busses as devices must be wired. The size of each chip should
> +      be provided as members of the array.
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      maxItems: 1
> +
>  # The controller specific properties go here.
>  allOf:
>    - $ref: cdns,qspi-nor-peripheral-props.yaml#
> -- 
> 2.27.0
> 
> 
