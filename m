Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A991F77F8
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 14:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgFLMey (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Jun 2020 08:34:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:25567 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgFLMex (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Jun 2020 08:34:53 -0400
IronPort-SDR: Ank0/1uoksElPtqh9c1o85vpqdK8D2ksdkIoTYUv4NLrY2MVzaUItY1wlUujgAdXp7GcY1GACj
 cTclz0jzDY6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 05:34:53 -0700
IronPort-SDR: /xK8J5kfUCMvfO03S7wFQwL/zukI0T48i6GLNJrWv2nxZHICvoBfiqvdEzoiEtvBm1johMlTs/
 OvqHPr2PBefA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="296929504"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2020 05:34:50 -0700
Date:   Fri, 12 Jun 2020 20:31:15 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH 4/6] spi: altera: use regmap instead of direct mmio
  register access
Message-ID: <20200612123115.GA8653@yilunxu-OptiPlex-7050>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
 <1591845911-10197-5-git-send-email-yilun.xu@intel.com>
 <20200611110211.GD4671@sirena.org.uk>
 <20200612044346.GC21214@yilunxu-OptiPlex-7050>
 <20200612115202.GD5396@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612115202.GD5396@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 12, 2020 at 12:52:02PM +0100, Mark Brown wrote:
> On Fri, Jun 12, 2020 at 12:43:46PM +0800, Xu Yilun wrote:
> 
> > So we think of creating regmap to abstract the actually register accessing
> > detail. The parent device driver creates the regmap of indirect access,
> > and it creates the spi-altera platform device as child. Spi-altera
> > driver could just get the regmap from parent, don't have to care about
> > the indirect access detail.
> 
> To be clear there's absolutely no problem with the end result, my
> concern is the way that we're getting there.
> 
> > It seems your concern is how to gracefully let spi-altera driver get the
> > regmap. or not using it. Since our platform doesn't enable device tree
> > support, seems the only way to talk to platform device is the
> > platform_data.
> 
> No, the problem is with how that platform data is structured.  Based on
> what you're saying I'd suggest adding another device ID for this - you
> can use the id_table field in struct platform_driver to have more than
> one ID like you can have more than one ACPI ID or OF compatible.  That
> would mirror how this would be handled if things were enumerated through
> firmware.

Thanks for your quick response. It's very clear and makes sense. I'll
change it.

> 
> > I think the driver may need to figure out the role of the device in
> > system, whether it is a subdev of other device (like MFD? Many mfd subdev
> > driver will get parent regmap by default), or it is an independent mmio
> > device. But I'm not sure how to do it in right way.
> 
> Yes, it sounds like this card is a MFD.


