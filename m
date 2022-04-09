Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F384FA1CD
	for <lists+linux-spi@lfdr.de>; Sat,  9 Apr 2022 04:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbiDIClQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Apr 2022 22:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbiDIClN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Apr 2022 22:41:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C2CF4A0
        for <linux-spi@vger.kernel.org>; Fri,  8 Apr 2022 19:39:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id p15so20593733ejc.7
        for <linux-spi@vger.kernel.org>; Fri, 08 Apr 2022 19:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDiJEuDFuGkwHXojfi+3MVI4ItQG2aZ6jj0r0oRWV5A=;
        b=n4+0WtW8kldSsZLnkOUjeF0TmKTgewJZB73x8goESRf9r+HNgRxPplcS7sti7TU5Wo
         tNWwSSZm/k56aQOuZYTsyPrkO9Ky17gapk9fifDxyNGZwd6kg/HCqlPIcwZK5b9FI7WE
         nN0hmqTQgaNr4hsisvFK0yOC1KVwsaItbxoJbowE44bbzo1ArxyC8YEte16+8etgU0bb
         L7hsgaEoBRa/hdBpshsNeMPa5aIdj0PVfNAuMGc96s3x0t4XXUmuAM3jArb06zXvdlOq
         9dks3huTuaS3+H4IL/MXaRT/Lx1qRNqMdbaKSDGoeCbA0KTo1I2pMsxq1mO0bUkrc+7O
         lDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDiJEuDFuGkwHXojfi+3MVI4ItQG2aZ6jj0r0oRWV5A=;
        b=V3kN16dz0b5e8uWWtTeC1tv+N1a7Cs8Gdlyt/kI0Qu73X9FO/tOvEMmfPMbyYZ9bs4
         zVrswNlF7WifQs1HQiM5nVGJhDw9keT8jlZ/Ex97x8axWYyMaIQV8W1Oa/vJ55X3Tf4B
         4dlKsZjwJIFIiXz9tA12joilG1bWoF3lB+tb1WxwSs82688+rE4eMW6TLErzlNv0Y6lY
         6vJtm1E8EIVvX2lAPLkralAB/hAE4xnH/d43KyS0DOHVUhaDSB7/jOCQreJfT8OGzFSW
         q6ELELpG5usQNdKa/7RDFswYSAsX4rtmkgh1q59f7ZPcI3Ox3SjLzUs0lPJP48xlWIUe
         98EQ==
X-Gm-Message-State: AOAM532L56sDKi8Z+X7AQtPVkDI8cz+ZlIC0MdZVM/MaC17Nem/NoEe5
        71aU5fwnZL/rfjmoYLvW8LHYRw5k1MTHPgBpK7wAmA==
X-Google-Smtp-Source: ABdhPJwZC/wvD6VzNIpF/Y/XATk6DvG8Fq7Kxsq+wI7cylWx0LPWterz+z+mAq8/iVcfHJ3ALSjOZtB3VDiJOEvRFGs=
X-Received: by 2002:a17:906:300f:b0:6e0:b38d:777d with SMTP id
 15-20020a170906300f00b006e0b38d777dmr21259966ejz.189.1649471946515; Fri, 08
 Apr 2022 19:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-12-brad@pensando.io>
 <9c08f621be28dba65e811bc9cdedc882@kernel.org>
In-Reply-To: <9c08f621be28dba65e811bc9cdedc882@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Fri, 8 Apr 2022 19:38:55 -0700
Message-ID: <CAK9rFnyRTX+VM5g9P-ar=3VaExhHcwR8DzLvxtv-tG8cN9gqEQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] arm64: dts: Add Pensando Elba SoC support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Apr 7, 2022 at 12:57 AM Marc Zyngier <maz@kernel.org> wrote:
>
> > +             gic: interrupt-controller@800000 {
> > +                     compatible = "arm,gic-v3";
> > +                     #interrupt-cells = <3>;
> > +                     #address-cells = <2>;
> > +                     #size-cells = <2>;
> > +                     ranges;
> > +                     interrupt-controller;
> > +                     reg = <0x0 0x800000 0x0 0x200000>,      /* GICD */
> > +                           <0x0 0xa00000 0x0 0x200000>;      /* GICR */
>
> You are still missing the GICV and GICH regions that are
> provided by the CPU. I already pointed that out in [1].
>
> The Cortex-A72 TRM will tell you where to find them (at
> an offset from PERIPHBASE).

Hi Marc,

Got the addresses, neither region is used, and will be included in the
next submission.

Best,
Brad
