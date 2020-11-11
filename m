Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAAE2AF636
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 17:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKKQY0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 11:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgKKQY0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 11:24:26 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F661C0613D1;
        Wed, 11 Nov 2020 08:24:26 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id v16so873798uat.9;
        Wed, 11 Nov 2020 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApPLUFcnKDn71TaylPm6eHhhvyQNjdkfYuRqJ1JLvIE=;
        b=DQX/rMcMM1jCqyXpIRlSZ47lySB+30dO2HivcfQU+j9CdEyevHbnxItvQ2L/pOjxVR
         29gVdmOe449NOk211xGfWsjfiMFVKp6sDamdJncl2l7/nQDcPm4rxN7RMWGNZgGWxHAt
         0Q7XnwP2tv42M97S+FkFshC/A20yNq8z1kj0ODIDdAifG2MM5zrrW/BvO/5ztOBvpYtC
         E3JUkXJVw5KoBtm6oqwMMtol5+mzPy9fQTv0fPICMbHjJku+uhd1qFJ0XUCtV/75gUbV
         NiZGxXzE62BIh3TyE2M7D5yxV7u+Z/6GCC4gm3qIan+vyIf2QeyofPMcBDN0RqNTb4TV
         Jr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApPLUFcnKDn71TaylPm6eHhhvyQNjdkfYuRqJ1JLvIE=;
        b=f4ENxhSpXsmnZ/3s7M0elxOJ33586oNOmmloa6wfm4bIxrBO0xGomUAnh61+DFfE1L
         CdNAPk2WOO56774pygFxnMCqa4vWuhdIuFGFyru1ZUsfOP28W/07CxiNysMJ1L4ZNsyC
         PmVfnDFfHLXtIEpfVv2z+eisM9l5wCBGhr+aMTZ6SwLHS58Q+IKoXFFzQOECAQoHZzzm
         N94kGVtEHx4Ep/Gxh4snC/N+d6pAj7+aN5R4mkgkzCFFVvALfjC5zQhdOt/qccyB5oNW
         RwITGhA9eN10hhahQPv6DoYXTRi8T3oznjuIXiLgLF+fn5vfiolTrUQi+DgmowAxpllm
         N8yg==
X-Gm-Message-State: AOAM533hqe2OO6iWMUxbkDkz3nmaX1fTziSp+ApEFif1nlkeEzaGZ2Le
        2SC9BmTtMh3QHR0QoCVcfi51TgfDucO1SUGQHx8=
X-Google-Smtp-Source: ABdhPJw1Gddy9gH/d3534yIUUFT+M1v5k1d/va9EFsczYYPkS4/PRzQEeKU9gIvOQMFcVjKGjtyT9ovkzB+nr3AK9Ns=
X-Received: by 2002:ab0:281a:: with SMTP id w26mr13677174uap.49.1605111865547;
 Wed, 11 Nov 2020 08:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20201106150706.29089-1-TheSven73@gmail.com> <160510968064.12304.14797288117651443603.b4-ty@kernel.org>
In-Reply-To: <160510968064.12304.14797288117651443603.b4-ty@kernel.org>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 11 Nov 2020 11:24:14 -0500
Message-ID: <CAGngYiVAdPSCEQm5pJdFQ+3VpwNH1vGD6rPNK1_SQK3Uvfbt5A@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Simon Han <z.han@kunbus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 11, 2020 at 10:48 AM Mark Brown <broonie@kernel.org> wrote:
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thank you !

Now that our minds are still focused on this subject, should
commit 138c9c32f090 ("spi: spidev: Fix CS polarity if GPIO descriptors
are used")
be reverted?

This fixed spidev to deal with SPI_CS_HIGH on gpiod.
But after our fix, its behaviour will probably be broken again.

Another candidate for revert is
commit ada9e3fcc175 ("spi: dw: Correct handling of native chipselect")
although I don't understand that code well enough to be sure.

Adding Charles Keepax.
