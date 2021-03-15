Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50A233C808
	for <lists+linux-spi@lfdr.de>; Mon, 15 Mar 2021 21:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhCOUyz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Mar 2021 16:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhCOUyo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Mar 2021 16:54:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B4FC06174A;
        Mon, 15 Mar 2021 13:54:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y6so18930933eds.1;
        Mon, 15 Mar 2021 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=38A15GNx1/N58gH7S4h5rE+apX8WICvL1/xV4PvZLew=;
        b=niIt2v9c4KJnHtqwNwkkZsu83qsifivcP9ZNkBSO2UzJxuJGxpeMcanZq1VQzTgFBj
         x3Gkde54nMtpP0okh+bUyVfTQm+suVZHP3oXZT0B8n3yeIbi/3Obq5HEU8HwvdpN4cu3
         6cqNYdeZBo8/zPviclEI1o6cOcMgZ2/qtzE62ICHfyQGkX06HSEkcXmTPxS7Hpu4cIle
         sbBYoIIMUzVEgJq7i1hE0cLhkkPeuNLWatrEputHd84JgfZsT+s6bOjJ1JpO1gcQPR1l
         L+/yrUQyiS0yi4fsyPtZx9oEIZIFLaBvMQiCaUYT72mpdKcTOpX24pQyyXHID/PW5FKI
         IcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=38A15GNx1/N58gH7S4h5rE+apX8WICvL1/xV4PvZLew=;
        b=F2oxQNemM6bTenFDtXkjg3TkQ0ybT4JciTx3vJPwUNoWZgJrFWeMqQGMZAEAdue8mw
         Nl3iRcFYa4M6Q3ElRwj03KjvyV4dHdSc2a7xK4c77CNj9NcyGxKtslDlEXCsAtQom8DT
         7Ml7fNkqDbk/koxNEOWnLNe61/AHzPb4Waq0CTpkB/kHmXfro/UxvH/PKForhJji9F78
         tA1ixUP1JL9PznOhyInAxZ4eAp3FhXWSZW+KiAwIW4OzXv7NibhDDo/sh+0/beOitrYm
         MhW/bx59DNPCqHBpTDhcEZUX5NbzJBtbCSmNrcUZJVL2ucGAodLElKD9BLVZG7MoIeOJ
         Cf6Q==
X-Gm-Message-State: AOAM530qsTrr6jzQ9tUZRQ2mOufXz8MyKXaZXy8oIZlwXOJxsQNHN0Ei
        Cuy+Ne+KMYvibtvM4hiy0jU=
X-Google-Smtp-Source: ABdhPJz22dzA3+6BANERbChcgx+w3bnMkCp3n1/WqmQflApE9CkK9VB5KhlJwBVzk7cg2aL9fyNKJA==
X-Received: by 2002:a05:6402:34d5:: with SMTP id w21mr11187131edc.14.1615841682665;
        Mon, 15 Mar 2021 13:54:42 -0700 (PDT)
Received: from skbuf ([188.25.219.167])
        by smtp.gmail.com with ESMTPSA id bm10sm8901947edb.2.2021.03.15.13.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:54:42 -0700 (PDT)
Date:   Mon, 15 Mar 2021 22:54:40 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
Message-ID: <20210315205440.lb6hcrvzxtqxdb5x@skbuf>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Kuldeep,

On Mon, Mar 15, 2021 at 05:45:18PM +0530, Kuldeep Singh wrote:
> Convert the Freescale DSPI binding to DT schema format using json-schema.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
> Hi Rob,
> This patch is checked with following commands with no warnings observed.
> make distclean; make allmodconfig;
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml;
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> 
>  .../bindings/spi/fsl,spi-fsl-dspi.yaml        | 131 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  65 ---------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 132 insertions(+), 66 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> new file mode 100644
> index 000000000000..15ffc83bdba6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale DSPI Controller
> +
> +maintainers:
> +  - Vladimir Oltean <olteanv@gmail.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,vf610-dspi
> +          - fsl,ls1021a-v1.0-dspi
> +          - fsl,ls1028a-dspi
> +          - fsl,ls2085a-dspi
> +          - fsl,lx2160a-dspi
> +      - items:
> +          - enum:
> +              - fsl,ls1012a-dspi
> +              - fsl,ls1028a-dspi
> +              - fsl,ls1043a-dspi
> +              - fsl,ls1046a-dspi
> +              - fsl,ls1088a-dspi
> +          - const: fsl,ls1021a-v1.0-dspi
> +      - items:
> +          - enum:
> +              - fsl,ls2080a-dspi
> +              - fsl,lx2160a-dspi
> +          - const: fsl,ls2085a-dspi

Can this simply be:
  compatible:
    oneOf:
      - enum:
          - fsl,vf610-dspi
          - fsl,ls1021a-v1.0-dspi
          - fsl,ls1012a-dspi
          - fsl,ls1028a-dspi
          - fsl,ls1043a-dspi
          - fsl,ls1046a-dspi
          - fsl,ls1088a-dspi
          - fsl,ls2080a-dspi
          - fsl,ls2085a-dspi
          - fsl,lx2160a-dspi
?

> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        spi@2100000 {
> +            compatible = "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi";

This doesn't need the "fsl,ls1021a-v1.0-dspi" compatible, can you please
remove it?

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0x0 0x2100000 0x0 0x10000>;
> +            interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +            clock-names = "dspi";
> +            clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>;
> +            dmas = <&edma0 0 62>, <&edma0 0 60>;
> +            dma-names = "tx", "rx";
> +            spi-num-chipselects = <4>;
> +            little-endian;
> +
> +            flash@0 {
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <10000000>;
> +                reg = <0>;
> +            };
> +        };
> +    };

(...)

> -Optional property:
> -- big-endian: If present the dspi device's registers are implemented
> -  in big endian mode.

I don't see "big-endian" being covered in any common yaml, could you
please not delete it? The driver calls of_device_is_big_endian.
