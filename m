Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41E637921A
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 17:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhEJPIC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243308AbhEJPG4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 11:06:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2E4C049632
        for <linux-spi@vger.kernel.org>; Mon, 10 May 2021 07:27:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z6so16860341wrm.4
        for <linux-spi@vger.kernel.org>; Mon, 10 May 2021 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QUpLnwL5Ztd2UMxVwblTFeegcFTeZYE+oxBEv6V5uU=;
        b=aTCVajgMygiZTtnQ4Q7j6vbW3+ZkvuMh+7qgG6J7j4a0kKzGpkFpneQFebYgaxQFAD
         vI+GJZE80ci/Qmi+QdgCuzlCEnDlheUfiJXnBj+mpB5QBRGSmQ5lGxr3vYwmKZek7JYM
         O5z2dJxEVkcy5aT5IVy38YXcxVzGjXBZKtMSZ2XXMUSqlQkw5kpgHHAwdSa0rPMnmBW0
         1d6Oy2lbMs6pNPlc6U5enL4jsHu7EE+s9AfxvSBFU+0ufwaTmX0UG2xzUN7XOtsl6Uv3
         TeyXOBiJVKeERHZGMQAqcx5HLeoJpnCo12dvCkglG1FPmzD6kDmvwqNG4cEqGzmLfZEA
         UgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QUpLnwL5Ztd2UMxVwblTFeegcFTeZYE+oxBEv6V5uU=;
        b=qwkJ3OjQPp5BBQbsAm/AyDyDcdFl9444iFND9XPNwKHKFpAujXb6GfWlknQNfNrA09
         V2vtHLy7N1W6Z5HZNYfUWgfTDx5/NURd1skuj0now+Z3CCphAVnX3Tw5CnWRNT79StnS
         Y/khn7s1pYVcZ8tEphfTFew0ItiKadFWIm9v++JWaPzq8ZtKHwlMH2jGcrSJce2ReBrG
         Zb2FoCqmatDgvFQEEzFGkL8tJ71dQ0T7R2t8MoBoDftc20ggBXx3HqDTR3D647y43faf
         DWxgXTP1SJPvClYzo2anut4BleyNB4Uq58+C4NATRDRvve3PALhZyv69xgt76CnXFnFQ
         6gvw==
X-Gm-Message-State: AOAM530pONHCQSEFSMaPgf16ZAjXLIAVfwZHJ/ExyDEnLjZKqVH6k2Xn
        lIWd8N4QT6vT7XrJWnzu3r7d/B3plEgZHzxYHsQ=
X-Google-Smtp-Source: ABdhPJxj+o/xqJXwU7No1HBM4XsyQRglkWLrnQcd0nb3r6fC5HlfLqJAR+02udeAxxXWqgMQqGchTQLv8Ox/O5MKTPY=
X-Received: by 2002:adf:d215:: with SMTP id j21mr31759313wrh.251.1620656867795;
 Mon, 10 May 2021 07:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com> <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com> <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
 <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
 <CAGngYiW=RTkHoSndJDr0mMUgLFfuB18g=AwKTvi8d2-tdBrroQ@mail.gmail.com>
 <CAHp75VfD5kEnjvvRWUJwpmFaWksnnTf_ewBNDsxz3W3kQMUv+w@mail.gmail.com>
 <CAGngYiVNE1FjsJZeHL5afpWeqf7pRhHqUcKkChML3KQ=6cj=Bw@mail.gmail.com>
 <YJkaqV4JalpS09bs@smile.fi.intel.com> <CAGngYiW=YP2xuxhiQFxmWD68nd9wKJJ_j+mWswGGT=m+44p3hw@mail.gmail.com>
 <CAHp75VeWqGpXPbO6JW2fA7fL=AsYCDbFdwJobuXwssOgRSdfQA@mail.gmail.com>
In-Reply-To: <CAHp75VeWqGpXPbO6JW2fA7fL=AsYCDbFdwJobuXwssOgRSdfQA@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 10 May 2021 10:27:36 -0400
Message-ID: <CAGngYiXyGkG73Ge7i_vMrfu0YS7jM_7VR7s4jUE6fUg7G2Ls6g@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

On Mon, May 10, 2021 at 10:02 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> For now I guess my patch is necessary to have. I don't think we may
> delay its distribution while developing a better solution, do you
> agree on this?

Agreed 100%. Fixing your/XinHao's immediate issue is the important thing here.

From what I can see, your patch won't break OF, so I'm good with it. I
can review / test the rebased patch on an OF system if you like. All
subject to Mark Brown's agreement, of course.
