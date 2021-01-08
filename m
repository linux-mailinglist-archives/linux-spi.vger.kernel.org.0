Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2902EEBEF
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 04:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbhAHDld (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 22:41:33 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:46367 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbhAHDld (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 22:41:33 -0500
Received: by mail-io1-f54.google.com with SMTP id 81so8408890ioc.13;
        Thu, 07 Jan 2021 19:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZABm+0zPMrafjNf/NaA+AvmZGg7YOMgwzG0f+U3Y50k=;
        b=BLc3ENrNQ49BFG8RDxpIw4QC0rdBviqUBb4eIfnrAKGEytk0KThZcQHlM03QcTxHtB
         dXRTb6pfzu7BgSe05xQUfmKpU0rsEDJq9LtL+K0hV6GzeHZqRPRcTttnqieA1ClsSho7
         n8N63rkwmwR0e1lA7+Z2/KeK7KG2fs11pHa7PITKxTTNMK+mwcNhjMrd2ou0Ylc/YQoZ
         /gLNsHJ7YRHNghi8Qk803oGw0mLTyG7AVMfgH0yU3MYrvfzurED7RbSX+Blb1MzXVPgM
         xWw8k6uG3vCoPTNRhplCKE4lK7IZWT6O5P0Rh2U/pcobWuI3jULjCKEr8YBqoEec2dwF
         pNfA==
X-Gm-Message-State: AOAM532nf9Rr4mFCXIYP4nAwg2efeyvs8BP5sdAzXjdEe3fsmdwRGLs/
        gbAuoh+cI6N/S/vy2XnnaySXKxRDjA==
X-Google-Smtp-Source: ABdhPJwiQy1ZUywcBJNCHO2TfdW68wQDG7QMFWTBoayDKoihoTNm+kzAr6GXdtwUte5HWNq0NQQ4fw==
X-Received: by 2002:a02:7692:: with SMTP id z140mr1624254jab.21.1610077246078;
        Thu, 07 Jan 2021 19:40:46 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v5sm4587781iob.26.2021.01.07.19.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 19:40:44 -0800 (PST)
Received: (nullmailer pid 1845015 invoked by uid 1000);
        Fri, 08 Jan 2021 03:40:42 -0000
Date:   Thu, 7 Jan 2021 20:40:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, yangtiezhu@loongson.cn,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] spi: ls7a: Add YAML schemas
Message-ID: <20210108034042.GA1839426@robh.at.kernel.org>
References: <1609124381-9107-1-git-send-email-zhangqing@loongson.cn>
 <1609124381-9107-2-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609124381-9107-2-git-send-email-zhangqing@loongson.cn>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 28, 2020 at 10:59:39AM +0800, Qing Zhang wrote:
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
> 
> v4:
> - fix warnings/errors about running 'make dt_binding_check'
> 
> v5:
> - remove num-chipelects
> 
> v6:
> - No changes
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

allOf:
  - $ref: spi-controller.yaml#

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

Doesn't match the schema. If this is on PCI bus, then the example is 
correct. Though you could drop some of the strings. And I think leading 
0s should be omitted. So 'pci14,7a0b'. But please double check that.

Rob
