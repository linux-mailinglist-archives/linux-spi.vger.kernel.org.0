Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90B53C69D5
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 07:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhGMFoo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 01:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhGMFoo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 01:44:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEC4A60FF2;
        Tue, 13 Jul 2021 05:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626154914;
        bh=wVeT2vhZy+JsnxcVkh38w1Xh4WtpCCDo8jgUFohfRNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNwjnVw74qXhD8+qq64iR3rh/0wG2zg2frJjWq4lRr+Vi3I8+/WU2IKdjxjppiqWJ
         o1mwoKpwurdmP8pw20M9wr64vUQTzqLctMcCvuK9k2b87la8XP9bV5n+hO/lZMfwqF
         WUnI4MesXuZWaHdsKTgSqjrDZak0zYdOc+MkCQWk=
Date:   Tue, 13 Jul 2021 07:41:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 3/3] misc: gehc-achc: new driver
Message-ID: <YO0nn5iX2835Zta9@kroah.com>
References: <20210712150242.146545-1-sebastian.reichel@collabora.com>
 <20210712150242.146545-4-sebastian.reichel@collabora.com>
 <YOx/3YaIg24Tx+OQ@kroah.com>
 <20210712232016.feixz7mqingdc7ck@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712232016.feixz7mqingdc7ck@earth.universe>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 13, 2021 at 01:20:16AM +0200, Sebastian Reichel wrote:
> Hi Greg,
> 
> On Mon, Jul 12, 2021 at 07:46:05PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 12, 2021 at 05:02:42PM +0200, Sebastian Reichel wrote:
> > > General Electric Healthcare's PPD has a secondary processor from
> > > NXP's Kinetis K20 series. That device has two SPI chip selects:
> > > 
> > > The main interface's behaviour depends on the loaded firmware
> > > and is currently unused.
> > > 
> > > The secondary interface can be used to update the firmware using
> > > EzPort protocol. This is implemented by this driver using the
> > > kernel's firmware API. It's not done during probe time, since
> > > the device has non-volatile memory and flashing lasts almost 3
> > > minutes.
> > 
> > In thinking about this some more, why does it matter?  Spin up a
> > workqueue when probing and do the firmware loading then. That way you
> > do not end up creating yet another custom user/kernel api just to do
> > something as trivial as loading the firmware for a device.
> > 
> > And I think the firmware loader even handles async loading, or at least
> > it used to, maybe not anymore, it's a complex api, I recommend reading
> > the docs...
> 
> Flashing the firmware during boot instead of on-demand is not
> a good idea for two reasons:
> 
> 1. This will wear the flash memory of the microcontroller for no
>    good reason.

Why would you boot with this hardware and not want the firmware loaded?

> 2. Even if the flashing happens in the background, the microcontroller
>    will not be usable while it is being programmed. Thus the system
>    boot takes 3 minutes instead of 30 seconds.

Why would the system boot depend on the firmware being loaded?

You have to wait sometime, might as well get the first 30 seconds of
waiting out of the way while the rest of the system boots :)

> Note, that this is not the first device with this kind of problem.
> I've seen this before for e.g. atmel touchscreen [0] basically does
> the same via (undocumented) mxt_update_fw_store().
> 
> [0] drivers/input/touchscreen/atmel_mxt_ts.c

Yes, but everyone else uses the normal firmware api method of doing
this, don't take one odd driver as being the "rule" :)

> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  .../ABI/testing/sysfs-driver-ge-achc          |  14 +
> > >  drivers/misc/Kconfig                          |  11 +
> > >  drivers/misc/Makefile                         |   2 +
> > >  drivers/misc/gehc-achc.c                      | 136 +++++
> > >  drivers/misc/nxp-ezport.c                     | 468 ++++++++++++++++++
> > >  drivers/misc/nxp-ezport.h                     |   9 +
> > 
> > Why is there two different modules here for the same piece of hardware?
> 
> It's only one module, but I put all the generic ezport code into its
> own file for easy code reuse. I can put it all into gehc-achc and
> thus reduce the chance of code reuse if somebody else needs to do
> ezport flashing. Since both files are built into the same module
> the size savings of merging both files are minimal.

Sorry, you are right, I read the code and Makefile wrong.

But, from an organizing point of view, having 2 random files in that
directory that are not named alike being built together into one module
is not obvious at all.

For now, keep it to one file.  If future users come along that need this
method, split the code then, no need to do extra work at this point in
time for unknown uses.

> > > +static ssize_t update_firmware_store(struct device *dev, struct device_attribute *attr,
> > > +				     const char *buf, size_t count)
> > > +{
> > > +	struct achc_data *achc = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	if (count != 1 || buf[0] != '1')
> > > +		return -EINVAL;
> > 
> > There a core kernel call to see if the data written to a sysfs file is
> > "true/false" I would recommend, if you stick with this, to use that
> > instead.
> 
> I have problems understanding that sentence, it seems to be missing
> a word.
> 
> As far as I can tell -EINVAL is usually used when the user supplied
> data is not formatted correctly for sysfs store routines, e.g. lot's
> of them are returning -EINVAL like this:
> 
> rc = kstrtoul(buf, 0, &value);
> if (rc)
>     return rc;
> 
> Did I miss something?

I was trying to say "use kstrtoul()" instead of trying to hand-roll much
the same thing.  Sorry for not being specific.

thanks,

greg k-h
