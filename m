Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A93348499
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 23:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhCXW1g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 18:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhCXW1b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 18:27:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E825AC06174A;
        Wed, 24 Mar 2021 15:27:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u19so15759211pgh.10;
        Wed, 24 Mar 2021 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GRkYdhVDclltdfZ2FdYU31f1Z7mv5y7KNEhciLwpFQU=;
        b=L9H7tXhLm56vOtoJETiA5o6hXACBJgzCuzRlItMdm19EkPpWmCFG30wGH+nqGkbgx5
         NBNHCgJm3XI3cbQHWO3vNHWyiohZ49fY8CWv2sqCqxwoTJ0WddkFocj+Tj/5k6ABAbI/
         wdzSJR8p2m+zQOamqMQEMhgzU8StOGgoshgjRwPCKM1YWeacwgRZ68VNGA0RXEAZBiSz
         nw6pTh0NcIMXvkIu6nvlKGpHbz+CMhzR5iNWSR5F4J1HIMtPfgHJOVHH332Jsn6qXi4s
         3mZzOzpx1nPOLBbyUwVx+pxenFBl0dPGcFg6BM4mXwn2J3QY1crGyXnicoQXL3bau+bd
         JOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GRkYdhVDclltdfZ2FdYU31f1Z7mv5y7KNEhciLwpFQU=;
        b=ispM2z2h81p1Nv7bHFU+bBFTB55A8uBFY2ZTmKJKsNlXfVwtgvrA2gX9xTUuEMJgYl
         MPYgiXAqqAyxYjQIa1c1NPMlE2Eu7PIsAVk6RjrRrmayZjoofH0B7MUPv+FYo5DK9BWv
         ts2NiC4VStaB6rHPcW8ZV72EhDKIP9/yUA/PcD0Vh8ovOrqfXwZR4QNliw1Uq3lY+uGa
         R8SDxGDJRceTp7VZVhG6bCzJfJ4+QSdcpLHgzJtAyw5BSWzp2gMCF0ky8z9aQ6nhoPBP
         cTRAjPxvdaobX1xq3nlo89K7Zp+H3dmcSlXHII84i/Yb/MjQvZrIpOCtGPNUmy7tlqF2
         pF5Q==
X-Gm-Message-State: AOAM531RuWUO97Yyx6pMqbjKEETK1l5wNPvVZQEcT9lQKKZPNFXRYgDi
        e4tqWYIEZnczhkVz7sR/sN8=
X-Google-Smtp-Source: ABdhPJz1J7k4jp41C7Yu0tZrufMMQ9j+Nz6By7Pd6kpJyaRl16hQtHfu0Y8n77QNZqwTJyNx65OFGg==
X-Received: by 2002:a17:903:22d1:b029:e7:1052:a979 with SMTP id y17-20020a17090322d1b02900e71052a979mr4819494plg.16.1616624847389;
        Wed, 24 Mar 2021 15:27:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4d6b:ca5a:c720:f5c9])
        by smtp.gmail.com with ESMTPSA id i13sm3287456pgi.3.2021.03.24.15.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 15:27:26 -0700 (PDT)
Date:   Wed, 24 Mar 2021 15:27:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <YFu8y9CuG6Mouxnq@google.com>
References: <YFf2RD931nq3RudJ@google.com>
 <20210322123707.GB4681@sirena.org.uk>
 <YFjyJycuAXdTX42D@google.com>
 <20210323173606.GB5490@sirena.org.uk>
 <YFo7wkq037P2Dosz@google.com>
 <20210324213225.GD4596@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324213225.GD4596@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 24, 2021 at 09:32:26PM +0000, Mark Brown wrote:
> On Tue, Mar 23, 2021 at 12:04:34PM -0700, Dmitry Torokhov wrote:
> > On Tue, Mar 23, 2021 at 05:36:06PM +0000, Mark Brown wrote:
> 
> > No it is ordering issue. I do not have a proven real-life example for
> > SPI, but we do have one for I2C:
> 
> > https://lore.kernel.org/linux-devicetree/20210305041236.3489-7-jeff@labundy.com/
> 
> TBH that looks like a fairly standard case where you probably don't want
> to be using devm for the interrupts in the first place.  Leaving the
> interrupts live after the bus thinks it freed the device doesn't seem
> like the best idea, I'm not sure I'd expect that to work reliably when
> the device tries to call into the bus code to interact with the device
> that the bus thought was already freed anyway.

That is not an argument really. By that token we should not be using
devm for anything but memory, and that is only until we implement some
kind of memleak checker that will ensure that driver-allocated memory is
released after driver's remove() method exits.

If we have devm API we need to make sure it works.

You also misread that the issue is limited to interrupts, when i fact
in this particular driver it is the input device that is being
unregistered too late and fails to timely quiesce the device. Resulting
interrupt storm is merely a side effect of this.

> 
> If we want this to work reliably it really feels like we should have two
> remove callbacks in the driver core doing this rather than open coding
> in every single bus which is what we'd need to do - this is going to
> affect any bus that does anything other than just call the device's
> remove() callback.  PCI looks like it might have issues too for example,
> and platform does as well and those were simply the first two buses I
> looked at.  Possibly we want a driver core callback which is scheduled
> via devm (remove_devm(), cleanup() or something).  We'd still need to
> move things about in all the buses but it seems preferable to do it that
> way rather than open coding opening a group and the comments about
> what's going on and the ordering requirements everywhere, it's a little
> less error prone going forward.

From the driver's perspective they expect devm-allocated resources to
happen immediately after ->remove() method is run. I do not believe any
driver is interested in additional callback, and you'd need to modify
a boatload of drivers to fix this issue.

I agree with you that manual group handling might be a bit confusing
and sprinkling the same comment everywhere is not too nice, so how about
we provide:

	void *devm_mark_driver_resources(struct device *dev)

and

	void devm_release_driver_resources()

and keep the commentary there? The question is where to keep
driver_res_id field - in generic device structure or put it into bus'
device structure as some buses and classes do not need it and we'd be
sawing 4-8 bytes per device structure this way.

Another way is to force buses to use devm for their resource management
(I.e. in case of SPI wrap dev_pm_domain_detach() in
devm_add_action_or_release()). It works for buses that have small number
of resource allocated, but gets more unwieldy and more expensive the
more resources are managed at bus level, that is why I opted for opening
a group.

> 
> > Note how dev_pm_domain_detach() jumped ahead of everything, and
> > strictly speaking past this point we can no longer guarantee that we can
> > access the chip and disable it.
> 
> Frankly it looks like the PM domain stuff shouldn't be in the probe()
> and remove() paths at all and this has been bogusly copies from other
> buses, it should be in the device registration paths.  The device is in
> the domain no matter what's going on with binding it.  Given how generic
> code is I'm not even sure why it's in the buses.

Here I will agree with you, bit I think it comes from power domain
"duality". In OF power domain represents grouping of devices, and is
static as devices do not move around, whereas in ACPI domain means
control, and we are putting a device under control of ACPI PM when we
bind it to a driver. As part of that control we bring the device into
_D0, etc.

Yay for mixing concepts, but this is not really material to the question
of how to orderly release resources.

Thanks.

-- 
Dmitry
