Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691541CD595
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 11:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgEKJop (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 05:44:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44160 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgEKJop (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 05:44:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04B9i1TG078513;
        Mon, 11 May 2020 04:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589190241;
        bh=byFyzQdwQhDM3dT5bOyJ2WghB41M52QlHFMI+0b6a0I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hmgf4bF3g5JuARgRipO90N1PvW0GwD8QNTHDuyyXUDlNeHfIhIWTM5Yg3hUr2a3L1
         q07eUpscFLogOsbMvNc/eJXct8Ojitroy8pSAuFjzbUwA2g0KKj4kXlvl2/dZwwf+j
         py8opZGiTzJ3Y7mEwFYKPcp8TOWIcmLU3/N1OCRI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04B9i1AJ059978
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 04:44:01 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 May 2020 04:44:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 May 2020 04:44:01 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04B9htxe073284;
        Mon, 11 May 2020 04:43:56 -0500
Subject: Re: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
To:     <Tudor.Ambarus@microchip.com>, <p.yadav@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <3649933.zuh8VGJVCz@192.168.0.120>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <7462190d-7459-7756-a32e-fb08e18d2ee2@ti.com>
Date:   Mon, 11 May 2020 15:13:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3649933.zuh8VGJVCz@192.168.0.120>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 11/05/20 2:30 pm, Tudor.Ambarus@microchip.com wrote:
> Hi, Pratyush, Boris,
> 
> On Friday, April 24, 2020 9:43:54 PM EEST Pratyush Yadav wrote:
>> This series adds support for octal DTR flashes in the spi-nor framework,
> 
> I'm still learning about this, but I can give you my 2 cents as of now, to 
> open the discussion. Enabling 2-2-2, 4-4-4, and 8-8-8 modes is dangerous 
> because the flash may not recover from unexpected resets. 

Unfortunately, xSPI compliant flashes need to support 1S-1S-1S and
8D-8D-8D (or 4S-4D-4D) mode only. So we have to start supporting
state-full modes

> Entering one of these modes can be:
> 1/ volatile selectable, the device return to the 1-1-1 protocol after the next 
> power-on. I guess this is conditioned by the optional RESET pin, but I'll have 
> to check. Also the flash can return to the 1-1-1 mode using the software reset 
> or through writing to its Configuration Register, without power-on or power-
> off.

Right, I guess switching to octal mode be made conditional based upon
SNOR_F_BROKEN_RESET?

> 2/ non-volatile selectable in which RESET# and software reset are useless, the 
> flash defaults to the mode selected in the non volatile Configuration Register 
> bits. The only way to get back to 1-1-1 is to write to the Configuration 
> Register.
> 

In addition to reset issue, supporting flash that boot up in Octal DDR
mode (due to non-volatile setting) is still pretty difficult. Commands
like Read ID and READ SFDP (that are used for flash discovery at
runtime) follow different protocols across different vendors in Octal
DDR mode. So its almost impossible to support such flashes w/o a hint
about device type from DT (or somewhere else).
I would really stick to option 1 for now until someone makes a
compelling case to support option 2.


> Not recovering from unexpected resets is unacceptable. One should always 
> prefer option 1/ and condition the entering in 2-2-2, 4-4-4 and 8-8-8 with the 
> presence of the optional RESET pin.
> 
> For the unfortunate flashes that support just option 2/, we should not enter 
> these modes on our own, just by discovering the capabilities from the SFDP 
> tables or by the flags in the flash_info struct. The best we can do for them 
> is to move the responsibility to the user. Maybe to add a Kconfig option that 
> is disabled by default with which we condition the entering in 2-2-2, 4-4-4 or 
> 8-8-8 modes. Once entered in one of these modes, if an unexpected reset comes, 
> you most likely are doomed, because early stage bootloaders may not work in 
> these modes and you'll not be able to boot the board. Assuming that one uses 
> other environment to boot the board, we should at least make sure that the 
> flash works in linux after an unexpected reset. We should try to determine in 
> which mode we are at init, so maybe an extension of the default_init hook is 
> needed. But all this looks like a BIG compromise, I'm not yet sure if we 
> should adress 2/. Thoughts?
> 


Agree, lets not worry about option 2 for now...

Regards
Vignesh
