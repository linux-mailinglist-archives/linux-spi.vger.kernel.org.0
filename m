Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C529D31BA4C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 14:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhBON05 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 08:26:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:35389 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhBON0R (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 08:26:17 -0500
IronPort-SDR: nh6QijjbTkyXDnKHS5En0JXD4cELcgi1O5jaLSM7gBNp71kiu+5SMvGPWY5vTgpszbY5Lz/ydc
 U4N1idhFLoJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="179175498"
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="179175498"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 05:23:40 -0800
IronPort-SDR: aLuQiNsTdW+Q6rKbONj7+mIfbiM2U7QPSampCExo58PpTQIAeLTkcodHSLF4zeg8qtMZ9FwL7C
 WM/euuJ8BtfA==
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="425460527"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 05:23:38 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lBdqh-005CSJ-J3; Mon, 15 Feb 2021 15:23:35 +0200
Date:   Mon, 15 Feb 2021 15:23:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, broonie@kernel.org, jan.kiszka@siemens.com,
        jarkko.nikula@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: pxa2xx-pci: Fix an issue about missing call to
 'pci_free_irq_vectors()'
Message-ID: <YCp11zuXjbPvQlG0@smile.fi.intel.com>
References: <20210215124429.618582-1-zhengdejin5@gmail.com>
 <20210215125927.GA618796@nuc8i5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215125927.GA618796@nuc8i5>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Feb 15, 2021 at 08:59:27PM +0800, Dejin Zheng wrote:
> On Mon, Feb 15, 2021 at 08:44:29PM +0800, Dejin Zheng wrote:
> 
> Hi All:
> 
> I'm very sorry forgot to add change list in patch v2.
> 
> v1 -> v2:
> 	* modify subject name  pca2xx-pci to pxa2xx-pci.
> 	* add jan and Jarkko's review tag.

Can you read my comment to v1, please?

-- 
With Best Regards,
Andy Shevchenko


