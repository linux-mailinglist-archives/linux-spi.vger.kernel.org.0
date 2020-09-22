Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715A6273F36
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIVKHT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIVKHT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Sep 2020 06:07:19 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDB2C061755
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2020 03:07:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w1so15642637edr.3
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2020 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mxajuGBJzKoVQ5z3uq972ivhDh8Xrl1E0odngLxnH5Q=;
        b=XMuG75MEwlaih43aHHX0I/79A6WwaZUY8wk25fnrkFtUAWdH8oxZtcl5oVzxOuzUob
         eawNnUSgpp0W+eJoXTjWXHPBSnjOfNep6+8f3SgLEdpBnOemnG3oLRJ+hcEB1lvYumAe
         XplHiQ0FZPUHuLZX8Fi9eeoxrGbg5vwXji+GBZkNpz1oo7jAEv4kCiY6iuvXCS/h/1kG
         TxM8QbEEJU+j8yQOAoNfoAKFBUrm/1wKFD/kVqv88QrqzRCrcRirS0v16BBLKQrA4mKA
         cHLkbHf3Z1dg1OI7o39xb60BDttEi91NVW4oLoQ2eawTMRKXrD8vgaBDE1Q2UYfNqhEE
         99rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mxajuGBJzKoVQ5z3uq972ivhDh8Xrl1E0odngLxnH5Q=;
        b=M6pvyBEj2/Pv8VQE7C4lkWVsCbKGCuWDu9+5bb43P9P729Y8ZFah7gkMXeY0COgpnv
         yzv6obxro4EHsPbu2FTgSaKVYUco3fAnfNBWrdm0N+4nfqMKEGojPODhq/buwzrtRdE/
         U4GGk4rM8wyHD3bOSJvyE8ZlLadY4eccaV5moVlwjU+sGyV7IabM1OnS5dkqBZc+Zl3A
         IqPsWxOaqKp7QC0BF88xWSU6iaarAe6Uc6qwYk8aVQEmAIPFjKgc96aeJoG3BkJ+v6GR
         GXaIJztmEYIoP2Xkx9SOIBdyfHHLOcibLnDDUm4JolsJu4jd4mB9iYW2pJ1afZlPth4D
         4cOQ==
X-Gm-Message-State: AOAM530HR5MiiEvD2ntBwjFqk4qrP7VAtcogF/h/p8OmMPLrMnryoont
        jpvoF0vP49nN4Ysvm/KMqoxSSbuzd5I=
X-Google-Smtp-Source: ABdhPJz6EJhq2W3qknrqYxZpY0xkbKcgY2uY62ZMoniSuHSRqRB7WtPLjrXhw0xQlWhOle3q97B4Kg==
X-Received: by 2002:a50:a694:: with SMTP id e20mr3113469edc.114.1600769237507;
        Tue, 22 Sep 2020 03:07:17 -0700 (PDT)
Received: from skbuf ([188.25.217.212])
        by smtp.gmail.com with ESMTPSA id p5sm10698924ejd.56.2020.09.22.03.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 03:07:17 -0700 (PDT)
Date:   Tue, 22 Sep 2020 13:07:15 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Subject: Re: users of spi_unregister_controller() broken?
Message-ID: <20200922100715.yxu55etwq64pry4n@skbuf>
References: <20200921110805.GI21278@pengutronix.de>
 <20200921120029.GA4792@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921120029.GA4792@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 21, 2020 at 01:00:29PM +0100, Mark Brown wrote:
> On Mon, Sep 21, 2020 at 01:08:05PM +0200, Sascha Hauer wrote:
> 
> > I see the following KASan use-after-free messages from the fsl-dspi
> > driver. It seems that after spi_unregister_controller() has been called
> > no references to the SPI controller device are left and the device is
> > freed in spi_controller_release(). This also frees the driver data
> > structure which is allocated with spi_alloc_master(). Nevertheless all
> > users of spi_unregister_controller() still use their driver data after
> > having called spi_unregister_controller().
> 
> > Any idea what to do about this?
> 
> Drivers that need to use their driver_data in remove() should either use
> devm_spi_register_controller() or not use spi_register_controller() to
> allocate driver_data.  Depending on what the remove function does it may
> not be practical to do the former, most likely it won't be.

Please think of the consequences of making such a change, especially to
so many drivers.

For example, in spi-fsl-dspi.c, the reason why
spi_unregister_controller() is first is:

From 7684580d45bd3d84ed9b453a4cadf7a9a5605a3f Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 22 Jun 2020 13:05:40 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Fix lockup if device is removed during SPI
 transfer

During device removal, the driver should unregister the SPI controller
and stop the hardware.  Otherwise the dspi_transfer_one_message() could
wait on completion infinitely.

Additionally, calling spi_unregister_controller() first in device
removal reverse-matches the probe function, where SPI controller is
registered at the end.

Fixes: 05209f457069 ("spi: fsl-dspi: add missing clk_disable_unprepare() in dspi_remove()")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200622110543.5035-1-krzk@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

We want to make sure there is no SPI transaction left in flight when we
remove the driver. So we need to unregister from the SPI core first, to
make it stop sending them.

I understand there is no spi_unregister_controller / spi_free_controller
API as there is for unregister_netdev / free_netdev.

Does it help if you call spi_controller_get(dspi->ctlr) at the beginning
of dspi_remove, and spi_controller_put(dspi->ctlr) at the end of it?

Thanks,
-Vladimir
