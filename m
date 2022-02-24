Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14EB4C36D7
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 21:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiBXUXM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 15:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbiBXUXM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 15:23:12 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7934117B0F1;
        Thu, 24 Feb 2022 12:22:41 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id j2so4741467oie.7;
        Thu, 24 Feb 2022 12:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AQE4AnwIVz+0iF8nufHOjdzMhDHazp/XagGhyvKub5Y=;
        b=r94JnRI7SJLDa3HqyXVw9eFlVrEj5+UTyddsQPter9GO809Diq8O6tl4RPuhiqkeQd
         Am5TVGJ8QIiUOdsbv3VCXTYmCJXpHe4GbNXfvS37/15yqtxpzAnMfalZGqGsa3wxQi/N
         we0DT7mco2PoJNlCOdo5T11MQS5wvVw54EjMEeCa199aBZGdsF1w18mlSju8uptaSwa+
         2/1aDy2QTEUCW0xpHOQuua2HAr4offrFWiMZq24HAiYHCPMIb5KQk9dDjmiT7/itP5rT
         vUDgbt/3/OQnPDilKQq6twT6Z0eVZq3anu7Mw9ysAoJlQ73R0xt5kNd/YB0Bu6cCl4fl
         VHrg==
X-Gm-Message-State: AOAM5332GtWs7o+PS07WiCtbr1F5PIDBCzUo7efrd3dhPUnDPO4EuWCG
        /UcJkDyIaVN0dkaE6A6VdQ==
X-Google-Smtp-Source: ABdhPJwfBrQb6gfJqoZaI2I5EjFPNP+FuBP0Acipmhp6nabxeKxtSNtfgRIJ+DxqWy//4jsyuZl6ZQ==
X-Received: by 2002:a05:6870:e2c6:b0:d6:cca1:2144 with SMTP id w6-20020a056870e2c600b000d6cca12144mr1994776oad.267.1645734160806;
        Thu, 24 Feb 2022 12:22:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i47-20020a9d172f000000b005aed7ea7b44sm144231ota.73.2022.02.24.12.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:22:40 -0800 (PST)
Received: (nullmailer pid 3522835 invoked by uid 1000);
        Thu, 24 Feb 2022 20:22:39 -0000
Date:   Thu, 24 Feb 2022 14:22:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3 2/5] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
Message-ID: <YhfpD9qfcuAlC+wp@robh.at.kernel.org>
References: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
 <2b7f0011-8872-70fa-b9b7-50b7817e7084@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b7f0011-8872-70fa-b9b7-50b7817e7084@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Feb 23, 2022 at 06:59:31PM +0100, Heiner Kallweit wrote:
> Add a YAML schema binding for TM1628 auxdisplay
> (7/11-segment LED) controller.
> 
> This patch is partially based on previous work from
> Andreas Färber <afaerber@suse.de>.
> 
> Co-Developed-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Co-Developed-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v3:
> - fix remaining YAML issues
> - use Co-Developed-by
> ---
>  .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> 
> diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> new file mode 100644
> index 000000000..2a1ef692c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Titan Micro Electronics TM1628 LED controller
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +  - Heiner Kallweit <hkallweit1@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: titanmec,tm1628
> +
> +  reg:
> +    maxItems: 1
> +

> +  grid:
> +    description:
> +      Mapping of display digit position to grid number.
> +      This implicitly defines the display size.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 1
> +    maxItems: 7
> +
> +  segment-mapping:
> +    description:
> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 7
> +    maxItems: 7

Are these properties useful for any 7 segment display or specific to 
this controller?

The commit msg mentions 11 segment display. Does this need to be?:

oneOf:
  - minItems: 7
    maxItems: 7
  - minItems: 11
    maxItems: 11


> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^.*@[1-7],([1-9]|1[0-6])$":
> +    type: object
> +    $ref: /schemas/leds/common.yaml#
> +    unevaluatedProperties: false
> +    description: |
> +      Properties for a single LED.
> +
> +    properties:
> +      reg:
> +        description: |
> +          1-based grid number, followed by 1-based segment bit number.
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led-controller@0 {
> +            compatible = "titanmec,tm1628";
> +            reg = <0>;
> +            spi-3-wire;
> +            spi-lsb-first;
> +            spi-max-frequency = <500000>;
> +            grid = /bits/ 8 <4 3 2 1>;
> +            segment-mapping = /bits/ 8 <4 5 6 1 2 3 7>;
> +            #address-cells = <2>;
> +            #size-cells = <0>;
> +
> +            alarmn@5,4 {
> +                reg = <5 4>;
> +                function = LED_FUNCTION_ALARM;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.35.1
> 
> 
> 
