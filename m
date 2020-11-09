Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315BD2AC2BF
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbgKIRpA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 12:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbgKIRo7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 12:44:59 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1F8C0613CF;
        Mon,  9 Nov 2020 09:44:59 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so12323743lfe.12;
        Mon, 09 Nov 2020 09:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6PkEwJhx8FCOKavtGOYhsFS5NvjQTTcf+upK9UsKwU0=;
        b=no+40PM5oXP5Stgl4mdsYfwCePictQCO/lAgDeyposk3c+C+nCnea1+PzSglmLWlXi
         O26lupimdFAfRyt36m/nOA5IKZeiUSfQG/orEJLcBTkUsu53BEhRb70NYAJAHRYHisn0
         hCj+ciFfuTxvljzBPnfqAp31IKxiM8rOUNwtTk1s0d2i1Unsusw6EplsLHHDSAe1cgdA
         XTKLEUcBk3CVHY+m+9wvoxPXiuRzkWAzYYiHdxJRxsYsnUOR2gcaUs/SvanLnoPnTQ+/
         FdNMTF5oC+sWTkiI2QYkN9V83gTDi3QdmTANTgNSlI2/oBWSxkX7sYeTKSIGXkk/NiEx
         bd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6PkEwJhx8FCOKavtGOYhsFS5NvjQTTcf+upK9UsKwU0=;
        b=qK2iYJdpUTZME1Li2S//1W2JW8QoWphl7vK7BPqKrWhVrhyK2yvljxyf41sGoKDjm7
         Q6YsDJeWjZujE0eYLP03+SzA+5rPS3GKSQwX98H6QcYsra06ULCqHbluqvQNd5W+b4Lb
         tzAW1F3j7KQCsNAgkm/yK7zsria3AMyr9sUfMhHqXlmOrDMPdfYZjXozRnSbqPpiQfnd
         JkC+ZyNBFSe4qFrqKWy9CX1o/ZfplP84fFYnxdWqW4U54uLvAu/DxHBTGKT02ez5gZbK
         1xdEWIW0aCJADHpOnEKe2+lr9wmUuFL+kfvlJXp/zh+kUnAP13ypJgyi1pNtYJuMU0qU
         hhtg==
X-Gm-Message-State: AOAM5332csNkdYIus+UTFFWnuiQIYT7/Upbqz4JszTUzafWRs7u4WE/C
        wF01yv0IJ98X3IuvtPA7udU=
X-Google-Smtp-Source: ABdhPJx6EGOQqxemXoAVKmGJV6KS3yMfgwlSCFSr9pPjqbI2yQSEryRSzZcOA2ebNDyND+jYcPmf6A==
X-Received: by 2002:a19:408b:: with SMTP id n133mr5672872lfa.564.1604943898030;
        Mon, 09 Nov 2020 09:44:58 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id z4sm815664lfd.123.2020.11.09.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:44:57 -0800 (PST)
Date:   Mon, 9 Nov 2020 20:44:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 01/32] of: Fix property supplier parsing
Message-ID: <20201109174450.myombn5skpj5wcxh@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-2-damien.lemoal@wdc.com>
 <CAHp75VfvUZ6h+JGCUQ65i7qFsugvbd3n=aCprgvp=geRSpQEhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfvUZ6h+JGCUQ65i7qFsugvbd3n=aCprgvp=geRSpQEhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Andy,

On Mon, Nov 09, 2020 at 05:14:21PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 7, 2020 at 10:14 AM Damien Le Moal <damien.lemoal@wdc.com> wrote:
> 
> > @@ -1308,7 +1308,6 @@ DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> > -DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
> 
> Sorry, but the above doesn't sound right to me.
> It's a generic code and you may imagine how many systems you broke by
> this change.

Damien replaced the macro above with the code below (your removed it from your
message):

+static struct device_node *parse_gpios(struct device_node *np,
+                                      const char *prop_name, int index)
+{
+       /*
+        * Quirck for the DesignWare gpio-dwapb GPIO driver which defines
+        * the "snps,nr-gpios" property to indicate the total number of GPIOs
+        * available. As this conflict with "xx-gpios" reference properties,
+        * ignore it.
+        */
+       if (strcmp(prop_name, "snps,nr-gpios") == 0)
+               return NULL;
+
+       return parse_suffix_prop_cells(np, prop_name, index,
+                                      "-gpios", "#gpio-cells");
+}

So AFAICS removing the macro shouldn't cause any problem.

My concern was whether the quirk has been really needed. As I said the
"snps,nr-gpios" property has been marked as deprecated in favor of the standard
"ngpios" one. Due to the problem noted by Damien any deprecated property
utilization will cause the DW APB SSI DT-nodes probe malfunction. That
though implicitly but is supposed to encourage people to provide fixes for
the dts-files with the deprecated property replaced with "ngpios".

On the other hand an encouragement based on breaking the kernel doesn't seem a
good solution. So as I see it either we should accept the solution provided by
Damien, or replace it with a series of fixes for all dts-es with DW APB SSI
DT-node defined. I suggest to hear the OF-subsystem maintainers out what
solution would they prefer.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
