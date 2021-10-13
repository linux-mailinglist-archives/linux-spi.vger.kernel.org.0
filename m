Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF18542C892
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 20:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJMSY6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSY5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 14:24:57 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DABBC061570
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 11:22:54 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id f3so6355465uap.6
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JG1HQyyMPQTh6Csd4yNqjO3wLupEnpfFk+sqAUPlTOk=;
        b=TFFzvH5Pu9WlzGI0InQxPwB3KxmNZSBDchOU6UGGLQGd0Xsenl03vyAl6SHXmxKQjy
         4qtW+cWYaPU4dr06zhFDGTUeLuqB776EveF7n2HPp0DP4OSGPKK6bfo9mGC73+t9asrW
         o75CBfjl6Ew/0ElWGVKnDFP6cyo6kQIUQlj3jQ0qrihFt0U9dE+TeihI0TxAfSf8lyeL
         ndGEYzI0Ey6wWTuWJuA96NjDAN9M2blmx7UFq3NkQYbpBFlJHkuZv5CIF0yrrbMqnQPD
         LubhmcsyJxzLoWH8v37eVMJAtypdbjA2h4XEq8hqTUCm8PqHOeL4kYfjICp9It2mktOZ
         pRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JG1HQyyMPQTh6Csd4yNqjO3wLupEnpfFk+sqAUPlTOk=;
        b=budgOpV9AsmS9p9upipC4tTZ2QcnffWaE15xHnV4HOOvkoAtgLgpp37nm50njp3C7n
         gHlt1twWnqfCtFcmIvHPBD9bwDw5S9Q48OG5s38eUmUgJncfAF1Ar7BVsqxvCoTruqI6
         D4d599hpVrFDXnsYQA1iAA1pjCfUBGNyfveNbeittP6a7yUWJ0mdNr7yA0mslZDWM4oh
         RwqRQcqsj/tMbq4VIwyJ7vCBYHBvowilx1r9yF3gDTIKhSA1ZC+Ub0rGImwtZLBbxmaP
         MkZb+atCgTE0UggWm3KuOlcWve7sLz5PMJeFfOrOssXPvOWbzOemqUAU4aK5ivhRccEy
         zbbQ==
X-Gm-Message-State: AOAM531FqliSjRNqvxJIrvK/8z8aruF0DsGEEOHatp5m+o7tpt354Sx2
        qvguwuO6Li2g9GM10iJnqCXLWkflNM/PKYfZqd/d1A==
X-Google-Smtp-Source: ABdhPJz69Ai0nTaBa5bEtqV6hL9jm5/HIGfcBAki8oEE+O1Uf7WRzLApuYsiDnVEd0spVImB3Qr9gvfCbOLu1452jrk=
X-Received: by 2002:a67:e090:: with SMTP id f16mr1204482vsl.17.1634149372078;
 Wed, 13 Oct 2021 11:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-2-mika.westerberg@linux.intel.com> <CAArk9MPWh4f1E=ecKBHy8PFzvU_y_ROgDyUU_O3ZQ0FuMhkj5Q@mail.gmail.com>
 <YVqOjF/xjqFV+Dl3@lahna> <CAArk9MPY+rCQse+JXtvb4KqunN9FZ=toK_v=PV-ro4cO6=5s7Q@mail.gmail.com>
 <YWag+RpkujjggPsW@lahna>
In-Reply-To: <YWag+RpkujjggPsW@lahna>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Wed, 13 Oct 2021 15:22:40 -0300
Message-ID: <CAArk9MPKLy0abox-ULNNuQ1XO_96aJn449qM0pAp_amxFY6RDg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: spi-nor: intel-spi: Disable write protection
 only if asked
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!
On Wed, Oct 13, 2021 at 6:04 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Tue, Oct 12, 2021 at 03:49:22PM -0300, Mauro Lima wrote:
> > Hi Mika
> >
> > On Mon, Oct 4, 2021 at 2:18 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Oct 01, 2021 at 05:23:23PM -0300, Mauro Lima wrote:
> > > > Question for maintainers: With these changes is it safe to remove the
> > > > *(DANGEROUS)* tag from menuconfig?
> > >
> > > I don't think we want to remove that. This driver is not for regular
> > > users, at least in its current form.
> > Do we know why this is still dangerous for the user?
>
> There was a bug in the driver in the past (that was already fixed but it
> did not yet reach the stable trees or something like that). At this
> unfortunate time there was no DANGEROUS in the name so Ubuntu kernel
> went and enabled it. Combined with the bug certain Lenovo laptops BIOS
> turned into read-only which prevented booting from non-default devices.
>
> This happened even when the driver did not do any "write" or "erase"
> operations, just clearing the status register or so.
>
> We don't want that to happen again.
>
> > My plan is to make a sys/class driver to query write protection status
> > of the SPI, this will be
> > used by fwupd to gather information about vendors, also should be easy
> > for the user to use
> > 'cat' and see the information from userspace. For this to be possible
> > we need kernel engineers
> > to compile the kernel with this driver enabled, but the (DANGEROUS)
> > tag is a no go for most
> > of them.
> > Is there anything I can do to make this possible?
>
> IMHO we can make certain parts of the driver, that are known not to
> cause any issues available without the DANGEROUS. I mean the controller
> exposes some information that I think you are intersted in and that does
> not cause anything to be sent to the flash chip itself.
This will work for me.
Thanks!
