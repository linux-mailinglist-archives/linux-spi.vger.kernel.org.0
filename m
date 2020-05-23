Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135DC1DF6F8
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 13:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgEWLwy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 May 2020 07:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgEWLwy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 May 2020 07:52:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D37C061A0E;
        Sat, 23 May 2020 04:52:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a13so5482356pls.8;
        Sat, 23 May 2020 04:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5xoUn3Q4/Fp4EcCpbrhEdHWRsyadLgqa5T9a3XYKYo=;
        b=VQm47eTFvQPbJMM8ywJp0vkVBO//feHejDn7v3HotsM0ncw5eruPvMdLiANU0BlXNu
         oftqiKGG41cDRuJnUd1/36SN9o26ZTp1yMmkcKCbZCd5yEEH8LO8eH2+wxtz+Fc7RxLb
         LgQgAzDH/pMplqqqonGc/UdaEqe2uod5u9w07a3GU5GVCheRTmlAQgEJqPpkIxeFaJDD
         3ib1dYSbyxf/ZDQtaOHF5K4A/sqQNWlawy1FYpizPXPjj83DJIPNzGwfgGLWW27E55Xv
         csXaqfPRL4f5W4yvvBrTjj9bZpcBT6AFI8QIKpnTYairyw1ia+YiDA3Rpd9u+oyqatBv
         8zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5xoUn3Q4/Fp4EcCpbrhEdHWRsyadLgqa5T9a3XYKYo=;
        b=meUbOQ+YqkloysQU3UhRurCjTMIWEY7t9IRmwRY9UWETWTx0nhaXrSVPObb7Pzgzj5
         8MDQIWL0dMp0UjFgBc4Q/bgzFjUlHpBaWQtzvPjgJmUfkEwHoDn8cDFq9AJRxwZ0lSet
         KtjD0MqUk0KIF1J4H7DNwSqczu3k+1gURGDiclpwzXINSavEZJK21lNN18VfzMwqrnHQ
         XHPSgLmqkFsl2DaltT1ER5wHejB+8M8jjPXHHRPP5uBRNiV4YPhmgq9sl4aLqL3KhpXR
         bnZECR1z/UXsPbohdCCd6ZysSyYEcTmNtXHf7AMNp3Mi1pQFZtSYTRsU07Ck4NR8hvN5
         u6Mw==
X-Gm-Message-State: AOAM532ZVjmXhXzK+7QT/dD/Wld5xsrjJqTsDwcEgqkvjkCXC9uokKkc
        lBKb/xtm2roxtI8mwU7DQfjFyLqpm/Gbdgq2xZE=
X-Google-Smtp-Source: ABdhPJxEGjiwB7kgqx5YJHq/6Pv/Bu4eDGwGyRlLk2ISdBwnq2tmscxvk9wJb2o21pGftL0ah3jZsqeFxJdAvO8kI5Q=
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr19539324plb.255.1590234770883;
 Sat, 23 May 2020 04:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
 <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
 <5a8a6e7b.bef25.1723b588c7f.Coremail.dinghao.liu@zju.edu.cn>
 <CAHp75Vem1kQviLrobJ65aVOb_VCmLkAv=5U_iXAdWPNe7n0+Ng@mail.gmail.com>
 <CAHp75VexCBc6iCrd_VLj5jXE8cxxdzUUf6pMG6O8LjtNj0J1Aw@mail.gmail.com> <53722a45.c204d.172414e8ed8.Coremail.dinghao.liu@zju.edu.cn>
In-Reply-To: <53722a45.c204d.172414e8ed8.Coremail.dinghao.liu@zju.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 23 May 2020 14:52:33 +0300
Message-ID: <CAHp75VcfcE63KHbyokoBuBKDdTHiB8QiauL8XU=rRo0-=NL-Kg@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] spi: tegra20-slink: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 23, 2020 at 2:32 PM <dinghao.liu@zju.edu.cn> wrote:
>
> > On Fri, May 22, 2020 at 6:20 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, May 22, 2020 at 10:46 AM <dinghao.liu@zju.edu.cn> wrote:

...

> I also checked many other implementation of probe in drivers.
> It seems that using pm_runtime_put() is ok.

In *error path* or normal path?

> If I misunderstood
> your opinion, please point it out, thanks.

Bottom line is (for the *error path* case):
pm_runtime_put_noidle() has no side effects
pm_runtime_put() (potentially) might have side effects.

You should choose one which is clearer about what it does.

-- 
With Best Regards,
Andy Shevchenko
