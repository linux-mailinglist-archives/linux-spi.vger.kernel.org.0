Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1C22CF4F
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 22:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgGXURO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 16:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXURO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jul 2020 16:17:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D667C0619D3;
        Fri, 24 Jul 2020 13:17:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so5157450pls.9;
        Fri, 24 Jul 2020 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mKCbM5fDDFwgjqPiF3ijFcse991Sj2a3LfByPXLuII=;
        b=Y1tD4DN5yNl68XSvLYmxs49j7aiN49qTyojf5OPc4Kw+MRCZfCt6UtBSWOlB678W1M
         BKqnYzdnHUIxaCvMtOy4wR0cwDOduZusruODItl/nbNcNhlVrWx/swEzgEXHePVXVbWe
         rUEdjZT4vuYtB1vjXCmV5i6xWPlDyoR7/VP3PTRQYVYl8pQtc7GhXQ4BU6lNGJn+wZ5P
         AVY2CuUl+Z+Om8n6hSqVgIkZjcqXk1FMzIJylM4ZOQryxgLHByB+gyU2P97Z0Qc72zjJ
         5xI94kpV5S9p8LyDSBhr0c1oWvsNjx299v8mCyyIHFvghoV86nL3xhxPvfI13BVBDcQ6
         kwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mKCbM5fDDFwgjqPiF3ijFcse991Sj2a3LfByPXLuII=;
        b=blrwDqjv3ar1L7qU40tBFrbFk0FoelZqK0OqOelkwq8MvjnLg6ihv1yk8DeU8exZOE
         GjvxlxFdCmQDXydEL3OdoUwMXr4YgkYbrUnFH+78f+VaQsAoX0xNhJr/TzvQo+Q+QGNL
         BeQd1vitkXOv14ceVRTnHGQY9WR6jPIsggV8/vpeX9I0inDdPJxGMGalPwDc5OgkyTay
         nRNUhA6Hgsg5oUm6xmxnqc+4DSfiw3fXYAENQs+r6uiotyFiNm1PvIhrWtF88USwqowK
         BXwZUniBFUjZxt7EoxnuZrIk4RCRkiS1gJrp/Kgkx76iNfK1FmCCd3te9u1gmWqpFDUu
         jteg==
X-Gm-Message-State: AOAM530yPP/CjW0rfNJj3Pb1UeOOlyvYb+msuHRMglXpvwtAQyY6YfhS
        0QooSrppLmRRaLVkJhZhfvo4PrLYDxmruzUar4k=
X-Google-Smtp-Source: ABdhPJyzOcJVavQbz8ez8GRBp/8SZ6nGygrW2abBhG+FnsSghwmrIRwfvQv84dmxy4goBWr4MTJQYcRXQ0DCXsjAqE8=
X-Received: by 2002:a17:90a:498b:: with SMTP id d11mr7409909pjh.129.1595621832763;
 Fri, 24 Jul 2020 13:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200720155714.714114-1-vaibhavgupta40@gmail.com>
 <CAHp75Vdh-ssrmGgTc=gE9dWLhWDAw7_QHJKFeWKHpO-JqBdsEA@mail.gmail.com> <20200724151601.GA3642@gmail.com>
In-Reply-To: <20200724151601.GA3642@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Jul 2020 23:16:55 +0300
Message-ID: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 24, 2020 at 6:17 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> On Fri, Jul 24, 2020 at 01:51:49PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 20, 2020 at 7:31 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:

...

> > > +       device_wakeup_disable(dev);
> >
> > Here I left a result. Care to explain (and perhaps send a follow up
> > fix) where is the counterpart to this call?
> >
> Hello Andy,
> I didn't quite understand what you are trying to point at. And the result part.

I emphasized the line by surrounding it with two blank lines followed
by my comment.

> Yes, it seem I forgot to put device_wakeup_disable() in .suspend() when I
> removed pci_enable_wake(pdev, PCI_D3hot, 0); from there. It doesn't seem that
> .suspend() wants to enable-wake the device as the bool value passed to
> pci_enable_wake() is zero.

> Am I missing something else?

At least above. Either you need to drop the current call, or explain
how it works.
Since you have no hardware to test, I would rather ask to drop an
extra call or revert the change.

-- 
With Best Regards,
Andy Shevchenko
