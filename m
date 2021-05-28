Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A2C3944A7
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhE1O6e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 10:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236551AbhE1O6L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 May 2021 10:58:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43FA56109F;
        Fri, 28 May 2021 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622213796;
        bh=9baTcwyVYHyrr3UGzx4nvGBYny1VEy+pk93u4/C9tTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oclZbnlf2bwYWO5MjMB1KT11RoV9HJw25FE4iUYWaBV34oM0U0rFlnRdHhKwvNXHU
         0CPLsVyVwXyW5vUEqs520ROPKy3pgKWKAortq84XD8j+f4J77zEtX2qRHBhOXPK6I7
         x/r4p1R7bXr3z2v3wRh1tw9FaoULX1KEwPKwT7hU=
Date:   Fri, 28 May 2021 16:56:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 5/5] misc: gehc-achc: new driver
Message-ID: <YLEEoV7d0rXn53n0@kroah.com>
References: <20210528113346.37137-1-sebastian.reichel@collabora.com>
 <20210528113346.37137-6-sebastian.reichel@collabora.com>
 <YLDfvD1nLgWqEavS@kroah.com>
 <20210528140654.ffhetiikhde6seuo@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528140654.ffhetiikhde6seuo@earth.universe>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 28, 2021 at 04:06:54PM +0200, Sebastian Reichel wrote:
> > > +	/*
> > > +	 * The sysfs properties are bound to the dummy device, since the main device already
> > > +	 * uses drvdata assigned by the spidev driver.
> > > +	 */
> > > +	spi_set_drvdata(achc->ezport, achc);
> > > +	ret = devm_device_add_group(&achc->ezport->dev, &gehc_achc_attr_group);
> > 
> > You just raced and lost. Please use the default groups attribute for
> > your driver instead of this. Or properly attach it to the device some
> > other way, but what you have done here does not work, sorry.
> 
> I've been told the race got fixed from kernel POV?
> 
> https://lore.kernel.org/linux-input/20200521055400.GX89269@dtor-ws/

Kind of, it's still not good to do this "by hand", the driver core
should do it for you.

> If this is still an issue, I think most (all?) existing instances of
> devm_device_add_group() are a problem and it makes sense to have a
> checkpatch warning for it.

Yes, I need to just get rid of that call entirely.  I'll sick one of my
interns on it...

thanks,

greg k-h
