Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41BB233F51
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 08:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgGaGpT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 02:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731400AbgGaGpS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 31 Jul 2020 02:45:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F3C20829;
        Fri, 31 Jul 2020 06:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596177917;
        bh=1YXpe3U3o4uaI2bdopIW3kDgpC0UgdKI39pipMD2SOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8u4Ypz5WsgTFM/sdmSvhPdx18F5Ncfwx6utunjwqEs65LQWv47Ol8sOCLpc+42ZP
         2IBnWysBTugUJ+Vn5iuruZw6gGmdwAwaLggMGiqNHjE6YcehlgF52LSA5HdllByvWD
         7LyissnM2TLiBRCtGP6Xxbmfeh15g4lGZ4gNDetA=
Date:   Fri, 31 Jul 2020 08:45:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] driver core: Use rwsem for kill_device()
 serialization
Message-ID: <20200731064505.GH1508201@kroah.com>
References: <cover.1594214103.git.lukas@wunner.de>
 <bf185285172a7b127424ac22fa42811eb2081cd4.1594214103.git.lukas@wunner.de>
 <20200730065326.GA3950394@kroah.com>
 <20200730095610.orkum2n6snb42uzs@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730095610.orkum2n6snb42uzs@wunner.de>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jul 30, 2020 at 11:56:10AM +0200, Lukas Wunner wrote:
> On Thu, Jul 30, 2020 at 08:53:26AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 08, 2020 at 03:27:02PM +0200, Lukas Wunner wrote:
> > > kill_device() is currently serialized with driver probing by way of the
> > > device_lock().  We're about to serialize it with device_add() as well
> > > to prevent addition of children below a device which is going away.
> > 
> > Why?  Who does this?  Shouldn't the bus that is trying to do this know
> > this is happening?
> 
> AFAICS, at least spi and i2c are affected.
> 
> I first thought that pci is affected as well but it seems the global
> pci_lock_rescan_remove() performs the required serialization.
> 
> I've yet to take a closer look at acpi and usb.  Any bus which
> creates a device hierarchy with dynamic addition & removal needs
> to make sure no new children are added after removal of the parent
> has begun.
> 
> 
> > So, why are you pushing this down into the driver core, can't this be
> > done in whatever crazy bus wants to do this, like is done here?
> 
> I guess it can.  Let me try to perform the locking at the bus level then.

I thought the bus code itself had this type of serialization already...
