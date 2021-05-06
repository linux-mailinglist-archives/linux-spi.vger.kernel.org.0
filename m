Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB623751C2
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhEFJqA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhEFJp7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 05:45:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8352EC061574;
        Thu,  6 May 2021 02:45:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b3so3093926plg.11;
        Thu, 06 May 2021 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/vnxthP+cndWAt50LBqS7Isorcx8QW4VEjwUBOxPj+k=;
        b=YJmIRWOSIQngLI53+5KNIPBJxwOj0FrsObrgePvR8fVRJoH/6kugKxAvygsEafgKqU
         MaMTxXgsPjPJpHM6DjWY4uX0fooVSkECEF9h+XAOidsbfN4E+OENLYUZtnYPdxOZCS/d
         FJdyrYl4Tw96Wp4Q5OQkEgsqHTv4r1/D/vtW82Z44z3eyQNwZDbZFyvhrV4Rw5QWx8GM
         S4eFWVDT9ItrsoL3fRoIyP9ED1RJ87d3nljWuBZ7lNZQRg9T+ZX53J7pDIGhcHvUasFL
         A7JOmeOVJkcTdyh+uZFcs6UZG3Ilhq3TLt0079rIkETqAHBYN+4N2l5YvCB0yjw0gL9m
         JCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/vnxthP+cndWAt50LBqS7Isorcx8QW4VEjwUBOxPj+k=;
        b=aQ4ZupBxOol7BDqojkldh6zDTgDp8VVKDc3Dih0ORpRnLFx0McpCxCzYm/lJbjc2MH
         vOD2v+dhRIKM9AuucAiSWLF6dWv5LADihMYggiQ+SJ+195w8Vm3lPFLqROb8bzRhXjnt
         +UKVVsxlXJPtzj3PBeJU17vyK3z2wzkOSXLiqeuqBVzqtInQFZcM1ic6YGQV9Pm+d4KA
         0ttPi7askRg0xYdJAUW03kI2iYgiGp94a4ESK3Drb8T0dCDTc8ApEIgHvZuNiu0kXSMt
         TBH9LA13fw6XXTAjP3UOfW6uZtHOWGGysf1idrn24IbcoGMclhAudQXOyofeItzQcSBt
         ztpg==
X-Gm-Message-State: AOAM530VhuciRzfep9f9bSeYuUz5gpoT6ff7gPYhzPzUrxWpm77DCjR/
        0FFQ4qG+XwmL7W/VqXUNHwOHHPnPNz6gTAQR9kBve3Xu6Ei6Gw==
X-Google-Smtp-Source: ABdhPJx6WSSYE43iYL9UWX1SOCil/KJ4N/+f1REKJ+8pNnO4p9tJDQbEb+nl0wcZ6mdjkqOuRvmnS4d4mmhQg8OTLfs=
X-Received: by 2002:a17:90a:246:: with SMTP id t6mr3770615pje.228.1620294300104;
 Thu, 06 May 2021 02:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
 <CAHp75Vfr8t9UVqVn6hLSN6Mi3=iNAn612eE-qKq9HfrwNhpg3Q@mail.gmail.com>
 <CAHp75Vei0QGaKiq5Nai7Gsa=jcMSipaXV_6qZbBy=f0OrN=DHQ@mail.gmail.com> <e919da77-a664-d78b-2c47-cc9ba8745a72@huawei.com>
In-Reply-To: <e919da77-a664-d78b-2c47-cc9ba8745a72@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 May 2021 12:44:44 +0300
Message-ID: <CAHp75VdPYGLmDkmKETBHWLOQVHwZAdbk4wBtzMjXcX223eH1-w@mail.gmail.com>
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

On Thu, May 6, 2021 at 12:11 PM Jay Fang <f.fangjian@huawei.com> wrote:
> On 2021/5/6 16:14, Andy Shevchenko wrote:
> > On Thursday, May 6, 2021, Andy Shevchenko <andy.shevchenko@gmail.com <m=
ailto:andy.shevchenko@gmail.com>> wrote:
> >     On Thursday, May 6, 2021, Jay Fang <f.fangjian@huawei.com <mailto:f=
.fangjian@huawei.com>> wrote:
> >
> >         This series introduces a generic implementation to solve the co=
nflict
> >         between the 'cs-gpios' flags and the optional SPI slaves flags.=
 So we
> >         don't need to add two similar quirks separately for DT and ACPI=
.

> >     NAK. There is a patch against documentation that clarifies polarity=
 of GPIO for ACPI. I have a fix for that to use generic implementation of  =
CS GPIOs .
>
> Thanks. Has the Fix patch been merged ? Commit Id ?

Not yet. I'm planning to send it next week (after v5.13-rc1 is out) as a fi=
x.
For your convenience the whole story is available in my publick branch:

https://gitlab.com/andy-shev/next/-/tree/topic/spi/reload

and yes, I have tested it on real hardware.

> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/com=
mit/?h=3Dbleeding-edge&id=3Dec3576eac11d66a388b6cba6a7cfb3b45039a712 <https=
://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=3D=
bleeding-edge&id=3Dec3576eac11d66a388b6cba6a7cfb3b45039a712>
> >
> >
> > If your ACPI table uses GPIO CS with polarity low (assumes _DSD() is in=
volved), this is a bug. Fix firmware or do a quirk specific for your platfo=
rm.


--=20
With Best Regards,
Andy Shevchenko
