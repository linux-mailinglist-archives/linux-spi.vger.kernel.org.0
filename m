Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72A442B806
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhJMGyl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 02:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231638AbhJMGyk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 02:54:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A524960EDF;
        Wed, 13 Oct 2021 06:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634107958;
        bh=64sfS8lwb1dMnCb2mzT+ksd45faTrMdUw4Ro9SdcHYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUyrJzynZTuVXfmHBa7A6Q/fvVpmbFoZsF0TGrCh5o47sT24fx05/Ar+UrvuPJuFm
         7C5dS3/Tf7D5ykSajBkiQL8X3I6fso44fHI39BUE2xuohRlr9ElPL8xRD9S/xPM0Cs
         AbnjIm6IQWLPoD4siKS2To5OrzAdzJsIzpT8XWMs=
Date:   Wed, 13 Oct 2021 08:52:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: Deadlock in spi_add_device() -- device core problem
Message-ID: <YWaCMwt+2QVRfCKY@kroah.com>
References: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
 <YV8eIoxIxQLC5x5N@kroah.com>
 <20211007165214.r5h7x3evdqbwxmma@pengutronix.de>
 <YWBITX2Wbfx/QHCE@sirena.org.uk>
 <20211012193005.lxqzbsdeh4k7nxe2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012193005.lxqzbsdeh4k7nxe2@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 12, 2021 at 09:30:05PM +0200, Uwe Kleine-König wrote:
> Hi Mark,
> 
> On Fri, Oct 08, 2021 at 02:31:57PM +0100, Mark Brown wrote:
> > On Thu, Oct 07, 2021 at 06:52:14PM +0200, Uwe Kleine-König wrote:
> > > On Thu, Oct 07, 2021 at 06:19:46PM +0200, Greg Kroah-Hartman wrote:
> > > > On Thu, Oct 07, 2021 at 06:05:24PM +0200, Uwe Kleine-König wrote:
> > 
> > > > Drivers for a bus bind to the bus, they should not be creating new
> > > > devices for that same bus, as that does not seem correct.
> > 
> > > That's not the culprit here. We have a spi-device (spi-mux) that is a
> > > bus device on the SoC's bus and a bus master for it's own bus. And
> > > spi_add_device for the spi-mux device triggers the probe function for
> > > the spi-mux driver which creates a new bus controller which triggers
> > > spi_add_device() for the devices on the inner bus.
> > 
> > I think we need to be arranging for spi_add_lock to be per bus
> > rather than global - putting it into the controller ought to do
> > the trick.
> 
> Yeah, that's what I consider the second best option that I already
> mentioned in the initial mail of this thread.
> 
> @Greg: Would you expect that it should be possible (and benificial) to
> rework the code to not hold a lock at all during device_add()?

rework the driver core or the spi code?

/me is confused...

> 
> This would then need something like:
> 
> 	lock() # either per controller or global
> 	if bus already has a device for the same chipselect:
> 	    error out;
> 	register chipselect as busy
> 	unlock();
> 
> 	ret = device_add(...)
> 
> 	if ret:
> 	    lock()
> 	    unregister chipselect
> 	    unlock()
> 
> Is this worth the effort?

Watch out that you do not have probe() calls racing each other, we have
guaranteed that they will be called serially in the past.

thanks,

greg k-h
