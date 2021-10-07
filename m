Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A737742597D
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 19:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242353AbhJGRcc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 13:32:32 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:39779 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242331AbhJGRcb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Oct 2021 13:32:31 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2021 13:32:31 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A1FFF2800BD95;
        Thu,  7 Oct 2021 19:23:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 945C41D3262; Thu,  7 Oct 2021 19:23:59 +0200 (CEST)
Date:   Thu, 7 Oct 2021 19:23:59 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: Deadlock in spi_add_device() -- device core problem
Message-ID: <20211007172359.GA13719@wunner.de>
References: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 07, 2021 at 06:05:24PM +0200, Uwe Kleine-König wrote:
> On an ARM board with an spi-mux I observe a deadlock during boot. This
> happens because spi_add_device() (in drivers/spi/spi.c) for the spi-mux
> device calls device_add() while holding &spi_add_lock. The spi-mux
> driver's probe routine than creates another controller and for the
> devices on that bus spi_add_device() is called again, trying to grab
> &spi_add_lock again.
> 
> The easy workaround would be to replace &spi_add_lock with a
> per-controller lock,

Either that or register the controller from spi-mux asynchronously
by way of a work item.


> There is also a check:
> 
> 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) &&
> 	    !device_is_registered(&ctlr->dev)) {
> 		return -NODEV;
> 	}
> 
> which catches the race that the controller (which is also the device's
> parent) is about to go while we try to add a new device to it. Is this a
> real problem? (The spi_unregister_controller() function unregisters all
> children which might race with adding a new child without locking. This
> check was implemented by Lukas Wunner (on Cc:) in commit ddf75be47ca7.)
> Doesn't all children of a given device are unregistered automatically by
> the device core somehow when said device is unregistered? (I checked,
> but didn't find anything.)

No, the device core makes no such guarantee.

Thanks,

Lukas
