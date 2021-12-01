Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E482465641
	for <lists+linux-spi@lfdr.de>; Wed,  1 Dec 2021 20:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhLATXV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Dec 2021 14:23:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:42666 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhLATXV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Dec 2021 14:23:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236764138"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="236764138"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:19:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500379014"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:19:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msV82-00187e-Dc;
        Wed, 01 Dec 2021 21:18:54 +0200
Date:   Wed, 1 Dec 2021 21:18:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: fix erroneous logic inversion in spi_match_id()
 usage
Message-ID: <YafKnpJxhfVLTdJW@smile.fi.intel.com>
References: <44b2ad71-dc4b-801c-237f-9c233f675c0d@gmail.com>
 <YaeXoiFRAcxVG3I3@sirena.org.uk>
 <043b15ea-968c-60cb-dc50-c2081105975a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043b15ea-968c-60cb-dc50-c2081105975a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 01, 2021 at 07:49:19PM +0100, Heiner Kallweit wrote:
> On 01.12.2021 16:41, Mark Brown wrote:
> > On Tue, Nov 30, 2021 at 09:13:35PM +0100, Heiner Kallweit wrote:
> > 
> >> We want to continue in case of a match. Fix the erroneously inverted
> >> logic.
> > 
> > We do?  Why?  I can't tell from this changelog what the problem is or
> > why the patch would fix it.

Isn't it fixed by b79332ef9d61 ("spi: Fix condition in the
__spi_register_driver()")?


-- 
With Best Regards,
Andy Shevchenko


