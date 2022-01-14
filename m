Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB648EEA2
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jan 2022 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbiANQpt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jan 2022 11:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbiANQpp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jan 2022 11:45:45 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55918C06173F
        for <linux-spi@vger.kernel.org>; Fri, 14 Jan 2022 08:45:45 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id i5so17836492uaq.10
        for <linux-spi@vger.kernel.org>; Fri, 14 Jan 2022 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBnfwH/s1nckEtFwwtwXrNqBglJnciIYNyoP3vBmMcA=;
        b=pzwJuFX+HKtuEM3O2uSUMWy3ssg3sY0XvaR5uq8tD+I1oYR+tqD1NZEVjA6w21HiUv
         zAJqF6r8tL8KUoxOQ+7aRb8AkFixLGrwTyJWNbC8IFlFzn+Ghq8AymP91Wn3F17zLD5V
         3zG+0tuiZkYHIExXJvYdqvjuWCYMIjA3WhUsG7nFa+Ah1V1ZBnoiFautvzLKfriFOmYq
         3a3Ik2PVPlGSzadMumWRpA6We5mOqtUYlGEfGsN5aMz405ClWxNDF4z3m8O7HbHtihA1
         3FG7rGWYfY8ESkAvrEmyU/9tuijbF6jpOBzzCMeCYco7/DuEi0H3tKGBWAmagmTcLsvf
         RiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBnfwH/s1nckEtFwwtwXrNqBglJnciIYNyoP3vBmMcA=;
        b=dgdro1an0mrz2GwJtWL1FwAMzmzv5o3x/xufXYZeRadd1mLXqhStKVG+oZZhnNWd+T
         MvyEUWpqeXeNlI1ni48I0n1BNFznpzCl03zqKJuEP4r3IhOJpzTtMAiXNOq5JIXcUiNp
         VHiBwN+X+ulJktoP6Bt26/alDAS5XuNXp6bNwlnfchMbq+p4ZFaktznq34AfjAzaT5YU
         EwPcM1AYj3IUE2SFr2oI5ehXrBk7DHYMqqhPeWqgpz8ClIBdftgK4jTfUrxLkL36DRfb
         3qYboOxsYL48nCJP/Ze1j5RTVuHMt46m43nqzrRA8qdVQoxFt6yn7f0GjAM5UdmsyHzI
         SIZg==
X-Gm-Message-State: AOAM5303KLmw1ATpc06dVn3OEcA+rvqdMnnqdaewxuRTrsuF815FDy0i
        gZRxE/Ew7+MwIjxofLPwJGUWkRWHAz7k5D8Pkh4aAA==
X-Google-Smtp-Source: ABdhPJxzbfwYXhLllqrfdBNTSZmo9/053hCIb0yZepZ92/AN16+ukkFuVGElSNY083XDNxtnOPe+ngaILZ18SxEfGUE=
X-Received: by 2002:a67:dd90:: with SMTP id i16mr4444764vsk.86.1642178744464;
 Fri, 14 Jan 2022 08:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com> <20220111101338.58630-4-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111101338.58630-4-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 14 Jan 2022 18:45:32 +0200
Message-ID: <CAPLW+4m5+BXD0vDi6YxvE7XYWZ5ej+QdL3OzzSCWG=mqX_sTqA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] spi: dt-bindings: samsung: allow controller-data
 to be optional
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 11 Jan 2022 at 12:13, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The Samsung SoC SPI bindings requires to provide controller-data node
> for each of SPI peripheral device nodes.  Make this controller-data node
> optional, so DTS could be simpler.
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../devicetree/bindings/spi/samsung,spi-peripheral-props.yaml  | 1 +
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml         | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> index aa5a1f48494b..cadc8a5f061f 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> @@ -28,6 +28,7 @@ properties:
>             - 3: 270 degree phase shift sampling.
>          $ref: /schemas/types.yaml#/definitions/uint32
>          enum: [0, 1, 2, 3]
> +        default: 0
>
>      required:
>        - samsung,spi-feedback-delay
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> index da4533feb946..322558818a43 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -75,9 +75,6 @@ patternProperties:
>      allOf:
>        - $ref: spi-peripheral-props.yaml
>
> -    required:
> -      - controller-data
> -
>      unevaluatedProperties: false
>
>  required:
> --
> 2.32.0
>
