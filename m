Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E3E7C4BFF
	for <lists+linux-spi@lfdr.de>; Wed, 11 Oct 2023 09:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbjJKHgf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Oct 2023 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjJKHgd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Oct 2023 03:36:33 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86E7B7
        for <linux-spi@vger.kernel.org>; Wed, 11 Oct 2023 00:36:30 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49a885c5961so2220181e0c.3
        for <linux-spi@vger.kernel.org>; Wed, 11 Oct 2023 00:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697009790; x=1697614590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRS9o9I+Gu3iTEeog0JyGYAqHgL6LnsLnS7hSU4NEGs=;
        b=W8kp+MZa7Cves1SOJRbhjitorqMA6SkVBxu6tQRe1Q+oDVDF2LMS5Ab9CmY7FIZUq3
         OOEgWdzSzNulCzKH500KhmHnyh98jaN5/8QVMhTtjEfOCx6WXv+JF8/WoWUuQun7zSI4
         +7CGua/zaZvxBHGgXmaM+8mJjFUWVIHgJKgb9gviemmGFn0yAL94m03rPA6kjjEcNua3
         X7OjUXmBlOlbY8/lcDmuQhJ1876mNG0Pi5t4KofaUHGLiFi9O47IziJI38SClhFTKni6
         GP83fLipKJ6zewuEtxqWvNE7z+J96cnk4NpItLXpAboh4l2BrxhfCKr6dS50uOMGFtSl
         EYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009790; x=1697614590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRS9o9I+Gu3iTEeog0JyGYAqHgL6LnsLnS7hSU4NEGs=;
        b=dp/12e/9mRS4S7OAsgAURgjqwrGYFy5dNJnJX4xJHP3bDit8eB0FeTZ/2ol9X9GVFP
         j1ZuTjMgU/UMIh3/Vz/16ny8npRjN5X9ICiQr1seD/jCM0L9Au05dzkfpyshsRU0HvS8
         3SJm41+14UXgPWX1BR+K/8HY5oqzzeswF7aaC5VKB0wZSwg2d/6mg8FkgVU09e8b/I8R
         oqdRUHU0D5m+Nmvvu/Ql6eC2PKC7ydwa0eGWPGAVKNwHfYMkwACeMMuy6qrziQslWmDJ
         ypECYH/PUo2R9VhE+yvIOMH0nje6Hoy9L+mvLS0IjTCxDjV76kJhvGAn83X90Og4rleS
         mqlg==
X-Gm-Message-State: AOJu0YzAMU9JrI2rFNR73S591+7mE8H8HPnWOR2Q0l6unPXDECwbayjr
        VVFgWh9bih4O3bwgJgqbs/ADz5rM08bjDHiWhiX8HQ==
X-Google-Smtp-Source: AGHT+IH7k7lOk7qzXxwq+a599srjgoT5V/UDb4C9WfWWKOK7ouhbNA93erEP3s0eQiz1RWMrtoMRqXglEcnhameXpjg=
X-Received: by 2002:a1f:ca83:0:b0:48d:5be:2899 with SMTP id
 a125-20020a1fca83000000b0048d05be2899mr16867806vkg.2.1697009790016; Wed, 11
 Oct 2023 00:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231004183906.97845-1-brgl@bgdev.pl> <169696282723.222014.3485016870976123694.b4-ty@kernel.org>
In-Reply-To: <169696282723.222014.3485016870976123694.b4-ty@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Oct 2023 09:36:19 +0200
Message-ID: <CAMRc=MenBeJV+p6LirsCfyaPRWfAvSrVQayqUc77KOyvRGMqvQ@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835: add a sentinel at the end of the lookup array
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 10, 2023 at 8:33=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, 04 Oct 2023 20:39:06 +0200, Bartosz Golaszewski wrote:
> > GPIOLIB expects the array of lookup entries to be terminated with an
> > empty member. We need to increase the size of the variable length array
> > in the lookup table by 1.
> >
> >
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt
>
> Thanks!
>
> [1/1] spi: bcm2835: add a sentinel at the end of the lookup array
>       commit: 9aaa25df9b02bfe5579cbc9b4cc1177c662ec33f
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>

Mark,

Can you provide me with an immutable branch containing commit
21f252cd29f08892d48739fd7513ad79c1cff96a (the one this one fixes)?

We are very close to removing gpiochip_find() from the GPIOLIB and
with this pulled we could remove it for v6.7.

Bart
