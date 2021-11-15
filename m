Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D164519A5
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 00:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbhKOXZI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 18:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353576AbhKOXWe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 18:22:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376CAC048C9D
        for <linux-spi@vger.kernel.org>; Mon, 15 Nov 2021 14:24:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so3582648edd.13
        for <linux-spi@vger.kernel.org>; Mon, 15 Nov 2021 14:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IA3uzL8dfIEQ00f28ulGEts22lGGQNmtQewySBj0XO4=;
        b=Bnv0ttRfNHVHdyq5LKLvyQjxpdMyK7zrZW+zF5YjwYhHNMqsmwWAV+1/zv3GBfmNDp
         dXZU4ZfENKWeRflnaGRWMV7/FLXl9mG+IQLudrxrRoFHQiAC8EGsSesyMOVUo5McbFRf
         +ppanSSlMs9Y4KjlkRjfUIf5VlAb1iLIWkx5y64VCMv7JDe6NmtMgXnhUpdfxxE3ybIg
         /Hohp9KrrQy5z8x2OBjx4agALcsIkg5fPX6iWzTB/WpMsVL7RmSwgi1CCzJrKrV7dXtC
         ig4npH2Y26QS10+qVyUxNe6jMz0mps8dMY3nnEb87rYqgDXq7Iw2K8aoFA58OHiqXBfm
         +gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IA3uzL8dfIEQ00f28ulGEts22lGGQNmtQewySBj0XO4=;
        b=XkeKZOEc99RN4L08CjdApwrzuE5xvqUTjVWLAKDg8RUgcvVQ1RoEtOrlIwjYaDFNS1
         8L/HxAuxmDL7mepBVF7S2DmedTLG11ysv7seKgAnW8xhAvYH/xLIyYaL5/xc2DH1gV5+
         /PmhYNWbN05gmqCQEmg+8gBJ2gWe1Um5sJY5PLnBciHq6qK3qmlH6hbHgxyslkJtJsJc
         Zuad49plfbnUM2BsWUvQD1eAG5BMUvRBB3GJ7ElGyRZkra++T0flHAqn8ADGln5P9X9h
         ORTwotWmPSm+jHZZOQDdecEJRxOoSVq4fjNTSxDmIYbu4JVcomXYotMMvKe4qxx/sjU5
         V+Pg==
X-Gm-Message-State: AOAM531ji/qvQm3/4UjzjzLl2+86maSY9R4yyXOS1XIhjA3q7F+iZG2X
        yi4CsMwVhAFW0miK4nXPqTPVjCX/nuVFl+SbK1fBQw==
X-Google-Smtp-Source: ABdhPJzxxVv/7atCKO4fqs47SY7HQRIQQsohvPdp3HNDWi3IhAIZG7PhKinKRwqO+bPgkrlboDKA7GrYcJYLOWPB3fY=
X-Received: by 2002:a17:907:6da9:: with SMTP id sb41mr3361170ejc.88.1637015090784;
 Mon, 15 Nov 2021 14:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-6-brad@pensando.io>
 <20211028074945.rv2j5kgzk7yc2srr@mobilestation>
In-Reply-To: <20211028074945.rv2j5kgzk7yc2srr@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 15 Nov 2021 14:24:40 -0800
Message-ID: <CAK9rFnw396xK+u3qUpgbnGNw7WDJPJm0L3o4nPAcFeqQjBDbXg@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] spi: dw: Add Pensando Elba SoC SPI Controller bindings
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergey,

On Thu, Oct 28, 2021 at 12:49 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Sun, Oct 24, 2021 at 06:51:50PM -0700, Brad Larson wrote:
> > The Pensando Elba SoC has integrated the DW APB SPI Controller
>
> Please add the "dt-bindings: " prefix to the patch name and discard
> the word "bindings" from the title as the submitting DT-patches
> requires:
> Documentation/devicetree/bindings/submitting-patches.rst

I'll add that.  I recall looking at the recent git log for similar
changes to the file as the current recommended approach.

> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> > ---
> >  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > index d7e08b03e204..0b5ebb2ae6e7 100644
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > @@ -73,6 +73,8 @@ properties:
> >                - renesas,r9a06g032-spi # RZ/N1D
> >                - renesas,r9a06g033-spi # RZ/N1S
> >            - const: renesas,rzn1-spi   # RZ/N1
>
> > +      - description: Pensando Elba SoC SPI Controller
> > +        const: pensando,elba-spi
>
> AFAICS from the driver-part of the patchset it's not enough. You've
> also got the syscon phandle, which needs to be reflected in the
> bindings. That also makes me thinking that you didn't perform the
> "dtbs_check" on the dts-files you were going to submit, but for some
> reason discarded from this series (btw why?). If you did you would
> have got an error of an unevaluated property detection.

I ran the checks below and didn't get errors.  Rob provided some info
and I found the server did not have yamllint installed (not flagged by
tool).  Also dt-schema was not the latest.  I'm re-doing this and
including "DT_CHECKER_FLAGS=-m" as that is new with v5.13.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/pensando,elba.yaml

make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/pensando,elba.yaml

Thanks
Brad
