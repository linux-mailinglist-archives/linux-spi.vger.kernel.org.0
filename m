Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA6F49BCE
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 10:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfFRIOK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 04:14:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37949 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFRIOK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 04:14:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so12157758ljg.5
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqWCYI/wkHRibNjnssmU/+fQYI3h5q8oCh9XVh2MUcE=;
        b=duBIJ4RXQIkap3sJ7PR7lu6EtYwkcH1iUAdA86oHXMlMSc+hyCxb9oY7FmYj4Dmkfq
         Qx6Ohnyt9NWUe1Uliv8VyUK84K888K+SDYgtdC4kXjsEFEzgb6HFXBlmwRwlkOuY7cuN
         bNAkHYumJT7AoxnI+HJHEOQqckX2btvVKHyJmQZ1OVuwY4U3NbYKTolfHZ9+cmuz2ues
         VgEzcpiym3kGWzIfLSo1IfjAn7n5Oz6VjjLJTd6Q3ETKh1+k7LBFsDUQYuQAmLGVQsGZ
         Wzw5B2Ui5OLlNbZqwvxWKIoAre3IqBJnPxIUFdQHnI1iTktjnZHTsn0fDHz+MKzbAg01
         Rwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqWCYI/wkHRibNjnssmU/+fQYI3h5q8oCh9XVh2MUcE=;
        b=m1R7VUpmu52ttE2TMlMaLIIxgiTMw8hwKcJoaYPRKLvKoyjtNUS59q+XBZK7qz4eQC
         02wow+ZVAzL2z3PCITAtW+bITAmka++L+fywxvz3sU/1BRwU0VnXPeyztKogTbCPtGig
         CNyu0eTjDpD7o3Bt2LX+aeiUbylOKpA6iHdM9h/ci4cuPEylcXijWGpioCvHCOeg+1l9
         wISigZnrOgm6vkuTNt5OIiYuisdI2oEAW3O5WeS3sAYGVWcSCaICJilZTsykDTT7UnUd
         jCCNzWc2mB3JYqAytz8GHPUELwcyBUt/9nk3TH/p0SMqD6hl/vxoHK7wpWW1cF4B/uL8
         aURg==
X-Gm-Message-State: APjAAAWB3mZPbvK0VT6QqIC370SR8zC8v6mEkzaHkDIqnewc3Ho8bg2L
        LrarHkQct48zl920mPYjMhz4Qlc0wGUrdFOvp1Hl1oQj+FE=
X-Google-Smtp-Source: APXvYqxBatGcY1hysoDznoPhtxooI85AftMssmgPT+PT/KQylcU/GnjR3QMq3dXPgXClN5VJ3UwV8qfJT92FSL8hrKE=
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr3256122ljh.196.1560845648244;
 Tue, 18 Jun 2019 01:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190617060957.16171-1-masahisa.kojima@linaro.org>
 <20190617101741.GK5316@sirena.org.uk> <CAKv+Gu-DYzRRG82t27nFZKeLOPzCYphY=AQCQy78=m591rXs_A@mail.gmail.com>
 <20190617114630.GO5316@sirena.org.uk>
In-Reply-To: <20190617114630.GO5316@sirena.org.uk>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Tue, 18 Jun 2019 17:13:57 +0900
Message-ID: <CADQ0-X_1kNChYr_vvOiafghk8h1AcERaGYWjo61ATLXy0_f_UA@mail.gmail.com>
Subject: Re: [PATCH] spi: Kconfig: spi-synquacer: Added ARM and ARM64 dependence
To:     Mark Brown <broonie@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Jaswinder Singh <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

There was a patch to address same compile error.
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1982194.html

Does it preferable solution to use iowrite32_rep() series?

On Mon, 17 Jun 2019 at 20:46, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 12:21:47PM +0200, Ard Biesheuvel wrote:
> > On Mon, 17 Jun 2019 at 12:17, Mark Brown <broonie@kernel.org> wrote:
>
> > > Are you sure it's those functions (which only appear to be defined on
> > > arc according to a quick grep) and are you sure that there's no other
> > > Kconfig symbol specifically for those being defined which can be used
> > > rather than depending on specific architectures?
>
> > I'm not sure I see the point of this. Building this driver for alpha
> > and parisc has no use in practice, and does not provide any additional
> > build coverage given that the driver can be enabled on any ARMA/ARM64
> > build.
>
> It's helpful for compile test coverage, which in turn is useful for
> people doing subsystem or kernel wide changes.  A dependency on ARM64 ||
> COMPILE_TEST would make sense but wouldn't stop things getting built on
> the older archtiectures so you'd still want some dependency for that.
>
> > > > This patch also specifies the default compile type as module.
>
> > > This should be a separate patch and we don't generally change the
> > > default unless there's a reason to do so.'
>
> > That was my suggestion - just 'default m' is generally not accepted,
> > but 'default m' for a driver if you enabled the ARCH_xxxx in question
> > is reasonable, no?
>
> No, there's no special treatment for arch specific drivers here.
