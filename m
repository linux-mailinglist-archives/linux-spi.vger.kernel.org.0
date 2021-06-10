Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFADE3A3411
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jun 2021 21:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFJTdw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Jun 2021 15:33:52 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:40616 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFJTdv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Jun 2021 15:33:51 -0400
Received: by mail-yb1-f181.google.com with SMTP id e10so901557ybb.7
        for <linux-spi@vger.kernel.org>; Thu, 10 Jun 2021 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXpFlNawRoF2WjSLirB384nbUTjlBXunJ1Pggj2upEY=;
        b=f4IPvjFMwOpSodGyKAhGTiUQFBIHmIvnC2Op/uXl1Hv0D/vvoVrCiAsHrGqgXv6AiM
         X8Jew9N42sv9H4CY26E/9IKnGlWTgMhMsEj3ZxlP02uI0mEIKooOlGuECNZnlZp4x9am
         x2CSNCvuO+YpAWWwlp7gAU9TvYPXS/EhNNeG8GZ/zrzK1r6DzusRTuP2kEAfgDG/DC4A
         R8HQQZS9OhbLf4nb8Enxwy0AOIWAtHuXYEpj5eYSZ+/rh/AWKdm1KNraH6nd0rVarzw4
         lRpV8R4wav4Qlim2f+m+zVbRsv1eb2euBaq+Uw9F/n9dX2lRaEwq3mTDowzCdwumSemF
         /Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXpFlNawRoF2WjSLirB384nbUTjlBXunJ1Pggj2upEY=;
        b=rNkACqvyYYEORjztekZf+rEKztx0VmNNIh2tqQTIJ8ItaDPnpv3z1Y+496mCU5YyRX
         eVpRhJf4Q4rPFUnCnSn2wj7Z8ZaurlUdxHcdOenFy4nTdNqGYKaKb0mP/muKBUAgiE5b
         xlF6Q2qDSHvyx7HUS/c7aqCKo1YAS+R/020vMPhBu+zHRoKsZNfpF4avN61EH7QY6phD
         AxEKGWhhkNlgk9bOTwmipIfFxbGMmfyxyLZ3yUT6RE4BBpOKlDC5Vk/eLAheN9VpDRxD
         huTH/NH/8HbhYn89N9KbWyN7wXtmURG3PH6zcnDMjwEw1K7ojmxSAS3zGMmrl9uJ7v0i
         yoDQ==
X-Gm-Message-State: AOAM532j+6MjokxIVxPqeJ60RPOFsnb6lpT7N66Ie7I0Fbnaf+fBvsc+
        WN+GvofKxJmZTSlB9AXyCnRcWXYcMk54IGEgbelSqw==
X-Google-Smtp-Source: ABdhPJxwuDOwVyQouPxcVuS3yjdy7twi/oWJ7ON3cIBq0fRPZ520caYhkgh/JqLIo7FO/U3hxp9VYv/y7j1Sc+QZ4yI=
X-Received: by 2002:a25:cbc9:: with SMTP id b192mr617261ybg.96.1623353454878;
 Thu, 10 Jun 2021 12:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210603170734.3168284-1-sashal@kernel.org> <20210603170734.3168284-3-sashal@kernel.org>
 <20210606111028.GA20948@wunner.de> <YMJR/FNCwDllHIDG@sashalap>
 <CAGETcx_w8pHs3OXQyVXYWV1CY4qGTWrZ9QNEwz=TL8SLbyq1bA@mail.gmail.com> <20210610192608.GA31461@wunner.de>
In-Reply-To: <20210610192608.GA31461@wunner.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 10 Jun 2021 12:30:18 -0700
Message-ID: <CAGETcx9xSsBMmxzKzgwkWYTrFbKidxY5ANmCmXsF6LduTMKtbA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.12 03/43] spi: Fix spi device unregister flow
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 10, 2021 at 12:26 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, Jun 10, 2021 at 12:22:40PM -0700, Saravana Kannan wrote:
> > On Thu, Jun 10, 2021 at 10:55 AM Sasha Levin <sashal@kernel.org> wrote:
> > > On Sun, Jun 06, 2021 at 01:10:28PM +0200, Lukas Wunner wrote:
> > > >On Thu, Jun 03, 2021 at 01:06:53PM -0400, Sasha Levin wrote:
> > > >> From: Saravana Kannan <saravanak@google.com>
> > > >>
> > > >> [ Upstream commit c7299fea67696db5bd09d924d1f1080d894f92ef ]
> > > >
> > > >This commit shouldn't be backported to stable by itself, it requires
> > > >that the following fixups are applied on top of it:
> > > >
> > > >* Upstream commit 27e7db56cf3d ("spi: Don't have controller clean up spi
> > > >  device before driver unbind")
> > > >
> > > >* spi.git commit 2ec6f20b33eb ("spi: Cleanup on failure of initial setup")
> > > >  https://git.kernel.org/broonie/spi/c/2ec6f20b33eb
> > > >
> > > >Note that the latter is queued for v5.13, but hasn't landed there yet.
> > > >So you probably need to back out c7299fea6769 from the stable queue and
> > > >wait for 2ec6f20b33eb to land in upstream.
> > > >
> > > >Since you've applied c7299fea6769 to v5.12, v5.10, v5.4, v4.14 and v4.19
> > > >stable trees, the two fixups listed above need to be backported to all
> > > >of them.
> > >
> > > I took those two patches into 5.12-5.4, but as they needed a more
> > > complex backport for 4.14 and 4.19, I've dropped c7299fea67 from those
> > > trees.
> >
> > Sounds good. Also, there was a subsequent "Fixes" for this patch and I
> > think another "Fixes" for the "Fixes". So, before picking this up,
> > maybe make sure those Fixes patches are pickable too?
>
> Aren't those the commits I've listed above?  Or did I miss any fixes?
> I'm not aware of any others besides these two.
>

Ah, those are the ones. I didn't see them. My bad.

-Saravana
