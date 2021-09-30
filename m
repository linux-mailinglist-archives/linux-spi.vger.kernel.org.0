Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077FD41D0C0
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 02:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346830AbhI3AxK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Sep 2021 20:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346375AbhI3AxJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Sep 2021 20:53:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B90EC06161C
        for <linux-spi@vger.kernel.org>; Wed, 29 Sep 2021 17:51:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id oa12-20020a17090b1bcc00b0019f2d30c08fso3462012pjb.0
        for <linux-spi@vger.kernel.org>; Wed, 29 Sep 2021 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Y/f0kHl2GnkH6IeczyNVQwDeW/eTaSrQelUuT6nPtkE=;
        b=IgOcjBNgYhLJ1RZD9xGjxPuAQ3+VxgpRpqIWLdBBDcknQuTRE7qmacLp3So+7dZcza
         Ac7ynrf+XaWVhuU3nOttYldc4h+S4OdGwagpuRCLjyFwAsswtTc5ra53i4Z9rWaOhBhD
         nbLM8c2dM5CVNwkfxGa3ymh4sWBI0IwmZqgqvARklpHN3JJXjPtPHYoNGtrH5gsxP9mv
         BTToTyVWKWy2/BJwezT7D0y92McVZfYaNlc4GBBGx0UOotMBTrPwOQgU7z56dnt1ko4w
         OdRCh/nrC2Xg849nIhPN4eom/uHLXoTPzYovJcIEqXYYYwIOTo6qkbSZFbk/VZ3iFwjV
         p4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Y/f0kHl2GnkH6IeczyNVQwDeW/eTaSrQelUuT6nPtkE=;
        b=zfebYztHhAlFxAANi7wdBWN3rx5T5hFTMEsS3h9N0j3a7GNjOhAmKqjNBLbZGt4NEe
         i8bQuqNmsBSgGfIryZWTBH8IFoFfUcOOwNpjOHKtkO3i0zH0KwMbkKwrqgvMZ4wNczcr
         Mqf8EqfirobNyifaz8ZsGswrarpO6JWjxbYyZF9icOG+KFAWrAfvTdRo+St7WvjNvhVI
         TlkuayIjstxC8C4igy0vCxbPOLdhR2ItcG0X+mDIvyLTZcKn5hPff+GZyeV6KLPDeAyq
         obxixq+WsbU+JP1s/o8J4P+KLh7KVw1jVz7Le+IYfMHvz/UDFrsWsKry9cT8RtdZW2wL
         25Vg==
X-Gm-Message-State: AOAM532uDf9oy7dzHmxnRJoE1JU4wdXnveqhAy8wJ9aHL5x6aY3Ericf
        ff9prmqtR2Vd1Sv7uYmy7YXjvZzcBOORjQfp+DUDCPnG8JQtoA==
X-Google-Smtp-Source: ABdhPJwn7hgBgbu5u6SaLoRaruT+IJRMYdyEq8QlBYoh9qxWIbxl9bgeN3nUJU34vIi6zx/BAIg7NnJ/3j5JgGatcAw=
X-Received: by 2002:a17:903:31cd:b0:134:5b6f:2ff8 with SMTP id
 v13-20020a17090331cd00b001345b6f2ff8mr1364894ple.46.1632963086459; Wed, 29
 Sep 2021 17:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU2aTKyQ=UwJMLKf9D7CTk4F59o3uHCC80jJBOge-Ff9Aw@mail.gmail.com>
In-Reply-To: <CAJ+vNU2aTKyQ=UwJMLKf9D7CTk4F59o3uHCC80jJBOge-Ff9Aw@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 29 Sep 2021 17:51:13 -0700
Message-ID: <CAJ+vNU22atsx618SY1UUrkpWfddzFHx+X+UsK3MySV8JU0EpVA@mail.gmail.com>
Subject: Re: spi-thunderx (OcteonTX) max SPI frequency
To:     linux-spi@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@marvell.com>,
        aron Williams <awilliams@marvell.com>,
        Suneel Garapati <sgarapati@marvell.com>,
        Stefan Roese <sr@denx.de>,
        Chandrakala Chavva <cchavva@marvell.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 22, 2021 at 9:14 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> Greetings,
>
> Does anyone know why the MAX spi frequency for the spi-thunderx driver
> would be 16MHz? The CN81XX HM states the SPI clock frequency can go up
> to 50MHz.
>
> The driver was originally for Octeon (I'm thinking this was CN7xxx
> SoC's?) which perhaps were limited to 16MHz yet I downloaded a CN70XX
> ref manual and it shows 25MHz.
>
> I don't know my history regarding the Cavium (now Marvell) SoC's well
> enough to know exactly what Octeon means or meant vs ThunderX. Hoping
> someone from Marvell can answer this.
>

Adding some more Marvell folk to this thread including those involved
in the octeon-spi driver contributed to U-Boot to support the Octeon
II/III and OcteonTX/TX2 SoC which was allowed to run up to 50MHz [1]

My theory is that the Linux driver originally supported the Octeon I
SoC (still not clear what chip(s) that actually refers to) which was
likely 16MHz and that the driver should be patched to support 50MHz
for the SoC's that support it. I'm happy to submit a patch but I need
Marvell to step up and explain what chips are capable of 50MHz and
which are limited to 16MHz. All the Marvell reference manuals are
under NDA and this makes it a bit difficult to figure out.

Best Regards,

Tim
[1] https://github.com/u-boot/u-boot/commit/7853cc05984c60e616163c9b17c14d9a50300abe
