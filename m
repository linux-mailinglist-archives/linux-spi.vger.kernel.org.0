Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076103771E4
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 14:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhEHMts (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 8 May 2021 08:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhEHMtr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 8 May 2021 08:49:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14999C061574
        for <linux-spi@vger.kernel.org>; Sat,  8 May 2021 05:48:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l14so11904761wrx.5
        for <linux-spi@vger.kernel.org>; Sat, 08 May 2021 05:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SY5P24KlbXnVKjQ4LJHNplf2PSUHocmNRGN4JWde4aA=;
        b=Zdr7pEKFkf1G12B+rob4GpsIkmd/ll6Ae2XrwHLjbj2+DVzKPD4x5EeoKsRadTdQ1Q
         W7g7EIcMk4n+ERJ9wqnd2jHoQ/MJ7VLDCoONfunGD6AwoM+/DXvtcMNPzX1nW15+xlFl
         tg2QQpN2dDh6bN3xPy1zV50R+viFfwlTqYQq4FXioQ3DbtXDw3sobRvuQUiovpthZfH/
         +hJsixNntHChiP7Gyha3pqkp9Dk5bPl3INY953mym+CKdirPnwFmYICcbHnbWM2tQqJN
         nTIFs+4fQTM5m2qppHVzgqY30hdYfEllpxYmo/Tb1gV8qYuKslLV+fynJgKGX2e/HyeO
         3Zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SY5P24KlbXnVKjQ4LJHNplf2PSUHocmNRGN4JWde4aA=;
        b=oIbO99FUMXtqJ5mi0YdeBA1u+A39KlmKbgrSzsus4QqlHk4AL3VkjcJH+d/gABL11R
         ROJ7S0u3ECgdIp5WbT9Vb0alinuZTly6CNUKlvDOV0J95EfOJSMDQvOvSOX2cLcjB/0q
         /OrHuwvT0yjsajvvX6XB3jtjXHW7K0RiJ6YbwIs+JAWDikjOHnt5KCV0PoPFrzWpeHKK
         ZK0M6z81SvlWMxzJyv0bR3YH3pEYT+f3yFmF7PD3DVF0HK0PQhVL7FlCPAiTS8a/T8Xc
         /kseCvnID+i1ffbbtYPc+mRDCUxLaFFRbRf9VZKaPhfd9mEZP1uz7aAgwDL5Nqq4iShb
         Ck9A==
X-Gm-Message-State: AOAM531bWSKB48ScrF3dIHfs9pieph1kWqUoSF1fPFn9qeM40aF1FUSP
        WPALmbRM60MAEW9KkgggIH3Vh2c2UiliMRnXSwA=
X-Google-Smtp-Source: ABdhPJw7Lk06P1vhGBruCF2vCTN/prcs9hGmboe2YGtIauCnb/4x9XtH4N9s6IPgz/yaILBPi0Rn2163Qfn+0AjBn+s=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr19063889wrt.197.1620478124678;
 Sat, 08 May 2021 05:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com> <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com> <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
 <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
 <CAGngYiW=RTkHoSndJDr0mMUgLFfuB18g=AwKTvi8d2-tdBrroQ@mail.gmail.com>
 <CAHp75VfD5kEnjvvRWUJwpmFaWksnnTf_ewBNDsxz3W3kQMUv+w@mail.gmail.com> <CAGngYiVNE1FjsJZeHL5afpWeqf7pRhHqUcKkChML3KQ=6cj=Bw@mail.gmail.com>
In-Reply-To: <CAGngYiVNE1FjsJZeHL5afpWeqf7pRhHqUcKkChML3KQ=6cj=Bw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 8 May 2021 08:48:33 -0400
Message-ID: <CAGngYiVh9Ega657-_=rODNdpefA1Y-CHSAKS=Hr48EgARyUJ9Q@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 8, 2021 at 7:46 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>It may have repercussions
> elsewhere though, not sure.

We can try to identify the fixes generated to deal with the changes
introduced in 766c6b63aa04, and revert them:
$ git log | grep 766c6b63aa04
$ git log | grep SPI_CS_HIGH
$ git log -p | grep SPI_CS_HIGH

This brings up:
7a2da5d7960a6 ("spi: fsl: Fix driver breakage when SPI_CS_HIGH is not
set in spi->mode")
