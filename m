Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECFF5D5A8
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfGBRwP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 13:52:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38932 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRwP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 13:52:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so8044674pgc.6
        for <linux-spi@vger.kernel.org>; Tue, 02 Jul 2019 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ixpJfhwdwCZLCTaghHH9e+e+L7UAinPYTOetEuPG/A=;
        b=t/vVRSaFiBTzjienW48J86EsCpUaCkc/PDBmaU7Bb7qxoI1gKuuRJF4JUKsdV9lOtW
         /Q2uAUK8Kra8RDpuWY0RyoYWapAPZyKvJwTO1crcKUGW9cobavcLlMZMnZJNVxGFLFZn
         AOX/umovqlqlYdCPQyyyu2gIryRRGOyo1qjDtGaZOFmC+DcDVh34k/yJc002u6VnXEx9
         Ppe0Xj4DKX9EOsvrrwVtRK9YI+HLXFCLdL6iYbQfYuiULHqOg8xRQeORL3H9U4+xgKqd
         ADk93mCttIQIIWjvpGFAOe35FsTNiSSU9gIL/toudX0FcUid1S3H1nKVlyf5GXwQ4B9Q
         HkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ixpJfhwdwCZLCTaghHH9e+e+L7UAinPYTOetEuPG/A=;
        b=NKN2y6wkzbeeaYnM7oQAfwN314m0nf51/aFESwq44aZUZnQIxL00Hn1RqhsWmHrNdj
         yIsGSuBLvtwtrcjzpSxUmEPf/BqJShgn2sZUCRMUxMjrCr8sBDT9gYeYQJXFHlB474yY
         289WI+aiu6LYWrZ0qMOVTL02S8J8elwiHXjoOv2ouawevr+TxGaSo/K1ns7aUPFSO+jF
         IuuITr1McqLVrzUjzOO30Ygj6pP11/gMJZYtA+HZ4Unn8ovp4SbVfdWfOFqtJhJCcf8W
         TWq5SjFKvzfEEDOgtALSK/7H518Xsjo2ytkHfD44H6xpjtArHb+DnVZL5CGqbV2YEFzS
         jn4w==
X-Gm-Message-State: APjAAAWsUBj+bWgTr49qzYc25KxZ6WGbGngUXsXDKKMjcdVHgiYKDaJZ
        +DaYNxy7vhPyTFgsk9qdb4+KhCbtn5AbrZRuLJQ=
X-Google-Smtp-Source: APXvYqygpARTK8BhLrsqM9pgZq3+2m1WQBcQHvsUYYR8EG8jFDMj4s2LFaGKChnB61sfDX8JwvvHFS+F83Kgngs1urg=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr13451678pgc.74.1562089934510;
 Tue, 02 Jul 2019 10:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <201906042339.gt5sS7Hb%lkp@intel.com> <CAHp75VcqTvoSf3-vbH555iY9NNu+fd5bzL0TFxfZEVU3M=Pg2Q@mail.gmail.com>
In-Reply-To: <CAHp75VcqTvoSf3-vbH555iY9NNu+fd5bzL0TFxfZEVU3M=Pg2Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jul 2019 20:52:03 +0300
Message-ID: <CAHp75VdVKCwwijbQNTqxLaR8k=D2SHRZ=D6pJDaTSVQL=j_Oow@mail.gmail.com>
Subject: Re: [spi:for-5.3 41/41] drivers/spi/spi-synquacer.c:153:3: error:
 implicit declaration of function 'readsb'; did you mean 'readb'?
To:     kbuild test robot <lkp@intel.com>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>, kbuild-all@01.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 2, 2019 at 8:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jun 4, 2019 at 6:59 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3
> > head:   b0823ee35cf9bc6b9a5403c12f12bd3e0b490045
> > commit: b0823ee35cf9bc6b9a5403c12f12bd3e0b490045 [41/41] spi: Add spi driver for Socionext SynQuacer platform
> > config: alpha-allyesconfig (attached as .config)
> > compiler: alpha-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout b0823ee35cf9bc6b9a5403c12f12bd3e0b490045
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=alpha
> >
>
> It seems false positive.
> kbuild bot has to be fixed,


Ah, didn't noticed ALPHA!
Perhaps,

depends on !ALPHA (or how is it called?)

should fix this.

-- 
With Best Regards,
Andy Shevchenko
