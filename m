Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF45449B66
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 19:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhKHSJF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 13:09:05 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:45910 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhKHSJD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Nov 2021 13:09:03 -0500
Received: by mail-oi1-f172.google.com with SMTP id u2so28858775oiu.12;
        Mon, 08 Nov 2021 10:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9lnLXG/bXbyXQGlWv3MhH5r9wnv2o0rdiMQr4B9gclY=;
        b=YdhIpeDLbuD9LQPWWhnIvcygLaYWzLKjcQV29Wv0lXavz+of0znbbXurUAnkYPVc26
         p8HpQppa0k3OZAndCWkpH1OZUl2JG8BmMUp0vNXQI567zYqIYkYLE/PXjzFB/1mPLlkL
         83hXZBXAlmQhBl2H1LikqoPVP4CEtTmH6E9CBB8X3CaAoncSHv/Ufc8H2Wwnask4ODiu
         JmQqRvsR+BFA71HVqtc4b+JZzs57zuNZMgI+stINK7KTjjuI6E8kFsyWx7cMZTpnOfND
         ROMal547PVcoJ48TgCbcdwtkClEPz8jlMbQ9Jb5oSWQecz73vXRFPJhnbQnUQf81KjAj
         yVXQ==
X-Gm-Message-State: AOAM531EwT46DbN2QJ75rP7fvHtP0YtABvLEaMHyuGiekZph7tqwvtNP
        79oays5eC0feOEgLwc38EQ==
X-Google-Smtp-Source: ABdhPJzGI4wzpRGugqgY8wFxgZUkbFlkvY8GaiFS4N4OxbYx7GtY1iRnLPxthCXtA/6sNluFcaXltA==
X-Received: by 2002:a54:4486:: with SMTP id v6mr186399oiv.90.1636394778826;
        Mon, 08 Nov 2021 10:06:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g15sm6378935oiy.8.2021.11.08.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:06:18 -0800 (PST)
Received: (nullmailer pid 3947047 invoked by uid 1000);
        Mon, 08 Nov 2021 18:06:17 -0000
Date:   Mon, 8 Nov 2021 12:06:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: dt-bindings: cdns,qspi-nor: Move
 slave-specific properties out
Message-ID: <YYlnGfTw42nmg3sl@robh.at.kernel.org>
References: <20211028124518.17370-1-p.yadav@ti.com>
 <20211028124518.17370-3-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028124518.17370-3-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 28, 2021 at 06:15:17PM +0530, Pratyush Yadav wrote:
> The spi-slave-props.yaml schema contains slave-specific properties
> for SPI controllers that should be present in the slave node. Move
> slave-specific properties to a separate file and refer to it in
> spi-slave-props.yaml.

Other than s/slave/peripheral/, LGTM.

> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v2:
> - New in v2.
> 
>  .../spi/cdns,qspi-nor-slave-props.yaml        | 42 +++++++++++++++++++
>  .../bindings/spi/cdns,qspi-nor.yaml           | 33 ---------------
>  .../bindings/spi/spi-slave-props.yaml         |  2 +
>  3 files changed, 44 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor-slave-props.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-slave-props.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-slave-props.yaml
> new file mode 100644
> index 000000000000..263382a5729a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-slave-props.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/cdns,qspi-nor-slave-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Slave-specific properties for the Cadence QSPI controller.
> +
> +description:
> +  See spi-slave-props.yaml for more info.
> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +properties:
> +  # cdns,qspi-nor.yaml
> +  cdns,read-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Delay for read capture logic, in clock cycles.
> +
> +  cdns,tshsl-ns:
> +    description:
> +      Delay in nanoseconds for the length that the master mode chip select
> +      outputs are de-asserted between transactions.
> +
> +  cdns,tsd2d-ns:
> +    description:
> +      Delay in nanoseconds between one chip select being de-activated
> +      and the activation of another.
> +
> +  cdns,tchsh-ns:
> +    description:
> +      Delay in nanoseconds between last bit of current transaction and
> +      deasserting the device chip select (qspi_n_ss_out).
> +
> +  cdns,tslch-ns:
> +    description:
> +      Delay in nanoseconds between setting qspi_n_ss_out low and
> +      first bit transfer.
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index ca155abbda7a..a439e3ed753f 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -86,39 +86,6 @@ properties:
>      items:
>        enum: [ qspi, qspi-ocp ]
>  
> -# subnode's properties
> -patternProperties:
> -  "@[0-9a-f]+$":
> -    type: object
> -    description:
> -      Flash device uses the below defined properties in the subnode.
> -
> -    properties:
> -      cdns,read-delay:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description:
> -          Delay for read capture logic, in clock cycles.
> -
> -      cdns,tshsl-ns:
> -        description:
> -          Delay in nanoseconds for the length that the master mode chip select
> -          outputs are de-asserted between transactions.
> -
> -      cdns,tsd2d-ns:
> -        description:
> -          Delay in nanoseconds between one chip select being de-activated
> -          and the activation of another.
> -
> -      cdns,tchsh-ns:
> -        description:
> -          Delay in nanoseconds between last bit of current transaction and
> -          deasserting the device chip select (qspi_n_ss_out).
> -
> -      cdns,tslch-ns:
> -        description:
> -          Delay in nanoseconds between setting qspi_n_ss_out low and
> -          first bit transfer.
> -
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/spi/spi-slave-props.yaml b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> index 5166ec9b0353..4cc12a161da9 100644
> --- a/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> @@ -87,5 +87,7 @@ properties:
>        Delay, in microseconds, after a write transfer.
>  
>  # The controller specific properties go here.
> +allOf:
> +  - $ref: cdns,qspi-nor-slave-props.yaml#
>  
>  additionalProperties: true
> -- 
> 2.33.1.835.ge9e5ba39a7
> 
> 
