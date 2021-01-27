Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87530626B
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 18:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbhA0RpE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 12:45:04 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43381 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbhA0Ro7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Jan 2021 12:44:59 -0500
Received: by mail-ot1-f41.google.com with SMTP id v1so2489144ott.10;
        Wed, 27 Jan 2021 09:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHVRlfV9EQu4gPj5dVenKguyA2U2WXu41Z7MOBH2q+k=;
        b=LPm4Nd3P5iDXt5n/WX5rX0Qet0y5kDWLmoWOWa4cdU+SCGR4EPxkY9OZQdBnKmFhUw
         YK7xnUBHrWykplK/+mR4h38u8jUWPIuUwvX2x88oLc7pWusPZWwb7M9OfyTZVnrb29X8
         y/l1Vyci1kIRyFduiNT4Gma3gxUIc731uEdPwEOTHhPHqqt/hovG+z0I329Sr8ZKUJrY
         INh0uY+30oxqw+eg3mF9VOWZohZ8kr44hRNFx51eHpntvCEq0cMrd4dmmSOSbIBbHgQ9
         kksksED3Qms4/sQ10tJ2HFk2OamNUiJ3vYiwv/o7FgNUBCJdyv4AioAoMfUCvKCxf6wo
         suNw==
X-Gm-Message-State: AOAM532UMZbORRP7Nu0TUJW6tvf1zU1TmEnx9b524b0BcR4IsrEwmwxU
        KxLHZxoSkO/zCNM8B5Bznt/WCBLCY3cqhuZ6FMs=
X-Google-Smtp-Source: ABdhPJx3wpBSkXPSpXDG6M0ltMbmguxQMImznzdVeAu1VT6FKAr93J3QfMztoWACmNnTeM4RMvDtc7yrOgIFRwkLX6w=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr8675107ote.321.1611769458811;
 Wed, 27 Jan 2021 09:44:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0ir4=urUviCR_4N96revWZkHVDyNNUiaJ3jjGzpX8zLVQ@mail.gmail.com>
 <20210127160650.GA2991034@bjorn-Precision-5520>
In-Reply-To: <20210127160650.GA2991034@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 18:44:07 +0100
Message-ID: <CAJZ5v0gmP2QBmMWkdVaGy+j6+FFPH6VGfRMU9ncz6m4BhBPgFA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        acpi4asus-user@lists.sourceforge.net, linux-hwmon@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 27, 2021 at 5:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 27, 2021 at 04:44:02PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 27, 2021 at 4:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Tue, Jan 26, 2021 at 02:23:17PM -0600, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > The double negative makes it hard to read "if (!ACPI_FAILURE(status))".
> > > > Replace it with "if (ACPI_SUCCESS(status))".
> > > >
> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > ---
> > > >
> > > > This isn't really an ACPI patch, but I'm sending it to you, Rafael, since
> > > > it seems easier to just apply these all at once.  But I'd be happy to split
> > > > them up into individual patches if you'd rather.
> > >
> > > Thanks, everybody.  Rafael, I'll just merge this via my tree to avoid
> > > burdening you.
> >
> > It may conflict with some janitorial stuff I'm doing, though, so
> > unless you've already applied it, I'd prefer to take it via the ACPI
> > tree.
>
> No problem, it's all yours!

Applied as 5.12 material with the ACKs, thanks!
