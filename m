Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F208E78FD01
	for <lists+linux-spi@lfdr.de>; Fri,  1 Sep 2023 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345106AbjIAMP6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Sep 2023 08:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245042AbjIAMP5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Sep 2023 08:15:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFBF10EB
        for <linux-spi@vger.kernel.org>; Fri,  1 Sep 2023 05:15:52 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d7e6d9665bcso724423276.1
        for <linux-spi@vger.kernel.org>; Fri, 01 Sep 2023 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693570551; x=1694175351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKQJzdrwVynBj+i/KLrgcZw6v08VJmYn3Jbn1ugOea4=;
        b=u4EYzcj7WRCe50N1iDyZxN1+j8HWYEA1RrcN6w9eoFyNnmbVGTvEvd63hNKMboft0p
         nRiQEFE4KO7xe/namXhRgqKyLqw2llMj6c7bbb+XHwvMk0PAR+5zrDIqqv4p+WAuL3/O
         Qmg2A+D9EIbr5ywgTxQKeMTML4zcODtw5XZrI6kPAks96jdv2XUoQuZ3ZNEuerGnoVPY
         H3DdCXmZdtE+8fZowzyJae761VODdyoesU4rj85ytlXLQ20gDRetVLUgo4tDUYJUQ6Ll
         gziVu6kAKIuEW/0NJGESVXoyXLCKjZxRgzVscPv3fONI0coxOn60mUFOS3JH/gPXKA5n
         Gd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693570551; x=1694175351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKQJzdrwVynBj+i/KLrgcZw6v08VJmYn3Jbn1ugOea4=;
        b=P22DBIxgBCATYgR7TCegsnIsqOvQCeZGdoq04iNWXgrHHm3PnpKr1AJ8iSr9WDLcCS
         aNRHbGG3TTH7IXuy//EgKRLnt/kkSkC9pgcG2VQV1IRrefOGVTUDioh1wsY698nOl0IY
         U4Xq/9YziNQS2OcqAZQIkr2BH6UjO25ZLFOOZ1B4nZ3BMeULyISXadlUOr+46JntqVji
         f41akGwOvPUyV0rir81QJmqmYlbATYhlEByihpZLlFn/+dUD/F1C26vdCKjMCHvbqt5s
         fpYUXBhIEPmABOCuHqe8PSninJfqxuxL36Fs0eLiPnZw5uO3oGuWbeqKiesmeUnlRqo8
         mFxQ==
X-Gm-Message-State: AOJu0Yws+ZX2XOP4D8T3fUwIU5vp6ruId3i8q7FHS/ZhVk5iHpqxVKyv
        0lGbje63DbgF5jBdy/6/nP1PW/BMDK3VuTSZUrgIAw==
X-Google-Smtp-Source: AGHT+IEGIJ2ghvCH0Ox2nia398Yqxzna/6LWbQzpvZgwZKocqcwbT3A7SbPs9h3C7RVL5XV/nxF1X5cIH7DZCApTsGU=
X-Received: by 2002:a05:6902:120e:b0:d77:e463:7c0e with SMTP id
 s14-20020a056902120e00b00d77e4637c0emr2955849ybu.50.1693570551371; Fri, 01
 Sep 2023 05:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230901111548.12733-1-brgl@bgdev.pl>
In-Reply-To: <20230901111548.12733-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Sep 2023 14:15:39 +0200
Message-ID: <CACRpkdYLcOZQ9r46aBwesh-H392C_0AWC8n2ikuwUknfEhoNNA@mail.gmail.com>
Subject: Re: [RFT PATCH v2] spi: bcm2835: reduce the abuse of the GPIO API
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Brown <broonie@kernel.org>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 1, 2023 at 1:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Currently the bcm2835 SPI driver uses functions that are available
> exclusively to GPIO providers as a way to handle a platform quirk. Let's
> use a slightly better alternative that avoids poking around in GPIOLIB's
> internals and use GPIO lookup tables.
>
> Link: https://www.spinics.net/lists/linux-gpio/msg36218.html
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

> +#include <linux/cleanup.h>
(...)
> -       struct gpio_chip *chip;
> +       struct gpiod_lookup_table *lookup __free(kfree) =3D NULL;

Whoa!
This is really neat.
As noted, it will confuse static checkers at no end, but they just have
to adopt. (CC to Dan C if he now runs into this.)

> +       gpiod_add_lookup_table(lookup);

Maybe we should mention the obvious advantage to the previous
hack: if there is a "cs-gpios" in the device tree, it will take precedence,
because gpiod_find_and_request() will try gpiod_find_by_fwnode()
*first* and only if this fails it will fall back to gpiod_find().

Hm, maybe we should go and fix these device trees? :P

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
