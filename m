Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4A449B5E
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 19:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhKHSHm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 13:07:42 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45022 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhKHSHm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Nov 2021 13:07:42 -0500
Received: by mail-ot1-f50.google.com with SMTP id g25-20020a9d5f99000000b0055af3d227e8so22437953oti.11;
        Mon, 08 Nov 2021 10:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IT0TOfNZrid+OKcl6kTolpGzJd7YUTS6ItseMSTHwM8=;
        b=YzcrQyDwJVmvULzQwxpAGuE4a0SOuee9xSppP/oUcw+6h/ZXLfO/XdVpEQk+BAt/vh
         qTBn9W5m2fDOTpmj/GckC+WYwtYcsA5PYoKQ2a0/2yhYEmD/uF0v5tMrNALkC979A1sl
         vImAG0eCnslNAYeLDxj1N6f4QXSh+EcSqd//tBeRaY9v9NAluzB6JgJoy6VEp5Y4C2aA
         4tRQBgWa6C7oA3tJh2nO5PY7pE0cn7uWMvedxdV7xwYWu5ZeLjKH5anwEkULFwugRqDA
         9chGu7izzfnKxcK5Y+Af2eUPplFHQ+u0al4/hP6kjG7sAMjqaMyRUbzbMu94nsoNBvtL
         hcHw==
X-Gm-Message-State: AOAM533MiCFOLN89Xgh8f2l+0lKX9dfsHR6kk0AwW1SFoMPUVxZGo0Uc
        aetHfjok9DQdqbkJk8Jm2Q==
X-Google-Smtp-Source: ABdhPJztta6Ve9cS47MO7ZL8lvI5qZYy/tl71CB5N4gC8Xn634NSaq/6AGkg8468MAweL7jBaDfVIQ==
X-Received: by 2002:a05:6830:14d9:: with SMTP id t25mr759237otq.69.1636394697386;
        Mon, 08 Nov 2021 10:04:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v66sm6303793oib.18.2021.11.08.10.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:04:56 -0800 (PST)
Received: (nullmailer pid 3938772 invoked by uid 1000);
        Mon, 08 Nov 2021 18:04:55 -0000
Date:   Mon, 8 Nov 2021 12:04:55 -0600
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
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: add schema listing
 slave-specific properties
Message-ID: <YYlmx3QyI9zxuO9N@robh.at.kernel.org>
References: <20211028124518.17370-1-p.yadav@ti.com>
 <20211028124518.17370-2-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028124518.17370-2-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 28, 2021 at 06:15:16PM +0530, Pratyush Yadav wrote:
> Many SPI controllers need to add properties to slave devices. This could

Probably should replace 'slave' with 'peripheral' throughout[1]. 

> be the delay in clock or data lines, etc. These properties are
> controller specific but need to be defined in the slave node because
> they are per-slave and there can be multiple slaves attached to a
> controller.
> 
> If these properties are not added to the slave binding, then the dtbs
> check emits a warning. But these properties do not make much sense in
> the slave binding because they are controller-specific and they will
> just pollute every slave binding. So this binding is added to collect
> all such properties from all such controllers. Slave bindings should
> simply refer to this binding and they should be rid of the warnings.
> 
> There are some limitations with this approach. Firstly, there is no way
> to specify required properties. The schema contains properties for all
> controllers and there is no way to know which controller is being used.
> Secondly, there is no way to restrict additional properties. Since this
> schema will be used with an allOf operator, additionalProperties needs
> to be true. In addition, the slave schema will have to set
> unevaluatedProperties: false.
> 
> Despite these limitations, this appears to be the best solution to this
> problem that doesn't involve modifying existing tools or schema specs.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v2:
> - Move other subnode properties listed in spi-controller.yaml to
>   spi-slave-props.yaml
> - Move the Cadence controller-specific properties out of
>   spi-slave-props.yaml. They will be added in a separate file.
> - Add a reference to spi-slave-props.yaml in spi-controller.yaml.
> - Update description.
> 
>  .../bindings/spi/spi-controller.yaml          | 69 +-------------
>  .../bindings/spi/spi-slave-props.yaml         | 91 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 8246891602e7..ff770657e214 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -94,73 +94,8 @@ patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
>  
> -    properties:
> -      compatible:
> -        description:
> -          Compatible of the SPI device.
> -
> -      reg:
> -        minItems: 1
> -        maxItems: 256
> -        items:
> -          minimum: 0
> -          maximum: 256
> -        description:
> -          Chip select used by the device.
> -
> -      spi-3wire:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires 3-wire mode.
> -
> -      spi-cpha:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires shifted clock phase (CPHA) mode.
> -
> -      spi-cpol:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires inverse clock polarity (CPOL) mode.
> -
> -      spi-cs-high:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires the chip select active high.
> -
> -      spi-lsb-first:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          The device requires the LSB first mode.
> -
> -      spi-max-frequency:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description:
> -          Maximum SPI clocking speed of the device in Hz.
> -
> -      spi-rx-bus-width:
> -        description:
> -          Bus width to the SPI bus used for read transfers.
> -          If 0 is provided, then no RX will be possible on this device.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [0, 1, 2, 4, 8]
> -        default: 1
> -
> -      spi-rx-delay-us:
> -        description:
> -          Delay, in microseconds, after a read transfer.
> -
> -      spi-tx-bus-width:
> -        description:
> -          Bus width to the SPI bus used for write transfers.
> -          If 0 is provided, then no TX will be possible on this device.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [0, 1, 2, 4, 8]
> -        default: 1
> -
> -      spi-tx-delay-us:
> -        description:
> -          Delay, in microseconds, after a write transfer.
> +    allOf:
> +      - $ref: spi-slave-props.yaml
>  
>      required:
>        - compatible
> diff --git a/Documentation/devicetree/bindings/spi/spi-slave-props.yaml b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> new file mode 100644
> index 000000000000..5166ec9b0353
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-slave-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Slave-specific properties for a SPI bus.
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  Many SPI controllers need to add properties to slave devices. They could be
> +  common properties like spi-max-frequency, spi-cpha, etc. or they could be
> +  controller specific like delay in clock or data lines, etc. These properties
> +  need to be defined in the slave node because they are per-slave and there can
> +  be multiple slaves attached to a controller. All those properties are listed
> +  here. The controller specific properties should go in their own separate
> +  schema that should be referenced from here.
> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +properties:
> +  compatible:
> +    description:
> +      Compatible of the SPI device.

You can drop 'compatible'.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 256
> +    items:
> +      minimum: 0
> +      maximum: 256
> +    description:
> +      Chip select used by the device.
> +
> +  spi-3wire:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The device requires 3-wire mode.
> +
> +  spi-cpha:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The device requires shifted clock phase (CPHA) mode.
> +
> +  spi-cpol:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The device requires inverse clock polarity (CPOL) mode.
> +
> +  spi-cs-high:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The device requires the chip select active high.
> +
> +  spi-lsb-first:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The device requires the LSB first mode.
> +
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Maximum SPI clocking speed of the device in Hz.
> +
> +  spi-rx-bus-width:
> +    description:
> +      Bus width to the SPI bus used for read transfers.
> +      If 0 is provided, then no RX will be possible on this device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 4, 8]
> +    default: 1
> +
> +  spi-rx-delay-us:
> +    description:
> +      Delay, in microseconds, after a read transfer.
> +
> +  spi-tx-bus-width:
> +    description:
> +      Bus width to the SPI bus used for write transfers.
> +      If 0 is provided, then no TX will be possible on this device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 4, 8]
> +    default: 1
> +
> +  spi-tx-delay-us:
> +    description:
> +      Delay, in microseconds, after a write transfer.
> +
> +# The controller specific properties go here.
> +
> +additionalProperties: true
> -- 
> 2.33.1.835.ge9e5ba39a7
> 
> 
