Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC83F4305
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 03:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhHWB0a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Aug 2021 21:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhHWB03 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Aug 2021 21:26:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92798C061760
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:25:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u3so33516061ejz.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqpWK2NpNMam+FVrnd5Qq4UQdG4vZMylCROkJYXdu6w=;
        b=mtHYLDxx+doZhDcK8JqpU0r2bgFOmLiQYIGB6kkMOuslrKGLPdnXfhACq0msmAHHqV
         wUSGl/V1rpTV5MzKxsKUzcrWv90OZg2d6Aq43ZEbaM8j9WbxaUhk5Cg/HfMf0OjgUaTk
         RPcOo7irbUFOg9p/PFpYoxcXZI2xfBc0qYsU+Rs8jtG6wsktBqgyfJFiKtstXvDcXvGl
         6BryYhWCifc74SPcD/Xrl5U0CwwvfWaze1TRdwesoE2CjUli9pDLPvhrD03LgyIrobpk
         myi2pB7Bv5gkYlxhrXSia6dWyqf/PfYY76vmH16/gcxECjrohJ+cUinGWq4XUNZbUs87
         oquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqpWK2NpNMam+FVrnd5Qq4UQdG4vZMylCROkJYXdu6w=;
        b=Dz4QJK/Q7JiOTzYAweZ7701X2rsGnz+zIRDgV6D5cFLUR4hF1sf+/38jeuo5K+yP7S
         W3+LVXJlYFCub7uwwSsLCElpJwJaK51pJVtTRsyTKhrHYgID5Bpv8Pv350M15/Mts5Yy
         whMhqEzOJH1dOvoThfAOaXXqmCWR0/hPi+5x0GacKZsX2+/9Kus/+hfnLklMRRaZDDsy
         TngU4Z3QXN1ZtXAzRBOdN8/myKRUp7ZwtuIwoxVmc+nh9aQQHO2dlpOxSXA617FJQX2Z
         YU3p+vHU1s54P1RXPMt+yzrqHrkgGwVkBCwnA1Ca/AbxMrgd2YuIfeinYvt0clYEM3Fw
         3TEg==
X-Gm-Message-State: AOAM530lvtb81Hiznwf+A8oOfv0++aKUs4mGZEpoDhcQY4ADYltIBgAr
        /BR0P+0SxYsl0LmXwPaGNZIBxV92lIRBDKuZJ7rk3Q==
X-Google-Smtp-Source: ABdhPJy/0sXtHHmKiUqDX9OM8jGFwko/lR4cRRRmI4r2eEOY/cer4itLJuSzsZZTroiumuKovs5s5IlI725zYJ9AWMo=
X-Received: by 2002:a17:906:b25a:: with SMTP id ce26mr1436524ejb.174.1629681946141;
 Sun, 22 Aug 2021 18:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-4-brad@pensando.io>
 <CAHp75VfmSKVRB+Rm+sWDjZaJwdX4qt56Qj6aehe4YnA5d6+a6Q@mail.gmail.com>
In-Reply-To: <CAHp75VfmSKVRB+Rm+sWDjZaJwdX4qt56Qj6aehe4YnA5d6+a6Q@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:25:35 -0700
Message-ID: <CAK9rFnzdPpVBZu8uxHU04pak9OxPMjFqAt_qnPQY2qK2WK4rTQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] spi: dw: Add support for Pensando Elba SoC SPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

On Mon, Mar 29, 2021 at 3:43 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 29, 2021 at 5:01 AM Brad Larson <brad@pensando.io> wrote:
> >
> > The Pensando Elba SoC uses a GPIO based chip select
> > for two DW SPI busses with each bus having two
> > chip selects.
...
> > +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> > +{
> > +       struct dw_spi *dws = spi_master_get_devdata(spi->master);
> > +
> > +       if (!enable) {
>
> Can you use positive conditional?

This function has been re-written to use the existing dw_spi_set_cs().
This is what I currently plan for the v3 patchset.

static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
{
        spi->chip_select = 0;
        dw_spi_set_cs(spi, enable);
}

Regards,
Brad
