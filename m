Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E8D2E3349
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 01:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgL1A1U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Dec 2020 19:27:20 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:45352 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgL1A1U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Dec 2020 19:27:20 -0500
Received: by mail-il1-f176.google.com with SMTP id w12so8167522ilm.12;
        Sun, 27 Dec 2020 16:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxF6gjxDj1D5oG9BFZvSKyyiGl1MUnLLDiE1YxgJ6wM=;
        b=CUePESMrQCqJYogxcY0LfdtCZ57MDKTc/iWIRiIEzMxqAgomh8O3vB7QE4zucM++6G
         1CtYmxVhnTuQHdR7OA694VOaMyC37OQxEa/JueCKuCYM6/tTP6LdXpXObbZBCzctLOQ1
         0CPhZf70q/UPAKOkRfWrRpgD893joPdA2bzC0fVPIx82AK2xpa4y3OXIwbTv+rl1Qbvu
         AxmIgQ8i7ZNFJqTjLSNXr4fJLhkuJZPdUjKTIbPg0/tuk1oqRUuNHhAFts9m4XDaGUPw
         8xSLYWslOshl2f2awNsbOu33dDmxAchywkkTKhPd3XtS3Ud39tk+D0+018ltspu3tutW
         f4+g==
X-Gm-Message-State: AOAM531236MKOBVDQJ3LPXGbDAiHrpIlQhBtjubf8ajnrSl58SWnbuYs
        GBuIoXFYmx2XYABIn/xZVe02a4UeSt08fpavaYg=
X-Google-Smtp-Source: ABdhPJwqWQzgWx9rHhJtLVsy+SFYeDCm+6mrk4i78hCJjXkIngpvN6ZcMJqvBVVvccqmAsUPnBG5MBs4U7VGTuwuSEI=
X-Received: by 2002:a05:6e02:1187:: with SMTP id y7mr42039158ili.143.1609115199086;
 Sun, 27 Dec 2020 16:26:39 -0800 (PST)
MIME-Version: 1.0
References: <1608973923-8328-1-git-send-email-zhangqing@loongson.cn> <1608973923-8328-2-git-send-email-zhangqing@loongson.cn>
In-Reply-To: <1608973923-8328-2-git-send-email-zhangqing@loongson.cn>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Mon, 28 Dec 2020 08:26:27 +0800
Message-ID: <CAAhV-H5xEf93_OXRLBFkaMhah5keHESiVbPhj0Fs=ajjCgWefg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] spi: ls7a: Add YAML schemas
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

On Sat, Dec 26, 2020 at 5:13 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> Switch the DT binding to a YAML schema to enable the DT validation.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>
> v4:
>  - fix warnings/errors about running 'make dt_binding_check'
>
> v5:
>  - remove num-chipelects
>
> ---
>  .../devicetree/bindings/spi/loongson,spi-ls7a.yaml | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
> new file mode 100644
> index 0000000..b90b28b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/loongson,spi-ls7a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson LS7A PCH SPI Controller
> +
> +maintainers:
> +  - Qing Zhang <zhangqing@loongson.cn>
> +
> +description: |
> +  This controller can be found in Loongson-3 systems with LS7A PCH.
> +
> +properties:
> +  compatible:
> +    const: loongson,ls7a-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pci {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        spi@16,0 {
> +            compatible = "pci0014,7a0b.0",
> +                             "pci0014,7a0b",
> +                             "pciclass088000",
> +                             "pciclass0800";
> +
> +            reg = <0xb000 0x0 0x0 0x0 0x0>;
> +        };
> +    };
> +
> +...
> --
> 2.1.0
>
