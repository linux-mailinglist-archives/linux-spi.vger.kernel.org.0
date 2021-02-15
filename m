Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F0731BA4B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 14:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBON0l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 08:26:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:22537 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhBON0R (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 08:26:17 -0500
IronPort-SDR: cw0SpZJkWfXf4g7/3QC6uHGl92mHR9dAles+kJiIa7OQQIWSTcTncjwQCD5SeCXB1xDIp8qrvI
 PcS139KcfBDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="267526103"
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="267526103"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 05:22:43 -0800
IronPort-SDR: Q92VLC8ChvVQp9ZTerRdIUQPLKHA+TrtS3HUJ9mgc6H5DzaPi59pZB7OXkoGrivf8EqbJjOAls
 AK0bhyIDQOVQ==
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="383365469"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 05:22:41 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lBdpm-005CRM-HF; Mon, 15 Feb 2021 15:22:38 +0200
Date:   Mon, 15 Feb 2021 15:22:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, broonie@kernel.org, jan.kiszka@siemens.com,
        jarkko.nikula@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: pca2xx-pci: Fix an issue about missing call to
 'pci_free_irq_vectors()'
Message-ID: <YCp1nh2ZEBvvB+lC@smile.fi.intel.com>
References: <20210214145746.602770-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214145746.602770-1-zhengdejin5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Feb 14, 2021 at 10:57:46PM +0800, Dejin Zheng wrote:
> Call to 'pci_free_irq_vectors()' are missing both in the error handling
> path of the probe function, and in the remove function. So add them.

I'm wondering if you noticed that it's done by pcim_* API.
Perhaps you can introduce pcim_alloc_irq_vectors() or so and do not add these
calls at all?

> Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")

No, it doesn't fix anything.

-- 
With Best Regards,
Andy Shevchenko


