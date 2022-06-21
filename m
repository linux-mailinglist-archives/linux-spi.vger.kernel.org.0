Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A945533F1
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiFUNrW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 09:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiFUNrV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 09:47:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F5D248C6
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 06:47:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kq6so27583141ejb.11
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLY7sPQfS1q+kwZl1J4I102XkQL36tpj1T6l3WUdfgY=;
        b=eGRe83W9PLRLx2zKSF2fJ6kcSzfExf5UiuL8gOL3SuoR5iFGey8r/3nFRxd/I9ImHg
         72F0WQnt1HQPrp5qJ04QsPHx5fhXbEa5U1uwn9c2bMHEEn4CjhCeP4yfmijt0vCBbbQH
         wm+eIFcxEKZtaCNoZlWFypm+qBaUpMpO23LKmt6E31wijsRsEpUoUa96GRPNrq17uw3b
         3CaXqsxJfKi0KUxQSCga8gxcCb6pNQ0TGk2aMWrh0Uvg57GNdHnuvaHaY0tlrN6j39Ec
         7hhdGUwklBKzLNb2hFNbq6facPSI7qkmDd1GEJIK8WPGroWniLrRkuMqKRYnnJ9J3ecp
         PC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLY7sPQfS1q+kwZl1J4I102XkQL36tpj1T6l3WUdfgY=;
        b=iU9O7XFiEAhrWFOkoF77oBKCgct20yeKsq4safhxiH7M21GT+dXAoCTNeMPjb0f7MJ
         NVD741XJapOoOTu3Wx4J1PuQvYrV6vWDosHYD05B2faEZXFzsG+hJhbCIfqU8kPTeUOn
         8w2Gzfh8JWgDBWliKMA0RZdXgzU7y8GYmHwJPYezouX33oLSEWtJ5Kg90SHJMOcxkwYZ
         JyhS/TjPgfH4kANT5XjykuDxLhCnIUFRiTyPr+YSntAqJtRHn6c/6NTeh8Utu9gptZ8O
         npg+Q4w2YJz0lNzqLt4Apf2ree6Cy3lWVmq7suSHjIlxIGFNpLTDOAc1nDoOpOSLsdU0
         4GOw==
X-Gm-Message-State: AJIora8JviGC6ijRtgqIfz3fmV3t2nNFqOQj/hQuo6oVxXBsDHI02ghX
        cTE0ZAu6odiT7MC2K9tl7dcw6vxNwTvSo8nRgEiRYQb0ZQHw3g==
X-Google-Smtp-Source: AGRyM1vDOgYuvbMCc4Tp9FyDjnssxjrx5eaxX6vrMb8p9sFbV0eo+0MWhpg3+vesGnxOcGnwnuAYhf4Q3/90KYBhxpA=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr25871678ejc.579.1655819238970; Tue, 21
 Jun 2022 06:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220621061234.3626638-1-david@protonic.nl> <20220621061234.3626638-12-david@protonic.nl>
In-Reply-To: <20220621061234.3626638-12-david@protonic.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 15:46:42 +0200
Message-ID: <CAHp75VeH-C2=uLTz_DLH32TLJ=PU8XLurvjVrGryo5MW4Cj9CA@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] spi: opportunistically skip ctlr->cur_msg_completion
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jun 21, 2022 at 8:16 AM David Jander <david@protonic.nl> wrote:
>
> There are only a few drivers that do not call
> spi_finalize_current_message() in the context of transfer_one_message(),
> and even for those cases the completion ctlr->cur_msg_completion is not
> needed always. The calls to complete() and wait_for_completion() each
> take a spin-lock, which is costly. This patch makes it possible to avoid
> those calls in the big majority of cases, by introducing two flags that
> with the help of ordering via barriers can avoid using the completion
> safely. In case of a race with the context calling
> spi_finalize_current_message(), the scheme errs on the safe side and takes
> the completion.
> The impact of this patch is worth the effort: On a i.MX8MM SoC, the time
> the SPI bus is idle between two consecutive calls to spi_sync(), is
> reduced from 19.6us to 16.8us... roughly 15%.

...

> +       smp_wmb(); /* make these available to spi_finalize_current_message */

spi_finalize_current_message()

...

> +               smp_mb(); /* see spi_finalize_current_message()... */

Be consistent with capitalization of one-liner comments, see below.

...

> +       smp_mb(); /* See __spi_pump_transfer_message()... */

^^^

This comment (and any other) applies to the entire series where it makes sense.

-- 
With Best Regards,
Andy Shevchenko
