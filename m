Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B220C4B607
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 12:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFSKQJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 06:16:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:61885 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfFSKQJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Jun 2019 06:16:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 03:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="181606423"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 19 Jun 2019 03:16:05 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Jun 2019 13:16:04 +0300
Date:   Wed, 19 Jun 2019 13:16:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        andy.shevchenko@gmail.com, masahisa.kojima@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
Message-ID: <20190619101604.GR2640@lahna.fi.intel.com>
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 19, 2019 at 11:52:54AM +0200, Ard Biesheuvel wrote:
> The ACPI device object parsing code for SPI slaves enumerates the
> entire ACPI namespace to look for devices that refer to the master
> in question via the 'resource_source' field in the 'SPISerialBus'
> resource. If that field does not refer to a valid ACPI device or
> if it refers to the wrong SPI master, we should disregard the
> device.
> 
> Current, the valid device check is wrong, since it gets the
> polarity of 'status' wrong. This could cause issues if the
> 'resource_source' field is bogus but parent_handle happens to
> refer to the correct master (which is not entirely imaginary
> since this code runs in a loop)
> 
> So test for ACPI_FAILURE() instead, to make the code more
> self explanatory.
> 
> Fixes: 4c3c59544f33 ("spi/acpi: enumerate all SPI slaves in the namespace")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
