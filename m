Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E8D42BB0F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 11:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhJMJGD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 05:06:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:48029 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234117AbhJMJGD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 05:06:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="290876540"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="290876540"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:04:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="441574840"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:03:56 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 13 Oct 2021 12:03:53 +0300
Date:   Wed, 13 Oct 2021 12:03:53 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: spi-nor: intel-spi: Disable write protection
 only if asked
Message-ID: <YWag+RpkujjggPsW@lahna>
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-2-mika.westerberg@linux.intel.com>
 <CAArk9MPWh4f1E=ecKBHy8PFzvU_y_ROgDyUU_O3ZQ0FuMhkj5Q@mail.gmail.com>
 <YVqOjF/xjqFV+Dl3@lahna>
 <CAArk9MPY+rCQse+JXtvb4KqunN9FZ=toK_v=PV-ro4cO6=5s7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAArk9MPY+rCQse+JXtvb4KqunN9FZ=toK_v=PV-ro4cO6=5s7Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Oct 12, 2021 at 03:49:22PM -0300, Mauro Lima wrote:
> Hi Mika
> 
> On Mon, Oct 4, 2021 at 2:18 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Fri, Oct 01, 2021 at 05:23:23PM -0300, Mauro Lima wrote:
> > > Question for maintainers: With these changes is it safe to remove the
> > > *(DANGEROUS)* tag from menuconfig?
> >
> > I don't think we want to remove that. This driver is not for regular
> > users, at least in its current form.
> Do we know why this is still dangerous for the user?

There was a bug in the driver in the past (that was already fixed but it
did not yet reach the stable trees or something like that). At this
unfortunate time there was no DANGEROUS in the name so Ubuntu kernel
went and enabled it. Combined with the bug certain Lenovo laptops BIOS
turned into read-only which prevented booting from non-default devices.

This happened even when the driver did not do any "write" or "erase"
operations, just clearing the status register or so.

We don't want that to happen again.

> My plan is to make a sys/class driver to query write protection status
> of the SPI, this will be
> used by fwupd to gather information about vendors, also should be easy
> for the user to use
> 'cat' and see the information from userspace. For this to be possible
> we need kernel engineers
> to compile the kernel with this driver enabled, but the (DANGEROUS)
> tag is a no go for most
> of them.
> Is there anything I can do to make this possible?

IMHO we can make certain parts of the driver, that are known not to
cause any issues available without the DANGEROUS. I mean the controller
exposes some information that I think you are intersted in and that does
not cause anything to be sent to the flash chip itself.
