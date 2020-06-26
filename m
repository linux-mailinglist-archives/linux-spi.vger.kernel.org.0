Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94BD20BA5D
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jun 2020 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgFZUgZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jun 2020 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUgZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jun 2020 16:36:25 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DECC03E979
        for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2020 13:36:25 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t74so5865228lff.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2020 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=apBirrgMWZ9iEVJFAxwc4zzDsROcVMp/Ws6qNq1mFZk=;
        b=JxyRGOsODkaOkwom1s1bJ6HpgTdZcTPQwOnCITl4OFbH/4ksD3bjtH1DEwTfLa0iqg
         167uCBUsHWbyLe/WSF0h6QN0BOQyHKCgmj9mTC3laSbUL8JR5w7sp0igRi+dVyCVXsRe
         ljI/YKpkOhzc0/EDo6lFKoitJU+5bc/pS4TthhUIAI42VvOvnU7Y5RvgLksbUhOPafx6
         XiEe9hFAhnA3HCNevIUuccZq2vYGPIFLcZUiznKfAyPtxxe33Y/DQfdBnawSdl/3WZL4
         L4/iS4seXBGhmq6Fnujw2UjUQ23R2LVEuXIy8kW3ioU4EapYbx/4OsttCt631ZL2R1vx
         QJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=apBirrgMWZ9iEVJFAxwc4zzDsROcVMp/Ws6qNq1mFZk=;
        b=tLbkXp5fzAAERdAdyk9ZEZssE1Gkh5TtvgspvhRiPdPx6mziTM/cpPTA1PWSlLFq95
         YfqJFY9lXU5eZl+AzA1rE9J0eKRgmLAdXRc7FgHPa7touO6ny0l4CPEluUVTDTjnd2aY
         WekxxLhyIFZdLEPsYdHXYMu1ve8p+s8Nau0nGh94LDMcQ6qm9Q42/uCJvJN5OVcv0gpc
         KVhV6ISSGozz87kMeKtnc4SsJZ0XLqm6d3qzmUIbCR8HkA4fX0vTNzYFPAwwEDkLaOww
         OMXdbj8TLBCKvAL8ximCHWT3ys0v82QULug8/DwLXBwa4KjI0t7LVmOT0SAWr5S3BB7W
         1sjg==
X-Gm-Message-State: AOAM531WjHX6OLGuIhHc3O+Y0WO6IWgQBtyy0MNgwGkJohkxFjX2Z3B1
        e5STHNmr857nA6H9pu/Fd09hEjoQFwrye+g5VwsdFw==
X-Google-Smtp-Source: ABdhPJx8313qZZl3iXOUgIollKACNNnGKFZWOINGv6iPJZ1Ykw6jquCzz8HYmk82zb4o4jhEAtSgY6EpaVIqfX1xbSg=
X-Received: by 2002:a05:6512:31ce:: with SMTP id j14mr2809729lfe.47.1593203783904;
 Fri, 26 Jun 2020 13:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200625200252.207614-1-linus.walleij@linaro.org> <20200626055919.bthsyx7ey7gpxkno@taurus.defre.kleine-koenig.org>
In-Reply-To: <20200626055919.bthsyx7ey7gpxkno@taurus.defre.kleine-koenig.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Jun 2020 22:36:12 +0200
Message-ID: <CACRpkdaExPFix0q34+1QeZ2Qh-rKSgb0tZwJQ-JfDRQnH0_L9w@mail.gmail.com>
Subject: Re: [PATCH] spi: imx/fsl-lpspi: Convert to GPIO descriptors
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 26, 2020 at 7:59 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Jun 25, 2020 at 10:02:52PM +0200, Linus Walleij wrote:

> >  arch/arm/mach-imx/devices-imx27.h            | 10 +--
> >  arch/arm/mach-imx/devices-imx31.h            | 10 +--
> >  arch/arm/mach-imx/devices/devices-common.h   |  5 +-
> >  arch/arm/mach-imx/devices/platform-spi_imx.c |  9 +-
> >  arch/arm/mach-imx/mach-mx27_3ds.c            | 40 ++++++---
> >  arch/arm/mach-imx/mach-mx31_3ds.c            | 13 +--
> >  arch/arm/mach-imx/mach-mx31lilly.c           | 14 +--
> >  arch/arm/mach-imx/mach-mx31lite.c            | 19 +---
> >  arch/arm/mach-imx/mach-mx31moboard.c         | 12 +--
> >  arch/arm/mach-imx/mach-pca100.c              | 21 +++--
> >  arch/arm/mach-imx/mach-pcm037_eet.c          |  7 +-
>
> I'm not sure I'd bother with these. I didn't see board files in use any
> more since quite some time. I suggest to delete them instead. (Or break
> them by doing the spi driver conversion without adapting them?)

I usually try to do a best effort to keep these systems running.
The *_3ds.c board files are reference designs which are usually important
to keep around so I would prefer if the maintainers delete them in that
case.

Yours,
Linus Walleij
