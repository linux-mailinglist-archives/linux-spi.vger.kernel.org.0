Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D239D346870
	for <lists+linux-spi@lfdr.de>; Tue, 23 Mar 2021 20:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhCWTFJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Mar 2021 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhCWTEk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Mar 2021 15:04:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CC3C061763;
        Tue, 23 Mar 2021 12:04:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so12601348pjq.5;
        Tue, 23 Mar 2021 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mOoV6NglxaO34D7E/LEb/wD+88EOY1QvctA0zUc+clA=;
        b=Jyo+0+4mxPVgA/fM4574ACwHQi23psRIg5eNX8N8Y5lVRf/Wz+uDT77vINBVF65bnW
         2D4ZpJC1oAwAtLPL5cYkL+C4/FH20kNR+Xwey6Otrt/EIUfO/rYzPUeVSzC4hlAYwxSL
         UDuPN/eL8uI87UNlDu+JLwikoKZ4Vr8AWNgx5sMde9BgCmuNcgzMDwSn1mUtyaOjrh1x
         KKUGjhrIB9u/T+MeTEybjrILwNPv7NaFtNjSGgiodHjX7zvZSmfoTqRRZOJrACipjRcr
         Z/2P3EZvvRyDQZtk3c87dyhJmi4b6885Jr5pBh6q8me/QhTxUpvT4Bs8Duo4Wsko6+RA
         JyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOoV6NglxaO34D7E/LEb/wD+88EOY1QvctA0zUc+clA=;
        b=rH2jjPO/WWZZfzDYwkpZJvCgPG1hip5zgO/fHdar90yRqtjN23GeGO9fbQ/WqCwlkC
         mjK8pSPoeLNKVbeAm/Lb++NQRaU7A6NckXgRo5/4xA4pnaKBzD4+9we8ZbFY9nkiOcPr
         HA5W88MyAusC+I51+GqEljcR8oCBg+RdUz3L6ARXecZPhXF1W5C3czvIw+1tukyzI1I/
         LauL+2o+ZiK/Eku6qu+R+0y/tNaUnuWuo1Ua0BjXvNI4jlWJxWqx98WguPt4RT9fJr8K
         NzZRCO7wTa8sGYgVbabTVRG5haq/2QiM/iWC2lHJ2tREyWVs2Yp5TW2Wm3qdnVgZ9e1S
         7q/g==
X-Gm-Message-State: AOAM532uAb4OVL2fUKfaDajrP1Lxyx51ognTxdp/rmylpQ4Q2ixBlYxk
        hKSH67WDlfRVORrA7AuChv0=
X-Google-Smtp-Source: ABdhPJxHbzgizGpkWqcw90BCMdfjJ0GIQGZFlAJ1gbQECc981kaAiP3H52DMoXq1CYIphhFtCEKA8w==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr5761602pjt.188.1616526278573;
        Tue, 23 Mar 2021 12:04:38 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4d6b:ca5a:c720:f5c9])
        by smtp.gmail.com with ESMTPSA id j2sm16067633pgh.39.2021.03.23.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 12:04:37 -0700 (PDT)
Date:   Tue, 23 Mar 2021 12:04:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <YFo7wkq037P2Dosz@google.com>
References: <YFf2RD931nq3RudJ@google.com>
 <20210322123707.GB4681@sirena.org.uk>
 <YFjyJycuAXdTX42D@google.com>
 <20210323173606.GB5490@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323173606.GB5490@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 23, 2021 at 05:36:06PM +0000, Mark Brown wrote:
> On Mon, Mar 22, 2021 at 12:38:15PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 22, 2021 at 12:37:07PM +0000, Mark Brown wrote:
> 
> > > This feels like it might make sense to push up to the driver core level
> > > then rather than doing in individual buses?
> 
> > That is exactly the issue: we can't. Driver core already releases all
> > resources when a device is being unbound but that happens after bus
> > "remove" code is executed and therefore is too late. The device might
> > already be powered down, but various devm release() callbacks will be
> > trying to access it.
> 
> Can you provide a concrete example of something that is causing problems
> here?  If something is trying to access the device after remove() has
> run that sounds like it's abusing devres somehow.  It sounded from your
> commit log like this was something to do with the amount of time it took
> the driver core to action the frees rather than an ordering issue.

No it is ordering issue. I do not have a proven real-life example for
SPI, but we do have one for I2C:

https://lore.kernel.org/linux-devicetree/20210305041236.3489-7-jeff@labundy.com/

However, if we consider fairly typical SPI driver, such as
drivers/input/touchscreen/ad7877.c, you can see that it uses devm in its
probe() and because all resources are managed, it does not define
remove() at all.

So during proble we have:

<driver core allocations>
SPI: dev_pm_domain_attach
AD7877: devm_kzalloc driver structure
AD7877: devm allocation of input device
AD7877: devm custom action to disable the chip on removal
AD7877: devm IRQ request
AD7877: devm sysfs attribute group
AD7877: devm input registration
<additional devm driver core allocations?>

And on remove:

SPI: dev_pm_domain_detach !!!!!!
<deallocate additional devm driver core allocations?>
AD7877: devm input unregistration
AD7877: devm sysfs attribute group removal
AD7877: devm freeing IRQ
AD7877: devm disable the chip
AD7877: devm freeing of input device
AD7877: devm free driver structure
<deallocate driver core allocations>

Note how dev_pm_domain_detach() jumped ahead of everything, and
strictly speaking past this point we can no longer guarantee that we can
access the chip and disable it.

> 
> > devm only works when you do not mix manual resources with managed ones,
> > and when bus code allocates resources themselves (attaching a device to
> > a power domain can be viewed as resource acquisition) we violate this
> > principle. We could, of course, to make SPI bus' probe() use
> > devm_add_action_or_reset() to work in removal of the device from the
> > power domain into the stream of devm resources, but that still requires
> > changes at bus code, and I believe will complicate matters if we need to
> > extend SPI bus code to allocate more resources in probe(). So I opted
> > for opening a devm group to separate resources allocated before and
> > after probe() to be able to release them in the right order.
> 
> Sure, these are standard issues that people create with excessive use of

devm is a fact of life and we need to live with it. I am unconvinced if
it solved more issues that it brought in, but it is something that
driver authors like to use and are pushed towards.

> devm but the device's remove() callback is surely already a concern by
> itself here?

In the example above there is not one, but even if it exists, it is
called first, so in some limited cases you could have non-managed
resources allocated very last and released first in remove(), and then
have devm release the rest. However driver's remove() is not issue here,
it is bus' non-trivial remove.

Thanks.

-- 
Dmitry
