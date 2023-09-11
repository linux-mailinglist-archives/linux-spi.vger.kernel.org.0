Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8AD79B735
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 02:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbjIKVkp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Sep 2023 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbjIKQRg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Sep 2023 12:17:36 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D955CCA
        for <linux-spi@vger.kernel.org>; Mon, 11 Sep 2023 09:17:32 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4935f87ca26so1576927e0c.3
        for <linux-spi@vger.kernel.org>; Mon, 11 Sep 2023 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694449051; x=1695053851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c818/2C7MImQNvV0QhVeq9ZOfTZd4ebInAc4aI9fMIs=;
        b=vzc3Ql7/YUBRak/Qonqr2xLPxTvgoEamrAVr/R4Y07Wef7hiScIwrtSLdCiAvwEXeD
         3nKKsugIf6p8MRtzh23IZY+FwaWmAm2chwdiO8s/tM8AqvjZpyAjhIGvZnPi7yEs7Do8
         TwsnUcYkEsw1lzQdrivt2B8rDzz9hnejdXo2IB5R+3ul+hNObllaJWBj5s98gFWBF6U/
         vw/fStodZOeFSReyrCrsxTRZC6svBSUk/MPnGEVixJFaQcHyFKZFXAJIOCtos4rEiwwP
         qhN4WGsZKRZc70hBCF0mcowhVSwlYfT41asLtdKXA+vB08G/AdVdhj7TMaHY1IsymtTF
         pvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694449051; x=1695053851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c818/2C7MImQNvV0QhVeq9ZOfTZd4ebInAc4aI9fMIs=;
        b=H/wC2//Wva0hy0aqY5TslbZRJN25FQYd3ycVo4B6uRNgKMY6vCj+sdWDJP8FLDXWfu
         Q0zma83qluY7y+x86hG8ESnADrY/6V/a0U0HF1t275/7TSIls5Mkcrt+F8AtWx652Z5z
         exisnmjhwFnxdDP8vq6m2SqQIMcczZC/zrfudubZziai+/l1s4NY6qRELPfvUt1hUSVF
         NB61je53i7ObwgkxcjOO12tX1BPGLBhspUiv9y2zSsJvysig0kha3uPFiaovkyGhJyag
         w+wUVtwBjZhDto3fsDsON3KFwpShC0Qo8Rp2/2uL/5X6uSyIy13KBmqWoUlu0Fs3xn1L
         ydrA==
X-Gm-Message-State: AOJu0Yy0VS1K3o5cf7I6muPANRfuK346sX7YYdpkowmT/TIbQSuwB4X5
        sQNRngnBpDH3JZiXuOty9d8devujPDaU4l5zDgke4g==
X-Google-Smtp-Source: AGHT+IFc6pJKCBeZqQGC2/ZX20MffBbxyMuqcPrSrWXFs3wy5taaZhH15QHwzOytsUmVCe297HU7fV6JlmZm6xl/oQ8=
X-Received: by 2002:a1f:738f:0:b0:495:cac2:2532 with SMTP id
 o137-20020a1f738f000000b00495cac22532mr6055491vkc.8.1694449051263; Mon, 11
 Sep 2023 09:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230911161553.24313-1-brgl@bgdev.pl>
In-Reply-To: <20230911161553.24313-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 18:17:20 +0200
Message-ID: <CAMRc=Mddoto8x6ydgo-kryGO+CHWYon_68662VEJ8sn05UAU+g@mail.gmail.com>
Subject: Re: [PATCH v3] spi: bcm2835: reduce the abuse of the GPIO API
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
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

On Mon, Sep 11, 2023 at 6:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Currently the bcm2835 SPI driver uses functions that are available
> exclusively to GPIO providers as a way to handle a platform quirk. Let's
> use a slightly better alternative that avoids poking around in GPIOLIB's
> internals and use GPIO lookup tables.
>
> Link: https://www.spinics.net/lists/linux-gpio/msg36218.html
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Gah, Linus already left his review tag.

For the record:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
