Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7311B22E6
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgDUJfr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 05:35:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33840 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgDUJfr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 05:35:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03L9ZEPN092019;
        Tue, 21 Apr 2020 04:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587461714;
        bh=EeE21hMUOfk3pC387RpavuP6TsxGuhOnVMwPs3H4nSk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kn5JrMwuqadtuMZU6zKFo3/VxCueg+wAfvntp8l6BnvP9ar/ktulDIftrzkIkqRqV
         gIbAhBJyXPaW0lUfjTB40Ix8pZSp3Bal/Alm632UcAe5MjIEMoR8eR5JA1gjitddGH
         OYYDaJLcYt9FTvM/143EFgw3l29320GK002ShqRM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03L9ZEsK034008;
        Tue, 21 Apr 2020 04:35:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 21
 Apr 2020 04:35:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 21 Apr 2020 04:35:14 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03L9Z9Qf105015;
        Tue, 21 Apr 2020 04:35:10 -0500
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mason Yang <masonccyang@mxic.com.tw>
CC:     <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <juliensu@mxic.com.tw>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
 <20200421092328.129308f6@collabora.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <56365995-fe30-534f-9dbc-7307d9b9f846@ti.com>
Date:   Tue, 21 Apr 2020 15:05:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421092328.129308f6@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 21/04/20 12:53 pm, Boris Brezillon wrote:
> +Pratyush who's working on a similar patchet [1].
> 
> Hello Mason,
> 
> On Tue, 21 Apr 2020 14:39:42 +0800
> Mason Yang <masonccyang@mxic.com.tw> wrote:
> 
>> Hello,
>>
>> This is repost of patchset from Boris Brezillon's
>> [RFC,00/18] mtd: spi-nor: Proposal for 8-8-8 mode support [1].
> 
> I only quickly went through the patches you sent and saying it's a
> repost of the RFC is a bit of a lie. You completely ignored the state
> tracking I was trying to do to avoid leaving the flash in 8D mode when
> suspending/resetting the board, and I think that part is crucial. If I
> remember correctly, we already had this discussion so I must say I'm a
> bit disappointed.
> 
> Can you sync with Pratyush? I think his series [1] is better in that it
> tries to restore the flash in single-SPI mode before suspend (it's
> missing the shutdown case, but that can be easily added I think). Of
> course that'd be even better to have proper state tracking at the SPI
> NOR level.
> 

[1] does soft reset on shutdown which should put it to reset default
state of 1S-1S-1S mode (if thats the POR default)

But, there is still one open question now that we are considering
supporting stateful modes:

What to do with flashes that power up in 8D mode either due to factory
defaults or if 8D mode NV bit is set? Do we say SPI NOR framework won't
support such flashes?
Auto discovery of such flashes is quite difficult as different flashes
use different protocols for RDID cmd in 8D mode (address phase may or
may not be present, dummy cycles vary etc) is almost impossible w/o any
hint passed to the driver?


> Regards,
> 
> Boris
> 
> [1]https://lkml.org/lkml/2020/3/13/659
> 
