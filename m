Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED82FE421
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jan 2021 08:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbhAUHiX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jan 2021 02:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbhAUHZD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jan 2021 02:25:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8FC061575;
        Wed, 20 Jan 2021 23:24:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x20so1059266pjh.3;
        Wed, 20 Jan 2021 23:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eAPaHKp7CGeHSFxhpojsQTigei11DdiPzuKEyiGvVVE=;
        b=Rw55E56Zr2NUtU3Dazx4l7DrEixq+oK++qgrgWlOFE5PrC1NekZch7TYTBtbZ9NSYM
         tHpCeleYWZUBlI4B+gyAiaEGoXnBiRJo5d6r3C8nRb7+RVTq9MDhFDp+DIgTxH0dx8rW
         HxydJv+HzuAFpxGEyx/7/UKcxwXYj03AIxKlsI9Royuduj+sVGM6FiveosKRX2+nZIql
         4O0z8A6pJvR5dK5RQaKlGlhZPw/lxCqaogFavVcWEdedBZ2d1zhxo97UpdnQwYXAZF3+
         E80nmHavTtH0eQeY2m3zAukXEugZY8L7N+E3kpYl4GzBVEuK+ipgotIMACYWFdFNTmpE
         7B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eAPaHKp7CGeHSFxhpojsQTigei11DdiPzuKEyiGvVVE=;
        b=kLx7BAxCYgjOT+X2Am4faf48j91vWqK1oRSGaWw3xaHao5OWdMUjB6bD5p9lQ6tSh3
         J4zW8K6h+F+qfsbzP/j8H/dJFx1WZnsg/0OuPInkvETTLSlnSUsO0/P6JoQdGGV+YWp+
         ZCYU/LFAjYwV2OahUgtpUSkpidlKqIbMPB3eUYBdDaRagT/dTJJOaNv/9Lp2ZF2rnmE8
         6cF6+IWh7a6T/HCVPMgUVc+eTcFeOlY/mNNeTp3ZqhcCegCI3+PFKbIkL2Kas+fdoOXn
         Iou0+8I5soHbID16msoT3YbMFgMm5UBXlXTM7gK1cEx5Y0ra0rki9RPqLSWrLKqOpP7+
         WtmQ==
X-Gm-Message-State: AOAM532X5F5dghUeFaWj1Wquckcq+vv7cFiFWaHwtVccnEul4kBfEqZ/
        oXpQXFbVIr9BSFBQ1pcKuMU=
X-Google-Smtp-Source: ABdhPJzztRFbAkTFXsKoD6AZ1QE3XZXoTJIYpUd+FUkNuVMglAddNprH75Fcq8Gx4x6GuNVu3cBBsw==
X-Received: by 2002:a17:902:c115:b029:de:8961:47e5 with SMTP id 21-20020a170902c115b02900de896147e5mr13545744pli.46.1611213862431;
        Wed, 20 Jan 2021 23:24:22 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id c204sm2975884pfc.152.2021.01.20.23.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 23:24:21 -0800 (PST)
Date:   Wed, 20 Jan 2021 23:24:18 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 2/2] Input: ads7846: convert to one message
Message-ID: <YAksInM07b3ACwMa@google.com>
References: <20201110085041.16303-1-o.rempel@pengutronix.de>
 <20201110085041.16303-3-o.rempel@pengutronix.de>
 <20201118003138.GD2009714@dtor-ws>
 <20210120074032.2swvp7iqli6xttul@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120074032.2swvp7iqli6xttul@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 20, 2021 at 08:40:32AM +0100, Oleksij Rempel wrote:
> 
> Hi Dmitry,
> 
> On Tue, Nov 17, 2020 at 04:31:38PM -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 10, 2020 at 09:50:41AM +0100, Oleksij Rempel wrote:
> > > Convert multiple full duplex transfers in to a single transfer to reduce
> > > CPU load.
> > > 
> > > Current driver version support following filtering modes:
> > > - ads7846_no_filter() - not filtered
> > > - ads7846_debounce_filter() - driver specific debounce filter
> > > - pdata->filter - platform specific debounce filter (do any platform
> > > 	provides such filter?)
> > > 
> > > Without filter this HW is not really usable, since the physic of
> > > resistive touchscreen can provide some bounce effects. With driver internal
> > > filter, we have constant amount of retries + debounce retries if some anomaly
> > > was detected.
> > > 
> > > High amount of tiny SPI transfers is the primer reason of high CPU load
> > > and interrupt frequency.
> > > 
> > > This patch create one SPI transfer with all fields and not optional retires. If
> > > bounce anomaly was detected, we will make more transfer if needed.
> > > 
> > > Without this patch, we will get about 10% CPU load on iMX6S on pen-down event.
> > > For example by holding stylus on the screen.
> > > 
> > > With this patch, depending in the amount of retries, the CPU load will
> > > be 1% with "ti,debounce-rep = <3>".
> > > 
> > > One buffer transfer allows us to use PIO FIFO or DMA engine, depending
> > > on the platform.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > Applied, thank you.
> 
> I can't find this patch in your git repository. Should I rebase it
> against latest git and resend it?

Ugh, sorry, now applied for realz.

Thanks.

-- 
Dmitry
