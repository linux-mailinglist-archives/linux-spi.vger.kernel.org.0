Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6271476EFB
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhLPKjP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 05:39:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:1650 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236122AbhLPKjP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Dec 2021 05:39:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239409782"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="239409782"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 02:39:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="545931922"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 02:39:09 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Dec 2021 12:39:07 +0200
Date:   Thu, 16 Dec 2021 12:39:07 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to
 SPI MEM
Message-ID: <YbsXS0SlrrQc0MGm@lahna>
References: <20211118130543.11179-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118130543.11179-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Nov 18, 2021 at 04:05:40PM +0300, Mika Westerberg wrote:
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

Any comments on this series? If no, I would appreciate if these could be
merged for v5.17 :)

Thanks!
