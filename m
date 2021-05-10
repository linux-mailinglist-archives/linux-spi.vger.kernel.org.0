Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33109378ABC
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 14:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhEJLv7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 07:51:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:26700 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240990AbhEJLhT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 07:37:19 -0400
IronPort-SDR: ccV9khc7HLZARv4jNUhEUfBNIYOvUJmu2cHHiucHebBTgftirop/SuqIJ+Q4rWZU8nw98EHfYy
 D5+9f/egxr3A==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="263104327"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="263104327"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 04:36:13 -0700
IronPort-SDR: RBfyB5z5WIuHe0GlaPbiDUMdtPGMsy2NL50pmyN/e+vHoPvuNHDwMTVsdj4XaviP1a4WmbDM0s
 L/a16fGCrTfg==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="536381037"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 04:36:12 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lg4Cn-00B9ko-IQ; Mon, 10 May 2021 14:36:09 +0300
Date:   Mon, 10 May 2021 14:36:09 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when
 use GPIO as CS
Message-ID: <YJkaqV4JalpS09bs@smile.fi.intel.com>
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com>
 <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com>
 <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
 <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
 <CAGngYiW=RTkHoSndJDr0mMUgLFfuB18g=AwKTvi8d2-tdBrroQ@mail.gmail.com>
 <CAHp75VfD5kEnjvvRWUJwpmFaWksnnTf_ewBNDsxz3W3kQMUv+w@mail.gmail.com>
 <CAGngYiVNE1FjsJZeHL5afpWeqf7pRhHqUcKkChML3KQ=6cj=Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGngYiVNE1FjsJZeHL5afpWeqf7pRhHqUcKkChML3KQ=6cj=Bw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 08, 2021 at 07:46:13AM -0400, Sven Van Asbroeck wrote:
> On Sat, May 8, 2021 at 3:38 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >> 2. Drive the gpiod chip select using the raw value, ignoring the
> >> built-in polarity, which treats it the same as a gpio_xxx. Nice!
> >>
> >
> > Looks nice (if for now don’t take into account the zillion of drivers to be changed), but IIRC last time discussions about this piece of code, the problem also in DT itself, you may not break boards with already cooked DTs. If you are sure about this, go ahead!
> 
> Yes, you're absolutely right, the zillion of drivers to be changed is
> a serious problem. I'm definitely not trying to sweep that under the
> carpet...
> 
> The rule table seems to indicate that the gpio's second devicetree
> flag is ignored when it's used as a SPI gpio. So changing where the
> polarity is stored, should not break DT? It may have repercussions
> elsewhere though, not sure.
> 
> (I hope the formatting will come out ok here. If not, use the link below)
>       device node     | cs-gpio       | CS pin state active | Note
>       ================+===============+=====================+=====
>       spi-cs-high     | -             | H                   |
>       -               | -             | L                   |
>       spi-cs-high     | ACTIVE_HIGH   | H                   |
>       -               | ACTIVE_HIGH   | L                   | 1
>       spi-cs-high     | ACTIVE_LOW    | H                   | 2
>       -               | ACTIVE_LOW    | L                   |
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/spi/spi-controller.yaml?h=v5.12#n54

This table is incompatible with ACPI. So we can't unify them until each of them
will play by the same rules. Can't say it won't happen, but it's far from that.

-- 
With Best Regards,
Andy Shevchenko


