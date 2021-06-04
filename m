Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA0339BABA
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFDOMP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 10:12:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:22229 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhFDOMP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Jun 2021 10:12:15 -0400
IronPort-SDR: rNCHwkY8gjqp9aG/ahyQQFF4V/ir6pG3S7NYk3ryehBDlHSjRPDfF3MWDi0FZbihsMBC19rssI
 Lknq//OLeBEw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265458063"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265458063"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 07:10:28 -0700
IronPort-SDR: I2P87V9me+RbSA6Ezc7S0FNIuY6KdQiDcO8+cqbm76s1dY6w1I/ZzMWG2KsmCzIdOTx6Gjuac6
 cG3ng19ZLwzQ==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="483923072"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 07:10:25 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 04 Jun 2021 17:10:22 +0300
Date:   Fri, 4 Jun 2021 17:10:22 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Add support for second flash
 chip
Message-ID: <YLo0TrtBVEEfXrXH@lahna.fi.intel.com>
References: <20210525191414.dc45h27rzqen4dce@ti.com>
 <20210526091250.GY291593@lahna.fi.intel.com>
 <20210526092417.GA291593@lahna.fi.intel.com>
 <e82f44552d0d4284fc5ed22ee0bee85a@walle.cc>
 <20210526102810.GB291593@lahna.fi.intel.com>
 <YLTILUh+bPhZ4ToR@lahna.fi.intel.com>
 <YLi3/DRqGzdlosNf@lahna.fi.intel.com>
 <20210603180843.hjzynysgby3d3e5r@ti.com>
 <YLoOSMxeGXP07Tfw@lahna.fi.intel.com>
 <20210604115339.GC4045@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604115339.GC4045@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 04, 2021 at 12:53:39PM +0100, Mark Brown wrote:
> On Fri, Jun 04, 2021 at 02:28:08PM +0300, Mika Westerberg wrote:
> 
> > Yes, exactly. With ACPI/DT the SPI core handles this after the SPI
> > master device is registered and that would result spi_nor_probe() to be
> > called for the children. However, with this one there is no ACPI node
> > for the controller (it is PCI enumerated) so there would need to be some
> > way to create that child device. In the old days that would be "platform
> > data" but that's pretty much frowned upon these days ;-)
> 
> No, that's totally fine and normal - it's just like probing a MFD, we do
> it all the time for child devices.

Okay, thanks! Then I think I have all the questions answered and can try
to convert the driver over the "SPI MEM" framework.
