Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7042AD04
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 21:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhJLTMH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 15:12:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:44727 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhJLTMH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 Oct 2021 15:12:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="226019235"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="226019235"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 12:10:04 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="547575391"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 12:10:00 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1maN7p-0003Qj-M6;
        Tue, 12 Oct 2021 22:07:45 +0300
Date:   Tue, 12 Oct 2021 22:07:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to
 SPI MEM
Message-ID: <YWXdAc/rzyhqxl0b@smile.fi.intel.com>
References: <20211007112132.30934-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007112132.30934-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 07, 2021 at 02:21:29PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> Based on discussion on the patch I sent some time ago here:
> 
>   http://lists.infradead.org/pipermail/linux-mtd/2021-June/086867.html
> 
> it turns out that the preferred way to deal with the SPI flash controller
> drivers is through SPI MEM which is part of Linux SPI subsystem.
> 
> This series does that for the intel-spi driver. This also renames the
> driver to follow the convention used in the SPI subsystem. The first patch
> improves the write protection handling to be slightly more safer. The
> following two patches do the conversion itself. Note the Intel SPI flash
> controller only allows commands such as read, write and so on and it
> internally uses whatever addressing etc. it figured from the SFDP on the
> flash device.
> 
> Previous version of the patch series can be found here:
> 
>   https://lore.kernel.org/linux-mtd/20210930100719.2176-1-mika.westerberg@linux.intel.com/
> 
> Changes from the previous version:
> 
>   * Arrange dependencies in Kconfig entries the same way in both glue
>     drivers.
>   * Added empty lines between different subsystem includes.
>   * dev_err() to single line
>   * Return intel_spi_sw_cycle() directly in intel_spi_erase().
>   * Drop redundant elses.
>   * Fixed typo in the commit message of the patch 3/3.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Mika Westerberg (3):
>   mtd: spi-nor: intel-spi: Disable write protection only if asked
>   mtd: spi-nor: intel-spi: Convert to SPI MEM
>   Documentation / MTD: Rename the intel-spi driver
> 
>  Documentation/driver-api/mtd/index.rst        |   2 +-
>  .../mtd/{intel-spi.rst => spi-intel.rst}      |   8 +-
>  drivers/mfd/lpc_ich.c                         |  59 ++-
>  drivers/mtd/spi-nor/controllers/Kconfig       |  36 --
>  drivers/mtd/spi-nor/controllers/Makefile      |   3 -
>  drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 --
>  drivers/spi/Kconfig                           |  39 ++
>  drivers/spi/Makefile                          |   3 +
>  .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  49 ++-
>  .../spi-intel-platform.c}                     |  21 +-
>  .../intel-spi.c => spi/spi-intel.c}           | 345 ++++++++++--------
>  drivers/spi/spi-intel.h                       |  19 +
>  include/linux/mfd/lpc_ich.h                   |   2 +-
>  .../x86/{intel-spi.h => spi-intel.h}          |  12 +-
>  14 files changed, 355 insertions(+), 264 deletions(-)
>  rename Documentation/driver-api/mtd/{intel-spi.rst => spi-intel.rst} (94%)
>  delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (84%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (78%)
>  create mode 100644 drivers/spi/spi-intel.h
>  rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (64%)
> 
> -- 
> 2.33.0
> 

-- 
With Best Regards,
Andy Shevchenko


