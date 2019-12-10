Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAF111857B
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 11:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLJKqq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 05:46:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38802 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfLJKqq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 05:46:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id b8so9360827oiy.5
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 02:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38n+SUSCAZzNf6eZdEVXYZJrATO3RUrrZdJdZGnzARk=;
        b=VwqHSZ+YwGCZMAjvZgyAO4HMseKZWW0sgz+EnxvknPPTqzzWR9FTADSMaQnU9X6gme
         74p79sPpeETPCMc2KaphbFUqur95ybwRQ5SqjrdzHeCRKJnFoJwYLbGiJexDzP/gI6iP
         47ERMHKg4AgaG8gBGPOOKsOcrO3shmce9qlPDUZn19WhxFF5YAtBUqH5I0v5+xxc07j0
         w/6jQkKoLOwFUBerLnjZRNh1TJRYoA26uM+ZFbSQvqViFf4wjTh2/NR6LV5FKmbb+aat
         sBBWoYOVFSOFdCQ1j/JG9g3gL/S0F+DJuADcajRzFm0wrmUfDSS1qZLoTQ2rpJFR6o7T
         +8RA==
X-Gm-Message-State: APjAAAVzqrKsP1QKdoq5pUS03HIHrE2AwA+rJYAbyXiWIN6ZlleSnXJH
        JWLK7Fu7p+T8w8CLtJzxrsSPbfHgp6S7x4WkMDI=
X-Google-Smtp-Source: APXvYqxFKy5Vo805SBXR06cVoeajMuKA/wgrcKvXOkZ0omIS061zfsb9HooemcKP/JOxgJnjTclNGHEhiuulN+0oBRM=
X-Received: by 2002:aca:4e87:: with SMTP id c129mr3233907oib.153.1575974805573;
 Tue, 10 Dec 2019 02:46:45 -0800 (PST)
MIME-Version: 1.0
References: <201912101605.WSMiIcKr%lkp@intel.com>
In-Reply-To: <201912101605.WSMiIcKr%lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 11:46:24 +0100
Message-ID: <CAMuHMdVUS+=k0cK-Z9x8JAS=p3BauPXm6C2EmV-umsJDQc1qMg@mail.gmail.com>
Subject: Re: [spi:for-next 1/2] drivers/spi/spi-fsl-spi.c:749: undefined
 reference to `of_irq_to_resource'
To:     kbuild test robot <lkp@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, kbuild-all@lists.01.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 10, 2019 at 9:10 AM kbuild test robot <lkp@intel.com> wrote:
> It's probably a bug fix that unveils the link errors.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> head:   d661a226ebf2961631a3961f2463f5db1b132430
> commit: 6f2e2fffd91fd9b4364fbefb78ebbe46d05b0bdd [1/2] Merge branch 'spi-5.5' into spi-linus
> config: sparc64-randconfig-a001-20191209 (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6f2e2fffd91fd9b4364fbefb78ebbe46d05b0bdd
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=sparc64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/spi/spi-fsl-spi.o: In function `of_fsl_spi_probe':
> >> drivers/spi/spi-fsl-spi.c:749: undefined reference to `of_irq_to_resource'

config OF_IRQ
        def_bool y
        depends on !SPARC && IRQ_DOMAIN

> vim +749 drivers/spi/spi-fsl-spi.c

The driver should depend on OF_IRQ.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
