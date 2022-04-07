Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38A4F89B6
	for <lists+linux-spi@lfdr.de>; Fri,  8 Apr 2022 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiDGUqO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 16:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiDGUqG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 16:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34989334112;
        Thu,  7 Apr 2022 13:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4A7D61F33;
        Thu,  7 Apr 2022 20:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D665C385A8;
        Thu,  7 Apr 2022 20:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649363755;
        bh=xY4n5DFeOjBOSt7trzE7j/aln49bfhNCoojRECfGPuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HXJZATBFqNQ1dh1kFQ9g0pzO9mLCpx/In8a4mVQ/VThHtFJ+sUPNLM6kF7XRwOllY
         MFM5kWVgMN2Qn+rippE1sAr5+aPFuqYrsBRjX9n+KtbH73Fli3URzltriy9JW/UOkG
         ZwC59UIVsbzjo2/1Ftk6NFpVeaswNwtLNjKx7wc2GeZal6dm0vdnBZy2nwTnaXXTPE
         rmN3IMCm99izM0kIXoY+Iw4iXNVDyRIGqUaYGyb3HvSOfsamGrM7Rd51ULeUN7oEhN
         1l7ly9Xp2BfLZwe1ufneT6R43mxKIUWT/0XEj264pM7eNrY634hx/bk1r3qoatXWkB
         LYXGk2GqfRpww==
Received: by mail-io1-f44.google.com with SMTP id p21so8311162ioj.4;
        Thu, 07 Apr 2022 13:35:55 -0700 (PDT)
X-Gm-Message-State: AOAM532TANR7xjjOqDs7HHPkszczFVhRi/UWYTvf5KnVpLql1qDZRMd0
        dDTbeHQQZaYlvs+FMOoO1KO5SxJRZgDRq9ds6g==
X-Google-Smtp-Source: ABdhPJwJk0a/KhYxzbGTgvoi1E+QyoOVEfvF8TMZ8cDPE3G/c8up6spg1jnQbgQUgdFNFXOcOoR9ez2W0uIcw0XRqJo=
X-Received: by 2002:a05:6638:24c9:b0:323:edae:e65d with SMTP id
 y9-20020a05663824c900b00323edaee65dmr7883355jat.91.1649363754324; Thu, 07 Apr
 2022 13:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220407194936.223041-1-marex@denx.de>
In-Reply-To: <20220407194936.223041-1-marex@denx.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 7 Apr 2022 15:35:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKRMrCdz4L6c2CyR1y+Wj7LG0NB4r9dm72gktmV08whyg@mail.gmail.com>
Message-ID: <CAL_JsqKRMrCdz4L6c2CyR1y+Wj7LG0NB4r9dm72gktmV08whyg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: Add YAML DT binding document for
 trivial devices
To:     Marek Vasut <marex@denx.de>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Apr 7, 2022 at 2:49 PM Marek Vasut <marex@denx.de> wrote:
>

'dt-bindings' pretty much implies or says 'YAML DT binding document'
already. Given limited subject line, don't repeat yourself.

> Document trivial SPI devices in single YAML DT binding document.
> Currently this overlaps Linux kernel spidev.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> To: linux-spi@vger.kernel.org
> ---
>  .../devicetree/bindings/spi/trivial.yaml      | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/trivial.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/trivial.yaml b/Documentation/devicetree/bindings/spi/trivial.yaml
> new file mode 100644
> index 0000000000000..6d6e682948dfc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/trivial.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/trivial.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Trivial SPI device DT bindings
> +

Add 'description' and describe what devices do and don't qualify as
trivial. (And you can't say 'spidev' :)).

> +maintainers:
> +  - Marek Vasut <marex@denx.de>
> +  - Mark Brown <broonie@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cisco,spi-petra
> +      - dh,dhcom-board
> +      - lineartechnology,ltc2488
> +      - lwn,bk4

This one is a *board*!. Wait, and a device... I suppose that's
possible if the board can be a device in another system. Except both
are used in the same dts file. That should create some nice warnings,
but I'm not sure anyone is paying attention to fsl.yaml warnings.

In any case, we're left with
Documentation/devicetree/bindings/misc/lwn-bk4.txt. That and any other
cases need to be deleted.

> +      - menlo,m53cpld
> +      - micron,spi-authenta
> +      - rohm,dh2228fv

This is a DAC. We have lots of DACs in trivial-devices.yaml already.
How does one decide where to document?

> +      - semtech,sx1301
> +
> +  reg:
> +    description: Chip select
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +  spi-cs-high: true

Reference spi-peripheral-props.yaml and drop these. Will also need to
use unevaluatedProperties.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      spidev@0 {

dac@0

> +        compatible = "rohm,dh2228fv";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +      };
> +    };
> --
> 2.35.1
>
