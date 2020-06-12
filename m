Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBD31F7322
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 06:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgFLErZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Jun 2020 00:47:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:53898 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgFLErY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Jun 2020 00:47:24 -0400
IronPort-SDR: DNghNkt2gfCihs+mAnbi4qELU0aVn4txjIUljQcdxmeNuzivRTHYr6hJOd2aQXDi5tXF9G3/0/
 01fbt0yfTwLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 21:47:24 -0700
IronPort-SDR: nDLzfVs4qbEQ6iBEMVl7Km9JaIiu8YjqkcYiXmrsCcxV70I0zslcV5jzacQIoGZgRe5KetwezU
 CEvqmcD57aeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="289770185"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2020 21:47:22 -0700
Date:   Fri, 12 Jun 2020 12:43:46 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 4/6] spi: altera: use regmap instead of direct mmio
  register access
Message-ID: <20200612044346.GC21214@yilunxu-OptiPlex-7050>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
 <1591845911-10197-5-git-send-email-yilun.xu@intel.com>
 <20200611110211.GD4671@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611110211.GD4671@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 11, 2020 at 12:02:11PM +0100, Mark Brown wrote:
> On Thu, Jun 11, 2020 at 11:25:09AM +0800, Xu Yilun wrote:
> 
> > +	if (pdata && pdata->use_parent_regmap) {
> > +		hw->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > +		if (!hw->regmap) {
> > +			dev_err(&pdev->dev, "get regmap failed\n");
> > +			goto exit;
> > +		}
> > +		hw->base = pdata->regoff;
> 
> This seems very confused - there's some abstraction problem here.  This
> looks like the driver should know about whatever is causing it to use
> the parent regmap, it shouldn't just be "use the parent regmap" directly
> since that is too much of an implementation detail.  This new feature

Our usecase is that, we have the PCIE card which integrates this
spi-altera soft IP. So It seems reasonable we reuse this driver. But the
IP registers are not directly accessed by MMIO. It is accessed via an
indirect access interfaces, SW need to operate on the indirect access
interfaces to RW the spi-altera registers. like the following:

+------+   +------------+   +------------+
| PCIE |---| indirect   |---| spi-altera |
+------+   | access     |   +------------+
           | interfaces |
           +------------+
           | SPI params |
           +------------+

So we think of creating regmap to abstract the actually register accessing
detail. The parent device driver creates the regmap of indirect access,
and it creates the spi-altera platform device as child. Spi-altera
driver could just get the regmap from parent, don't have to care about
the indirect access detail.

It seems your concern is how to gracefully let spi-altera driver get the
regmap. or not using it. Since our platform doesn't enable device tree
support, seems the only way to talk to platform device is the
platform_data.

Do you have any suggestion on that?


I think the driver may need to figure out the role of the device in
system, whether it is a subdev of other device (like MFD? Many mfd subdev
driver will get parent regmap by default), or it is an independent mmio
device. But I'm not sure how to do it in right way.

> also seems like a separate change which should be in a separate patch,
> the changelog only talked about converting to use regmap which I'd have
> expected to be a straight 1:1 replacement of non-regmap stuff with
> regmap stuff.

Understood. I should make a patch to do 1:1 replacement of regmap first,
then a second patch to handle the parent regmap.


