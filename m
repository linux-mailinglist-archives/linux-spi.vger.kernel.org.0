Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C354478F935
	for <lists+linux-spi@lfdr.de>; Fri,  1 Sep 2023 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbjIAHk1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Sep 2023 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbjIAHk0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Sep 2023 03:40:26 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C410D7
        for <linux-spi@vger.kernel.org>; Fri,  1 Sep 2023 00:40:23 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-48d0db157efso605723e0c.1
        for <linux-spi@vger.kernel.org>; Fri, 01 Sep 2023 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693554022; x=1694158822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdSEnSSizczTE8HJIRHe+3r0VQs218gZ30sV8UlBVvo=;
        b=yZA8qyctQFfw3y8c3bJ/tEmiiWf7nsBvhdEKU8qSr1pvETfeX53fx1Bi8QUCXvz8mj
         c/m9YJZk/vvWIDLpDyDzs+qfQGC+eksxmZISEU5l32P5BRP99YCNjfzyvEHOAD1GCIXl
         js9MWZMHU4KDcdtPkoEqel2t+QNHdRCfq6fyUvTxomKHDRqjMcHC7YR3P4rOwhlyuqaJ
         OAp7gHf6OedwMF28BRAeagTHzSyLtbc+pWGCi1EkSQQjDC1rXNrj8jb/LhITyfxAPXLQ
         FUKiLC3Qrow90wTEV9nrPIzXcxb9AuA7/jRhGOW/Hpq6WgA4bXvoIbuA6TUNIi8P+Xim
         lYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693554022; x=1694158822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdSEnSSizczTE8HJIRHe+3r0VQs218gZ30sV8UlBVvo=;
        b=fl84Ht9E17bCCVStIJxlbxUUUDc2T5+3UJzLC6Jn9FNGNOlxIxn0KYOFUe7o8Qc2Qp
         e43XRFXozcMUfcjnmw7UhCapV/Y7rZwcce/CcF6a9HSQ0ZLAobpxZG4gMfuXNb1RHsaF
         wCaojF4We3cJo6vxn0A1t+n17RcW3Sq1bZtFXS25m1KuAnEtDYvgWAy1u1a/2TRLLdN2
         JWMLNGsXsVi7lJc/qkiJkAEckrNRJGkz0N6f5pcfL4GxDY7nsFF5S1xpqnzHJepi770G
         Z0rs3Z4ovtGPJJK4iRICd/uzV1hZLWqKLq6ICTbN+5p+k/QL26wDYEaEqW5o34g/McQu
         zFgQ==
X-Gm-Message-State: AOJu0YzbXAG9uhnpPrQmW+qqtCs8EUjsGvM3hF3PDqATzAcQS3X3XXCM
        DxpJr+1kPGr2uSHf1DGl9FkOny57MPG2agBBCDRtUA==
X-Google-Smtp-Source: AGHT+IF4/dIUb/yBKlSH666awkw3CGUYKSZGAkFwNTY7ILWywn+c24x4A5D+cmyWsgAnTqUbFGhsKHxztcUzGlh/8wc=
X-Received: by 2002:a1f:df01:0:b0:48d:bdd:9913 with SMTP id
 w1-20020a1fdf01000000b0048d0bdd9913mr2102598vkg.12.1693554022565; Fri, 01 Sep
 2023 00:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230831194934.19628-1-brgl@bgdev.pl> <ZPEhS0uBWABpaE+/@smile.fi.intel.com>
In-Reply-To: <ZPEhS0uBWABpaE+/@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Sep 2023 09:40:11 +0200
Message-ID: <CAMRc=Md-6i+nqDtYiUUtZExA32c0nJxhevYsiZqmd1PP8aaMng@mail.gmail.com>
Subject: Re: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 1, 2023 at 1:25=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 31, 2023 at 09:49:34PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Currently the bcm2835 SPI driver uses functions meant for GPIO provider=
s
> > exclusively to locate the GPIO chip it gets its CS pins from and reques=
t
> > the relevant pin. I don't know the background and what bug forced this.
>
> ...
>
> >       /*
> > +      * TODO: The code below is a slightly better alternative to the u=
tter
> > +      * abuse of the GPIO API that I found here before. It creates a
> > +      * temporary lookup table, assigns it to the SPI device, gets the=
 GPIO
> > +      * descriptor and then releases the lookup table.
> >        *
> > +      * Still the real problem is unsolved. Looks like the cs_gpiods t=
able
> > +      * is not assigned correctly from DT?
> >        */
>
> I'm not sure why this quirk is here. AFAIR the SPI CS quirks are located =
in
> gpiolib-of.c.
>

I'm not sure this is a good candidate for the GPIOLIB quirks. This is
the SPI setup callback (which makes me think - I should have used
gpiod_get(), not devm_gpiod_get() and then put the descriptor in
.cleanup()) and not probe. It would be great to get some background on
why this is even needed in the first place. The only reason I see is
booting the driver with an invalid device-tree that doesn't assign the
GPIO to the SPI controller.

Bart
