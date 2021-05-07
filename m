Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD41376BD7
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 23:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhEGVeT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 17:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEGVeT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 17:34:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767EBC061574
        for <linux-spi@vger.kernel.org>; Fri,  7 May 2021 14:33:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b21so13299085ljf.11
        for <linux-spi@vger.kernel.org>; Fri, 07 May 2021 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1X4wT9VJmdOHLFabevqt8sFZYRkgMGdviVtu7swAQpY=;
        b=qHTCGY8RrKshvsET6Cbk3cnv2Iv6PFhaCz3zKtuFkK/qb4a9sQbl8LL8LW/pCKXr0g
         J616zpnfO58CWnz5zDL0j1+Qv09wkVmZdK1yA57ykJzjboMeXj7GTjSatZyHzRywuCMU
         6PuqzDtPeiaqAxgh7Eci/zFdNdzzE7Y0rr3d6J1AVIJ9txGXVlaDH7RsO9PIQgfCAJnd
         cq3h7M/qZdX6NYMD6SSgu3R5WMpZz6bbmd/BPVTHmSLHLqXzSyaimHz//LW9Es6ge3Gk
         lMYnS4AaIohKNj1gs+I63OzwlpowwVQmRalYjkNzWtJaMQTYTtekyhEQvKRHkLYmEV9+
         bTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1X4wT9VJmdOHLFabevqt8sFZYRkgMGdviVtu7swAQpY=;
        b=N2bEelkZTJNvmHJsSxLibf4h+gg1/ZtltQYAFCbnwDdbivl0CYltm/JFN7CnIBqNIq
         b5OefoDU0rp5NYPMHdxRXhp2CuWOa+GaNVAGcXHnosKjCCiHsYZ+kb5rZjlAoKrvoOhN
         mgvILGThLFNh+5upYzsPKrlnJyLDBJdcxsWaynjmp9/ch6WPqbtJ2RhSoq/lnMz9BRm6
         J5MuAMefbiL0K28nQvocFf3uHdcQK3OB5WkK3jcc8q2NQSlbP/9d2ZXb2RWCKjjfeFKR
         NBIly89TLC7E1lHdPLU7yUTLuB2eQtSWcuCsmBGpJVCS98+js8Lv4LrwscnEi+BULOWT
         meqA==
X-Gm-Message-State: AOAM530f7GEqgCTXG70ijq0vn956Fo7OPgcYHM6ggba+1mLtMTrq/+vU
        EJAzkUL/fP5XTLPY7BU3kv9DCQkxeXw7wIf78quHzg==
X-Google-Smtp-Source: ABdhPJx/k1vF/WoBe+z2WnLH2YLXPqQjVqifxgPbo2PdliZ2YdIGiSP/2nFaQLDDrGQkYfPtS/3hpLioL21/SaPMfu4=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr9310512lju.200.1620423196026;
 Fri, 07 May 2021 14:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com> <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com> <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
In-Reply-To: <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 May 2021 23:33:04 +0200
Message-ID: <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 7, 2021 at 9:11 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> It can=E2=80=99t be done due to differences of the expectations from them=
.
> Your patch breaks OF as far as I understand. Linus?

It looks to me like it would break OF.

commit 766c6b63aa044e84b045803b40b14754d69a2a1d
"spi: fix client driver breakages when using GPIO descriptors"
passes enable1 to gpiod_set_value_cansleep() expecting
gpiolib to handle polarity.

If this should be changed, Sven van Asbroeck really needs
to look at it first.

But I think Andy's approach is the best.

Yours,
Linus Walleij
