Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEDDDC6DB
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408714AbfJROEf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 10:04:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38163 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408654AbfJROEe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 10:04:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so3446857pgt.5;
        Fri, 18 Oct 2019 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDsR3uMfXkgF7u6HALnY0iXOM6iF9eRUOFTw+nG58FU=;
        b=s/332UPVcH1YG4ye19Mtt+q/dq09kM3b0whWofT6iOrvdLjKeNJSYkEGYFV41HwrJ+
         NWTQw49T0F9jwGWvwScp1UZ2t847mGaAFXXulMv9mGQAJLsG3dKWHgREe0FpOs6jVYWK
         cppS7aPIqstVZHnSUo3gHthlzVCgIAjPKB5T0vMa1tMxCUgxWuDmLC+RQT/E6RHfjHDC
         AqSTsQDXzjEWd/gfhgAYV3UjuuJtrtpN/6tAuKaAU/ghmYpCssDi7ZljlQIV/F5zRKrX
         TWEOv8hq5IVZpBOqM1H9GQ9T/oMyHsN53zFGEZmTr+uA1ka0S8bMJoWEGMXfMR0uDHxe
         aVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDsR3uMfXkgF7u6HALnY0iXOM6iF9eRUOFTw+nG58FU=;
        b=M1g3JUbOoZsVDjdyERFUL8jVd7PIfRJQynGrwPzRSG1M9wbGBRflDgLhpiFIvIXBCc
         liCcKlyxKYlMBYebpC/ggiwm7skM/8ZZmz8vxDQICpBbK5tz/JUaAXNoGZU8EDcGEJhc
         0FMi5nyxo2o0B8UcrkvWlRsgR1lrl3mM02nrd0KzU4hQtUVZLPaMSuWBJQknyP7+B5vE
         Pl8VxJ3XfpcL3Hz/8Am+lDC4ZTLp74KnXl/TTiOmvm2keuZ5Bl4bfb15lpkwan7l7vjH
         LAnMPgyek5FT3MIYtD2lZD1dJbkQ7XZNTlovuuBeRHcoMIcIHLi3Qy8Fcy9GDQxCx6+m
         +m5w==
X-Gm-Message-State: APjAAAUMfS4d4f+Li92/M+FWk+VcuOYxXxHreJ/l++u+AjmKAxtr2Fja
        27Kd8nY1A5Nja6zKE7l+ckcee+uC6bB3Yv/T65M=
X-Google-Smtp-Source: APXvYqwnOvM20v2TXGRKh+0hhjR67QeiaXXXTMLJTzrrZMqLeIyDAtaDXT+eB8luNhsXXvgzPPPobaNa8D5T/VNq5xk=
X-Received: by 2002:a17:90a:9416:: with SMTP id r22mr11549632pjo.20.1571407473810;
 Fri, 18 Oct 2019 07:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191017025058.31528-1-hslester96@gmail.com> <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
 <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com>
 <CAHp75VeLyTi=gqfNr-=Tg36yQs_fYG__iQAxAEKdks0mqsTbug@mail.gmail.com> <CANhBUQ1CnCHiY8tkCMcXZ3DAPcfnQZgfA_Fj4qf3yYBKGg10Wg@mail.gmail.com>
In-Reply-To: <CANhBUQ1CnCHiY8tkCMcXZ3DAPcfnQZgfA_Fj4qf3yYBKGg10Wg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Oct 2019 17:04:22 +0300
Message-ID: <CAHp75Vdb19w02zKHo1tqAtF8TmT=z6Ye2YFfxVw_TGtO3VxfLA@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add missed security checks
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 18, 2019 at 2:37 PM Chuhong Yuan <hslester96@gmail.com> wrote:
> On Fri, Oct 18, 2019 at 7:14 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Oct 18, 2019 at 1:39 PM Chuhong Yuan <hslester96@gmail.com> wrote:
> > > On Fri, Oct 18, 2019 at 5:35 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Oct 18, 2019 at 8:59 AM Chuhong Yuan <hslester96@gmail.com> wrote:

> > > > I'm not sure they are mandatory for all platforms.
> > > > To be on the safe side, you simple need to add _optional() to the both
> > > > call along with above change.
> > > >
> > >
> > > As I know, this is the only one in spi which does not have a check for
> > > devm_clk_get.
> >
> > For some it still may be optional. That's why better to check it and
> > mention in the commit message.
> >
> > > Even if add _optional(), they still may return errors and need security checks.
> >
> > Of course, see "along with" in my previous comment.
> >
>
> Got it. I will send version 2 in which both _optional() and security
> checks will be added.

Let me be clear. I didn't check if _optional() needed or not. You need
to investigate this before sending new verison.
And in either case this should be explained in commit message.

-- 
With Best Regards,
Andy Shevchenko
