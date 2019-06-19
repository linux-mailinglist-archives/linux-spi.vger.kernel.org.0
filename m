Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC14BBE6
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFSOnA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 10:43:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:42142 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFSOnA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Jun 2019 10:43:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 07:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="181649285"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 19 Jun 2019 07:42:56 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Jun 2019 17:42:55 +0300
Date:   Wed, 19 Jun 2019 17:42:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
Message-ID: <20190619144255.GG2640@lahna.fi.intel.com>
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
 <20190619101604.GR2640@lahna.fi.intel.com>
 <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
 <CAKv+Gu_Bw3aV-pUVYf8T1hLfL35X7ozEPtqL9oLcDvwcQ4qMiw@mail.gmail.com>
 <c96afe71-c7bd-d30f-ef37-0c6eeb726f67@linux.intel.com>
 <CAKv+Gu9fafXNrAYAgUuqMPVjZm2bWJmzg_aPz9WD1skemQme8A@mail.gmail.com>
 <08e498d6-1ff8-771f-7d4f-6ea5f705d386@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e498d6-1ff8-771f-7d4f-6ea5f705d386@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 19, 2019 at 05:17:59PM +0300, Jarkko Nikula wrote:
> Hi
> 
> On 6/19/19 4:58 PM, Ard Biesheuvel wrote:
> > So can you explain how exactly the I2C GPIO expander is failing? I
> > struggle to understand how the SPI slave probing could be related to
> > that.
> > 
> They don't show up in /sys/kernel/debug/gpio, are not present in
> /sys/bus/i2c/devices/ but SPI core instead tries add them with a bogus Chip
> Select number:
> 
> [    5.727699][    T1] pxa2xx-spi pxa2xx-spi.5: cs56 >= max 4
> [    5.733545][    T1] spi_master spi5: failed to add SPI device INT3491:00
> from ACPI

Just a guess but looking at the 4c3c59544f33 acpi_register_spi_device()
does not seem to zero fill the whole struct acpi_spi_lookup structure so
when it is supposed to bail out when SPI slave was not found:

	if (!lookup.max_speed_hz)
 		return AE_OK

it instead continues to register SPI slave because lookup.max_speed_hz
may contain whatever garbage there is in the stack at that address.
