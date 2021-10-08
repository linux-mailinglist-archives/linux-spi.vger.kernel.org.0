Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134B142664F
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhJHJEe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 05:04:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:51264 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235208AbhJHJEa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 Oct 2021 05:04:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="287348899"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="287348899"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 02:02:35 -0700
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="478904636"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 02:02:30 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 08 Oct 2021 12:02:28 +0300
Date:   Fri, 8 Oct 2021 12:02:28 +0300
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
Message-ID: <YWAJJLST7KYAD6Fw@lahna>
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-3-mika.westerberg@linux.intel.com>
 <20211004095239.dyowgkyq5lnfdag2@ti.com>
 <YVrSbyEsSLMOu1bU@lahna>
 <20211007123621.ld4aqasr3hlwq2c7@ti.com>
 <YV8kVKiMShWp4g7a@lahna>
 <20211007180029.6agt43vyiwpcgmjz@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007180029.6agt43vyiwpcgmjz@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Oct 07, 2021 at 11:30:31PM +0530, Pratyush Yadav wrote:
> > Probably but I would not call these "problems" - it is how the
> > controller is designed. This one is meant only for SPI-NOR flash access,
> > typically used by the BIOS. It is by no means general purpose SPI
> > controller (as you can see from the datasheet). The BIOS does need the
> > full SPI stack, it just issues these simple commands and let's the
> > controller figure out what actually needs to be done.
> 
> The problem is not the controller itself. It is perfectly fine piece to 
> have a controller like this IMO. The problem is how do we make it fit 
> into the SPI MEM model, which seems to be designed for general purpose 
> controllers only. This problem is shared with this and the Cadence xSPI 
> controller.

Fully agree. IMHO trying to shoehorn driver like this into a generic SPI
subsystem does not make much sense to me. These things can only talk to
SPI-NOR chips, nothing else.

Do you have any suggestions how to solve this "problem" so we can move
forward with the drivers?
