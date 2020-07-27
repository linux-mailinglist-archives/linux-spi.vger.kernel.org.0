Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1122ECE7
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgG0NKZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgG0NKY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 09:10:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CF0C061794;
        Mon, 27 Jul 2020 06:10:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so9474370pgc.5;
        Mon, 27 Jul 2020 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m8ss2q7X9z9vWtUgWZuhapv2kDOMmjklHJYu5RbP5UQ=;
        b=tfe0RUHcG6oEB/pYDfPsKbNlouoLw0dJgAttdqMZmC+zxCa/y4vF/dDFzGevJjNZvH
         cBQT3JQLt5EnDjE4rTePPuKCj1AaL56IC2TphWX1/5fnCdys4Rl/wDYqdE0Qi7uRvYE6
         0oK7ZkmnNGgA7wJSRU5NcJt+rshEcFyoMSukxUhyoB1IfeHhivqMO0bGgkHWwxLSSt62
         sEnNrtGDxf5e/i0e+pnAbhSsh0jYdYT8ORkwoFoPOQUxBHU1Pgg1vIYL4E+rGViAKCpM
         F2fuW8Dg2ZEun0pd/DnorX8w3ZC5o4jVcSlfDl60+7kOdWxBRnomw/s5TkiuhPv/loXX
         S/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8ss2q7X9z9vWtUgWZuhapv2kDOMmjklHJYu5RbP5UQ=;
        b=GiXSJBBthCRDBXjc9L9rWGlJ8JsmF6LE8zl4Lx7qBp1BJQ6+44s1ugrOG+WhMk4wPI
         WWJcKGMSQwqNA5ZBeWhuwNjygvK+3Mp9bbhPkjCmcN4VTDJjjb0msHIfL9m2Skj3DIi+
         EDmGklieXBDWUYHZGjFzR1zHpMI64XAhnDH5nYrGn4JWd9Klw7qjsJ/PhXXcWFbJTQE4
         8GkM6qIcV7T83eMEsieB3573UVV/aRe4kXxvQwdNZ5nPf3BegYUUiDbwIfIvpZOzbSBb
         JTohgLifxaDKKD6UctT+y5q7f5YGWRESQDqnxlEwpZfAmD7r52cp/Y1ZK3dRw6mCN7Y8
         X2yA==
X-Gm-Message-State: AOAM532AiSDuQj5uYCQyOtSTG1+D/7V0JGxEwq+qJe0rgJKj23zzmoLx
        aAB+Fg7tbdqNoH2RyzXO0WPiA+/QQboJzQ==
X-Google-Smtp-Source: ABdhPJyLY2OZt4FGCKBTtRcO9W18r2z79wDn+b8Jv3UNdFD4X2mpSxav3uGwaI20ww39In/zyxqTBw==
X-Received: by 2002:aa7:94a7:: with SMTP id a7mr19562705pfl.83.1595855423688;
        Mon, 27 Jul 2020 06:10:23 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id e15sm14802124pgt.17.2020.07.27.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:10:23 -0700 (PDT)
Date:   Mon, 27 Jul 2020 18:38:58 +0530
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
Message-ID: <20200727130858.GB82098@gmail.com>
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
 <20200724223746.GA1538991@bjorn-Precision-5520>
 <CAHp75VdSr1rguc9HJVh_rA1nBh1uyCdr18eyPosWPzCH1K2=zg@mail.gmail.com>
 <CAHp75VfKeTCBOne3tDSM46q6m_FE+7hS3H9Hx5C3RRPvueqZAQ@mail.gmail.com>
 <20200727070652.GA5400@gmail.com>
 <CAHp75VdzAk6U_mKn32+dmw1aNyREtaXMB6sHubE8G9imtv5=3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VdzAk6U_mKn32+dmw1aNyREtaXMB6sHubE8G9imtv5=3g@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 27, 2020 at 02:12:16PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 27, 2020 at 10:08 AM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> > On Sat, Jul 25, 2020 at 01:44:44PM +0300, Andy Shevchenko wrote:
> > > On Sat, Jul 25, 2020 at 1:42 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> 
> ...
> 
> > > The only problem here, is that the 2nd is already in the Mark's tree
> > > and he doesn't do rebases.
> > > So, it will be the other way around.
> > >
> > Concluding from yours and Bjorn's suggestion, I will drop the
> > device_wakeup_disable() call form .resume() and send the fix. I will also track
> > the drivers who got similar upgrades and went un-noticed.
> 
> Thanks for doing this!
> 
> > As Bjorn mentioned, the problem is that I don't have hardware to test, so I just
> > replicated the legacy behaviour in generic by replacing
> > pci_enable_wake(....,false) with device_wakeup_disable().
> >
> > So, from now, while upgrading drivers with generic PM, should I completely drop
> > the pci_enable_wake(....,false) calls if both .suspend() and .resume() try to
> > wakeup-disable the device?
> 
> I guess the best approach is to rely on the PCI core to do the right thing.
> But mention this change in the commit message that we will have a
> track of the changes properly.
> 
Okay. Thanks !
Vaibhav Gupta
> -- 
> With Best Regards,
> Andy Shevchenko
