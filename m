Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD8937667D
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 15:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhEGN5s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 09:57:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52500 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbhEGN5r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 09:57:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 147DuZQ5113652;
        Fri, 7 May 2021 08:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620395795;
        bh=f37/TL3HEr+S3ewgNxXgMI9KuXAOPNHmxT2K4OR6Jvc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aSU23RdLK0xVAhC/u1TH99n/i5e+FjWLxGBJWUYXqnW8rjh4h9AO0evYzGhTckf6E
         9kfnrXwCvBYYKjCI4csXMnHO9fjH2h/VjU/9qOpbsAuUJyKiq6Sia0yN9iEosw6Thu
         TJEbaOOyMVcF6a6S64gKhT9XbuHu4u24e6t3OY0E=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 147DuZBJ051614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 May 2021 08:56:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 7 May
 2021 08:56:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 7 May 2021 08:56:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 147DuYSA102637;
        Fri, 7 May 2021 08:56:34 -0500
Date:   Fri, 7 May 2021 19:26:33 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 4/6] spi: spi-mem: reject partial cycle transfers in
 8D-8D-8D mode
Message-ID: <20210507135631.maue7gorfzsv4qpk@ti.com>
References: <20210506191829.8271-1-p.yadav@ti.com>
 <20210506191829.8271-5-p.yadav@ti.com>
 <20210507125533.GA6383@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210507125533.GA6383@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07/05/21 01:55PM, Mark Brown wrote:
> On Fri, May 07, 2021 at 12:48:27AM +0530, Pratyush Yadav wrote:
> > In 8D-8D-8D mode two bytes are transferred per cycle. So an odd number
> > of bytes cannot be transferred because it would leave a residual half
> > cycle at the end. Consider such a transfer invalid and reject it.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > This patch should go through the SPI tree but I have included it in this
> > series because if it goes in before patches 1-3, Micron MT35XU and
> > Cypress S28HS flashes will stop working correctly.
> 
> It seems like this should probably even go in as a fix even if nothing
> is broken with mainline right now, it's the sort of thing some out of
> tree patch could easily trigger.  Unless anyone objects I'll do that.

If it does get backported to stable branches, patches 1-3 would have to 
go in _before_ this one. Otherwise it will break the two 8D-8D-8D 
flashes: Micron MT35XU512ABA and Cypress S28HS512T. Without patch 1 
8D-8D-8D mode will not be selected correctly on these two flashes. The 
supports_op() will reject it because of 1 data byte. This is a 
relatively safe patch for backporting to a stable branch.

Patches 2 and 3 are a slightly different matter. They add an extra 
register write. But most controllers I've come across don't support 
1-byte writes in 8D mode. It is likely that they are sending 
bogus/undefined values in the second byte and deasserting CS only after 
the cycle is done. So they should _in theory_ change undefined behaviour 
to defined behaviour.

Still, they introduce an extra register write. I'm not sure how 
risk-tolerant you want to be for stable backports. I will leave the 
judgement to you or Tudor or Vignesh.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
