Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C5022E63D
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 09:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgG0HIR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 03:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0HIR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 03:08:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A929C0619D2;
        Mon, 27 Jul 2020 00:08:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so7506565pls.9;
        Mon, 27 Jul 2020 00:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r3ohMdUUisXXnJtg4Sj8gOXxHs0SULkmzOyNPW3p948=;
        b=J7drz06irjdSn4IEzXgudUrCCZnvkKA7cxf4NRdogNw/S2loC8qb0x8wuxjbKR2HtB
         PonGxSpWHuChJh9AYDUz65IOJtL7ALkmFRY6FQA/89hAZ2laXJu/9GNjCF8k3P/vC/67
         LNpcl46FH8W63QyGQRdYKwDzNNpiAiqUNSDEYJoKWpTOciWVQA4+cZFE71/7GlKZntpn
         2a4JTr5TWo3OP3y68Tdev/F0mICuQ1KuM2pRiyoXHocX0eGLj5/+DsTZKYsNihtrb2Tw
         L8fabAssBOKF5M1nR2ITvjqijq0pPazWFZB2hG5+paAOZhilTt5mHzCCHil3ef/Kbprz
         zPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r3ohMdUUisXXnJtg4Sj8gOXxHs0SULkmzOyNPW3p948=;
        b=SVDUM8Bl3YoOLrx7kv0CIjNwZ8G31QbEeQM5QmR8Xrd0qJeLq9YBCNYecQyKQ5Ob0Z
         ULc+gIpPRO2dE1XhNF66WRZR+85YyJBAVLL8qPb+ZDsrD5XZktyAnlLONNd3GwZZsIj4
         b0/xv1B7CmkGJYyraTJJZETQSLVACZ0kNHmdfgtN9bHWCr1Axhm4avgabYcytPoeU/dS
         GwukbbZbyyRbDNuT0MxUZNM51ZsHlDtZDyh05m3NviYgpU8iiuzRcn3TT1ZvybdKwyWI
         eebKnOR8A7hI8GsBXP0N2CeSGz5TEapD2DMijvN0ILMZ8eK+PyKSbGifPSupU2FeGPN0
         aVWg==
X-Gm-Message-State: AOAM531K3YUiPCxE9kIax5nGVe7IeRgbiuqG3CG7EfiaAKdBr8FguByP
        PA8wIbe3rPY8kHuDKlB34fo=
X-Google-Smtp-Source: ABdhPJzKJySBE72OX3M6X924GWk4LabSjO0/kXJ/nn3paqyIlriQgFdkPx1NMQe+b8k/s7JD6PLQFQ==
X-Received: by 2002:a17:90a:6948:: with SMTP id j8mr16013497pjm.45.1595833696391;
        Mon, 27 Jul 2020 00:08:16 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o128sm13916110pfg.127.2020.07.27.00.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:08:15 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:36:52 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
Message-ID: <20200727070652.GA5400@gmail.com>
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
 <20200724223746.GA1538991@bjorn-Precision-5520>
 <CAHp75VdSr1rguc9HJVh_rA1nBh1uyCdr18eyPosWPzCH1K2=zg@mail.gmail.com>
 <CAHp75VfKeTCBOne3tDSM46q6m_FE+7hS3H9Hx5C3RRPvueqZAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VfKeTCBOne3tDSM46q6m_FE+7hS3H9Hx5C3RRPvueqZAQ@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jul 25, 2020 at 01:44:44PM +0300, Andy Shevchenko wrote:
> On Sat, Jul 25, 2020 at 1:42 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Jul 25, 2020 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Jul 24, 2020 at 11:16:55PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > If it's a bug that spi-topcliff-pch.c disables but never enables
> > > wakeup, I think this should turn into two patches:
> > >
> > >   1) Fix the bug by enabling wakeup in suspend (or whatever the right
> > >   fix is), and
> > >
> > >   2) Convert to generic PM, which may involve removing the
> > >   wakeup-related code completely.
> >
> > Works for me.
> 
> The only problem here, is that the 2nd is already in the Mark's tree
> and he doesn't do rebases.
> So, it will be the other way around.
>
Concluding from yours and Bjorn's suggestion, I will drop the
device_wakeup_disable() call form .resume() and send the fix. I will also track
the drivers who got similar upgrades and went un-noticed.

As Bjorn mentioned, the problem is that I don't have hardware to test, so I just
replicated the legacy behaviour in generic by replacing
pci_enable_wake(....,false) with device_wakeup_disable().

So, from now, while upgrading drivers with generic PM, should I completely drop
the pci_enable_wake(....,false) calls if both .suspend() and .resume() try to
wakeup-disable the device?

Thanks
Vaibhav Gupta
> 
> -- 
> With Best Regards,
> Andy Shevchenko
