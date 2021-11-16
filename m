Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B354530A4
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhKPLcf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 06:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbhKPLcK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 06:32:10 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F914C061202;
        Tue, 16 Nov 2021 03:29:12 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d11so42529578ljg.8;
        Tue, 16 Nov 2021 03:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KgH8hxHm/FrDWe8yu/KtutrLYb/eHAySYSG7tABVZD8=;
        b=WQXwJtlQVd+47QBnnFnwMnHb+unQnWJRVp8wa0AAzlb+m5V+4E+gTCt24sAj6B+xxt
         0rlCxO8r9bnoJFqpL0pyGjT8MmhgYrolx5H6mBWDWMYoneuhLPnvtMUzQlkuEy6Qfb+K
         aMoyWbKCGA03sRWgwyTm+66RhHAlpLbu3ZzjG3MUverXK1LlZ70OPYkvA7uxllqr5EdW
         Ynee/tWnWOjd3LKBwmADf1dGMGAQfiMm/9ZJT/tthXNR1a8Xv+W8g5T4EYW20We6a8Oo
         6pmb1HVHbsushdwxfYUN+yWOeoYhokFpirI0P5DGS9lAiJ2fLv9X6CdCKuFRio9gHv2y
         QMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KgH8hxHm/FrDWe8yu/KtutrLYb/eHAySYSG7tABVZD8=;
        b=BAVTJJCLBlWwbJcX9jRs1T30Dy0FlTrC+mVmtlw0ENIrB6y/ewwK6ZgDIrj1cnQlm1
         5dwpm5fq6e998gWyzJBtIw0bsBHFQE3LEmp7frWjcvMjURNY1dsNr336KqHGG5wHVGrI
         p+ev45DZSr7Nfb4KRyxGFI+18rUvw3TB+Nxr5Ly2xMeu7ES4xMkKPmP3WkSlYu42a9jc
         AtXiIkiUFS0DIJl4TYn1uw1U1SOBNPLPxkEvSLssO1BieyHeMCChjuLWvYfRoUaFprkN
         vXDKMQlfDn9lRn+fTu17fvAbzN4eQ/BTQKJ+sdO1/5JXjOf2AfRxuo5Ms6Z4+qfqkm2R
         KaJA==
X-Gm-Message-State: AOAM532sTcyhqNRZlThacGkcxooVYlLOb+JIj2umCasL5BV686x3rsnP
        JZAnhii7Uk0uijUZIWVr1ws=
X-Google-Smtp-Source: ABdhPJwT05xYGdFvFfnRIzfOHSrJKu1dUYSKUfjYX/R14U1ARea6ixOoVJqMNgE6F5QYwh5yfRZxWQ==
X-Received: by 2002:a2e:7807:: with SMTP id t7mr6110206ljc.426.1637062150438;
        Tue, 16 Nov 2021 03:29:10 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id m16sm1485527lfj.59.2021.11.16.03.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:29:10 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:29:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>, Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
Subject: Re: [PATCH v3 05/11] spi: dw: Add Pensando Elba SoC SPI Controller
 bindings
Message-ID: <20211116112907.lbwdcz5pmgxqzv55@mobilestation>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-6-brad@pensando.io>
 <20211028074945.rv2j5kgzk7yc2srr@mobilestation>
 <CAK9rFnw396xK+u3qUpgbnGNw7WDJPJm0L3o4nPAcFeqQjBDbXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9rFnw396xK+u3qUpgbnGNw7WDJPJm0L3o4nPAcFeqQjBDbXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 02:24:40PM -0800, Brad Larson wrote:
> Hi Sergey,
> 
> On Thu, Oct 28, 2021 at 12:49 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Sun, Oct 24, 2021 at 06:51:50PM -0700, Brad Larson wrote:
> > > The Pensando Elba SoC has integrated the DW APB SPI Controller
> >
> > Please add the "dt-bindings: " prefix to the patch name and discard
> > the word "bindings" from the title as the submitting DT-patches
> > requires:
> > Documentation/devicetree/bindings/submitting-patches.rst
> 
> I'll add that.  I recall looking at the recent git log for similar
> changes to the file as the current recommended approach.
> 
> > >
> > > Signed-off-by: Brad Larson <brad@pensando.io>
> > > ---
> > >  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > > index d7e08b03e204..0b5ebb2ae6e7 100644
> > > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > > @@ -73,6 +73,8 @@ properties:
> > >                - renesas,r9a06g032-spi # RZ/N1D
> > >                - renesas,r9a06g033-spi # RZ/N1S
> > >            - const: renesas,rzn1-spi   # RZ/N1
> >
> > > +      - description: Pensando Elba SoC SPI Controller
> > > +        const: pensando,elba-spi
> >
> > AFAICS from the driver-part of the patchset it's not enough. You've
> > also got the syscon phandle, which needs to be reflected in the
> > bindings. That also makes me thinking that you didn't perform the
> > "dtbs_check" on the dts-files you were going to submit, but for some
> > reason discarded from this series (btw why?). If you did you would
> > have got an error of an unevaluated property detection.
> 
> I ran the checks below and didn't get errors.  Rob provided some info
> and I found the server did not have yamllint installed (not flagged by
> tool).  Also dt-schema was not the latest.  I'm re-doing this and
> including "DT_CHECKER_FLAGS=-m" as that is new with v5.13.
> 

> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/pensando,elba.yaml

Hmm, that's weird. Rob, does dtschema tool have the
"unevaluatedProperties" property support?

Brad, anyway you still need to add the syscon-property (pensando,*spics)
requirement in the snps,dw-apb-ssi.yaml schema. See the way it's done there
for instance for "baikal,bt1-sys-ssi" when it comes to the
vendor-specific properties definition in the allOf composition block.
You'll need to define a custom phandle property there in case if a
DT-node is compatible with you SPI controller.

-Sergey

> 
> make dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> make dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> make dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> make dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
> make dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/pensando,elba.yaml
> 
> Thanks
> Brad
