Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60125425849
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbhJGQtK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 12:49:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:12181 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242790AbhJGQtJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Oct 2021 12:49:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213254728"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="213254728"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:46:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="522666265"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:46:15 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 07 Oct 2021 19:46:12 +0300
Date:   Thu, 7 Oct 2021 19:46:12 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <YV8kVKiMShWp4g7a@lahna>
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-3-mika.westerberg@linux.intel.com>
 <20211004095239.dyowgkyq5lnfdag2@ti.com>
 <YVrSbyEsSLMOu1bU@lahna>
 <20211007123621.ld4aqasr3hlwq2c7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007123621.ld4aqasr3hlwq2c7@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Oct 07, 2021 at 06:06:23PM +0530, Pratyush Yadav wrote:
> > Unfortunately there is no way to tell the controller any of these. It
> > simply does "read" or "write" (as we command it) and internally then
> > uses whatever it got from the SFDP tables of the flash chip. That's why
> > we just claim to support all these operations and let the controller do
> > its thing (whatever it is).
> 
> That is not ideal. SPI NOR uses this to negotiate the best available 
> protocol with the controller. Say you have a flash that is capable of 
> octal mode but the controller can only support quad mode. Your driver 
> will happily tell SPI NOR that it can support octal mode. I think you 
> should check the SPI mode bits to make sure the protocol bus width is 
> supported at least (see spi_check_buswidth_req() in spi-mem.c).

Okay, I'll see if I can add that check somewhere.

> As for opcodes, is there no way to find out what opcodes the controller 
> discovered via SFDP? Maybe we can't change them, but can we at least 
> take a peek at them?

AFAICT no. The controller only allows "higher" level commands like read,
write, erase but does not expose any of that to software. You can see
yourself if you want, the spec is here:
 
  https://cdrdv2.intel.com/v1/dl/getContent/636174

Page 403 has the control register.

> I think this has problems similar to the Cadence xSPI controller [0].

Probably but I would not call these "problems" - it is how the
controller is designed. This one is meant only for SPI-NOR flash access,
typically used by the BIOS. It is by no means general purpose SPI
controller (as you can see from the datasheet). The BIOS does need the
full SPI stack, it just issues these simple commands and let's the
controller figure out what actually needs to be done.

> Sorry I only replied to this after you posted a new version. It got lost 
> in the heap of emails in my inbox :-(

No worries :)
