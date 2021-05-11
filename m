Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8037A941
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhEKO3k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhEKO3i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 10:29:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A1C06174A;
        Tue, 11 May 2021 07:28:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x188so16196898pfd.7;
        Tue, 11 May 2021 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9vYfnNGizia/DXzQt9LvMmzevHRIe0AtBEWW+5SpT8=;
        b=ef363TFWFirJXVfI9x5WSCfHySvf8gXrsZmyJ9A5nmPUlKj+wNgeLnBp4hkI5XGiX5
         my1P6/VdipbKZcJ/si2D+JD6o144GalW8TR+p96/tU9rjK3MeFik8tIhvkIAt2PIQaq4
         DYuC1cMNedDSPdutc1bvjWqdZRf7Z5teI6LGEj4dXWH/j6Fp88P/noljSD/AKvhOV3v/
         B6JHAmUBhdC/5GbFFFvzRKjfRqLBRgvZySCttMyo6TXtL4S3bkrjDva2nFJYshwgguzC
         fWySgFFg6ZVbrP7b6jaA9Ad9zgouLo8YMC5H43mFc9s91ZZ5mgYqDVQB/RuRhxcvOJf1
         vuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9vYfnNGizia/DXzQt9LvMmzevHRIe0AtBEWW+5SpT8=;
        b=FO69K6GLrljJcZqr5U4ifujHVLs3IFhhsce7bs4pRRmns8v8yQb16z7fwFD1SeKUJd
         GG0baYhML+26R96Hw1qtJ5KxvsQ94r8ZKiuGmjNb5St8jWaNI6ndAn5bvhWd3/3i/hri
         ky8ewwaCluvemoLAQMr5ZpTaUZKzHynMMJk8sYGjhO/yRbxZqYf9ZtdGs3nKgdnO2xDo
         0MSaOJuNryegiCacMINnLUP89MIbsS1Oenfw9kiHBEwU/7ePWgpLMSxgJoNzqfEXRFF2
         /WKFVDeM/DQGFPqo4yOInL+p2qcIuB+8uYMar7soHD3v1xYSoWaakCdr2kYMEK6UR2uV
         qBsg==
X-Gm-Message-State: AOAM530VsVP75m5TcaS4DPjKL+n3+zfftGwMlmKoEND/adkIPVULdHnI
        yduEwZ6LkHio3s1Q8DOEiSJ1EOOVAJyBZqzslXo=
X-Google-Smtp-Source: ABdhPJw8nPLuRSRyShhXX7vnVnPbSBcHzhmkN+VmRMyx6DmoNtkt8GxITxTEKN6KYU9V/EeI0uf1gNbAfnDo8EPwCjU=
X-Received: by 2002:a63:79c3:: with SMTP id u186mr27596553pgc.203.1620743310395;
 Tue, 11 May 2021 07:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
 <20210511134706.GI4496@sirena.org.uk> <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
 <CAHp75Vca2KT4kd9zw3ECqym1rRDSg2NNbwRRVVA1L7vyD3VCJQ@mail.gmail.com>
 <YJqRBIdTlvnsCYsn@smile.fi.intel.com> <20210511142433.GK4496@sirena.org.uk>
In-Reply-To: <20210511142433.GK4496@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 May 2021 17:28:13 +0300
Message-ID: <CAHp75Vfh4AViMMSm6MKAGP7s_ANOSyHVDj5qG=j5YrLPjH+Y8w@mail.gmail.com>
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

On Tue, May 11, 2021 at 5:25 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 11, 2021 at 05:13:24PM +0300, Andy Shevchenko wrote:
>
> > Just in case I'll send a v4 with only patches that missed.
> > Otherwise it will be the same as in v3 (see above).
>
> Please stop.

Okay, what should I do?

-- 
With Best Regards,
Andy Shevchenko
