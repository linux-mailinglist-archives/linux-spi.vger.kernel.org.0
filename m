Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD71E43DC69
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 09:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJ1HzC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 03:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1HzC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 03:55:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA32C061570;
        Thu, 28 Oct 2021 00:52:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l2so9185955lji.6;
        Thu, 28 Oct 2021 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ncm5RLVfG8Rch5oTebv4WuqYF8vVKQ52wGDqN1K88ZM=;
        b=XPQxQDLke3l5szkLZPojr3KA/yAbpCVzhmPqHXsUgV8/HrWQ2WfDoY3MgfHZPHbBpQ
         CLqTxicf7xUfuhW4SSohyvbHRyQIVTQGd/JI4lpZgVIVhuviU6AbSw3MD+EeI0leQSi9
         SYy6/wM7CCeVbZxolMqvTOSOSILX6b3ASscZ04+LaTMaSDwiXOyJw1rw94YZRg5axye+
         v0uvVjx/89YMUnvYHI6V97sNc8I3FBHjejkSzDG5fj+9uC0AfCyGSokShZaBI43GhEtm
         t0ZzQYkZn7Zaeuy9e3JyMotNvsc8Gj5XePCWjuALpQKDGftqUyEaYGqDNWEqd7vBj+Bd
         IFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncm5RLVfG8Rch5oTebv4WuqYF8vVKQ52wGDqN1K88ZM=;
        b=uCIeybtxVF5kkpb99Fwhnq8HKhskHKdW8640fcxPWI/VNCcq/CI2W8RRKI/KjXgMjk
         yxkEKfMRmhqtDzJnNiyy5xww++e6w64+eKh0rQIXB6bWECIj7cwaImiejX2BUFLFSfwJ
         7pNRidVuwpdJLRbsd+PkDkqm7EMCLc7fjWcYO9D+ASipOgkSZPri7gdW1S7kVGt6URBx
         eirNCQOzvruOyVyAOUiv2whFSpnqqncW6UMZruJkf92etKS83JsQsygTSpbHOEtbrXNV
         0xkY1V9gE0e/bfxJ8zuKL5Z5Mq8BgYVhSCGWBjMzP4us03woAH63Aq2+aJLzGv+G0hkh
         dI+Q==
X-Gm-Message-State: AOAM530eK3KFhZiMEcp8PUkQu8d5FzP1D0cmwko/G2xk+AgBKlJLd9Fd
        auWp4joGEz8rF8zk4VSZfs0=
X-Google-Smtp-Source: ABdhPJzWaKruJXPS+XLQZC8j2kvpnKqV1KxSNlUhCxXyQhNNHpe58LURH79lwVIK+N6vl0Qpy8ahLw==
X-Received: by 2002:a2e:3007:: with SMTP id w7mr3171650ljw.152.1635407553444;
        Thu, 28 Oct 2021 00:52:33 -0700 (PDT)
Received: from mobilestation ([95.79.132.211])
        by smtp.gmail.com with ESMTPSA id k16sm208982ljq.83.2021.10.28.00.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 00:52:33 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:52:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/11] spi: dw: Add Pensando Elba SoC SPI Controller
 bindings
Message-ID: <20211028075231.47ihqwopu5qodhl7@mobilestation>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-6-brad@pensando.io>
 <20211028074945.rv2j5kgzk7yc2srr@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028074945.rv2j5kgzk7yc2srr@mobilestation>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 28, 2021 at 10:49:48AM +0300, Serge Semin wrote:
> On Sun, Oct 24, 2021 at 06:51:50PM -0700, Brad Larson wrote:
> > The Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Please add the "dt-bindings: " prefix to the patch name and discard
> the word "bindings" from the title as the submitting DT-patches
> requires:
> Documentation/devicetree/bindings/submitting-patches.rst
> 
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
> "dtbs_check" on the dts-files you were going to submit,

> but for some reason discarded from this series (btw why?).

Oops. Found it. The question regarding "dtbs_check" is still actual.

-Sergey

> If you did you would
> have got an error of an unevaluated property detection.
> 
> -Sergey
> 
> >  
> >    reg:
> >      minItems: 1
> > -- 
> > 2.17.1
> > 
