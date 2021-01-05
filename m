Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF62EB393
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 20:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbhAETmO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 14:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbhAETmO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 14:42:14 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E946C061574
        for <linux-spi@vger.kernel.org>; Tue,  5 Jan 2021 11:41:34 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v19so524538pgj.12
        for <linux-spi@vger.kernel.org>; Tue, 05 Jan 2021 11:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMFOAFZFlYW+eUre2PkHe1D8HJjsKx5wuGAw4VigT/k=;
        b=PYhRu3fodzwT3SmYBMkpVuB+dfW7fvTvp8+QoF5yCIBs0egWnRrypiB5bFIxjUAfnH
         XkwDQjlATI1N1MIZ8ueqtkUl2y3iV6ysXr60bCnNRCo6vq8igHsXORFf+6SdI924zbxy
         /83HmwpIlV7icwC6HyMDaBGO0g2BOIw30xVgw67YGpL23IIXDvGI2QBIaC+porCc8hCS
         neiD6owyzEGK7qNgHuaeYmUNpMX7RAMbDZLBK1L2rbcPnpjPbzzdrawZsoKNaZDl+Bdv
         UCbOcdJur+iUcfxh/BwARd84J7eFYy/El0qlWbdyENjKOW6msBrh2ZcF9oySrmYZcayH
         c1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMFOAFZFlYW+eUre2PkHe1D8HJjsKx5wuGAw4VigT/k=;
        b=liK8Kiu3ErPp4Tf8H9W/2cdFSHF6bVu/7LwbLUw4oZLhAbtrJsMInl5fB7y/rV8PnR
         P8V7UOvM22KWmgtycI1Iz5posDj1UzJCPhxIk7LLv8p0Lma2cFceClS6QFMFA+d0hoM4
         AIWZnmSzQ3ctxj4Y9E221CGnoZ1jnk/Bpu1oyZisvPlZk7OvG6wfTRHJHGC8Ik9rr2dK
         gpx1w7Wyh8YxgReAlTy0R09Ir3NRXW9/D/a1jzYV7+EFDFUeK7T1JwSiFQ/Cg2Yr5xxU
         OIay7IAXrEQoY286DIZB74ogivkL1o9dRrytX602etEIfBIoEwCGvY33uKs6UvmerQpE
         eO3Q==
X-Gm-Message-State: AOAM533LM7RTRVtIyijYUXXXhVnSCRnsYCrV0lDL5gW4AEpf2Ws06kQu
        mG73GtpoENpAtdQfQAdwPMXobo9/zwOZFqxgmG/NAQ==
X-Google-Smtp-Source: ABdhPJzZaj54e0rqEqOprP4a9mEFCCyzuXKeSYX7ix+zANye147fcj5ZIWekkh9+e/KR+LQ6BaXoGywjQE/GTDeFSCQ=
X-Received: by 2002:a62:7c4a:0:b029:19d:b7bc:2c51 with SMTP id
 x71-20020a627c4a0000b029019db7bc2c51mr631636pfc.30.1609875693171; Tue, 05 Jan
 2021 11:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20201222184425.7028-7-p.yadav@ti.com> <202012291151.fApnPO6i-lkp@intel.com>
 <20201229091806.eyrakehdxo6762sg@ti.com>
In-Reply-To: <20201229091806.eyrakehdxo6762sg@ti.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Jan 2021 11:41:25 -0800
Message-ID: <CAKwvOdnNeAXUsNQnSmVmODT9C4_J9cX7prRaYTs+R588=JW7LA@mail.gmail.com>
Subject: Re: [PATCH 6/7] spi: cadence-quadspi: Wait at least 500 ms for direct reads
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 29, 2020 at 1:18 AM 'Pratyush Yadav' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On 29/12/20 11:29AM, kernel test robot wrote:
> > Hi Pratyush,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on spi/for-next]
> > [also build test WARNING on v5.11-rc1 next-20201223]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/Pratyush-Yadav/spi-cadence-quadspi-Add-Octal-DTR-support/20201223-025328
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> > config: arm-randconfig-r006-20201221 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://github.com/0day-ci/linux/commit/04a7bcbc449363e5d6f498376c69116567b49d7d
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Pratyush-Yadav/spi-cadence-quadspi-Add-Octal-DTR-support/20201223-025328
> >         git checkout 04a7bcbc449363e5d6f498376c69116567b49d7d
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/spi/spi-cadence-quadspi.c:966:24: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'unsigned int *') and 'typeof (500UL) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
> >                                             msecs_to_jiffies(max(len, 500UL)))) {
> >                                                              ^~~~~~~~~~~~~~~
> >    include/linux/minmax.h:58:19: note: expanded from macro 'max'
> >    #define max(x, y)       __careful_cmp(x, y, >)
> >                            ^~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/minmax.h:42:24: note: expanded from macro '__careful_cmp'
> >            __builtin_choose_expr(__safe_cmp(x, y), \
> >                                  ^~~~~~~~~~~~~~~~
> >    include/linux/minmax.h:32:4: note: expanded from macro '__safe_cmp'
> >                    (__typecheck(x, y) && __no_side_effects(x, y))
> >                     ^~~~~~~~~~~~~~~~~
> >    include/linux/minmax.h:18:28: note: expanded from macro '__typecheck'
> >            (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> >                       ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
> >    1 warning generated.
>
> On arm64 size_t is defined as unsigned long and on arm is it defined as
> unsigned int. So using 500U would generate the same warning on 64-bit
> platforms. Maybe the fix is to do something like: max(len, (size_t)500).
> Any better ideas?

SGTM

-- 
Thanks,
~Nick Desaulniers
