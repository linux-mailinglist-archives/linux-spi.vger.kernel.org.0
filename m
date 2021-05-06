Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9483751D3
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhEFJw1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhEFJw0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 05:52:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F353DC061574;
        Thu,  6 May 2021 02:51:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v13so3104558ple.9;
        Thu, 06 May 2021 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E2/GQNJIWtrVWBYkH9ZAGUBIr27tmlJACtlSEsIoPMc=;
        b=HhuE97T9n6XLEO6MmpuQ0kjHhKTmjXDEXjIwGvz1Ccweuc+zMxIF0nJFviXDvKccLj
         JAG5cMFqjpGxICV8xym1PFPI1sbYpupOWF+UCyyNir8u3gPqowDmCGfxO/zLd7mViDXE
         XQMAePH0oTIimhmJbx5jpbj5N2kbJ3QRoJq/uwthfAdEC5c2+BpTN4EGiOsTsPDtBbns
         X6WNvQ8IDZ7oQPzZ8M53aTXbrVKnLwLIKghreWd1ypod3ZF41wmEIaPHJruStJJkqtTB
         T+K6QL1WOv89V5pKZtWBU/HLFayoN/JGp3Vz7u+E1sBUtO7VaQCBM8Vko3bhQ5H07s79
         QxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E2/GQNJIWtrVWBYkH9ZAGUBIr27tmlJACtlSEsIoPMc=;
        b=hL7uJZxxPBX5t4hFOayk3NGV/Nv8n+y0DYkdeJJLQ4BirVA2cGrUkDkoMW2PhnOfhV
         YsFf0x6SOkPtJdiobo2wRDketfM5NUbaVsRT5sYLTN/BwP5M+5wfNrLVzmQ4pZQ579qb
         opVC1+FmUdZrfws8BB0MuqU5bn5ce9g4yMCvFttYDYsR9lO+beV1+l/O1Do3SYFeukS8
         UKgsWr/aIfmrMEKeLoelqXqkV0yja1KYxGZ0LOd6+0HV3SJbpSCyR1VpJ8h2xbFQfCGo
         QOXyvztNxELJ1LJoT5/dQ6EKkqdYEr5cJsBVKSCabooOLTMAKvzFsss5g7/JF863EImp
         ohog==
X-Gm-Message-State: AOAM532s5HOggKh5diTX8cbqOLgV39WLso1XA8/QNQNz47XMKElR58GN
        ejtN5hSmADVAy1ZIOX7qV/NIZzXn4zEJ+QqiOKg=
X-Google-Smtp-Source: ABdhPJzmFkAaDdfYxFQta/xLcxP9EhdbfTgFjf/Ys+mgQjeTLukMCnDvvpP1KWarW0mWwY4WijIXf03C7bruzamQY4c=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr17475531pjr.181.1620294688394;
 Thu, 06 May 2021 02:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
 <CAHp75Vfr8t9UVqVn6hLSN6Mi3=iNAn612eE-qKq9HfrwNhpg3Q@mail.gmail.com>
 <CAHp75Vei0QGaKiq5Nai7Gsa=jcMSipaXV_6qZbBy=f0OrN=DHQ@mail.gmail.com>
 <e919da77-a664-d78b-2c47-cc9ba8745a72@huawei.com> <CAHp75VdPYGLmDkmKETBHWLOQVHwZAdbk4wBtzMjXcX223eH1-w@mail.gmail.com>
In-Reply-To: <CAHp75VdPYGLmDkmKETBHWLOQVHwZAdbk4wBtzMjXcX223eH1-w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 May 2021 12:51:12 +0300
Message-ID: <CAHp75VdpBsZJJ-gSEkKHf9vCSnkcxXbwi16ZkCwXwa1HcTwuOg@mail.gmail.com>
Subject: Re: [PATCH 0/2] spi: Correct CS GPIOs polarity when using GPIO descriptors
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>,
        "tangzihao1@hisilicon.com" <tangzihao1@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 6, 2021 at 12:44 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, May 6, 2021 at 12:11 PM Jay Fang <f.fangjian@huawei.com> wrote:
> > On 2021/5/6 16:14, Andy Shevchenko wrote:
> > > On Thursday, May 6, 2021, Andy Shevchenko <andy.shevchenko@gmail.com =
<mailto:andy.shevchenko@gmail.com>> wrote:
> > >     On Thursday, May 6, 2021, Jay Fang <f.fangjian@huawei.com <mailto=
:f.fangjian@huawei.com>> wrote:
> > >
> > >         This series introduces a generic implementation to solve the =
conflict
> > >         between the 'cs-gpios' flags and the optional SPI slaves flag=
s. So we
> > >         don't need to add two similar quirks separately for DT and AC=
PI.
>
> > >     NAK. There is a patch against documentation that clarifies polari=
ty of GPIO for ACPI. I have a fix for that to use generic implementation of=
  CS GPIOs .
> >
> > Thanks. Has the Fix patch been merged ? Commit Id ?

It's here

https://gitlab.com/andy-shev/next/-/commit/5ccbdbb4787d871722f361d77c5f3cb8=
06811c48

and now I remember that I didn't dare to make it as a fix due to:
 - recent (non-fix) dependencies
 - no existing driver uses it for ACPI (at least nothing has been reported)

> Not yet. I'm planning to send it next week (after v5.13-rc1 is out) as a =
fix.
> For your convenience the whole story is available in my publick branch:
>
> https://gitlab.com/andy-shev/next/-/tree/topic/spi/reload
>
> and yes, I have tested it on real hardware.
>
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/c=
ommit/?h=3Dbleeding-edge&id=3Dec3576eac11d66a388b6cba6a7cfb3b45039a712 <htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=
=3Dbleeding-edge&id=3Dec3576eac11d66a388b6cba6a7cfb3b45039a712>
> > >
> > >
> > > If your ACPI table uses GPIO CS with polarity low (assumes _DSD() is =
involved), this is a bug. Fix firmware or do a quirk specific for your plat=
form.

--=20
With Best Regards,
Andy Shevchenko
