Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEC1306014
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 16:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhA0PrM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 10:47:12 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:46063 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbhA0Poz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Jan 2021 10:44:55 -0500
Received: by mail-oi1-f173.google.com with SMTP id g69so2538558oib.12;
        Wed, 27 Jan 2021 07:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKSsdWM+4/PJcslQINc+CYwOklvwIWIB07uvc/J/vlk=;
        b=NX4HMljMu9Ej/KJ+BMSXa14bYdoQpIUDw3CREYMpYNCvOpRHRlp1CAlEFzHtY0J1KS
         J0lKfY5dm67Q4/EOe3hpi+CLqNwlf3Ip2KrtLEHVALC4q+SZDj2PKUms5kWH0VEemvWT
         4U90vSlQENL4PV+t86oM9mEtO9eYKXsIkGL12uTNobF+kXrRkhjW5EdfoniP3v1FltdB
         Emmba3RLRi30abWVfnZoCAKfdoMFs7+JrAzzowNxRqpLuB/3/RhFMCWl4/Xk81lOtilk
         FgSJQCl8DVwaYgEH0x+hgTg3P/UqbXtusSlfIbxu7L5DcuurK1l9TQTNHeGstiKMdfdg
         +5/A==
X-Gm-Message-State: AOAM530wYrJyMO9DMQU5QrZqYbQ4WIroMl52hUeGjIFugs1HsASchiW5
        +Eu46U/iux68olcmLxY3I3UpBJUhaRW+Wlucntg=
X-Google-Smtp-Source: ABdhPJyGYnzCLCgmUpX6BZg27NxRlq7hf3IvEKBXZL0LTkdyV6wPNtwJmSJGeCPint6S81BushRMZF17XVyz6Aa3ljk=
X-Received: by 2002:aca:308a:: with SMTP id w132mr3432211oiw.69.1611762253600;
 Wed, 27 Jan 2021 07:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20210126202317.2914080-1-helgaas@kernel.org> <20210127151426.GA2984275@bjorn-Precision-5520>
In-Reply-To: <20210127151426.GA2984275@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 16:44:02 +0100
Message-ID: <CAJZ5v0ir4=urUviCR_4N96revWZkHVDyNNUiaJ3jjGzpX8zLVQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Jan 27, 2021 at 4:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jan 26, 2021 at 02:23:17PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > The double negative makes it hard to read "if (!ACPI_FAILURE(status))".
> > Replace it with "if (ACPI_SUCCESS(status))".
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >
> > This isn't really an ACPI patch, but I'm sending it to you, Rafael, since
> > it seems easier to just apply these all at once.  But I'd be happy to split
> > them up into individual patches if you'd rather.
>
> Thanks, everybody.  Rafael, I'll just merge this via my tree to avoid
> burdening you.

It may conflict with some janitorial stuff I'm doing, though, so
unless you've already applied it, I'd prefer to take it via the ACPI
tree.

Cheers!
