Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC43377176
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhEHLjS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 8 May 2021 07:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEHLjR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 8 May 2021 07:39:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2AC061574
        for <linux-spi@vger.kernel.org>; Sat,  8 May 2021 04:38:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g65so6587942wmg.2
        for <linux-spi@vger.kernel.org>; Sat, 08 May 2021 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDpGWDYbeeizlosJVz5lXNO4/kxljZNfcY+fonMgk2c=;
        b=cqYRLLT188ws2+zRwst1PQL2XK4PyT7TGEAQysC77At+5wAU3eZLwOvF9xkDzXpjii
         1dzmoHiKD3V6v4PJ2HQR99AnsMV7queFgG9sFMpWDFmw51ZkgQBFACZoC6UdnlKSS9Pq
         ephrcYCKv2YRBATPx3RPG1YI4d97Ei6jlyKi4dzJfzloJzsl9MvmmG9gluI71lUuzijz
         vOtLo162ycD+O0bsHs7ekOrnz1i+QtF8qkU5bf4I25CP+MD9+NYijhpoZncRexY2mla3
         w7J6ErmFCPyJTJBSPnkPThHmB3mHfzvfYd5Y1r3BtMqw51Hh1rtzjuUxUBGH45virpHZ
         acew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDpGWDYbeeizlosJVz5lXNO4/kxljZNfcY+fonMgk2c=;
        b=Uu9oHtVeC6WuK8wzUG1zWAfOf1WbJpwMM6J5Yny3IDHVGtOscORDBZyUnwoBeL7aiC
         l7tjXH24Vm8bxcZxUQmwDRf4bLJTZBnyj7cJoGLM7+7s4CPkY/nrAMB35zXMRHU/DTGN
         +2mhbfSzcEDIzpyZdyur1wRGU+kcd3jAaPfN11tRBmVRA08kbK5ppf5GroZUmXsYtB5W
         kboaepUhwaWmqNP5gIZWC7+sxu1KmNQEOzJ2yje2z+YQhtK0OWdA8ONH01v94j9uRP2W
         oUmsRust0v99dDGthscFXzB4C1Zgt+F/G7AzyKC7Lxi1StXICORAQbQOoF6nGAA8DwZV
         exqg==
X-Gm-Message-State: AOAM533Kgu14WfQ+6ij6RmHpH9idqPo5/BFWtGRaPYWol+367jBlT3iK
        atQ5RaePbCw83Z19t7ttlelVccfZq/l8xS4EexI=
X-Google-Smtp-Source: ABdhPJx2I9z+X2u5Rak2LXsBoYr/wcnV6fNFZLxob39fhlFopfjHhsj7EnTYvSWksBHNnJ/j0aWiv676wwLQuJoWNiE=
X-Received: by 2002:a05:600c:4b88:: with SMTP id e8mr15392999wmp.74.1620473894179;
 Sat, 08 May 2021 04:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com> <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com> <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
 <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com> <CAGngYiW=RTkHoSndJDr0mMUgLFfuB18g=AwKTvi8d2-tdBrroQ@mail.gmail.com>
In-Reply-To: <CAGngYiW=RTkHoSndJDr0mMUgLFfuB18g=AwKTvi8d2-tdBrroQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 8 May 2021 07:38:02 -0400
Message-ID: <CAGngYiWMMntihqSonSGZ5=OB0vOm+bvXhFnyb_4EFg5aoKxEdw@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     Linus Walleij <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 7, 2021 at 10:36 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Mike, Linus, Andy, XinHao,

Oops, s/Mike Brown/Mark Brown/. It was getting a bit late :)
