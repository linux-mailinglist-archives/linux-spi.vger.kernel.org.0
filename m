Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132483A3F58
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jun 2021 11:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFKJry (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Jun 2021 05:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFKJrx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Jun 2021 05:47:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48F63613CF;
        Fri, 11 Jun 2021 09:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623404756;
        bh=bV0c25psnxZ45TnMzhSLmCCDxKUGPIDab/Wtf/aPOA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T35Yiby6dC7HtrS5nqPDscgVBRcBQPI6e3nQdSeCzBYNh9jAqsim5d5b7+3hfrX52
         tV3sB878jEk3lILhvl4JHW8zzPQ4Ex1GjWcYlqs4jnnHE+zo+rFuTTzMaieUMzRd/w
         C4ydotcwcSIXqg1XJ/5NCe5yR85xNTEyBxMgRUys=
Date:   Fri, 11 Jun 2021 11:45:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 5/6] misc: nxp-ezport: introduce EzPort support
Message-ID: <YMMw0Xh+c/IRZ98R@kroah.com>
References: <20210609151235.48964-1-sebastian.reichel@collabora.com>
 <20210609151235.48964-6-sebastian.reichel@collabora.com>
 <YMMnd3bBgT8QcuQu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMMnd3bBgT8QcuQu@kroah.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 11, 2021 at 11:05:59AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 09, 2021 at 05:12:34PM +0200, Sebastian Reichel wrote:
> > Add new EzPort support code, which can be used to do
> > firmware updates of Kinetis coprocessors. The driver
> > is not usable on its own and thus not user selectable.
> > 
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> 
> Why is this a separate module if only 1 driver needs this?  Why not keep
> it together until you have a second user?
> 
> And this module is not able to be unloaded ever?  Why not?
> 
> > +int ezport_flash(struct spi_device *spi, struct gpio_desc *reset, const char *fwname)
> > +{
> > +	int ret;
> > +
> > +	ret = ezport_start_programming(spi, reset);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ezport_firmware_load(spi, fwname);
> > +
> > +	ezport_stop_programming(spi, reset);
> > +
> > +	if (ret)
> > +		dev_err(&spi->dev, "Failed to flash firmware: %d\n", ret);
> 
> %pe perhaps instead of %d?

Oops, nope, my fault, that's not a pointer.

greg k-h
