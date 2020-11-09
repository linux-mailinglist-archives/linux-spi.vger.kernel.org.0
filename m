Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117862ABF61
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgKIPF7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbgKIPFH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:05:07 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB1EC0613CF;
        Mon,  9 Nov 2020 07:05:07 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id q19so8979371ljc.10;
        Mon, 09 Nov 2020 07:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Fi5Hhyl7gelaqOmcgAJ5M1MZ/xVgsIzn2nzYEuzd1A=;
        b=tvuwBxx+Iv7Mda16xZUTuva+GASbvOuK2AZr0+o3QLQXajOmpBYoQ2ksHZau/GPle3
         BnyfEpgqAizWpJZOUyG9cc81uDC4ctAzj7jerluvanbj5XzZFcl+OzIrG+T5tfN9aIQe
         qx/6Xe8wJYguBk8LCwmig2QjdWGpEZwb9WPzzUuXAkETNGNZ59CSb5RNkjQCYBW0S1w8
         xj5wtAlX1JDVF8R5eGZmckL1XFGUUoWqxvKVZN15IE90rKivrim8RltvVTvr7Nr2BXDk
         bFLJt3HzZtH14a/FB373L3IG43mtwtw6/dazdPun9KjLC0WrFU8wdfw5s2VAMqyp/Rho
         043w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Fi5Hhyl7gelaqOmcgAJ5M1MZ/xVgsIzn2nzYEuzd1A=;
        b=nsx7gMPcxktCEypAmjdc+KRcsgMZo6om9YKS+UpR/dsBZpHxWtsEoU7EwMw4SkKsVo
         xTB9hO2D+QO9B4dGzyK/nwSjeTXBYHOa9+WkJr1SNXVuVOLkVZV0+1XvCvGEApK6ke5i
         vax6Tw8IwMKnu6GaRGCWz7OOXSllYcDQQHi7UHBPBVh5iA3mKbDyUNa3pJxexuJJ4Xte
         pg0IuKJUXxi0/4PbsZxkbw/RD3cKv4mxbSNTxtmPnvvFUnelA2UHNC7EneKOZiYU2eXI
         4OayFnYw73iOYjFgiWBs15xpVLKDn9o/v2klvr+roSSPJdbZAghCWPQiwzxBtKAMVtar
         8J/w==
X-Gm-Message-State: AOAM531lVwLZ5Ptml5AHdrOTIwBaOgc7pG7SvQ0LR9QRPTpKhuL5KgIt
        h4+3Sb17b2x7D9av8BwAmSw=
X-Google-Smtp-Source: ABdhPJz8ZT9IqU+wtfbrOXL+B3JrzFSM+Jqh+Cc+c2Mi1XuR1K1aT8v1QkfGUTsrsUzG/NrzrDIviQ==
X-Received: by 2002:a2e:b4f3:: with SMTP id s19mr4036487ljm.196.1604934305938;
        Mon, 09 Nov 2020 07:05:05 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id w12sm2216805ljo.67.2020.11.09.07.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:05:05 -0800 (PST)
Date:   Mon, 9 Nov 2020 18:05:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 01/32] of: Fix property supplier parsing
Message-ID: <20201109150503.ijc72z76i6wjxfhx@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-2-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 07, 2020 at 05:13:49PM +0900, Damien Le Moal wrote:
> The DesignWare GPIO driver gpio-dwapb ("snps,dw-apb-gpio" or
> "apm,xgene-gpio-v2" compatible string) defines the property
> "snps,nr-gpios" for the user to specify the number of GPIOs available
> on a port. The "-gpios" suffix of this property name ends up being
> interpreted as a cell reference when properties are parsed in
> of_link_to_suppliers(), leading to error messages such as:
> 
> OF: /soc/bus@50200000/gpio-controller@50200000/gpio-port@0: could not
> find phandle
> 
> Fix this by manually defining a parse_gpios() function which ignores
> this property, skipping the search for the supplier and thus avoiding
> the device tree parsing error.

That's why I have introduced the "ngpios" property support and marked the 
"snps,nr-gpios" as deprecated here:
https://lkml.org/lkml/2020/7/22/1298

to encourage the later one from being used in favor of the first one. So I
suggest for you to convert your dts'es (if you have ones) to using the
"ngpios" property anyway.

> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/of/property.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 408a7b5f06a9..d16111c0d6da 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1308,7 +1308,6 @@ DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> -DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
>  
>  static struct device_node *parse_iommu_maps(struct device_node *np,
>  					    const char *prop_name, int index)
> @@ -1319,6 +1318,22 @@ static struct device_node *parse_iommu_maps(struct device_node *np,
>  	return of_parse_phandle(np, prop_name, (index * 4) + 1);
>  }
>  

> +static struct device_node *parse_gpios(struct device_node *np,
> +				       const char *prop_name, int index)
> +{
> +	/*
> +	 * Quirck for the DesignWare gpio-dwapb GPIO driver which defines
           ^
           |
           Quirk?     
> +	 * the "snps,nr-gpios" property to indicate the total number of GPIOs
> +	 * available. As this conflict with "xx-gpios" reference properties,
> +	 * ignore it.
> +	 */
> +	if (strcmp(prop_name, "snps,nr-gpios") == 0)
> +		return NULL;
> +
> +	return parse_suffix_prop_cells(np, prop_name, index,
> +				       "-gpios", "#gpio-cells");
> +}
> +

Personally I'd prefer to convert all the dts-es to using the "ngpios' instead of
the vendor-specific property. That's why I haven't fixed the problem the way you
suggest in the first place, to encourage people to send the patches with such
fixes. Anyway it's up to the OF-subsystem maintainers to decide whether to accept
this quirk.

-Sergey

>  static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_clocks, },
>  	{ .parse_prop = parse_interconnects, },
> -- 
> 2.28.0
> 
