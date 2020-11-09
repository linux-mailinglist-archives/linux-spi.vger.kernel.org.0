Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C832AC655
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 21:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgKIUwn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 15:52:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbgKIUwm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 15:52:42 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81380221FB;
        Mon,  9 Nov 2020 20:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604955161;
        bh=D2C0dwhvGc/byaIhEDmOPOOvSRn49LYfvX5fua57lQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zZSrg3tvNee2ietU2BpJkGBKg/kzb2mddFoYf98vEp4qdGqMDk//tKMvlLoVGSLOC
         jyajCyn85Hvzt+jWYbMNDEm7FsGVuDKSf4enMv4N166pyV7R554+HlcgaiYUbVbDdb
         wRPyA6Kdam7lkVaDQsa/y8BFBXXw0QAmETjyz+6k=
Received: by mail-ot1-f44.google.com with SMTP id i18so10364136ots.0;
        Mon, 09 Nov 2020 12:52:41 -0800 (PST)
X-Gm-Message-State: AOAM533bjSa3CIPq3ojS15SA1xiudcZxVVnlLlfX0xBtCZxqo2d93rVa
        nwl55FHhPGdAfBt2lb6Pa4162CWgM4uzYYckKg==
X-Google-Smtp-Source: ABdhPJxOhi7q2TyR1cU1bUXAG1nazgiWne5zeC8nU0nRaw0X6g9uRWTSp5SOeyBKdMyk9NnV3n4OJCWoPencr/BRt0Q=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr10925302oti.107.1604955160785;
 Mon, 09 Nov 2020 12:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-2-damien.lemoal@wdc.com>
 <CAHp75VfvUZ6h+JGCUQ65i7qFsugvbd3n=aCprgvp=geRSpQEhQ@mail.gmail.com> <20201109174450.myombn5skpj5wcxh@mobilestation>
In-Reply-To: <20201109174450.myombn5skpj5wcxh@mobilestation>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 9 Nov 2020 14:52:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+sz09YWxpyM_tBbvJzidbARUVF2fvxMe-SS666WvNRBQ@mail.gmail.com>
Message-ID: <CAL_Jsq+sz09YWxpyM_tBbvJzidbARUVF2fvxMe-SS666WvNRBQ@mail.gmail.com>
Subject: Re: [PATCH 01/32] of: Fix property supplier parsing
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 9, 2020 at 11:45 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hello Andy,
>
> On Mon, Nov 09, 2020 at 05:14:21PM +0200, Andy Shevchenko wrote:
> > On Sat, Nov 7, 2020 at 10:14 AM Damien Le Moal <damien.lemoal@wdc.com> wrote:
> >
> > > @@ -1308,7 +1308,6 @@ DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> > >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> > > -DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
> >
> > Sorry, but the above doesn't sound right to me.
> > It's a generic code and you may imagine how many systems you broke by
> > this change.
>
> Damien replaced the macro above with the code below (your removed it from your
> message):
>
> +static struct device_node *parse_gpios(struct device_node *np,
> +                                      const char *prop_name, int index)
> +{
> +       /*
> +        * Quirck for the DesignWare gpio-dwapb GPIO driver which defines
> +        * the "snps,nr-gpios" property to indicate the total number of GPIOs
> +        * available. As this conflict with "xx-gpios" reference properties,
> +        * ignore it.
> +        */
> +       if (strcmp(prop_name, "snps,nr-gpios") == 0)
> +               return NULL;
> +
> +       return parse_suffix_prop_cells(np, prop_name, index,
> +                                      "-gpios", "#gpio-cells");
> +}
>
> So AFAICS removing the macro shouldn't cause any problem.
>
> My concern was whether the quirk has been really needed. As I said the
> "snps,nr-gpios" property has been marked as deprecated in favor of the standard
> "ngpios" one. Due to the problem noted by Damien any deprecated property
> utilization will cause the DW APB SSI DT-nodes probe malfunction. That
> though implicitly but is supposed to encourage people to provide fixes for
> the dts-files with the deprecated property replaced with "ngpios".

May be deprecated, but we've still got 53 cases in upstream dts files.
Plus changing doesn't work well for new DT with old kernels unless we
backport 'ngpios' support.

> On the other hand an encouragement based on breaking the kernel doesn't seem a
> good solution. So as I see it either we should accept the solution provided by
> Damien, or replace it with a series of fixes for all dts-es with DW APB SSI
> DT-node defined. I suggest to hear the OF-subsystem maintainers out what
> solution would they prefer.

I'd suggest making failing to parse a warning rather than an error.
The devlink stuff is off by default anyways and is still changing.

Rob
