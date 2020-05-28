Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53771E5B0E
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgE1Ile (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 04:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgE1Ild (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 04:41:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B62C05BD1E
        for <linux-spi@vger.kernel.org>; Thu, 28 May 2020 01:41:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so4390711plb.11
        for <linux-spi@vger.kernel.org>; Thu, 28 May 2020 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBT03Y62ZSiHLY24SlJ4ujIv3y7WPG81WxSDwKyqu58=;
        b=T0f8hvaB/dV9+JOhoQ5KBetHg47OLggdkoIfY/hWQjcKadizFIXa/gnCRExgXgpwRp
         738pLKz1YEQ2JRJJXOdWAq6LVeTsksTEGRRjkup/M15FY3Mx8KsiEUeVfQjjLT7/PY8d
         lYcei0xifcnT3OUH/2FV0JxUblMxrNOmz1VDUOzxAhl8Hw5X03zlEIwQVK2hcnDTEcDB
         kuiEdBxfRI5A8Gp4mSQPUzMEtjLzk2rPNshM3qh2hUBQ1VaTwPSqnb3SelzmLapOCZXx
         PujdaYMDxau/Kno2AJTE/LoTgP3Aqik7fQeTKjq4Yc5ySmc8pVdaVRNvRqHU61NxrA3K
         IWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBT03Y62ZSiHLY24SlJ4ujIv3y7WPG81WxSDwKyqu58=;
        b=h7sZzps9KQ8VvN+UiISRxQpc2/0xiiehbmUd98KGP0q66xuluaGp4myh+FNl8jWcVo
         eBawAURIgWP7hcDv4GW48BfDyNW/L1BazBLghtTc5IHcH0amOkn3ICuQoM9ir32EERtO
         dKmqgHbD2fV4i3RmGsZ9IHtjukiTLttA6UTC+DoZP268QmVJZxKnnLP7sQelmNhNMC8s
         lYQkHNsqHr8Jpt67Ud0LQTb41OdGKXqfwM9ZJqK+/qq4I5SZ7oBU9Q9b/hvys+D0zw0a
         00MmK6YmD4PIfBBW0VdfnuPXlSGFNUC1l5FfVyK+X/L8eL8yivHh76oymK6VQebOiidc
         Eylg==
X-Gm-Message-State: AOAM53318lqqMtatj2YuCN0SkcuHQ14K5hMZWx2df37DTJNQiSYLp8e2
        34GrVOWnW9cv89eeuhBhteIiRo4gKVvt60/QNes=
X-Google-Smtp-Source: ABdhPJyh4g2Zl7/qjOJ1/kl+S2wx8PCOrYtFyTPNNAnV2uH4LjOozjSfdSRLsjqRET5oviZjbjOUoMQrEnm4rMmWNYY=
X-Received: by 2002:a17:90b:3651:: with SMTP id nh17mr2713948pjb.228.1590655293046;
 Thu, 28 May 2020 01:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590408496.git.lukas@wunner.de> <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
 <20200525132143.GX1634618@smile.fi.intel.com> <20200526073913.vmgak5xsrjiyn4ae@wunner.de>
 <20200526082204.GM1634618@smile.fi.intel.com> <45681e81-7efd-857f-eea1-fb4767e3d946@gmail.com>
 <20200527122753.GN1634618@smile.fi.intel.com> <2e9365fd-9307-045a-8afe-1770f7cd7eda@gmail.com>
 <7e085731-a56f-07d5-3ad0-a8f7d0a93516@gmail.com>
In-Reply-To: <7e085731-a56f-07d5-3ad0-a8f7d0a93516@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 May 2020 11:41:21 +0300
Message-ID: <CAHp75Ve6xUhic1g2A1cGoCOOom55Za=WXzR4C9o5=zMN80nFdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
To:     Tsuchiya Yuto <kitakar@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 28, 2020 at 10:03 AM Tsuchiya Yuto <kitakar@gmail.com> wrote:
> On 5/27/20 10:14 PM, Tsuchiya Yuto wrote:
> > On 5/27/20 9:27 PM, Andy Shevchenko wrote:
> >> On Wed, May 27, 2020 at 09:09:17PM +0900, Tsuchiya Yuto wrote:

...

> This is true for both this series and branch topic/spi/reload
>
> > What this series fixed is the following thing:
> > - without this series: reloading spi_pxa2xx_platform resurrects touch
> >   input with causing NULL pointer dereference (system still operational
> >   after this anyway)
> > - with this series: reloading spi_pxa2xx_platform resurrects touch input
> >   *without* causing NULL pointer dereference
> >
> > Let me know if any further info is required.

Thank you very much for testing, I will figure out what can be done
more there, but it's minor now.
For input and touchscreen I guess you may ask Dmitry (input subsystem
maintainer) and Benjamin (HID, but he might have an idea as well).

> *What this series (and branch topic/spi/reload) fixed is the following thing:
>
> >>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206403
> >>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=206403#c1


-- 
With Best Regards,
Andy Shevchenko
