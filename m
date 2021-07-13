Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC863C6F07
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhGMK7g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 06:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235508AbhGMK7e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 06:59:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 864666127C;
        Tue, 13 Jul 2021 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626173805;
        bh=CUz5DNHYp7J2Qi4kShmm8q0o4eae/stvnRk/KeoGgd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2g8iUO2SdpRvF+7XcoZeodN1uD/DGbSvIZCBZ3/PIeX7UEFhAXoM75bDR2IFYbGV
         gkfE37qOel6g+2CxBLKDLqHGu6gcGWEHq8dLpo7fgRPShZfFUiI1pvwPMy22N1LVLa
         bVWRlGdFxmR7Qy4j08trX7JsaoJbMg7RWM66gEL0=
Date:   Tue, 13 Jul 2021 12:56:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 3/3] misc: gehc-achc: new driver
Message-ID: <YO1xaUAgO2LnXLva@kroah.com>
References: <20210712150242.146545-1-sebastian.reichel@collabora.com>
 <20210712150242.146545-4-sebastian.reichel@collabora.com>
 <YOx/3YaIg24Tx+OQ@kroah.com>
 <20210712232016.feixz7mqingdc7ck@earth.universe>
 <YO0nn5iX2835Zta9@kroah.com>
 <20210713104600.gbhixaf7r4cukg6i@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713104600.gbhixaf7r4cukg6i@earth.universe>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 13, 2021 at 12:46:00PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jul 13, 2021 at 07:41:51AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jul 13, 2021 at 01:20:16AM +0200, Sebastian Reichel wrote:
> > > On Mon, Jul 12, 2021 at 07:46:05PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Jul 12, 2021 at 05:02:42PM +0200, Sebastian Reichel wrote:
> > > > > General Electric Healthcare's PPD has a secondary processor from
> > > > > NXP's Kinetis K20 series. That device has two SPI chip selects:
> > > > > 
> > > > > The main interface's behaviour depends on the loaded firmware
> > > > > and is currently unused.
> > > > > 
> > > > > The secondary interface can be used to update the firmware using
> > > > > EzPort protocol. This is implemented by this driver using the
> > > > > kernel's firmware API. It's not done during probe time, since
> > > > > the device has non-volatile memory and flashing lasts almost 3
> > > > > minutes.
> > > > 
> > > > In thinking about this some more, why does it matter?  Spin up a
> > > > workqueue when probing and do the firmware loading then. That way you
> > > > do not end up creating yet another custom user/kernel api just to do
> > > > something as trivial as loading the firmware for a device.
> > > > 
> > > > And I think the firmware loader even handles async loading, or at least
> > > > it used to, maybe not anymore, it's a complex api, I recommend reading
> > > > the docs...
> > > 
> > > Flashing the firmware during boot instead of on-demand is not
> > > a good idea for two reasons:
> > > 
> > > 1. This will wear the flash memory of the microcontroller for no
> > >    good reason.
> > 
> > Why would you boot with this hardware and not want the firmware
> > loaded?
> 
> As written in the commit message this code is updateing the firmware
> in non-volatile memory, so the previously flashed FW will be used
> until a new one is flashed.
> 
> The datasheet for the memory being programmed states, that it has a
> guaranteed programming endurance of 10.000 times. So programming it
> at every boot instead of manually when a new FW should be flashed
> (i.e. once every few years) shortens the device life time considerably.

Ah, ok, that was not obvious at all.  This is much more like a "BIOS
update" in that it is infrequent.  You might want to document the heck
out of this so others are not confused like me.

thanks,

greg k-h
