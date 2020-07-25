Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C489E22D6D8
	for <lists+linux-spi@lfdr.de>; Sat, 25 Jul 2020 12:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYKpB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Jul 2020 06:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgGYKpB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 25 Jul 2020 06:45:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14220C0619D3;
        Sat, 25 Jul 2020 03:45:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so6813420pjb.1;
        Sat, 25 Jul 2020 03:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mw7/94BNaGAP671q/l4zcNRypbQ7/HXqY8h0Z+X694Y=;
        b=E9dx9GXWAwQ7BS1lvhzr3sZfUxFAkQCxs5IbeVy6jaQBBHsu94zA60eqL7E+EYJo3Q
         o5M+JZQTvCGluvRrFru0n9ayJVBFbIPfRMQE3qHhtea2kG1q7aVghq19KypExGrLAUjv
         rqkoqBHRFNw0zGwNJJ7iwYwjWq4UEfVTDiIlgjoTnK5Qk+oJn7BF6JvErc+BT17cAe+D
         b3RMdbOnWIRDid3pzE+IeXsA5eUKrikE6bw4eUpym3hL+75cArFaB7Oe6L0E3hrAgpWn
         saFfcPuc743cXNpG/pAQ+Xnqlixj6NgfwXV6ybUWRxa9hfHHASeXsmQQO50KX+HUcRhv
         wP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mw7/94BNaGAP671q/l4zcNRypbQ7/HXqY8h0Z+X694Y=;
        b=bbpIkzsWgjEFuYLiO1m/vDz//BK06WCgePNEv3Uag/WuppLtSiqctdDwzjfk2rk+sx
         /OL6Gfexgr7q0gXTJw3ZSZ72uuJJeJJc7FZGA77qa8TYmVvzUwzMg9BQf+Q1XBPhPrtN
         dmVb+1uCbZVhxKwwyX2u4av/WqGKDXRlu5o/CGcX1r3DxfpSC1DU7UZ6vsDEf3Xzez9W
         XTHRE3DMMgve5f6WCKGg6yunVmaV9ZxG8fnmoRYP+SUxaYYUBpIJjpyqHNx3yS9w6JHr
         OFMGg6txMvMFDiJR/59cOR9qgwOpLNE74FlGCR3BTco5DddB9CB9SNE5ZWd6dRkWRE6z
         WnsA==
X-Gm-Message-State: AOAM531KPNpLAbLBohLFHfRVUFHS91cVdSHk7wGP+v27cuFsg/LCiSW0
        qwbPN64VgmksJgXudiEaNdKkvOs2J2rmbj+YSQY=
X-Google-Smtp-Source: ABdhPJyZDOpYfyd7juxBE+IWrL4ffBNacFmyQCYFqqh7ePdTGjI1aHlUpxfwYpP49GEn93LRwwbAcoFpFZzFsh2mt/M=
X-Received: by 2002:a17:90a:498b:: with SMTP id d11mr10012883pjh.129.1595673900537;
 Sat, 25 Jul 2020 03:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
 <20200724223746.GA1538991@bjorn-Precision-5520> <CAHp75VdSr1rguc9HJVh_rA1nBh1uyCdr18eyPosWPzCH1K2=zg@mail.gmail.com>
In-Reply-To: <CAHp75VdSr1rguc9HJVh_rA1nBh1uyCdr18eyPosWPzCH1K2=zg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Jul 2020 13:44:44 +0300
Message-ID: <CAHp75VfKeTCBOne3tDSM46q6m_FE+7hS3H9Hx5C3RRPvueqZAQ@mail.gmail.com>
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jul 25, 2020 at 1:42 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Jul 25, 2020 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 24, 2020 at 11:16:55PM +0300, Andy Shevchenko wrote:

...

> > If it's a bug that spi-topcliff-pch.c disables but never enables
> > wakeup, I think this should turn into two patches:
> >
> >   1) Fix the bug by enabling wakeup in suspend (or whatever the right
> >   fix is), and
> >
> >   2) Convert to generic PM, which may involve removing the
> >   wakeup-related code completely.
>
> Works for me.

The only problem here, is that the 2nd is already in the Mark's tree
and he doesn't do rebases.
So, it will be the other way around.


-- 
With Best Regards,
Andy Shevchenko
