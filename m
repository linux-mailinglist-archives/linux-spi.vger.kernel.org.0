Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C906176338
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 19:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCBSvo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 13:51:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42374 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSvn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Mar 2020 13:51:43 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so287124otd.9;
        Mon, 02 Mar 2020 10:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cH1nDM4uwumr6KdthICcbpNTedeJBeY/wKjOC4m8TLQ=;
        b=EeW/108PF8Vk/izFryec4ZmriJb9PlrBde9zT17X+01T01pL45SFvgGKJHoXT6ReI0
         szDn6ySFYKq/+AWkI2bCuXEjaCuqGxyZnfijahD23dXZxDUacepckHcJHARuDvjRRoW8
         AP7mo670oWS/Opofmxfj8c8BPsIqBtf+MMdNtH/5BgUS8MAusPYSb9tyVwz94QuWzV58
         wIzrfctzMa3Al3z6+AAYd+eJH+zlDKDJiJK8j3Ha+t37ImBa5z7wlDwU2JsjsI8G0KNd
         pQCOITAQeljdm/u9UUgXMSUiR0+lQn9e3tl+16JV+lwRnnsqpN+6wtR/5W0azoyEL219
         24Rw==
X-Gm-Message-State: ANhLgQ2MbDrSdO6OpAVjDjFTaCuxzCiz3FIohkgLcIHKSmvSTguGOb17
        85R7PqktzeBRoXbTGYL/Vvm9zU2vrNv4ViN0z/0=
X-Google-Smtp-Source: ADFU+vtjNzCGescRbFcFgmJZbsy+UPTWYBrrpuwFClvDp2HC/YFd54MwAImxgozZRZYrp9DjMoDEHIgXHozDv3Kahco=
X-Received: by 2002:a05:6830:100e:: with SMTP id a14mr435280otp.297.1583175101255;
 Mon, 02 Mar 2020 10:51:41 -0800 (PST)
MIME-Version: 1.0
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com> <1582903131-160033-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1582903131-160033-2-git-send-email-john.garry@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Mar 2020 19:51:29 +0100
Message-ID: <CAMuHMdW7Xu6EzfmVFx1+i1byy3KOS5A+h2GuMb8nkZ+-jD1=BA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device buswidth
To:     John Garry <john.garry@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi John,

On Fri, Feb 28, 2020 at 4:23 PM John Garry <john.garry@huawei.com> wrote:
> Currently ACPI firmware description for a SPI device does not have any
> method to describe the data buswidth on the board.
>
> So even through the controller and device may support higher modes than
> standard SPI, it cannot be assumed that the board does - as such, that
> device is limited to standard SPI in such a circumstance.
>
> As a workaround, allow the controller driver supply buswidth override bits,
> which are used inform the core code that the controller driver knows the
> buswidth supported on that board for that device.

Just wondering: can't the controller just override this (e.g. in the .setuup()
callback) without having to touch the generic code?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
