Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18C3051AA
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 06:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhA0FE7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 00:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhA0C5I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Jan 2021 21:57:08 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C724C061788;
        Tue, 26 Jan 2021 18:17:07 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h14so269536otr.4;
        Tue, 26 Jan 2021 18:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6RQrtHgaCb4lMM8fMMEFtRSX9i0mstcMB4wNsJgI/MI=;
        b=T6Lo6Ii/bnJxz2vRaiF2Gti0hvCGinxBzrtBlwrYo4bXEVfvVVpjiPCrFs9/pdbu2c
         7rGnPVQR9bFaaslAIsvoLPhfZEtbU4K265AixqeJ8C+/+l3dlIT1luwdttlDeiY5d0ga
         uIw4XRQ1cQ1jHFTeXsSFNNJvNTdEZ84Ip4V3ZIxjPopth8YVVts2rRtbftVuIZ45jS8g
         rCV4GRV6KI8OkXEKkGLhv/DRESs4HWNySBNhNo4CY9I8+fWWAwwVweHdfJO2v62yyXUr
         efRdqh3U7FP4+F5lkGMraytiEcrqwoG1ziFQ+aHvjd/VARCjEjZKtRAMbNRcGm5/wW+k
         2jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6RQrtHgaCb4lMM8fMMEFtRSX9i0mstcMB4wNsJgI/MI=;
        b=cu1YrXozgtBiG6clpaNRnZx8S0pcwQM8HENW9hYNJLw3GI1HOb1Jll0K4YCRmALWks
         ut4gbOKQodSvZFIFUu9BJfGtTUQjX/gFKFS7hvPZiS045Zmgf+xI0PxEWzglGoW6dX5C
         SZABnDiiiGWS9pEtlAKg75S/PED7+kq2DeDFreyb2Lc7DhjkkH4FRpg7ZrsxXzyxKOr1
         45VY0kny48BP5XdU/CQ67ZQ49vbRmlD25tnF7nyt2m4r1X6cMIqPv4tJHQte3Iye+NrU
         xaGjnShQI3/cS//BVNoRQowmsBQhM5yIF1A2VuTBTTpReUK0xRlocShbKBSdJRldgh7P
         kL+g==
X-Gm-Message-State: AOAM531iTGISs5RLmMF1t0DTH5UV28wLFYgbBL73cU8DpTNEF9NLMcWR
        T9MrZeeY55uTdeL3rdOOGhA=
X-Google-Smtp-Source: ABdhPJyifwvpQ79A0lInOexsJ2UPKtY+Jo11Y/jeVCEYoOuTRlsI5eNy2f6YDNYsG6g4Fj+ErKD5Ow==
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr6023104ots.345.1611713826628;
        Tue, 26 Jan 2021 18:17:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s69sm173201oih.38.2021.01.26.18.17.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jan 2021 18:17:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Jan 2021 18:17:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jean Delvare <jdelvare@suse.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-spi@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-hwmon@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
Message-ID: <20210127021704.GA44695@roeck-us.net>
References: <20210126202317.2914080-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126202317.2914080-1-helgaas@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jan 26, 2021 at 02:23:17PM -0600, Bjorn Helgaas wrote:
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

Acked-by: Guenter Roeck <linux@roeck-us.net>

>  drivers/platform/x86/asus-laptop.c       | 6 +++---
>  drivers/spi/spi.c                        | 2 +-
>  sound/pci/hda/hda_intel.c                | 4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 6333cada1e09..055f600eeed8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -291,7 +291,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
>  			continue;
>  
>  		status = acpi_get_handle(dhandle, "ATRM", &atrm_handle);
> -		if (!ACPI_FAILURE(status)) {
> +		if (ACPI_SUCCESS(status)) {
>  			found = true;
>  			break;
>  		}
> @@ -304,7 +304,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
>  				continue;
>  
>  			status = acpi_get_handle(dhandle, "ATRM", &atrm_handle);
> -			if (!ACPI_FAILURE(status)) {
> +			if (ACPI_SUCCESS(status)) {
>  				found = true;
>  				break;
>  			}
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
> index bb29cf02974d..43bbbfd6ade8 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -205,7 +205,7 @@ static bool radeon_atrm_get_bios(struct radeon_device *rdev)
>  			continue;
>  
>  		status = acpi_get_handle(dhandle, "ATRM", &atrm_handle);
> -		if (!ACPI_FAILURE(status)) {
> +		if (ACPI_SUCCESS(status)) {
>  			found = true;
>  			break;
>  		}
> @@ -218,7 +218,7 @@ static bool radeon_atrm_get_bios(struct radeon_device *rdev)
>  				continue;
>  
>  			status = acpi_get_handle(dhandle, "ATRM", &atrm_handle);
> -			if (!ACPI_FAILURE(status)) {
> +			if (ACPI_SUCCESS(status)) {
>  				found = true;
>  				break;
>  			}
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 848718ab7312..7d3ddcba34ce 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -161,7 +161,7 @@ static ssize_t set_avg_interval(struct device *dev,
>  	mutex_lock(&resource->lock);
>  	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PAI",
>  				       &args, &data);
> -	if (!ACPI_FAILURE(status))
> +	if (ACPI_SUCCESS(status))
>  		resource->avg_interval = temp;
>  	mutex_unlock(&resource->lock);
>  
> @@ -232,7 +232,7 @@ static ssize_t set_cap(struct device *dev, struct device_attribute *devattr,
>  	mutex_lock(&resource->lock);
>  	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_SHL",
>  				       &args, &data);
> -	if (!ACPI_FAILURE(status))
> +	if (ACPI_SUCCESS(status))
>  		resource->cap = temp;
>  	mutex_unlock(&resource->lock);
>  
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index 0edafe687fa9..bfea656e910c 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -861,7 +861,7 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 * The significance of others is yet to be found.
>  	 */
>  	rv = acpi_evaluate_integer(asus->handle, "SFUN", NULL, &temp);
> -	if (!ACPI_FAILURE(rv))
> +	if (ACPI_SUCCESS(rv))
>  		len += sprintf(page + len, "SFUN value         : %#x\n",
>  			       (uint) temp);
>  	/*
> @@ -873,7 +873,7 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 * takes several seconds to run on some systems.
>  	 */
>  	rv = acpi_evaluate_integer(asus->handle, "HWRS", NULL, &temp);
> -	if (!ACPI_FAILURE(rv))
> +	if (ACPI_SUCCESS(rv))
>  		len += sprintf(page + len, "HWRS value         : %#x\n",
>  			       (uint) temp);
>  	/*
> @@ -884,7 +884,7 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
>  	 * silently ignored.
>  	 */
>  	rv = acpi_evaluate_integer(asus->handle, "ASYM", NULL, &temp);
> -	if (!ACPI_FAILURE(rv))
> +	if (ACPI_SUCCESS(rv))
>  		len += sprintf(page + len, "ASYM value         : %#x\n",
>  			       (uint) temp);
>  	if (asus->dsdt_info) {
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 720ab34784c1..801d8b499788 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2210,7 +2210,7 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>  		return AE_OK;
>  
>  	if (!lookup.max_speed_hz &&
> -	    !ACPI_FAILURE(acpi_get_parent(adev->handle, &parent_handle)) &&
> +	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
>  	    ACPI_HANDLE(ctlr->dev.parent) == parent_handle) {
>  		/* Apple does not use _CRS but nested devices for SPI slaves */
>  		acpi_spi_parse_apple_properties(adev, &lookup);
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 770ad25f1907..fe8049cd2765 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1444,7 +1444,7 @@ static bool atpx_present(void)
>  		dhandle = ACPI_HANDLE(&pdev->dev);
>  		if (dhandle) {
>  			status = acpi_get_handle(dhandle, "ATPX", &atpx_handle);
> -			if (!ACPI_FAILURE(status)) {
> +			if (ACPI_SUCCESS(status)) {
>  				pci_dev_put(pdev);
>  				return true;
>  			}
> @@ -1454,7 +1454,7 @@ static bool atpx_present(void)
>  		dhandle = ACPI_HANDLE(&pdev->dev);
>  		if (dhandle) {
>  			status = acpi_get_handle(dhandle, "ATPX", &atpx_handle);
> -			if (!ACPI_FAILURE(status)) {
> +			if (ACPI_SUCCESS(status)) {
>  				pci_dev_put(pdev);
>  				return true;
>  			}
> -- 
> 2.25.1
> 
