Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0D3053B4
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 07:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhA0G5W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 01:57:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:34828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhA0Gvh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Jan 2021 01:51:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBE44AF2B;
        Wed, 27 Jan 2021 06:50:55 +0000 (UTC)
Date:   Wed, 27 Jan 2021 07:50:55 +0100
Message-ID: <s5hk0ryzxdc.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-spi@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-hwmon@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
In-Reply-To: <20210126202317.2914080-1-helgaas@kernel.org>
References: <20210126202317.2914080-1-helgaas@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 26 Jan 2021 21:23:17 +0100,
Bjorn Helgaas wrote:
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The double negative makes it hard to read "if (!ACPI_FAILURE(status))".
> Replace it with "if (ACPI_SUCCESS(status))".
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> This isn't really an ACPI patch, but I'm sending it to you, Rafael, since
> it seems easier to just apply these all at once.  But I'd be happy to split
> them up into individual patches if you'd rather.
> 
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 4 ++--
>  drivers/gpu/drm/radeon/radeon_bios.c     | 4 ++--
>  drivers/hwmon/acpi_power_meter.c         | 4 ++--
>  drivers/platform/x86/asus-laptop.c       | 6 +++---
>  drivers/spi/spi.c                        | 2 +-
>  sound/pci/hda/hda_intel.c                | 4 ++--

For the sound/*:
Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
