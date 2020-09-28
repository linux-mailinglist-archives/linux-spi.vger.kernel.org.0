Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301DF27A8BF
	for <lists+linux-spi@lfdr.de>; Mon, 28 Sep 2020 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgI1Hga (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Sep 2020 03:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgI1Hga (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Sep 2020 03:36:30 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19750208FE;
        Mon, 28 Sep 2020 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601278589;
        bh=EZsgizha+4vidtJcdQsnLl7s03GVBSE6qX8QQvIuSwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DjtdV5U6pmfdzytym0Ljq7Q18u2uZwGbIps+15wRsVBSeGNnYp9i+WlBdWVHT2Rwc
         GEpMdgp4nxV9CfxypU58PgMpqWUeiM6PuwcrJY5txEotuMOtWj+wrKrN+eTB1+WVK6
         5g9y9jqXlHjpnp4DlA988t32sKD6Qadr1Am9lQWg=
Received: by mail-ed1-f45.google.com with SMTP id e22so205315edq.6;
        Mon, 28 Sep 2020 00:36:29 -0700 (PDT)
X-Gm-Message-State: AOAM530B77b7KPCR/RllHCr5jCQFds7F2SP28+UmN0FzyKLuGD8w2GPH
        zpvcO2eDKO+GxdNKTVVLWd1pkihJ4yAMQPXEkRg=
X-Google-Smtp-Source: ABdhPJyIDlL6FJVIJiEe0/i3txpPYMMV6w7U9VT6MR4Bs/jJkfgvAudqi+FMUebgQrRhDc2cuYI0vhM47hYZ+tcof8U=
X-Received: by 2002:aa7:da16:: with SMTP id r22mr335430eds.132.1601278587625;
 Mon, 28 Sep 2020 00:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200927224336.705-1-michael@walle.cc> <20200927232747.3jwr6mqql727etyz@skbuf>
 <CAJKOXPeeKyPzx4pnuXT=o7p8hE0SeCuyt9d8uj+Dc9fjjXULMA@mail.gmail.com>
In-Reply-To: <CAJKOXPeeKyPzx4pnuXT=o7p8hE0SeCuyt9d8uj+Dc9fjjXULMA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 28 Sep 2020 09:36:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcVJqjOn6gn+SYXtDbmi2kG2j=KFocagD7Lpe0YHwxbLA@mail.gmail.com>
Message-ID: <CAJKOXPcVJqjOn6gn+SYXtDbmi2kG2j=KFocagD7Lpe0YHwxbLA@mail.gmail.com>
Subject: Re: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
To:     Vladimir Oltean <olteanv@gmail.com>,
        Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 28 Sep 2020 at 09:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > This is because since this commit, the allocation of the drivers private
> > > data is done explicitly and in this case spi_alloc_master() won't set the
> > > correct pointer.
> > >
> > > Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > ---
> >
> > Sascha, how did you test commit 530b5affc675?
>
> Hi,
>
> I just hit it on my Vybrid systems as well. It fails on every boot, so
> I have doubts that it was actually tested. The fix was posted on 23rd
> and applied within a few hours... also no time for anyone else to test
> it.

The flow of this patch to mainline/RC reminds me what Sasha Levin was
saying here:
https://lwn.net/Articles/753329/
" - This means that -rc commits mostly end up replacing obvious bugs
with less obvious ones.
 - A merge window commit spent 50% more days, on average, in -next
than a -rc commit."

Best regards,
Krzysztof
