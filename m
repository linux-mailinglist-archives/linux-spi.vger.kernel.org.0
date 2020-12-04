Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F252CE42C
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 01:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502082AbgLDALW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 19:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLDALW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 19:11:22 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C6C061A4F
        for <linux-spi@vger.kernel.org>; Thu,  3 Dec 2020 16:10:42 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b26so2471373pfi.3
        for <linux-spi@vger.kernel.org>; Thu, 03 Dec 2020 16:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4pKKFMfBLZOZ3sCLtJOcZ0LC1q6FIsFGdOapn0cj/sE=;
        b=YG7/BFHde8GeX7lx42RuXxFWd4/scS9eXfgkysdXbOefnXw2jtYTo0cjwW5BMdR3vC
         O21bBPedVmXiNUpaNTxJddYGeP9WwdxcU6KGBVuHmiI8IrVsOls5xwOUsBLE6vQYzpT2
         hmydIfUrXeWnOUEU6hg2VZUGZeybW15x1AiZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4pKKFMfBLZOZ3sCLtJOcZ0LC1q6FIsFGdOapn0cj/sE=;
        b=ak3i+ck6jj5ecPQ/dhC8PNTl3Eq5Ma1cvewLxwA3hmBWR5j84yQtfH0t+HjsI/L+eA
         eyxjmzCAFpML0APHDvGyyV/JbQ469oHdSiQDr6X3SeSdKYtOXHD/+l/W/KLUnhOA3XFP
         uVQwTG0AEcfPyKI1Ha3cPhvy/rQ/I1Q9lgy45b4puu17ztOqltIDyqueea5lPSsZjR+5
         SlCwSn+A5acsw9/8jmyfh85TRauYFbrBnjKY4+eKanaEXNWedpx1PiixoKNy39EJ2ewN
         e4+0ztPQBbuT+IHLXig/9AdNygP8n0NuGvezmwUo9dKERbU95OAtHV2zhcWp7pcQTpS/
         5e0A==
X-Gm-Message-State: AOAM533HPEhYL3U/qr/JPn61pYpQ5fv8rwbHj1p01pajQ+Mu1PdFCE7V
        cS9LWG8lUMwGRZyeSYFZkjTvOg==
X-Google-Smtp-Source: ABdhPJzo+9IuXUxApVeZPjc5IJqLxvJ4174bUZ83s3C19rp5kB62KNuYaLGRvpAX8A2Cz1FJTbbEIw==
X-Received: by 2002:a63:6683:: with SMTP id a125mr5175488pgc.272.1607040641735;
        Thu, 03 Dec 2020 16:10:41 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id m26sm2802715pfo.123.2020.12.03.16.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 16:10:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=WDYdfURHWf8qGOSwT+7Y5i=9FMgRn5hYZA-oTfR6KoFQ@mail.gmail.com>
References: <20201202214935.1114381-1-swboyd@chromium.org> <CAHNYxRwMD4XahHXWW9z7b=VCOEsdPe5Df4CohNwmBy_ijWJ62g@mail.gmail.com> <160695172591.2717324.17788035024164242534@swboyd.mtv.corp.google.com> <160695644776.2717324.633265815704005177@swboyd.mtv.corp.google.com> <CAD=FV=WDYdfURHWf8qGOSwT+7Y5i=9FMgRn5hYZA-oTfR6KoFQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Use the new method of gpio CS control
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alexandru M Stan <amstan@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Doug Anderson <dianders@chromium.org>
Date:   Thu, 03 Dec 2020 16:10:39 -0800
Message-ID: <160704063968.1580929.17834773484656581141@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-12-03 12:06:10)
> On Wed, Dec 2, 2020 at 4:47 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > And that is wrong. With even more investigation and Doug's eagle eyes it
> > seems that the cros-ec driver is overriding the spi::mode to clear out
> > the SPI_CS_HIGH bit that the spi core sets in there when using the gpio
> > descriptors. I'll send a patch for cros-ec-spi shortly.
>=20
> So do we need any coordinating here, are we OK w/ trogdor devices
> being broken for a short period of time?
>=20
> I think the device tree changes switching to use GPIO for chip select
> is already queued in linux-next.  That means if we land this patch
> before the fix to cros_ec [1] then we'll end up in a broken state.
> Would we be able to do some quick landing to get the cros-ec fix into
> v5.10 and then target the SPI patch for 5.11?

I don't think it really matters if the two patches meet up in linux-next
or cros-ec is fast tracked, but it would be bad if this patch was merged
without the cros-ec one. One option would be to apply the cros-ec fix to
the spi tree along with this patch (or vice versa) so that a bisection
hole isn't created. Or this patch can wait for a while until cros-ec is
fixed. I'm not the maintainer here so it's really up to Mark and
Enric/Benson.

>=20
> [1] https://lore.kernel.org/r/20201203011649.1405292-2-swboyd@chromium.or=
g/
