Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D70376904
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhEGQub (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 12:50:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57516 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhEGQua (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 12:50:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 147GnG6B067773;
        Fri, 7 May 2021 11:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620406156;
        bh=dYP29pg/OnV05yhd4OtnZKNb/Vkg7K7Xnr53+6Bu5YM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iNbF/LfZSUntCse7qnXSMLHxJaJc2vKUK2EE510Hzt3hvRNqvG5X44O05xxzpPLlS
         +5F6SB6GlvbQETiu5h5Z9YVtqXzz2cgoslz0bwPJJSniUut5OTWtei07hnTmWXbEL+
         X53WUSWSWGH4SRt75O/3ZKa8ivEFMRsApNpRXyq0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 147GnGuR121556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 May 2021 11:49:16 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 7 May
 2021 11:49:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 7 May 2021 11:49:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 147GnFZQ055469;
        Fri, 7 May 2021 11:49:15 -0500
Date:   Fri, 7 May 2021 22:19:14 +0530
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
Message-ID: <20210507164912.hwzsf6q65pfewtdy@ti.com>
References: <20210506191829.8271-1-p.yadav@ti.com>
 <20210506191829.8271-5-p.yadav@ti.com>
 <20210507154825.GE6383@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210507154825.GE6383@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07/05/21 04:48PM, Mark Brown wrote:
> On Fri, May 07, 2021 at 12:48:27AM +0530, Pratyush Yadav wrote:
> > In 8D-8D-8D mode two bytes are transferred per cycle. So an odd number
> > of bytes cannot be transferred because it would leave a residual half
> > cycle at the end. Consider such a transfer invalid and reject it.
> 
> Reviwed-by: Mark Brown <broonie@kernel.org>

Thanks. BTW, s/Reviwed/Reviewed/.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
