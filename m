Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25D72D9AE
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2019 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfE2JzG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 May 2019 05:55:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:2229 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfE2JzF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 May 2019 05:55:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 02:55:04 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 29 May 2019 02:55:01 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 29 May 2019 12:55:00 +0300
Date:   Wed, 29 May 2019 12:55:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        andy.shevchenko@gmail.com, masahisa.kojima@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH] spi/acpi: enumerate all SPI slaves in the namespace
Message-ID: <20190529095500.GG2781@lahna.fi.intel.com>
References: <20190528164040.6781-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528164040.6781-1-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+Rafael, Jarkko and linux-acpi.

On Tue, May 28, 2019 at 06:40:40PM +0200, Ard Biesheuvel wrote:
> Currently, the ACPI enumeration that takes place when registering a
> SPI master only considers immediate child devices in the ACPI namespace,
> rather than checking the ResourceSource field in the SpiSerialBus()
> resource descriptor.
> 
> This is incorrect: SPI slaves could reside anywhere in the ACPI
> namespace, and so we should enumerate the entire namespace and look for
> any device that refers to the newly registered SPI master in its
> resource descriptor.

Yes, that's right.

> In order to prevent potential regressions, retain the old code and run
> it first. Only then, enumerate the entire namespace. Note that this
> could result in child devices wrongly being associated with a SPI master
> but this can only occur if a SPI master has a child device representing
> a SPI slave that is connected to another master.

I don't think we need to retain the old behavior here. We did the same
already for I2C and I don't remember seeing any regressions. Also I have
not seen too many real SPI slaves in ACPI based systems so most probably
nobody even notices this change ;-)

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/spi/spi.c | 75 ++++++++++++++++++--
>  1 file changed, 69 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 5e75944ad5d1..d2f4332d9cc3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1882,10 +1882,6 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>  	struct spi_device *spi;
>  	int ret;
>  
> -	if (acpi_bus_get_status(adev) || !adev->status.present ||
> -	    acpi_device_enumerated(adev))
> -		return AE_OK;
> -
>  	spi = spi_alloc_device(ctlr);
>  	if (!spi) {
>  		dev_err(&ctlr->dev, "failed to allocate SPI device for %s\n",
> @@ -1927,18 +1923,64 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>  	return AE_OK;
>  }
>  
> +static acpi_status acpi_spi_add_child_device(acpi_handle handle, u32 level,
> +					     void *data, void **return_value)
> +{
> +	struct spi_controller *ctlr = data;
> +	struct acpi_device *adev;
> +
> +	if (acpi_bus_get_device(handle, &adev) ||
> +	    acpi_bus_get_status(adev) ||
> +	    !adev->status.present ||
> +	    acpi_device_enumerated(adev))
> +		return AE_OK;
> +
> +	return acpi_register_spi_device(ctlr, adev);
> +}
> +
> +static int acpi_spi_check_parent(struct acpi_resource *ares, void *data)
> +{
> +	struct acpi_resource_spi_serialbus *sb;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return 1;
> +
> +	sb = &ares->data.spi_serial_bus;
> +
> +	/* check whether this resource refers our controller */
> +	acpi_get_handle(NULL, sb->resource_source.string_ptr, data);
> +	return 1;
> +}
> +
>  static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
>  				       void *data, void **return_value)
>  {
>  	struct spi_controller *ctlr = data;
> +	acpi_handle parent_handle = NULL;
> +	struct list_head resource_list;
>  	struct acpi_device *adev;
> +	int ret;
>  
> -	if (acpi_bus_get_device(handle, &adev))
> +	if (acpi_bus_get_device(handle, &adev) ||
> +	    acpi_bus_get_status(adev) ||
> +	    !adev->status.present ||
> +	    acpi_device_enumerated(adev))
> +		return AE_OK;
> +
> +	INIT_LIST_HEAD(&resource_list);
> +	ret = acpi_dev_get_resources(adev, &resource_list,
> +				     acpi_spi_check_parent,
> +				     &parent_handle);
> +	acpi_dev_free_resource_list(&resource_list);
> +
> +	if (ret < 0 || ACPI_HANDLE(ctlr->dev.parent) != parent_handle)
>  		return AE_OK;
>  
>  	return acpi_register_spi_device(ctlr, adev);
>  }
>  
> +#define SPI_ACPI_ENUMERATE_MAX_DEPTH		32
> +
>  static void acpi_register_spi_devices(struct spi_controller *ctlr)
>  {
>  	acpi_status status;
> @@ -1948,10 +1990,31 @@ static void acpi_register_spi_devices(struct spi_controller *ctlr)
>  	if (!handle)
>  		return;
>  
> +	/*
> +	 * Enumerate child nodes of this controller. This logic is retained to
> +	 * prevent potential regressions on systems where the ResourceSource of
> +	 * a device's SpiSerialBus() resource does not refer to the parent SPI
> +	 * controller device.
> +	 */
>  	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +				     acpi_spi_add_child_device, NULL, ctlr,
> +				     NULL);
> +	if (ACPI_FAILURE(status)) {
> +		dev_warn(&ctlr->dev, "failed to enumerate SPI children\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Walk the entire namespace and enumerate all devices containing a
> +	 * SpiSerialBus() resource whose ResourceSource argument refers to this
> +	 * SPI controller device.
> +	 */
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +				     SPI_ACPI_ENUMERATE_MAX_DEPTH,
>  				     acpi_spi_add_device, NULL, ctlr, NULL);
>  	if (ACPI_FAILURE(status))
> -		dev_warn(&ctlr->dev, "failed to enumerate SPI slaves\n");
> +		dev_warn(&ctlr->dev,
> +			 "failed to enumerate SPI slaves in the ACPI namespace\n");
>  }
>  #else
>  static inline void acpi_register_spi_devices(struct spi_controller *ctlr) {}
> -- 
> 2.20.1
