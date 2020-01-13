Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A251393BA
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgAMOeG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 09:34:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:42496 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMOeG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Jan 2020 09:34:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 06:34:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="218679884"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2020 06:34:02 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1ir0n5-0000dT-J4; Mon, 13 Jan 2020 16:34:03 +0200
Date:   Mon, 13 Jan 2020 16:34:03 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, tudor.ambarus@microchip.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chenxiang66@hisilicon.com, Linuxarm <linuxarm@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        fengsheng5@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, liusimin4@huawei.com
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Message-ID: <20200113143403.GQ32742@smile.fi.intel.com>
References: <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
 <20200113114256.GH3897@sirena.org.uk>
 <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
 <20200113140627.GJ3897@sirena.org.uk>
 <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q@mail.gmail.com>
 <20200113142754.GL3897@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113142754.GL3897@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jan 13, 2020 at 02:27:54PM +0000, Mark Brown wrote:
> On Mon, Jan 13, 2020 at 04:17:32PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 13, 2020 at 4:07 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Mon, Jan 13, 2020 at 01:01:06PM +0000, John Garry wrote:
> > > > On 13/01/2020 11:42, Mark Brown wrote:
> 
> > > > > The idiomatic approach appears to be for individual board vendors
> > > > > to allocate IDs, you do end up with multiple IDs from multiple
> > > > > vendors for the same thing.
> 
> > > > But I am not sure how appropriate that same approach would be for some 3rd
> > > > party memory part which we're simply wiring up on our board. Maybe it is.
> 
> > > It seems to be quite common for Intel reference designs to assign
> > > Intel IDs to non-Intel parts on the board (which is where I
> > > became aware of this practice).
> 
> > Basically vendor of component in question is responsible for ID, but
> > it seems they simple don't care.
> 
> AFAICT a lot of the time it seems to be that whoever is writing
> the software ends up assigning an ID, that may not be the silicon
> vendor.

...which is effectively abusing the ACPI ID allocation procedure.

(And yes, Intel itself did it in the past — see badly created ACPI IDs
 in the drivers)

-- 
With Best Regards,
Andy Shevchenko


