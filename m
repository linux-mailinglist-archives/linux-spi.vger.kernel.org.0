Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F45341F0
	for <lists+linux-spi@lfdr.de>; Wed, 25 May 2022 19:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbiEYREE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 May 2022 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245498AbiEYRED (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 May 2022 13:04:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541C854011
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 10:04:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i9so807803wrc.13
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loFo61ZrCr4QaTZkLYB3/JVJBU50T2JZCagmaC/lyAw=;
        b=Z0B1Dtj6jth9CjXTTNew6KleYGbdoUTXOF3eLdqZhHVQRSY9Ky2118o70pkPI06R9P
         SCqgbQIPZdZ8A+6XSqyr1osIbRUQ8jpfM1SQtn6RlB5oIv/W8tbxbnvk+47CA+AWjest
         fU9lJTgzqMVV2QPEjcYrGH5PygljPkdVEauDmiwPjEtRcpCDBLpc0PmAXeWfj4pPKG7P
         pCI4ZM59v4xHiw267rYLRgaUgXjxAGW8u6XvjRKmXusnMKtuWVLzpPYgToPdkIedX47q
         k/L2+ukcxX0kz9hd85M5bc1W9/J2LevtOKtA1eKU2NrffXaDBmtVE2rifIsoXEy8zF78
         gDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loFo61ZrCr4QaTZkLYB3/JVJBU50T2JZCagmaC/lyAw=;
        b=w8UU16pjiZ8paTyhZo4p0Qm3NyUCWgEd0w3+j5eoo6u0254iJZLWR8NMPq1fEdZd2L
         YsocTZQ6olZ5/mUHChJXhtvvzEPHudM66rfLYhks6vO+RT00q4AfRJo7jqHA4Y7bgA/d
         XEybEcLZChtCCt96Z+dR+iebb6E64G6RsUiJFCpEjOq+ZRTDGHAln2cMrLwRY/Q2/gIK
         wAUspUtX+ioGXn8BJsp588c+wb1VJbvA8G2F/HA/7SaIevwFIco1vCQpckxrwYhqoUJa
         DTZS/7NgtqZO633QE7NVXTop8pyeoHpXlJL+JNoWwX5XpHJd0sqmhyqyeafzxA+TFwcH
         BgWA==
X-Gm-Message-State: AOAM531u0C3+EBJ9easPjusGNXx9g+SwctqrTwNcMjc2c77kkr5WRP53
        /WxCdLnODi5jhFlWz2fiyiIDR3cjrHlLE3VlGlL5BA==
X-Google-Smtp-Source: ABdhPJzNHPfJp1XyqZV7qhrWcbxNk3IfEfV32VUdXbe3pQf8/N0AgRWU30h5jOGOB2lixvKXXGLLczV8CTTR/5Arbjg=
X-Received: by 2002:a5d:5954:0:b0:20c:4d55:1388 with SMTP id
 e20-20020a5d5954000000b0020c4d551388mr28040155wri.90.1653498238868; Wed, 25
 May 2022 10:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-5-brad@pensando.io>
 <20220412113739.xczqscungojcitrm@mobilestation>
In-Reply-To: <20220412113739.xczqscungojcitrm@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 10:03:48 -0700
Message-ID: <CAK9rFnx98FCVd9-HHdxMCwp_M9a7C5yd_pkA7TvrMLGM=kkOww@mail.gmail.com>
Subject: Re: [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba SoC
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
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

Hi Sergey,

On Tue, Apr 12, 2022 at 4:37 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> > [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba SoC
>
> I think you need to be more specific in the patch title to what bindings
> you are adding the new compatible string. Something like this
> "dt-bindings: spi: cdns: ..."
> The same concerns the patch "[PATCH 03/11] dt-bindings: mmc: Add Pensando
> Elba SoC binding".
> Otherwise it isn't clear to what schema you are adding the Elba SoC
> support to.

Thanks for the review, I'll add more specifics to the bindings patch title.

Regards,
Brad
