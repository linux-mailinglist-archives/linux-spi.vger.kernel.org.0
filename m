Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7A398355
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 09:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFBHo0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 03:44:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54546 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBHo0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 03:44:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1527gGHk040486;
        Wed, 2 Jun 2021 02:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622619736;
        bh=on221I0/fbDX/gm21Y2yHzs/Jt3SZPApRYBMpZhQw2g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lufhlBy4NtrGCtX5ePp062Lnf0ktHPnng6jRt3EU8AkLiTWWk6JoCQstL+kXMXnW0
         z6lLXNfrZb4FVMOCxuBz/m8O8u9LLBIMbJxhbs62s5cU0YumCrXQ7C+QcGHSbxKdCc
         BtcmLSCV1nENUu7u6eXsjNsgW9cS+BPxwnugD7X4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1527gG5S014263
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jun 2021 02:42:16 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 2 Jun
 2021 02:42:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 2 Jun 2021 02:42:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1527gFSs037775;
        Wed, 2 Jun 2021 02:42:15 -0500
Date:   Wed, 2 Jun 2021 13:12:14 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] mtd: spi-nor: spansion: write 2 bytes when
 disabling Octal DTR mode
Message-ID: <20210602074212.o4dmwry747wortsq@ti.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
 <20210531181757.19458-3-p.yadav@ti.com>
 <f875025538713a005b1c18f8eb5c24c0@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f875025538713a005b1c18f8eb5c24c0@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/06/21 02:47PM, Michael Walle wrote:
> Am 2021-05-31 20:17, schrieb Pratyush Yadav:
> > The Octal DTR configuration is stored in the CFR5V register. This
> > register is 1 byte wide. But 1 byte long transactions are not allowed in
> > 8D-8D-8D mode. Since the next byte address does not contain any
> > register, it is safe to write any value to it. Write a 0 to it.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> 
> Can't say much, because there is no public datasheet, is there?

https://www.cypress.com/file/513996/download

> 
> But looks sane. Same for patch 3/6.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
