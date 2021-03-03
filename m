Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4832C6E1
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380222AbhCDAaQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241133AbhCCKcq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 05:32:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8877464ECE;
        Wed,  3 Mar 2021 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614762769;
        bh=LcFEAIV39oP6qhAFHARHbGR+Nvr/RN2ia8mLaBzIos0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z7bLFFz9oOMQtk+cVU94y2on5R6Q6uDedD0ceE8/iNe/x8BenPPZ4SJCxbiraQLWI
         bAC3OiRYGRfht03bQg+Fe5L3uDsNHbKAUlo3sOZxjur8xt4ppSFR4rK+YBup7Za6zU
         oVGBTXdLWnIyxSZs/+9zmrv5s9qf882+rPRnZsGA=
Date:   Wed, 3 Mar 2021 10:12:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "luhua . xu" <luhua.xu@mediatek.com>,
        Wei Yongjun <weiyj.lk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Axel Lin <axel.lin@ingics.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        fparent@baylibre.com
Subject: Re: [PATCH] spi: mediatek: Re-license MTK SPI driver as Dual MIT/GPL
Message-ID: <YD9TDv85D/zSV2Li@kroah.com>
References: <20210303025636.795-1-leilk.liu@mediatek.com>
 <YD84OKr4vNwA7vnz@kroah.com>
 <1614762159.5898.9.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614762159.5898.9.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 03, 2021 at 05:02:39PM +0800, Leilk Liu wrote:
> On Wed, 2021-03-03 at 08:18 +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 03, 2021 at 10:56:36AM +0800, Leilk Liu wrote:
> > > From: "leilk.liu" <leilk.liu@mediatek.com>
> > > 
> > > It is wanted to use MTK spi bus driver with GPL-2.0 or MIT license.
> > > But now it is only licensed as GPL-2.0, so re-license it as dual
> > > MIT/GPL.
> > > 
> > > Signed-off-by: leilk.liu <leilk.liu@mediatek.com>
> > 
> > Please use your name here, not an email alias for where your name goes.
> > 
> OK, I'll fix it, thanks!
> > 
> > > ---
> > >  drivers/spi/spi-mt65xx.c                 | 4 ++--
> > >  include/linux/platform_data/spi-mt65xx.h | 2 +-
> > 
> > Given that these files have been licensed under the GPL only since 2015,
> > all changes contributed to it have only been licensed under the GPL as
> > well, so have you gotten approval for all of the contributors for this
> > change?
> > 
> This is the reason that I sent this patch to ask for ACKs from all
> contributors (who are all in the To mail-list) for these files.

That wasn't obvious :)

But given that many of the contributors here do not actually own the
copyrights of their contributions, how can you be sure that the real
owners are agreeing to this?  That requires something much more "legal"
than just an "ack" on a patch.  Please work with your corporate lawyers
for how to do this correctly.

> > Can you please get your lawyer to also sign off on this license change
> > patch, so that we know that you have their approval for this incase
> > there are questions about it in the future?
> > 
> I need to use the code in other projects that is not with GPL-2.0.

What project needs this code that you can not just base it off of your
original contribution instead?  That would not require any license
change of the kernel files, right?  Wouldn't that be easier than trying
to retain this license change over time as you will not be taking the
changes here into another project as well.

> Also, the license change is approved by Mediatek supervisor.

Great, get them to also sign-off on the patch please, along with your
lawyers, so that we know all is done correctly.

thanks,

greg k-h
