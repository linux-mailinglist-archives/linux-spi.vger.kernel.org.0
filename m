Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF13173435
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 10:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgB1JhY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 04:37:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45708 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgB1JhY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Feb 2020 04:37:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S9b0LZ113746;
        Fri, 28 Feb 2020 03:37:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582882620;
        bh=SPh+Agdmc6y0lmp3JNluat2ukjO6mzKkaFasmlrPdpQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rgJKb74ynq2dLwtsfSpxdsXdaOGvSe9L4xmdd+a3NkHX485BrLUxJvn69jE1xHkOc
         YHl5UH2KhSNFs89dzWm+9i7e1QcOuht2RIfDAElrWfIpjkVw+kUuJdlIr/wSNWk5se
         ZnIWaUcEQSDzIaxoW/Gbir8lcxFJ+dLVRnohg/I0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01S9b0d4120325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 03:37:00 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 03:36:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 03:37:00 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01S9axce104882;
        Fri, 28 Feb 2020 03:36:59 -0600
Date:   Fri, 28 Feb 2020 15:06:58 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 06/11] mtd: spi-nor: add support for DTR protocol
Message-ID: <20200228093658.zc3uifqg4zruokq3@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-7-p.yadav@ti.com>
 <20200227175841.51435e3f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200227175841.51435e3f@collabora.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

On 27/02/20 05:58PM, Boris Brezillon wrote:
> On Wed, 26 Feb 2020 15:06:58 +0530
> Pratyush Yadav <p.yadav@ti.com> wrote:
> 
> > Double Transfer Rate (DTR) is SPI protocol in which data is transferred
> > on each clock edge as opposed to on each clock cycle. Make
> > framework-level changes to allow supporting flashes in DTR mode.
> > 
> > Right now, mixed DTR modes are not supported. So, for example a mode
> > like 4S-4D-4D will not work. All phases need to be either DTR or STR.
> 
> Didn't go deep into the patch but at first glance you don't seem to
> extend the framework to support stateful modes as I tried to do here
> [1]. That's really something we should address before considering
> supporting xD-xD-xD modes, unless the SPI-NOR only supports one
> stateful mode. If we don't do that first, we might face all sort of
> unpleasant issues:
> 
> * kexec not working correctly because the previous kernel left the NOR
>   in an unknown state
> * suspend/resume not working properly
> * linux not booting properly because the bootloader left the device in
>   its non-default mode
> * ...

Correct. I am working on a follow-up series that takes care of these 
problems. The series will allow spi-nor to detect what mode the flash is 
in and then run the SFPD procedure in that mode (or maybe switch to 
single SPI mode and then go about its business as usual? I haven't 
figured out all the details yet).

So for the context of this series, assume we are handed the flash in 
single SPI mode.
 
> [1]https://patchwork.kernel.org/cover/10638055/

BTW, I took a quick look at this series but I don't see any code that 
tries to detect which mode the flash is in (which is the troublesome 
part [0]). So, for example, if the bootloader leaves the flash in 
8D-8D-8D mode, how would your series handle that situation?

[0] There are multiple problems to take care of when trying to detect 
    which mode a flash is in. We can try reading SFDP in each mode and 
    whichever mode gives us the correct "SFDP" signature is the mode the 
    flash is in. But the problem is that even in xSPI standard Read SFDP 
    command is optional in 8D-8D-8D mode, let alone non-xSPI flashes. 
    Another problem is that the address bytes and dummy cycles for Read 
    SFDP are not the same for every flash. The xSPI standard says 
    address bytes can be 3/4 and dummy cycles can be 8/20. So, for 
    example, Cypress s28hs/s28ht family and Micron Xccela (mt35x) family 
    use 4 address bytes, but the Adesto ATXP032/ATXP032R flashes use 3 
    address bytes.

    Say that a flash supports Read SFDP in 8D-8D-8D mode and we try all 
    the combinations to find out which mode the flash is in, we now have 
    the problem of actually identifying the flash. Unfortunately, the 
    Read ID command is not uniform across flash vendors. The Micron 
    Xccela flashes use 8 dummy cycles and no address bytes for Read ID. 
    The Cypress s28hs/t family uses configurable dummy cycles 
    (defaulting to 3) and needs 4 dummy address bytes all of which are 
    0.

    If we can't find out which flash it is, we can't run its fixup 
    hooks, and might end up running it with incorrect settings. And all 
    this is assuming a flash even has SFDP and has it available in all 
    modes.

    So, the only solution I can now think of is having the flash name in 
    its compatible string in the device tree. This way we can skip all 
    the Read ID ugliness and can have flash-specific hooks to make it 
    easier to detect the mode it is in (though I wonder if it is even 
    possible to detect the mode in a flash that doesn't have SFDP in 
    8D-8D-8D).

    Thoughts? Is there a better way to solve this problem that I didn't 
    think of?

-- 
Regards,
Pratyush Yadav
Texas Instruments India
