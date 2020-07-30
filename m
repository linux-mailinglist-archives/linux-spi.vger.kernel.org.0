Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE93232FF0
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jul 2020 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgG3J4O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jul 2020 05:56:14 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:58417 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgG3J4N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jul 2020 05:56:13 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3352D30000898;
        Thu, 30 Jul 2020 11:56:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id ED72B60DD4; Thu, 30 Jul 2020 11:56:10 +0200 (CEST)
Date:   Thu, 30 Jul 2020 11:56:10 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] driver core: Use rwsem for kill_device()
 serialization
Message-ID: <20200730095610.orkum2n6snb42uzs@wunner.de>
References: <cover.1594214103.git.lukas@wunner.de>
 <bf185285172a7b127424ac22fa42811eb2081cd4.1594214103.git.lukas@wunner.de>
 <20200730065326.GA3950394@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730065326.GA3950394@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jul 30, 2020 at 08:53:26AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 08, 2020 at 03:27:02PM +0200, Lukas Wunner wrote:
> > kill_device() is currently serialized with driver probing by way of the
> > device_lock().  We're about to serialize it with device_add() as well
> > to prevent addition of children below a device which is going away.
> 
> Why?  Who does this?  Shouldn't the bus that is trying to do this know
> this is happening?

AFAICS, at least spi and i2c are affected.

I first thought that pci is affected as well but it seems the global
pci_lock_rescan_remove() performs the required serialization.

I've yet to take a closer look at acpi and usb.  Any bus which
creates a device hierarchy with dynamic addition & removal needs
to make sure no new children are added after removal of the parent
has begun.


> So, why are you pushing this down into the driver core, can't this be
> done in whatever crazy bus wants to do this, like is done here?

I guess it can.  Let me try to perform the locking at the bus level then.

Thanks,

Lukas
