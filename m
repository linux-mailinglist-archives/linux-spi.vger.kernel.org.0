Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD04F36C590
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 13:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhD0Luc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 07:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhD0Lub (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 07:50:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D293361002;
        Tue, 27 Apr 2021 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524188;
        bh=VX3HwOn8sTx95Uhi2Qyewuwpq9p8vfQOXdkqnYEe10g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRUjblZuePo0P0vVslJrRyKvz6Jy74fvqhEqjyB2dz+SKs71DH9sBEkfPFuj/tFQf
         uJHEp0vrHCH4nIhQxtHr/r3o+SgjlDqzeHX7bn9F+XDE+H5Fld/ZzxJEO8CjYqdTEU
         BB1bXivp4Fdra39fgEX6/2GGdBmKhnHEWB2KNAag=
Date:   Tue, 27 Apr 2021 13:49:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
Message-ID: <YIf6WeFCJaj404xT@kroah.com>
References: <20210426235638.1285530-1-saravanak@google.com>
 <CAHp75VeNZ4-TgkevNF5tgmB1eU9E77RNsPWRABp6PvC6eGpQrQ@mail.gmail.com>
 <20210427104851.GC4605@sirena.org.uk>
 <CAHp75VdpC687cHezCy5nP6BRYo-dS8COYvBBvu02f6W_dS6JEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdpC687cHezCy5nP6BRYo-dS8COYvBBvu02f6W_dS6JEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 27, 2021 at 02:42:19PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 27, 2021 at 1:49 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, Apr 27, 2021 at 09:52:48AM +0300, Andy Shevchenko wrote:
> > > +Cc Lukas
> >
> > The cleanup callback has been in release() since the framework was
> > merged AFAICT.
> 
> Yep.
> 
> Personally it feels to me wrong to require device_release() being
> atomic. It might be that I missed something in documentation or
> somewhere else that suggests the opposite.
> But let's wait for other comments if any.

There is no requirement from the driver core to have the release
callback be "atomic", you should be able to sleep just fine in there.

If not, something is wrong and has changed...

thanks,

greg k-h
