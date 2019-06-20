Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4924CDAF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfFTM0B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 08:26:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32927 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFTM0B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 08:26:01 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so73578iop.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2019 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ctz/QXIjFDB2GQaXAT8d5GhauHD070PbTLxLxPKH/s=;
        b=GH/mMZStQUfIAzr4/qoFK62z5iJHdJfjnHxFZ2+S8HKFU6RdbFONhNAIiO5V4tU3ng
         sLY1qEPtET6/mqqUb5DsBRNVBSlw914NtH2dW0w8mMlKKgY7rgq9xAk3E8M75l1BOMU7
         m26VrRmiK4KnzZX1JEUVrGChFUvqXTTejire5qnf79QoyqVxBebM8J4587dQT0x4z4Fl
         90OsLDxG7gVvObws54knH3K5nXbcOAKeqgRqz4fFN7DvAEX+EiWCsVs/UAKhKSiiQCUG
         FmPSol0kJTrbsrupLb6p4h0jvcS6kUXU2lzVsjNdsRBLRjeFUSFRdDkXNrGj22CIa1wW
         0Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ctz/QXIjFDB2GQaXAT8d5GhauHD070PbTLxLxPKH/s=;
        b=U+GvBVEJHVNjfwqBN6oqdmL97p3S2v0rjyymraSc6vjrGogcMVgLjyM3vmI8/Iw0J1
         KY/KRYGdAMffeho1+BRUAdY14qoiR+jOzuc0JC2ycriYLO8yEFTpu0rWtefSK4xjQ/HU
         jf4g7SS4RlfvYjdzhrzDs4xc1D7WlaGB+3QFlm+xUbYZGwbjXyLyaRtu78feKIshdUns
         8Hk7xCrsOGuR7GYhrWGzccQtxNh5FwTP/1GMYuUbmnUI/j0SZXbrAJkr044HZQCSpAYM
         ED01EOTATaax6cBXLt2ZDkvnKH6MTnmJD7FVe0WnObtMRJyn62mJm86uxQEfOe3vHYDh
         6wNA==
X-Gm-Message-State: APjAAAVCy54XFkx30X5XDe/nfRlKCbsuCpamHPkgy+y0sGP1rjxfecK6
        UAFEVJ4BlpKKikHhPR+ZQwU2x+gbRfXowLE7tIWIXw==
X-Google-Smtp-Source: APXvYqzkq6RMp9yFa1M3ZuxWUckqeXk+l0SQzhChdUZqcbaoZ3bK1OfcQ68ijWjF+T27QsX0ZKzg7asMwQQRLC4dvBU=
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr29715556iob.49.1561033560337;
 Thu, 20 Jun 2019 05:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
 <20190619101604.GR2640@lahna.fi.intel.com> <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
 <CAKv+Gu_Bw3aV-pUVYf8T1hLfL35X7ozEPtqL9oLcDvwcQ4qMiw@mail.gmail.com>
 <c96afe71-c7bd-d30f-ef37-0c6eeb726f67@linux.intel.com> <CAKv+Gu9fafXNrAYAgUuqMPVjZm2bWJmzg_aPz9WD1skemQme8A@mail.gmail.com>
 <08e498d6-1ff8-771f-7d4f-6ea5f705d386@linux.intel.com> <20190619144255.GG2640@lahna.fi.intel.com>
 <CAKv+Gu82UcBcj_cjfEDpEyQyGzPvtGnVJN22hCroHKyudhk=8w@mail.gmail.com> <efe4ab27-61eb-af89-f023-c0208253fc69@linux.intel.com>
In-Reply-To: <efe4ab27-61eb-af89-f023-c0208253fc69@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 20 Jun 2019 14:25:49 +0200
Message-ID: <CAKv+Gu8=J83ibSQBU66pWuo86n8+zO=Op8313eugx2ARF55kSA@mail.gmail.com>
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 20 Jun 2019 at 14:21, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 6/20/19 1:33 PM, Ard Biesheuvel wrote:
> > Jarkko, does this help?
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 50d230b33c42..d072efdd65ba 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1914,6 +1914,7 @@ static acpi_status
> > acpi_register_spi_device(struct spi_controller *ctlr,
> >                  return AE_OK;
> >
> >          lookup.ctlr             = ctlr;
> > +       lookup.max_speed_hz     = 0;
> >          lookup.mode             = 0;
> >          lookup.bits_per_word    = 0;
> >          lookup.irq              = -1;
> >
> Yes it does.
>
> I guess you have some cleanups or changes on top of your b5e3cf410b48
> ("spi/acpi: fix incorrect ACPI parent check") since for me change go
> around lines @@ -1981,6 +1981,7 @@ ?
>

Thanks,

This is my own tree with just my own 2 patches, not what's in
broonie's tree for spi-next
