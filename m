Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EB437A9CA
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhEKOpW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhEKOpU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 10:45:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD7C061574;
        Tue, 11 May 2021 07:44:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b3so10918317plg.11;
        Tue, 11 May 2021 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBC2p5ihKeMf1HGjAdHfxw7d7sie0dBHM2U88fiva74=;
        b=pikvPPb3zc241TwPQBu/ftn/nF90SMkMFXM9Yfn0ed2jvmIQ1ZSQeLXrtv1lg4j/NS
         AhVaAsCzk9FpYmzDGDh/Ma2ZlzTWSqJTqmYj+QFQX9/Kur0QszpOupXkwfm4sQ9Msp3f
         Ds+SFJngqaBD+QHFmcFUbGWxqNqmEyQzd4YQMmHN2Td5CPwfyM2pBXyXVsyZmc9a7R7f
         CLt1aaAKqj7DkfFu95ygHRx67Uqaqi3xjjcxhMffjl4T1HpW8LBhKK6Or1L9ZFjMPVHB
         vmbsHKmeVBwaPg5vsrvlB4kQjNnghoFBs5TpS7VJ5g+hNog6Z/dod7mWHlDE8O+qzr7Y
         TFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBC2p5ihKeMf1HGjAdHfxw7d7sie0dBHM2U88fiva74=;
        b=e/ibRPI3jDEPKCLsmuQHJKgWQ7TJcAfger59o1hrXwP1+2ybFk53C24lAoUqwy2AN0
         sEvyfeE4VtxKgTc2C+5VAy1TWEsJZ6Mlz101AubkEygScdOxOSzzhMdkA9TxfmzBEWlY
         +hRYQZ5CzGXCvaoEXDgGkGvBhFx/qMnRAbyJbTU0d6vOZP4Vbc2k3oybloPYYs/yp2+m
         /5fsTK9blJLkAS4DsLo3BqVMsTwMoax5qOuxQhy2CO6dM9N/G3euLGJV9TjWVi6qr+4l
         V9lrk5jmWpgGzYs6TnaPos/+RHZeUUjs7sSQPpgc4erCEg/SRSjHykVrkM0ebP+UIHoS
         rvdA==
X-Gm-Message-State: AOAM531NP1Wk8JLJ0mYZMgi332GI9KOnJBG+p7h5Gd9llbls2k1h02DI
        SGq/y6JhQb+PIIS6QoEI0HmQJUbnwdWcySi+oL0cq1u4X1A=
X-Google-Smtp-Source: ABdhPJw7BO8Pi8gIIgCJtYQyji5hMrwwNMo4n4xlVAAFcT7KACAbMMyAsgd0gFbLpFA7N5JXdn9mTIhUuJVgSRzbKsU=
X-Received: by 2002:a17:902:b20a:b029:ef:463:365a with SMTP id
 t10-20020a170902b20ab02900ef0463365amr24194656plr.17.1620744253449; Tue, 11
 May 2021 07:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
 <20210511134706.GI4496@sirena.org.uk> <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
 <CAHp75Vca2KT4kd9zw3ECqym1rRDSg2NNbwRRVVA1L7vyD3VCJQ@mail.gmail.com>
 <YJqRBIdTlvnsCYsn@smile.fi.intel.com> <20210511142433.GK4496@sirena.org.uk>
 <CAHp75Vfh4AViMMSm6MKAGP7s_ANOSyHVDj5qG=j5YrLPjH+Y8w@mail.gmail.com> <20210511143807.GL4496@sirena.org.uk>
In-Reply-To: <20210511143807.GL4496@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 May 2021 17:43:57 +0300
Message-ID: <CAHp75Vc1E2ahkR6zKDT9BT6O5TH6fQPLZHKLTN7M_qqfD=EubA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 11, 2021 at 5:38 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 11, 2021 at 05:28:13PM +0300, Andy Shevchenko wrote:
> > On Tue, May 11, 2021 at 5:25 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > Please stop.
>
> > Okay, what should I do?
>
> Nothing.  Just stop sending this out until I've had a chance to handle
> the current version.

Thanks, and sorry for the mess.
v4 I have sent before had a chance to read your previous email(s).

No more versions this week for sure, and sorry again.

-- 
With Best Regards,
Andy Shevchenko
