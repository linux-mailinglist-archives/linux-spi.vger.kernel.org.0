Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937333C777B
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhGMTuZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbhGMTuW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 15:50:22 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE1C0613EE;
        Tue, 13 Jul 2021 12:47:31 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id o3-20020a4a84c30000b0290251d599f19bso5699304oog.8;
        Tue, 13 Jul 2021 12:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gFfhK+dHl3bp85B3Vs5e1G4mkaJcqFiMp7hidA4VQrc=;
        b=BJmVlR1nnMOFCY+tUM1CE6tc2PG13DjPOxDGJMy1r8fqHaZq82NV6qcdvRnCKucF8J
         7GgazHIovzhsAxB3T8iNpmHulOK5K4yKN0HnR81eklObsjZcMno2w4pOUt/v6tUjl+aS
         hrojfdWrIOMXGSCpTdI3XwDEe0XJITFFXcOYpE/67rOOikqGZK5zSACVPUZ24VhW1dzb
         xy7dkF9xy925O4Oec/kYN/JjMV6qCUki3ZE2oNuhLEYt2wMvLOopF/qYRXrVtx6Pt7ps
         gFADR3MpwUdU9Q/4LJFbSC/L7D8owh0MfMFnOdn6t6OiiSBR5g7nSUafY9BllSEFAjt4
         NtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gFfhK+dHl3bp85B3Vs5e1G4mkaJcqFiMp7hidA4VQrc=;
        b=FcQs1YHuw87UL/5d0hc27J3BX8qcFJ7Ib/uQhpPFhhCoc7Fbtw4E3V//f7teHUZGEU
         QPG4i3E4+V7JqE350xLUxIKnRzMcRO9DUyQH28Gp2+2AU6rOhjoBwv355kP2OMDa337P
         lYECq0spvdqRMK1DRkSqyMVpn6uPYyY0VWO4APUka6OQWDKCnaP8tWqHeImqDxLepubc
         REgQprnVhCLiH7iDFKbXQjqZ+GW8CIAoRKg7WVX6m2lk+5Ybc4ACOZMoYOw4VZZ5InFI
         M8TSKahBQk1oUy/7IDwHFJK4iRtsoQySBVmQavO8lIxdI6XCSaULWWvGB95HiyNYGZjf
         KyVQ==
X-Gm-Message-State: AOAM5316OQmhzXwrA40FSA6Mom1rj12+BxEBB2CvWeYNZ0oP9OXiDre1
        j7WawNoqB9k53PXZpc0pE2I=
X-Google-Smtp-Source: ABdhPJwkEc7sB0iELYLZ2JAZlpTbL1bO3oOf9KlA2BmVUOlsJn3J/w0ElwyTXh+7Bj4/wyIfXrSMsw==
X-Received: by 2002:a4a:ce8f:: with SMTP id f15mr1553204oos.68.1626205650505;
        Tue, 13 Jul 2021 12:47:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 2sm3983500ota.58.2021.07.13.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:47:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Jul 2021 12:47:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        linux-hwmon@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Move fixed string 'patternProperties' to
 'properties'
Message-ID: <20210713194728.GA3229000@roeck-us.net>
References: <20210713193514.690894-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713193514.690894-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 13, 2021 at 01:35:14PM -0600, Rob Herring wrote:
> There's no need for fixed strings to be under 'patternProperties', so move
> them under 'properties' instead.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Saravanan Sekar <sravanhome@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 22 ++++----

Acked-by: Guenter Roeck <linux@roeck-us.net>

>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 56 +++++++++----------
>  .../bindings/regulator/mps,mpq7920.yaml       |  6 +-
>  .../regulator/nxp,pf8x00-regulator.yaml       |  3 +-
>  .../bindings/spi/spi-controller.yaml          | 32 +++++------
>  5 files changed, 60 insertions(+), 59 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> index ad0ec9f35bd8..7d9c083632b9 100644
> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -39,17 +39,7 @@ properties:
>    reg:
>      maxItems: 1
>  
> -patternProperties:
> -  "^adi,bypass-attenuator-in[0-4]$":
> -    description: |
> -      Configures bypassing the individual voltage input attenuator. If
> -      set to 1 the attenuator is bypassed if set to 0 the attenuator is
> -      not bypassed. If the property is absent then the attenuator
> -      retains it's configuration from the bios/bootloader.
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [0, 1]
> -
> -  "^adi,pwm-active-state$":
> +  adi,pwm-active-state:
>      description: |
>        Integer array, represents the active state of the pwm outputs If set to 0
>        the pwm uses a logic low output for 100% duty cycle. If set to 1 the pwm
> @@ -61,6 +51,16 @@ patternProperties:
>        enum: [0, 1]
>        default: 1
>  
> +patternProperties:
> +  "^adi,bypass-attenuator-in[0-4]$":
> +    description: |
> +      Configures bypassing the individual voltage input attenuator. If
> +      set to 1 the attenuator is bypassed if set to 0 the attenuator is
> +      not bypassed. If the property is absent then the attenuator
> +      retains it's configuration from the bios/bootloader.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index 5272b6f284ba..dcd63908aeae 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -77,6 +77,34 @@ properties:
>        Type-C spec states minimum CC pin debounce of 100 ms and maximum
>        of 200 ms. However, some solutions might need more than 200 ms.
>  
> +  refclk-dig:
> +    type: object
> +    description: |
> +      WIZ node should have subnode for refclk_dig to select the reference
> +      clock source for the reference clock used in the PHY and PMA digital
> +      logic.
> +    properties:
> +      clocks:
> +        minItems: 2
> +        maxItems: 4
> +        description: Phandle to two (Torrent) or four (Sierra) clock nodes representing
> +          the inputs to refclk_dig
> +
> +      "#clock-cells":
> +        const: 0
> +
> +      assigned-clocks:
> +        maxItems: 1
> +
> +      assigned-clock-parents:
> +        maxItems: 1
> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +      - assigned-clocks
> +      - assigned-clock-parents
> +
>  patternProperties:
>    "^pll[0|1]-refclk$":
>      type: object
> @@ -121,34 +149,6 @@ patternProperties:
>        - clocks
>        - "#clock-cells"
>  
> -  "^refclk-dig$":
> -    type: object
> -    description: |
> -      WIZ node should have subnode for refclk_dig to select the reference
> -      clock source for the reference clock used in the PHY and PMA digital
> -      logic.
> -    properties:
> -      clocks:
> -        minItems: 2
> -        maxItems: 4
> -        description: Phandle to two (Torrent) or four (Sierra) clock nodes representing
> -          the inputs to refclk_dig
> -
> -      "#clock-cells":
> -        const: 0
> -
> -      assigned-clocks:
> -        maxItems: 1
> -
> -      assigned-clock-parents:
> -        maxItems: 1
> -
> -    required:
> -      - clocks
> -      - "#clock-cells"
> -      - assigned-clocks
> -      - assigned-clock-parents
> -
>    "^serdes@[0-9a-f]+$":
>      type: object
>      description: |
> diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> index 12b8963615c3..c2e8c54e5311 100644
> --- a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> +++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> @@ -36,12 +36,12 @@ properties:
>            switching frequency must be one of following corresponding value
>            1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
>  
> -    patternProperties:
> -      "^ldo[1-4]$":
> +      ldortc:
>          type: object
>          $ref: regulator.yaml#
>  
> -      "^ldortc$":
> +    patternProperties:
> +      "^ldo[1-4]$":
>          type: object
>          $ref: regulator.yaml#
>  
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> index 8761437ed8ad..aabf50f5b39e 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> @@ -83,7 +83,8 @@ properties:
>  
>          unevaluatedProperties: false
>  
> -      "^vsnvs$":
> +    properties:
> +      vsnvs:
>          type: object
>          $ref: regulator.yaml#
>          description:
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index faef4f6f55b8..8246891602e7 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -79,22 +79,7 @@ properties:
>      description:
>        The SPI controller acts as a slave, instead of a master.
>  
> -allOf:
> -  - if:
> -      not:
> -        required:
> -          - spi-slave
> -    then:
> -      properties:
> -        "#address-cells":
> -          const: 1
> -    else:
> -      properties:
> -        "#address-cells":
> -          const: 0
> -
> -patternProperties:
> -  "^slave$":
> +  slave:
>      type: object
>  
>      properties:
> @@ -105,6 +90,7 @@ patternProperties:
>      required:
>        - compatible
>  
> +patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
>  
> @@ -180,6 +166,20 @@ patternProperties:
>        - compatible
>        - reg
>  
> +allOf:
> +  - if:
> +      not:
> +        required:
> +          - spi-slave
> +    then:
> +      properties:
> +        "#address-cells":
> +          const: 1
> +    else:
> +      properties:
> +        "#address-cells":
> +          const: 0
> +
>  additionalProperties: true
>  
>  examples:
> -- 
> 2.27.0
> 
