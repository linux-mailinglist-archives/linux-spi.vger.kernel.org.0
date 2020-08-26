Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A80253985
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 23:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHZVHD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 17:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHZVHC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 17:07:02 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C7AC061574;
        Wed, 26 Aug 2020 14:07:02 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q21so1804777edv.1;
        Wed, 26 Aug 2020 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Os1LN7Ue+Ms9CVeN7ASmdmMTYx1HCqAOOT3/+0mXhg=;
        b=PtFcrHvI6+V4VyHgf02ZQVEQf/Nbjj3TPaB0qAz/abmIAwiZ2ezYJ5lgCSAGzQUAox
         O8FEw5ZWgrVK5GXdTTtXj2jzNV5BchVbIsaDfmpuGAXeErGEb1LbI+7rhESOvCCAuEc4
         UlOfXYO/G+Cj3Y6P2OXhC+N96u3CiacF7omuraKWHo7NH4ZTIeHReQJsArfygjJnYj4b
         eM3Sj2pXvju6R/vwgxDsBFjRecPy+8nZ/ijvXkExngPCLaTGkNY09jN5olxpvRjOg5vB
         XOwDSOaqwDjuGV2T1m/bb4NKsFkEv0ADJBl6py9SjSuNvcLB2/Xj74EBekm7RYo0Z2yr
         ITEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Os1LN7Ue+Ms9CVeN7ASmdmMTYx1HCqAOOT3/+0mXhg=;
        b=EMG0BwzChp+zJ5fX55pvxCOLMyPpNSYUJ2LvwHaKcEI21rkRov0pBe2iBzChnFLFTm
         v9fwNCD0rEgRJXnaNtekWLqvQQRehh6mjXXOIO1wT3tbFbfIo/4t7LZr4dOEDZY1qqL/
         w8WV7xaRPy+xM3JTmeWpBWQ3gjXu1zJoe1FTFjQKzmHCyZjl8aISvJdsmb+5HoIltS5L
         dSQRoxIaVRaE8d3LERNzypdJJl1DfeNoGvYwUk5r4kpvm+S3XoA3SkSDoa3N+QZiFMcw
         Ad6XrClb5ff/Z1mF2K6fdMdF+XSK6gLe7xEhsQMybXlW3nHDe3Vo0A05HUesrWOU4zn5
         9spw==
X-Gm-Message-State: AOAM532l3MZt0TRucqovk4HKkQC/2LyA+g5koK1x8/0jZCC2dC3zq2hu
        K8B1rFHxWK5mwm4P9xVyat2+fmdGvV4=
X-Google-Smtp-Source: ABdhPJxiegS9IXlSGKx/12qlpIj+mvTmflGrxgGgaRzu0Q6o1wRNRQgOGRIVgaLIUSuqoAihTbBPJw==
X-Received: by 2002:aa7:da02:: with SMTP id r2mr4198492eds.231.1598476019749;
        Wed, 26 Aug 2020 14:06:59 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id o7sm2882960edq.53.2020.08.26.14.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 14:06:59 -0700 (PDT)
Date:   Thu, 27 Aug 2020 00:06:57 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        tanveer <tanveer.alam@puresoftware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826210657.z526xjhhkq6vkxgr@skbuf>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200822183342.6sdhp6yq6i7yvdia@skbuf>
 <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
 <20200826204108.reuy7ieqabutwuwo@skbuf>
 <20200826204547.GU4965@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826204547.GU4965@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 26, 2020 at 09:45:47PM +0100, Mark Brown wrote:
> On Wed, Aug 26, 2020 at 11:41:08PM +0300, Vladimir Oltean wrote:
> > On Wed, Aug 26, 2020 at 10:34:04PM +0300, Andy Shevchenko wrote:
>
> > > Theoretically you may declare your HID in the same / similar way as
> > > PRP0001 and use same compatible strings and all other DT properties
> > > (when they make sense and not duplicate ACPI functionality).
> > > But better if ACPI people can tell you (I Cc'ed Rafael and ACPI
> > > mailing list) if it is gonna work.
>
> > Something doesn't look right about PRP0001, what's the catch?
>
> Microsoft decided not to implement support for it in Windows, it's
> essentially there for embedded style x86 platforms running Linux so they
> don't need to reimplement so many wheels and can just reuse existing DT
> bindings but it causes problems if you want to run Windows (and possibly
> some of the enterprise Linux distros, I can't remember if any of them
> had concerns about it) on the platform.

So if a silicon vendor doesn't care about Windows, what incentive does
it have to even register an official ACPI/PNP ID for its devices?
