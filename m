Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8DE3752C3
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 13:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhEFLHf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 07:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbhEFLHf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 07:07:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD546C061574
        for <linux-spi@vger.kernel.org>; Thu,  6 May 2021 04:06:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o16so6532756ljp.3
        for <linux-spi@vger.kernel.org>; Thu, 06 May 2021 04:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWmNHmfjUj3qc0B9aWn4OMmxqOepf+LhF996RVo1X60=;
        b=WczG4xLQR7UX5zXs+PCspWWBZa2nW+o0uVdGeKYdZX1ZRPKWmy7+9O6TuPKIjOk5UE
         8iGD6bjNDA6v5q6DjkXH8MI+mmZRDieUzkf8IyHORdIeQs1NU2WrOqyaUX9nnydQn8+g
         lQMYJlI4j6qT2uq5x9dCKW+2nWSvHPiYoI6wkD5A6ItEzsCZ5yPZeVCd9hitOAje/dvE
         pi6fMK2DuydpBQAMWzSCZE0ZxHBHrPqrGpb3wqXDOekmL0Bl13n9KptqSxjz7jMXQtgg
         rBlY32yuCSW1nYAbWyPtztxHUkAFuf1g9Ww1vxrIXWxr0KjSoGV8h4EfijzcfS7dtuF/
         E3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWmNHmfjUj3qc0B9aWn4OMmxqOepf+LhF996RVo1X60=;
        b=bn4F4ei67rwUyg4w0Q14p4lEcx4RnIaDz3ff/te+5UNIzSSDGkJkRhwsRyQx3Dzob8
         FP210SgX0qHXmrMxPrnFCLIW4q3lbmsyhEHsWrf7ZSjdIUbG5dfL03LIUhCTULWdPgS1
         QCsv6BssnKxqNw5tutE3DhXA6QobRsOXWOFUfDvHRHRtfFfMiYOlhwUG+d6Uv4wtzb/q
         WBCARrhg4FpyqfCjhsQqQMbiQM2lrnf8aAgf4mDh6ogT06pXSHuY4EjLGuQhU9qY+T2U
         HSECWNZDtOjlNpT5B72fuCj3LXv9LCHxmFMuUz5hHbCsUAQePFb6AzjkuGXmxS0BmIKu
         GetA==
X-Gm-Message-State: AOAM533aelDIWdftUC5TcuXGFnic8r4H1DF8FdqOi7inKUcxyRuUyK5G
        v7qTLsKEe85lt/qAvtHeL7V+umLPb/ntGOyFjjFCNA==
X-Google-Smtp-Source: ABdhPJwQ27yDfXTygjDihF/g76lDPnA2/XVNACTIBpf5xL9Jwg2ij7sQtPwwUBUJxYWPzxKFNM1xetdugOHn9rZFbxY=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr2842452lju.200.1620299194178;
 Thu, 06 May 2021 04:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
 <CAHp75Vfr8t9UVqVn6hLSN6Mi3=iNAn612eE-qKq9HfrwNhpg3Q@mail.gmail.com>
 <CAHp75Vei0QGaKiq5Nai7Gsa=jcMSipaXV_6qZbBy=f0OrN=DHQ@mail.gmail.com>
 <e919da77-a664-d78b-2c47-cc9ba8745a72@huawei.com> <CAHp75VdPYGLmDkmKETBHWLOQVHwZAdbk4wBtzMjXcX223eH1-w@mail.gmail.com>
In-Reply-To: <CAHp75VdPYGLmDkmKETBHWLOQVHwZAdbk4wBtzMjXcX223eH1-w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 13:06:23 +0200
Message-ID: <CACRpkdYR99SRgDJEK6e-eT86hBOxz-Ym5pf8Zn+0k4u+i=nfOA@mail.gmail.com>
Subject: Re: [PATCH 0/2] spi: Correct CS GPIOs polarity when using GPIO descriptors
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jay Fang <f.fangjian@huawei.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>,
        "tangzihao1@hisilicon.com" <tangzihao1@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 6, 2021 at 11:45 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> > Thanks. Has the Fix patch been merged ? Commit Id ?
>
> Not yet. I'm planning to send it next week (after v5.13-rc1 is out) as a fix.
> For your convenience the whole story is available in my publick branch:
>
> https://gitlab.com/andy-shev/next/-/tree/topic/spi/reload
>
> and yes, I have tested it on real hardware.

Oh what a nightmare you got into there.

Curious that ACPI has SPI CS as always active high,
but that just underscore that we *really* need to
abstract this out to avoid really complex specialcasing.

Interesting that the PXA2xx XScale lives in Merrifield,
I didn't know. Reminds med of how the Samsung
hardware is alive and well in the recent Apple M1 laptops.

Yours,
Linus Walleij
