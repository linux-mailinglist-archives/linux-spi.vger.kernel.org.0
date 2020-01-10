Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C651137741
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2020 20:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAJTbX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jan 2020 14:31:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:47059 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbgAJTbW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jan 2020 14:31:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:31:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="422217933"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2020 11:31:18 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iq007-0003bl-4D; Fri, 10 Jan 2020 21:31:19 +0200
Date:   Fri, 10 Jan 2020 21:31:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, chenxiang66@hisilicon.com,
        linuxarm@huawei.com, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        xuejiancheng@hisilicon.com, fengsheng5@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, liusimin4@huawei.com
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Message-ID: <20200110193119.GI32742@smile.fi.intel.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 10, 2020 at 02:58:54PM +0000, John Garry wrote:
> On 10/01/2020 14:07, Mark Brown wrote:
> > On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote: >

...

> > > I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the
> > > defacto method to describe the SPI NOR-compat part for ACPI - that's what
> > > I'm using. We could add properties there, but that seems improper.
> > 
> > OK, so that's just reusing the DT binding in which case everything
> > that's valid for the DT binding should also be valid for ACPI - I
> > thought that actually worked automatically without you having to do
> > anything in the code but ICBW.
> 
> I thought that it would be improper as we could be mixing ACPI methods to
> describe the serial bus (SPI Serial Bus Connection Resource Descriptor) and
> also DT properties which could conflict, like CS active high.
> 
> However I do see extra properties than "compatible" being added in DSD for
> PRP0001:
> https://patchwork.ozlabs.org/patch/662813/ (see EEPROM part)

PRP method is only for vendors to *test* the hardware in ACPI environment.
The proper method is to allocate correct ACPI ID.

Properties (_DSD in ACPI) may be used in the same way as for DT if we have no
other means in ACPI specification for them.

> And if we were to do this, I think that we would need to add some
> device_property_read_u32("spi-rx-bus-width", ...), etc calls in the SPI FW
> parsing for ACPI path - I couldn't see that.

It's okay as long as you have ACPI ID.

P.S. Most of the sensor drivers were updated in order to support ACPI PRP
method due to DIY hobbyist on IoT sector and embedded devices. This should not
be an official way how we support hardware on ACPI-based platforms.

-- 
With Best Regards,
Andy Shevchenko


