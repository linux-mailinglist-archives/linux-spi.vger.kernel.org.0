Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F6F14EBCD
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2020 12:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgAaLj2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jan 2020 06:39:28 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37358 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgAaLj2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jan 2020 06:39:28 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so2713932pjb.2;
        Fri, 31 Jan 2020 03:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WmrfKAtR6rlTIfiY5AkUEXZDNoeTvIvDZR49xG7X0iM=;
        b=oOAbXq94h9YRyz91+sD53WjDW5+ZTgL4fU3l4NGlBC34eguYDGLrLljKAcBtUe9dWG
         Na9LB3tCn5njql68CWeLjEQsAs+tOD0MNTyirMjslz7cvY42+Rx5FYhzhYcQEBEqTAA2
         tryYjvxrcGIZd1J9/ctgSwG9LwAMspXDNxIsW+uV9oam70ILayFwgxIsrUsYNEfsB1qX
         QzxHovB1fotXB3Fmr2QDheJzL0DdKwo2F+q4d27NDLGH77HfqC4cbPvJO9kF5wwTfiEc
         dJher5NP8RB0cmHj2rUg+7tttDDy31Eog8MZvbG4orkQ1FTqIeo2YhPbVAJtbgYgkxF9
         I3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WmrfKAtR6rlTIfiY5AkUEXZDNoeTvIvDZR49xG7X0iM=;
        b=H9kGy+7W+3Jf3D18XiCfVMxsWjGlJZ8vixUS4KWA/cJdg7REnSyLjYtSBXOT62556H
         Z2VLtM6JHf717Vw3I49eRwAvPGZpiMi9uXmua6qgh9f911oid2lMGuxdq9P6jtdv6BId
         +EOHv3YccYJRs6NDfStaAm7s9oAJa72elF55Oc1m6+waBaceEtd2ZKAimCaR1HGc1QeU
         Y+iQEmxxyUPlMrJz3LsIuaVWvyJ/rL91A999hnAbXkKQ9uRKADLLQIarc0IduYEu8f1E
         uSEvZ6ocfzqbhnL7gybh/JMBeLFd//TeZIzKguUvJ1SdCBOjU74A+12WE8EhGCe1Q9jj
         fS9g==
X-Gm-Message-State: APjAAAWMwRev6L8WtZkS0zfNLENc1Zomh842nRgfov+XRVemxdtaR4aa
        IZ8KfyPq4d4AhAIfacY+/RqIN7rPsDJ59MorbKX1QkbaGHhUdg==
X-Google-Smtp-Source: APXvYqxuTmsJhpjXYt1mZREUpJKBkFxJkHMZdboNze2B6ebKELDLMxrXGF0WRVRt8pH69iyQQgLvjPT1IjciSQu9PFw=
X-Received: by 2002:a17:902:b116:: with SMTP id q22mr9561021plr.255.1580470767774;
 Fri, 31 Jan 2020 03:39:27 -0800 (PST)
MIME-Version: 1.0
References: <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk> <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com> <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
 <20200113114256.GH3897@sirena.org.uk> <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
 <20200113140627.GJ3897@sirena.org.uk> <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q@mail.gmail.com>
 <20200113142754.GL3897@sirena.org.uk> <20200113143403.GQ32742@smile.fi.intel.com>
 <0252a76d-7e2b-2c70-8b1b-0d041d972098@huawei.com>
In-Reply-To: <0252a76d-7e2b-2c70-8b1b-0d041d972098@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jan 2020 13:39:19 +0200
Message-ID: <CAHp75Ve=ZwJe2XV8Y1UN6sMe1ZHOBwUtRUD=aGqhR4Gc7BNUcg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller driver
To:     John Garry <john.garry@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, chenxiang66@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        liusimin4@huawei.com, Linuxarm <linuxarm@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        tudor.ambarus@microchip.com,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, fengsheng5@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 31, 2020 at 12:08 PM John Garry <john.garry@huawei.com> wrote:
>
> On 13/01/2020 14:34, Andy Shevchenko wrote:
> > On Mon, Jan 13, 2020 at 02:27:54PM +0000, Mark Brown wrote:
> >> On Mon, Jan 13, 2020 at 04:17:32PM +0200, Andy Shevchenko wrote:
> >>> On Mon, Jan 13, 2020 at 4:07 PM Mark Brown <broonie@kernel.org> wrote=
:
> >>>> On Mon, Jan 13, 2020 at 01:01:06PM +0000, John Garry wrote:
> >>>>> On 13/01/2020 11:42, Mark Brown wrote:
> >>
> >>>>>> The idiomatic approach appears to be for individual board vendors
> >>>>>> to allocate IDs, you do end up with multiple IDs from multiple
> >>>>>> vendors for the same thing.
> >>
> >>>>> But I am not sure how appropriate that same approach would be for s=
ome 3rd
> >>>>> party memory part which we're simply wiring up on our board. Maybe =
it is.
> >>
> >>>> It seems to be quite common for Intel reference designs to assign
> >>>> Intel IDs to non-Intel parts on the board (which is where I
> >>>> became aware of this practice).
> >>
> >>> Basically vendor of component in question is responsible for ID, but
> >>> it seems they simple don't care.
> >>
> >> AFAICT a lot of the time it seems to be that whoever is writing
> >> the software ends up assigning an ID, that may not be the silicon
> >> vendor.
> >
> > ...which is effectively abusing the ACPI ID allocation procedure.
> >
> > (And yes, Intel itself did it in the past =E2=80=94 see badly created A=
CPI IDs
> >   in the drivers)
> >
>
> Hi Mark,
>
> About this topic of ACPI having no method to describe device buswidth in
> the resource descriptor, it may be an idea for me to raise a Tianocore
> feature request @ https://bugzilla.tianocore.org/
>

The 19.6.126 describes the SPI resource, in particular:

---8<---8<---
DataBitLength is the size, in bits, of the smallest transfer unit for
this connection. _LEN is automatically
created to refer to this portion of the resource descriptor.
---8<---8<---

Is it what you are looking for? (As far as I know most of the
firmwares simple abuse this field among others)

> There seems to be an avenue there for raising new features for the spec.
> I (or my org) can't participate in AWSG.

But have you read 19.6.126?

> I would have no concrete proposal for spec update for now, though.
> Hopefully others with more expertise could contribute.


--=20
With Best Regards,
Andy Shevchenko
