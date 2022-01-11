Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413C948A7F0
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jan 2022 07:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348298AbiAKGuE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jan 2022 01:50:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:20431 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233997AbiAKGuE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 Jan 2022 01:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641883804; x=1673419804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=biYXURg2KRnUNlO5yn6yZJU2HW5H6DzCM4RRie0avx8=;
  b=W0i8AGJowCLleUqpbQ9POHY95PjIAlh5LmEvZ58cU/gzHIDSkmONBlAE
   0X6Cl7Hbz0x6u/cNwKNYqgmPqeVMq2y1gtmwGbZJtuZRolro+7ik0Xp0r
   V1IjwBjjUcuDUjr0foQOqL+5qkL0A9qu6rGAd6IQFl58g+5/rjaTg/B29
   pTpk/yOwwvqgwHW08/lvjT5lLw7dfq0hmacxcmtvZSlyiAvnn2yxA0iSg
   t0uRUXs1S4UklrWZkRpYCJtbrXrcjL6q01TcgzTcn0+H2hbq+zpsnDGJQ
   JBGi6ZuPzJLbMR97iprJfEcsBKi17VnSSktAW6yrnvLL8wkt1WaiQjF2D
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="224112214"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="224112214"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 22:49:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="690887314"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 22:49:52 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 11 Jan 2022 08:49:50 +0200
Date:   Tue, 11 Jan 2022 08:49:50 +0200
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
Subject: Re: [PATCH v5 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to
 SPI MEM
Message-ID: <Yd0ojpMnSjlguMi1@lahna>
References: <20211220164625.9400-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220164625.9400-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tudor and Mark,

On Mon, Dec 20, 2021 at 07:46:22PM +0300, Mika Westerberg wrote:
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

Any chance to get this one merged?

Thanks!
