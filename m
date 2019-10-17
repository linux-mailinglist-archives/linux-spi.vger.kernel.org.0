Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22270DA5DB
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 08:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392784AbfJQG6k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Oct 2019 02:58:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:8622 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392691AbfJQG6k (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Oct 2019 02:58:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 23:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,306,1566889200"; 
   d="scan'208";a="200300093"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 16 Oct 2019 23:58:36 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iKzk3-000870-G4; Thu, 17 Oct 2019 09:58:35 +0300
Date:   Thu, 17 Oct 2019 09:58:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Lechner <david@lechnology.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 05/11] drm/tinydrm: Remove
 tinydrm_spi_max_transfer_size()
Message-ID: <20191017065835.GZ32742@smile.fi.intel.com>
References: <20190719155916.62465-1-noralf@tronnes.org>
 <20190719155916.62465-6-noralf@tronnes.org>
 <20191015143236.GA5363@smile.fi.intel.com>
 <253aec49-e51c-b35b-4e7d-53a8a948655d@tronnes.org>
 <20191015155720.GQ11828@phenom.ffwll.local>
 <20191016161300.GW32742@smile.fi.intel.com>
 <CAKMK7uEp39uvLtgyTTj31u-GYVoPiVJDTVbUThtn7NU_EoKk3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEp39uvLtgyTTj31u-GYVoPiVJDTVbUThtn7NU_EoKk3A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 16, 2019 at 07:44:51PM +0200, Daniel Vetter wrote:
> On Wed, Oct 16, 2019 at 6:13 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Oct 15, 2019 at 05:57:20PM +0200, Daniel Vetter wrote:

> > max_transfer_size should be a function. In that case it works.
> 
> Why do you want to make it a function?

Me?!

commit 4acad4aae10d1fa79a075b38b5c73772c44f576c
Author: Michal Suchanek <hramrach@gmail.com>
Date:   Wed Dec 2 10:38:21 2015 +0000

    spi: expose master transfer size limitation.

-- 
With Best Regards,
Andy Shevchenko


