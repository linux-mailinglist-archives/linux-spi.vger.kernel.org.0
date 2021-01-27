Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8730609E
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 17:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhA0QI7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 11:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236425AbhA0QHg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Jan 2021 11:07:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB390207CC;
        Wed, 27 Jan 2021 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611763613;
        bh=TBiVdWNTKBxGL5C6wtlgzd2GcCfyPi02KPshb6e+jeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SwdW0TktI9sBGvj6wz48I+buvaYvvjBOEypEw/ZV2ww9FFDfZxnAGUAOYBsHJaQxp
         uDCXnm7Y+Jlrlc7jPCntfC2SL8P8hVVBCnQoM4Ofm7akEEs7sCb8FDdwizdwt/ZMKk
         mJ5JOz+P/5vXPVkMmhmarNNeAC0/beYCn+jrKBH2g3ywi5AjgVSPW6yiEmS14yEXXF
         e+FcRZYhqDtVorRN4HUjqYEwhBD/3XLdd/3foTCO8RcZevxQOPEG+oI1kzwI9MQneg
         /fw7BNKdhDJQJHg19ZxYWSFIvMzaWoSrEZNtzkkXXfgBoAlg74ErtyHhaKqOvFRoEW
         CT9VTuVNEoEFQ==
Date:   Wed, 27 Jan 2021 10:06:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
Message-ID: <20210127160650.GA2991034@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ir4=urUviCR_4N96revWZkHVDyNNUiaJ3jjGzpX8zLVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 27, 2021 at 04:44:02PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 27, 2021 at 4:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Jan 26, 2021 at 02:23:17PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > The double negative makes it hard to read "if (!ACPI_FAILURE(status))".
> > > Replace it with "if (ACPI_SUCCESS(status))".
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >
> > > This isn't really an ACPI patch, but I'm sending it to you, Rafael, since
> > > it seems easier to just apply these all at once.  But I'd be happy to split
> > > them up into individual patches if you'd rather.
> >
> > Thanks, everybody.  Rafael, I'll just merge this via my tree to avoid
> > burdening you.
> 
> It may conflict with some janitorial stuff I'm doing, though, so
> unless you've already applied it, I'd prefer to take it via the ACPI
> tree.

No problem, it's all yours!

Bjorn
