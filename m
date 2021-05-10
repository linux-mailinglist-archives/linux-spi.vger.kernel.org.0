Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B1379AD3
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhEJXhm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 19:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhEJXhl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 19:37:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C0AC061574;
        Mon, 10 May 2021 16:36:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j3-20020a05600c4843b02901484662c4ebso225153wmo.0;
        Mon, 10 May 2021 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmVdPodNBh1H0rgnm38deCST/rryCbgx8LeA4HoogHE=;
        b=OmEfPyyaDh4DIPO6uK6xsdL9GtjAOtrJ/GpN5iKASc9uZCTctM1o3nV61Ghc3y2Y8P
         6eMxsqnmgGDvrtIr7/+Utj8tqI3CsCzrypJ2S4EJPqkUqx3XIkjCidOi4T5wPSaT3wsb
         JAeEvRhpzNqwzeVq0/C1MVpFITx+6njQ3yyUl8lmfHyYxIZ8Ju6Gny8L+KA7+q9tEPbN
         j9P4FaGCR73OPvI/7MEpGXhKU1vsmso9cT/byA85nGYo7KrP/bvEphveoBDjndl+fr/p
         p66FVTYULXT2TVeFA852LMMez76LDJWJ1q/fSOidS9ydU9Q38H0+JGJLQnUzUEZxA6uG
         Ee4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmVdPodNBh1H0rgnm38deCST/rryCbgx8LeA4HoogHE=;
        b=U27VnFXYpwMS3Q4cA11T5u/K+Zzn8I0ccM2Q49quygX0UxDkvpBfrDhQ5h97+tOlwI
         ycnHgNoJJANLPe3KpJKkBq+txYsFx8QsXLgPoPMEhSS/hRXaCni0momvbsm+RwPx0eZv
         JGg2vjjmxl1vRrlDzqYQRYCm+0dTyVTuB1lXqTc77Brz6KbvD8jgY59Pk3SUABgihr8W
         qVduoDgJgIkobQ/41JqnULKPVMK269iJxpGtd7AjqakQYNMLn4A5qZKAAp3OorS2lStv
         1obD401nEOdcFSJUtqutKXPbjjEvc0cOIJ8p5xEwZdhyIxWzVLlXVXMZFbzsjGUownQl
         D2Hg==
X-Gm-Message-State: AOAM533sJ285NNp4eBDCWx0AWWOpoHOg8QJVBhtjhSkujwWiikO4R+j2
        6FDL5JtEIueQzrsNoEMT3c7zQcGkMTsmSfye5Lo=
X-Google-Smtp-Source: ABdhPJxcfvT5O1SvgyRKQ5d9F4Q6wTLFlPL1V3xFX1EcUFhWi8EaeHTBvV39WmTMxefb46AZaG2YlVlm3eYnd9Vin+M=
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr28560834wmq.11.1620689794697;
 Mon, 10 May 2021 16:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210510141022.56499-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210510141022.56499-1-andriy.shevchenko@linux.intel.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 10 May 2021 19:36:21 -0400
Message-ID: <CAGngYiVHq=TxVL5gs19EXHSobCmQ7Pw0v9Oe4XceLRboj8u+3A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Assume GPIO CS active high in ACPI case
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Xin Hao <xhao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy, see below.

On Mon, May 10, 2021 at 10:10 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
>         if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio)) {
>                 if (!(spi->mode & SPI_NO_CS)) {
> +                       /*
> +                        * Historically ACPI has no means of the GPIO polarity and thus
> +                        * the SPISerialBus() resource defines it on the per-chip basis.
> +                        * In order to avoid a chain of negations, the GPIO polarity is
> +                        * considered being Active High. Even for the cases when _DSD()
> +                        * is involved (in the updated versions of ACPI) the GPIO CS
> +                        * polarity must be defined Active High to avoid ambiguity.
> +                        * That's why we use enable, that takes SPI_CS_HIGH into account.
> +                        */
> +                       bool value = has_acpi_companion(&spi->dev) ? !enable : activate;

There are three booleans involved now: "value", "enable" and
"activate". It might be quite hard for someone reading this code
later, to work out what's going on? I've got to admit that my previous
choice of "enable1" was also not perfect, to say the least...

AFAIK there are two basic concepts in this function:
- enable: indicates chip-select enabled or disabled (independent of
gpio polarity)
- level : indicates the required level of the chip-select gpio

So maybe we can simplify like this?

static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
{
        bool level = (spi->mode & SPI_CS_HIGH) ? enable : !enable;

        if cs_gpio              => use level  : gpio_set_value_cansleep(level)
        else if cs_gpiod(acpi)  => use level  : gpiod_set_value_cansleep(level)
        else if cs_gpiod(_)     => use enable :
gpiod_set_value_cansleep(enable);
}
