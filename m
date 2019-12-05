Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4DAB114565
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2019 18:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfLERIq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Dec 2019 12:08:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43963 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLERIq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Dec 2019 12:08:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id h14so1891970pfe.10
        for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2019 09:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/rXekQHS5OmcamXJRlcX1nMr/U/pWRS/JvOxVvicWg=;
        b=JiLHjMZatH1xXbOOdV5XH73w1wGgZ28z99UhA815C1L9UpGMWfl48+YMLpa7wA8bMb
         kuOnBIAW6fBhLJ7bIehmzZHBNogXe5FLojJHEsrn4umabCyI8ikMm4R71m0mSzRQcsSW
         3dK7iX9BvXCDPgEqwSRxeyLVV37F0GUyEVFzHzSHz0o6O5ZWse+0xjIlXDyQqHl5ak3a
         97VRVyg/HfwClFf/U3B9T6gRePGmOOB+dsa2xVkU278fDvbNTGKUFdQDlwsmDBccYE9p
         REYwgObNV9Vsgh+ZHvrShzf4AiHdHNaE4ST28DYIROdbrVKO/l1tDQDphzxugJ91bBtX
         +wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/rXekQHS5OmcamXJRlcX1nMr/U/pWRS/JvOxVvicWg=;
        b=O13dTGCUh1rbCYGA11oCtdTvvCU5BV8QFLdKx4vDgDs7eH6snkWcDCynIs3Aq7oD6h
         +MacY5vgUl5kOjVujWNs5NAxcf4NIxZgs1WqCkHK4FpESArMb3+V4RER4j7htJwNo5AQ
         z4182gKEnrFkJXTnjb1FBTZNv2VZ9zfRspZbKwdv+BW1ESC7L66x3n6PTB9RV2WrCfyF
         tJtBywjgVBVN9oflR+N8dIvOh1jfYGnPvQmDh/+lWwOqBKPZFGYPGmCP5VrEfadkbXeQ
         ED9x3cqO4Kvcunk8zeKoVHUcT61GJA9B4EaDiZtinr89/giDnN84TgMdCCTL0FnwuGkT
         5KmA==
X-Gm-Message-State: APjAAAXQ8hkREcdngMfMG+LPBgbUY9ZxJziUSj7DYoXBZNQ47HP0QITn
        6KycfxFX82Uoeu6cnFRtjMkvWj1ebM49pOiMz4c=
X-Google-Smtp-Source: APXvYqxvv/BN8PyOMboKgozg2AK7hqyxcNc6P3+27dfhnApzzlgXjYniZ2dwAF5v7eLLCcZ4CLTiwtrLmB3/B4ZNGnU=
X-Received: by 2002:a65:490e:: with SMTP id p14mr1542181pgs.4.1575565725246;
 Thu, 05 Dec 2019 09:08:45 -0800 (PST)
MIME-Version: 1.0
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk> <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
 <20191203163521.GM1998@sirena.org.uk> <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
In-Reply-To: <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Dec 2019 19:08:35 +0200
Message-ID: <CAHp75VdiTvXm0P5k75oupFck4sQoh--ZY=YvNMFop9k-gZTNZw@mail.gmail.com>
Subject: Re: Side effect of SPI GPIO descriptor usage
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 4, 2019 at 4:47 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Dec 3, 2019 at 5:35 PM Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Dec 02, 2019 at 02:11:51PM +0000, Phil Elwell wrote:


> and I can find one more outlier:
>
> drivers/mmc/host/mmc_spi.c, function mmc_spi_initsequence()
>
> This very clearly want the inverse polarity of whatever was the default,
> but the code assumes that SPI_CS_HIGH implies that this is the
> actual physical level and forces it high, then low. I will send
> a patch for this: what they want to achieve is the inverse of
> whatever was configured.

Linus, hold on.
MMC SPI is abusing protocol, you can't fix it in logical way.
I recommend to read the protocol specification.

P.S. I would be glad to be wrong, though.

-- 
With Best Regards,
Andy Shevchenko
