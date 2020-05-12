Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE81CF1EB
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgELJtr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 05:49:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41210 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgELJtr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 05:49:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04C9nDED114366;
        Tue, 12 May 2020 04:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589276953;
        bh=jUYRZICT0PRktUXP+DkHT6YPgQop3lvSvIxDQCp6Tcw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YaY/K/6P+NWmD68AeIpmrtjtam+dzCKmnqb9uPVuISjUb+E/3vFaEgSV7VrB5uvyC
         mWswey9Fy7l9mRqoOSgWz3pBz8a2OiRcJOmTP6xtnOAYGsZPD6FS4JGagFMFeTEuyp
         bvOKqgSLWA0o3dlznsyX7ao7M9PYEM+uqqJ/IiS4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04C9nDoe049255;
        Tue, 12 May 2020 04:49:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 04:49:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 04:49:13 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04C9n7cO076689;
        Tue, 12 May 2020 04:49:08 -0500
Subject: Re: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <p.yadav@ti.com>, <alexandre.belloni@bootlin.com>,
        <richard@nod.at>, <nsekhar@ti.com>, <Nicolas.Ferre@microchip.com>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <linux-mtd@lists.infradead.org>,
        <miquel.raynal@bootlin.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <3649933.zuh8VGJVCz@192.168.0.120> <20200511112712.466f7246@collabora.com>
 <144878625.o7txgtY6sz@192.168.0.120>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <49abc8f3-5bb5-bc6d-b2ec-f14b115c58dc@ti.com>
Date:   Tue, 12 May 2020 15:19:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <144878625.o7txgtY6sz@192.168.0.120>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 12/05/20 11:46 am, Tudor.Ambarus@microchip.com wrote:
> Hi, Boris, Pratyush,
> 
> I stripped case 2/, we'll not treat it for now.
> 
> On Monday, May 11, 2020 12:27:12 PM EEST Boris Brezillon wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> On Mon, 11 May 2020 09:00:35 +0000
>>
>> <Tudor.Ambarus@microchip.com> wrote:
>>> Hi, Pratyush, Boris,
>>>
>>> On Friday, April 24, 2020 9:43:54 PM EEST Pratyush Yadav wrote:
>>>> This series adds support for octal DTR flashes in the spi-nor framework,
>>>
>>> I'm still learning about this, but I can give you my 2 cents as of now, to
>>> open the discussion. Enabling 2-2-2, 4-4-4, and 8-8-8 modes is dangerous
>>> because the flash may not recover from unexpected resets. Entering one of
>>> these modes can be:
>>> 1/ volatile selectable, the device return to the 1-1-1 protocol after the
>>> next power-on. I guess this is conditioned by the optional RESET pin, but
>>> I'll have to check. Also the flash can return to the 1-1-1 mode using the
>>> software reset or through writing to its Configuration Register, without
>>> power-on or power- off.
>>
>> My understanding is that there's no standard software reset procedure
>> that guarantees no conflict with existing 1S commands, so even the
>> software reset approach doesn't work here.
>>
> 
> The software reset procedure can't protect you from unexpected resets, but the 
> hardware with its optional reset pin can. Pratyush to confirm.
> 
> cut
> 
>>
>>> Not recovering from unexpected resets is unacceptable. One should always
>>> prefer option 1/ and condition the entering in 2-2-2, 4-4-4 and 8-8-8 with
>>> the presence of the optional RESET pin.
>>
>> Totally agree with you on that one, but we know what happens in
>> practice...
> 
> What I proposed is to condition the entering in the state-full modes with the 
> presence of the optional RESET pin. We would introduce an optional device tree 
> property for the RESET pin. If hardware doesn't implement the optional RESET# 
> signal, then we will not enter in the state-full modes.
>

Are you asking for dedicated SW controllable reset line or just an
indication from DT that OSPI reset line is connected to board level
soft/hard reset lines?

Mandating SW controllable RESET line is bit of a stretch IMO... Board
design may not allow wasting dedicated pin due to lack of GPIOs perhaps..

For eg.: TI EVM has OSPI reset line connected to board level reset out.
This ensures any soft/warm/hard CPU reset will trigger OSPI Flash reset,
but there is no SW control that allows OSPI flash alone to be reset.
Isn't such a reset mechanism sufficient?

Regards
Vignesh

