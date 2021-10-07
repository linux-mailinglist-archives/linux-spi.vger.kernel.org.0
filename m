Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC46E4257B9
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 18:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbhJGQVn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 12:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242631AbhJGQVm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Oct 2021 12:21:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEF536113E;
        Thu,  7 Oct 2021 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633623589;
        bh=Mk81amKBBYXKslOkYC455eudE2LnTW5hOnr9rGAWn3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/Mju2FuTkUcFv4zQ4AJpoVs2bIhiRxGCBmYx4BgbRfhIVuuU0BheRwyw+KrXu30s
         BpcBfd+OgASArBT5u+4Ka89vxVbcjSG8jAAOkqQuRPOXAekPTF8RW1W19POrDzKRH9
         UjI4pkoe+NrKR4AycujcsCPgjmGb6USBHTNLNs6M=
Date:   Thu, 7 Oct 2021 18:19:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: Deadlock in spi_add_device() -- device core problem
Message-ID: <YV8eIoxIxQLC5x5N@kroah.com>
References: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007160524.qhjtcwtto2ftsmhe@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 07, 2021 at 06:05:24PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On an ARM board with an spi-mux I observe a deadlock during boot. This
> happens because spi_add_device() (in drivers/spi/spi.c) for the spi-mux
> device calls device_add() while holding &spi_add_lock. The spi-mux
> driver's probe routine than creates another controller and for the
> devices on that bus spi_add_device() is called again, trying to grab
> &spi_add_lock again.
> 
> The easy workaround would be to replace &spi_add_lock with a
> per-controller lock, but I have the expectation that it should be
> possible to not hold a lock while calling device_add().

No, busses should not be adding new devices to the same bus from within
a probe function.

Drivers for a bus bind to the bus, they should not be creating new
devices for that same bus, as that does not seem correct.

> The difficulty (and the reason that this lock exists) is that it should
> be prevented that more than one device is added for a any chipselect.
> My first guess was, this check isn't necessary, because the devices are
> called $busname.$chipselect and a second device on the same bus with the
> same chipselect would fail when device_add() tries to create the
> duplicate name. However for devices instanciated by ACPI the naming is
> different (see spi_dev_set_name(), and commit b6fb8d3a1f15). Also there
> is a comment "We need to make sure there's no other device with this
> chipselect **BEFORE** we call setup(), else we'll trash its
> configuration." A problem there might be that spi_setup() might toggle
> the chipselect line (which is a problem if the chipselect polarity
> isn't the same for the two devices, or the earlier device is currently
> busy). Anything else?
> 
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
> 
> Does this all sound about right? Greg, do you have a recommendation how
> to properly fix this problem?

Don't allow it :)

Since when do spi devices find new spi devices on their same bus?  This
feels very wrong...

thanks,

greg k-h
