Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E727908C1
	for <lists+linux-spi@lfdr.de>; Sat,  2 Sep 2023 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjIBQ5H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Sep 2023 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIBQ5G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Sep 2023 12:57:06 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042C9E4B
        for <linux-spi@vger.kernel.org>; Sat,  2 Sep 2023 09:57:04 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7766072ba4so1366813276.1
        for <linux-spi@vger.kernel.org>; Sat, 02 Sep 2023 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693673823; x=1694278623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ys7Ptt3vouhvDmGvnohD/T/0YM16X316blFuKjq/vI=;
        b=C/k5c70ewmnYtF7/qQCP6ju/TuKP8B2VTPg4PaCT2skLYzqZUKBrvN4Aty7vTnRR2e
         d37UxbQv6RLqeiTC2Q1c7A+njNbIqrJxFxw0NEgHWKFJvb0+CemTihNPQqlcklCGgDtD
         MFaHZLwVx8Ip9clEpbFBl1pxeW2oGTphpUHAMR1SO13FWgmuDCnoH9dPUrCtgup0b24j
         9BtaW37CFBQEzwa96aKD1eneQ1l1Kn+Twuc7On8YV6zqsgi7AANcRIaF3IMQVNoRAhNy
         ZflQPEvR7l5YqPBsrStp5VtXsDorM0HTfVKHRxrlNyArzTSPJZA1dEIiDT3byHSfIUby
         6syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693673823; x=1694278623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ys7Ptt3vouhvDmGvnohD/T/0YM16X316blFuKjq/vI=;
        b=hkJ5qLnjmeu/PuDlXHBMaVIXw1nieHm8DDiw1EkVSByDvyRr3tvlivhy+rDt0VM6e/
         R33kcLJOKvjJUTgawp6S3XVo1zCTzSu9eJF3Cn4keDxQhit1KkCkow3L7jBWzRsqvfbx
         K8COCSJod+FQwHL+t6lrQo8AgbEgYfUgG0vLRsTvO1zZ7xSkH9rh7/DhYxfVT2UqhU3F
         pJkmBrd/IieZT6Fl69AKvWk6GLqoNAsu+IRUjQ751t75YpEmD8x4mtjFC1WJTnvG6n9l
         3MS6APEJHa+esBGyuv32Meh3/9I4oMYQMZsUgasL6lt0roByxi6oOhv87PFSgt/L3Rcj
         53mw==
X-Gm-Message-State: AOJu0YxL0SDo/agHbT/uSQzCaSzH9zmmXQMB6M4ofbi1mRQ6+8lEYAAk
        reaZ3plAlhkgi6Kdg9x7dylkHN9ytVRYqFlMomPXtWMWUbarssvE
X-Google-Smtp-Source: AGHT+IEuKfD5QlVNltjchmvAiVIFV8nY6p9/ilbXHrzqZdlWmHsDdcWuXvaClm9zyhkCdh/n1u3/aHgw85il/vwSGA0=
X-Received: by 2002:a25:acc3:0:b0:d60:b5f2:9824 with SMTP id
 x3-20020a25acc3000000b00d60b5f29824mr6964370ybd.23.1693673823171; Sat, 02 Sep
 2023 09:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230901111548.12733-1-brgl@bgdev.pl> <CACRpkdYLcOZQ9r46aBwesh-H392C_0AWC8n2ikuwUknfEhoNNA@mail.gmail.com>
 <ba9803e9-3aff-42b9-87ad-4e6d75d36d87@sirena.org.uk>
In-Reply-To: <ba9803e9-3aff-42b9-87ad-4e6d75d36d87@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 2 Sep 2023 18:56:51 +0200
Message-ID: <CACRpkdaDG30k_OM_xTCM6yOTB3rjzxrsbbrLZpvYCh7e66Zt7g@mail.gmail.com>
Subject: Re: [RFT PATCH v2] spi: bcm2835: reduce the abuse of the GPIO API
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 1, 2023 at 2:31=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:

> > > +       struct gpiod_lookup_table *lookup __free(kfree) =3D NULL;
>
> > Whoa!
> > This is really neat.
> > As noted, it will confuse static checkers at no end, but they just have
> > to adopt. (CC to Dan C if he now runs into this.)
>
> It also doesn't look amazing for humans, it's very not C like...

<linux/cleanup.h> and the __free() macro was introduced by Peter
Z who also very famously suggested (OTOMH!) that instead of
adopting Rust to the kernel it would be possible to bring the
desired Rust features into C.

Which is what he does, well the feature has been there for a while
but he identified it and made it easily accessible.

Now if this path is desirable ... yeah. Maybe a matter of taste.

Yours,
Linus Walleij
