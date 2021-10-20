Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FDD434AA3
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTMBw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 08:01:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40432 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJTMBv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 08:01:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19KBxHvM090400;
        Wed, 20 Oct 2021 06:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634731157;
        bh=rlMVQBrt/BXGNUndMGSC4aInghxlxwn1R/F4gxYaNVM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vivVc90Wv/k59eXzuyZWzXoAvqlwz2HRSAVKXwXFlVZlAEisxG7+EScOERqj8wNWN
         0dYLa/HtBTgAydnr52ILPxFkZiUHMXNAyQOrajuC3CQPTMjMJIqWnwZpJVIohn6WWo
         CpfyuJqn+r7Lrw0B7raQ7SUN6lN5EXNiaGnRnCwE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19KBxHmk062374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Oct 2021 06:59:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 20
 Oct 2021 06:59:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 20 Oct 2021 06:59:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19KBxGJe025515;
        Wed, 20 Oct 2021 06:59:16 -0500
Date:   Wed, 20 Oct 2021 17:29:15 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <20211020115913.uzo3ogkmrltnb26y@ti.com>
References: <20211013114432.31352-1-mika.westerberg@linux.intel.com>
 <20211013114432.31352-3-mika.westerberg@linux.intel.com>
 <20211020114153.0f99c5df@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211020114153.0f99c5df@collabora.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/10/21 11:41AM, Boris Brezillon wrote:
> On Wed, 13 Oct 2021 14:44:31 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > The preferred way to implement SPI-NOR controller drivers is through SPI
> > subsubsystem utilizing the SPI MEM core functions. This converts the
> > Intel SPI flash controller driver over the SPI MEM by moving the driver
> > from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> > SPI MEM functions. The driver name will be changed from intel-spi to
> > spi-intel to match the convention used in the SPI subsystem.
> > 
> 
> I skimmed over the driver changes, and I'm skeptical about this "let's
> convert all spi-nor controller drivers into spi-mem drivers even if
> they don't fit the spi-mem model" strategy. Clearly, the intel
> controller is much more limited than any other spi-mem controller (I
> mean feature-wise not perf-wise of course). The fact that you have to
> check the opcode to decide whether the operation is supported or not,
> or the way you deduce when to issue an erase vs a regular read/write is
> kind of hack-ish. Not saying we shouldn't support this case in spi-mem,
> but it should at least be done in a more controlled way. Maybe with an
> explicit array of supported spi_mem operations, and driver specific
> hooks for each of these operations so anything falling outside is
> clearly identified and rejected (we have this sort of things in the raw
> NAND framework).

I am curious about how we can solve this. Any pointers to 
functions/drivers in raw NAND framework that follow this model?

[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
