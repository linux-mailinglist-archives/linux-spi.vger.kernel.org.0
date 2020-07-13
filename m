Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C985221E0A0
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 21:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGMTXD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 15:23:03 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44020 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgGMTXC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jul 2020 15:23:02 -0400
Received: by mail-il1-f193.google.com with SMTP id i18so12201133ilk.10;
        Mon, 13 Jul 2020 12:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z6l2qI+K33ZIyGh2iAzifK0EJmgah4onXsJ9iJQsL6k=;
        b=ARgaSpAn5q0sW1krs/qj6vYmtHwTH7JoXXY5Ft9oka8AO3JwKz7JnWQ2t8sg7BzErs
         IOzn8gCUwS43HLPy2gEeUGjhqHzc34oRwW9xX5cGEP/OjkCnvV+SQY+m13BWOQt1Z0EJ
         2729KodIzJBhN+CAr3v0Z1ohI8IkHCO/gS84KjueRoO2R2o5RIfXHIY7EoWR9s2W9yWp
         a14L9m7K67R1i/lJSyURf2eMof4fUTJsTTsomMUJq2oE/mneiKQsHLbfFgKK5AeEvJ9Z
         WHyKZniZmEWHdy2uoTXhWjGneLuahhb+4LN8U842uqWrP3v95oNyOvXTlVX7A5SuRVpK
         D1bg==
X-Gm-Message-State: AOAM533v/t+DNeViMKkLaQYUUnimUe0yd+371R88ra/kt/1mMqtRGlYE
        6UxadMeatdWPh44hOvmVE6U4YYwMAw==
X-Google-Smtp-Source: ABdhPJx0fZoesFoSttNLhXIu0D/sCw48OSjyG1jR+wcDMT2daIoZuFNpeOuvHXA+lPdlxwrrbVB15Q==
X-Received: by 2002:a92:4049:: with SMTP id n70mr1292900ila.161.1594668181506;
        Mon, 13 Jul 2020 12:23:01 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y12sm8649031ilm.38.2020.07.13.12.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:23:00 -0700 (PDT)
Received: (nullmailer pid 586277 invoked by uid 1000);
        Mon, 13 Jul 2020 19:22:59 -0000
Date:   Mon, 13 Jul 2020 13:22:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 5/8] dt-bindings: snps,dw-apb-ssi: Add sparx5 support,
 plus snps,rx-sample-delay-ns property
Message-ID: <20200713192259.GA553903@bogus>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
 <20200702101331.26375-6-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702101331.26375-6-lars.povlsen@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jul 02, 2020 at 12:13:28PM +0200, Lars Povlsen wrote:
> This has the following changes for the snps,dw-apb-ss DT bindings:
> 
> - Add "microchip,sparx5-spi" as the compatible for the Sparx5 SoC
>   controller
> 
> - Add the property "mux-controls" for the above compatible string
> 
> - Add the property "snps,rx-sample-delay-ns" for SPI slaves
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index c62cbe79f00dd..9d9208391fae3 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -36,6 +36,8 @@ properties:
>                - mscc,ocelot-spi
>                - mscc,jaguar2-spi
>            - const: snps,dw-apb-ssi
> +      - description: Microchip Sparx5 SoC SPI Controller
> +        const: microchip,sparx5-spi
>        - description: Amazon Alpine SPI Controller
>          const: amazon,alpine-dw-apb-ssi
>        - description: Renesas RZ/N1 SPI Controller
> @@ -93,6 +95,19 @@ properties:
>        - const: tx
>        - const: rx
> 
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: microchip,sparx5-spi
> +
> +then:
> +  properties:
> +    mux-controls:
> +      description: A mux controller node for selecting SPI bus interface.
> +      maxItems: 1
> +      $ref: '/schemas/types.yaml#/definitions/phandle'

Can drop the type. You can assume common properties already have a 
defined type.

> +
>  patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
> @@ -107,6 +122,14 @@ patternProperties:
>        spi-tx-bus-width:
>          const: 1
> 
> +      snps,rx-sample-delay-ns:

We already have 'rx-sample-delay-ns' from Rockchip SPI, so use that. But 
note that it applies to the SPI node. Does this need to be per SPI 
child?

BTW, the Rockchip controller appears to be a version of the DW 
controller.

> +        description: SPI Rx sample delay offset, unit is nanoseconds.
> +          The delay from the default sample time before the actual
> +          sample of the rxd input signal occurs. The "rx_sample_delay"
> +          is an optional feature of the designware controller, and the
> +          upper limit is also subject to controller configuration.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
>  unevaluatedProperties: false
> 
>  required:
> @@ -129,5 +152,10 @@ examples:
>        num-cs = <2>;
>        cs-gpios = <&gpio0 13 0>,
>                   <&gpio0 14 0>;
> +      spi-flash@1 {
> +        compatible = "spi-nand";
> +        reg = <1>;
> +        snps,rx-sample-delay-ns = <7>;
> +      };
>      };
>  ...
> --
> 2.27.0
