Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0650822FA49
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 22:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgG0Uoh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 16:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgG0Uog (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 16:44:36 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A2C061794;
        Mon, 27 Jul 2020 13:38:50 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l17so4065204ilq.13;
        Mon, 27 Jul 2020 13:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cKdW+grdmMQSHxJMAoZvPNlBL11Q09cWhyyo13ys2bI=;
        b=I7oqel0uPK5yNykeEPGkM2wntlhQHCyZChnUcWmgYtx1IBCUw1BngS2drpCSOwXShV
         tyntXnpf7s1DwuorTHYqh3kFcfXGAOBG4mHZKf0sq0yhJorPasp0fbAcVp8PPVA87wD/
         cfSGd1+o8yuNoca3uAJDIPYp6P+hHeo/aqG7lBjlW5wOg1x0Xu5hkrJ4+aqGPFFgvFGV
         Dgdfq92GQc6amxiRixw0Jp7Y9tXwcNlZt54AUgyX2T6MMut49kXB4+hyGLRFUeiXv/dT
         qckXgY/0r6pL9z115tsy2Ng6+HlvcmQe/42shhr1nlihWra1gu2wMZ1KMRucM+NoYWHF
         qMHw==
X-Gm-Message-State: AOAM532dskbRb5zYjRsYq4Lq5cPEiOcoy3yIr3hrHHmRVAmqE2TVg8Vm
        o2ukUPlL1/t01ndtaxh/PA==
X-Google-Smtp-Source: ABdhPJy9O/ZdIIW2uzTQWTdhUSFiitu2eaLf82UdvHppY862YgDtihIZUI+Ug5Bc98jvfGhPnhKwGg==
X-Received: by 2002:a92:9fcb:: with SMTP id z72mr25457987ilk.195.1595882329431;
        Mon, 27 Jul 2020 13:38:49 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b20sm9124735ila.5.2020.07.27.13.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:38:48 -0700 (PDT)
Received: (nullmailer pid 834377 invoked by uid 1000);
        Mon, 27 Jul 2020 20:38:47 -0000
Date:   Mon, 27 Jul 2020 14:38:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v4 4/6] dt-bindings: snps,dw-apb-ssi: Add sparx5 support,
 plus rx-sample-delay-ns property
Message-ID: <20200727203847.GA782308@bogus>
References: <20200724111404.13293-1-lars.povlsen@microchip.com>
 <20200724111404.13293-5-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724111404.13293-5-lars.povlsen@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 24, 2020 at 01:14:02PM +0200, Lars Povlsen wrote:
> This has the following changes for the snps,dw-apb-ss DT bindings:
> 
> - Add "microchip,sparx5-spi" as the compatible for the Sparx5 SoC
>   controller
> 
> - Add the property "rx-sample-delay-ns"
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index c62cbe79f00dd..c0adaad1aa695 100644
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
> @@ -93,6 +95,12 @@ properties:
>        - const: tx
>        - const: rx
>  
> +  rx-sample-delay-ns:
> +    description: Default value of the rx-sample-delay-ns property.
> +      This value will be used if the property is not explicitly defined
> +      for a SPI slave device. Default value is 0. See below.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type for properties with unit suffixes.

Also, add:

'default: 0'

> +
>  patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
> @@ -107,6 +115,13 @@ patternProperties:
>        spi-tx-bus-width:
>          const: 1
>  
> +      rx-sample-delay-ns:
> +        description: SPI Rx sample delay offset, unit is nanoseconds.
> +          The delay from the default sample time before the actual
> +          sample of the rxd input signal occurs. The "rx_sample_delay"
> +          is an optional feature of the designware controller, and the
> +          upper limit is also subject to controller configuration.
> +
>  unevaluatedProperties: false
>  
>  required:
> @@ -129,5 +144,11 @@ examples:
>        num-cs = <2>;
>        cs-gpios = <&gpio0 13 0>,
>                   <&gpio0 14 0>;
> +      rx-sample-delay-ns = <3>;
> +      spi-flash@1 {
> +        compatible = "spi-nand";
> +        reg = <1>;
> +        rx-sample-delay-ns = <7>;
> +      };
>      };
>  ...
> -- 
> 2.27.0
> 
