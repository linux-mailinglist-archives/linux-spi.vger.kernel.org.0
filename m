Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08473726B5
	for <lists+linux-spi@lfdr.de>; Tue,  4 May 2021 09:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhEDHnc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 May 2021 03:43:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49514 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhEDHna (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 May 2021 03:43:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1447gLMl109806;
        Tue, 4 May 2021 02:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620114141;
        bh=dfU3OUcVoRBJbR3Exsd2SHBYTLZkiu3fPn4CwADJUF8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=d6KcoZ4HCaCCrjUlx/wSPeKxYlt48C6UyQ7ng5VZlpNZnDymW/ZB5FmpRNWA+wR3a
         oguojS8xWiOZ1VvyvuDtO8wm0izXjRJFCJz8M27bnIlohYQcMruesa3YOdnKVszaD4
         ZbAglvqTT463wyYGp1FwckAjBK9jxPpmQhMkbA9Q=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1447gLNc098473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 May 2021 02:42:21 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 4 May
 2021 02:42:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 4 May 2021 02:42:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1447gKu5018786;
        Tue, 4 May 2021 02:42:21 -0500
Date:   Tue, 4 May 2021 13:12:20 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <zhengxunli@mxic.com.tw>
CC:     <broonie@kernel.org>, <jaimeliao@mxic.com.tw>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <tudor.ambarus@microchip.com>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: macronix: add support for Macronix
 octal dtr operation
Message-ID: <20210504074218.s2zezkt3imaanfmr@ti.com>
References: <1618900179-14546-1-git-send-email-zhengxunli@mxic.com.tw>
 <1618900179-14546-2-git-send-email-zhengxunli@mxic.com.tw>
 <20210427023604.vamgepl4myrhpiwu@ti.com>
 <OF2365AB9C.87E8927D-ON482586CA.0029B8EB-482586CB.001E5C1A@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF2365AB9C.87E8927D-ON482586CA.0029B8EB-482586CB.001E5C1A@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/05/21 01:31PM, zhengxunli@mxic.com.tw wrote:
> Hi Pratyush,
> 
> Thanks for your comment on this patch.
> 
> "Pratyush Yadav" <p.yadav@ti.com> wrote on 2021/04/27 上午 10:36:06:
> 
[...]
> > > +   if (!enable)
> > > +      spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> > 
> > When disabling, the op would be in 8D-8D-8D mode so having a data length 
> 
> > of 1 would be invalid. This is currently the case even in the patches 
> > that I sent for Micron and Cypress.
> > 
> > I am not sure what the correct fix for this is though. One option is to 
> > send the same byte twice, but I remember that on the Cypress flash the 
> > second byte over-writes the register at the next address. I'm not sure 
> > how Macronix flashes handle the second byte. Can you check what the 
> > behavior for your flash is when you write 2 bytes to the register?
> 
> I checked the behavior of Macronix and the second byte will overwrites the 
> register.

Yes, I see the same behaviour on Micron and Cypress flashes. Can your 
controller send a 1-byte write in 8D mode? I am curious if this is 
possible and how flashes react to it.

My theory is that even if you ask the controller to send 1 byte in 8D 
mode, it won't deassert the CS till the end of the cycle. This would 
result the flash in taking the default value of the lines as the second 
byte.

> Do we need to send the same bytes to resolve this error?

I think this is a design oversight by flash manufacturers. Having two 
registers at consecutive addresses is problematic in 8D-8D-8D mode. The 
only solution I see is to read the register at the next address, and set 
its value as the second byte in the transaction. This way its value will 
stay the same at the end of the transaction.

PS: If possible, please try to relay this issue to your hardware design 
team. Hopefully they can come up with a clever solution for future 
devices and make our lives easier ;-)

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
