Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3421C371E
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEDKmw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 06:42:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:54863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEDKmw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 06:42:52 -0400
IronPort-SDR: z8OwaJ5Z97ZaM1Mi6CMaX4YoWtZSnXJehwkguRm0EfJlBC77z28ZsHFH/F8JMXqauNWmJ+cXeO
 D6X3m9GpuBmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 03:42:50 -0700
IronPort-SDR: YsyTN3XujNe4EH/d4h27FxTbwofavGyfETEfLF0Cea+JivViR5D1mUUgsVIGHKiPMZLpRnvBv9
 2aH3IIZDn2EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="248182608"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 04 May 2020 03:42:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jVYYl-004bJY-VT; Mon, 04 May 2020 13:42:51 +0300
Date:   Mon, 4 May 2020 13:42:51 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] spi: dw: Add support for Intel Keem Bay SPI
Message-ID: <20200504104251.GC185537@smile.fi.intel.com>
References: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200428141449.GV185537@smile.fi.intel.com>
 <20200428180720.GO5677@sirena.org.uk>
 <CAHp75Vf6OenGTz3Pvg9QQVEygK71E5j-2W-s+0G6dh=QDDfR2Q@mail.gmail.com>
 <20200429101611.GF4201@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429101611.GF4201@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Apr 29, 2020 at 11:16:11AM +0100, Mark Brown wrote:
> On Wed, Apr 29, 2020 at 01:14:48AM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 28, 2020 at 9:08 PM Mark Brown <broonie@kernel.org> wrote:
> 
> > > If there are problems with the DT binding conversion
> 
> > We don't know (yet) if there is any problem, that's why I'm asking Rob
> > to have a look.
> 
> Yes, what I am saying is that in the event there are problems the
> conversion should be split out and done separately.

Wan, please rebase the series in order that conversion patch goes last.
Thanks!

-- 
With Best Regards,
Andy Shevchenko


