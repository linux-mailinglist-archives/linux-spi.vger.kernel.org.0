Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC544BB58
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 06:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhKJFpB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 00:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhKJFpA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Nov 2021 00:45:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5C4C061764;
        Tue,  9 Nov 2021 21:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=3M/NTBsu5GaPZueRkc8Z3raX6bV5w4MFW1rB64CQo9Q=; b=lB0EnMOxp8TS2snuwi0FdWZB/H
        1A2BQO8DTRZ7uc8PfgEnPgaeLiKm0sw27IKGTeEJek33ZD9l3L48ykVZTTfrmDSaM5DyGNyFhe/PP
        nz3wL8IT1dY6SaA4MK2Qd9yMEFMsXgm+4/9oEI5hwe5C/JJEOn9wD+H2eJ+AhRAMHMLuOGk2Ouhhz
        YqK9296TRlAkVqeQagvZqOaO7CnhlBk9q85xgkZ53etqJ4XI7YRQOlWAo56ByN3CRaDCymepDXjtb
        zZ+AoDWQXsO+HyFQcy1Yx/Q91U1xb6rjtFxo5WdOVxz0bOWFvEKA3OJjq4Ye9QNnmbr28i+5orzKh
        J9ubqSPw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkgN0-004VON-Oi; Wed, 10 Nov 2021 05:42:02 +0000
Subject: Re: [PATCH v2 1/2] SPI: Add SPI driver for Sunplus SP7021
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>,
        "LH.Kuo" <lhjeff911@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-2-git-send-email-lh.kuo@sunplus.com>
 <1b034b0b-d1ac-5bbe-4384-d0be9bd47710@infradead.org>
 <de7535b134fb4247b5275c04fa21debf@sphcmbx02.sunplus.com.tw>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <952720eb-e302-8a9e-a8ae-1ca7c3dd7e1c@infradead.org>
Date:   Tue, 9 Nov 2021 21:41:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <de7535b134fb4247b5275c04fa21debf@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/9/21 9:39 PM, Lh Kuo 郭力豪 wrote:
> Hi
> 
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Sent: Wednesday, November 10, 2021 12:55 AM
>> To: LH.Kuo <lhjeff911@gmail.com>; p.zabel@pengutronix.de;
>> broonie@kernel.org; robh+dt@kernel.org; linux-spi@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: dvorkin@tibbo.com; qinjian@cqplus1.com; Wells Lu 呂芳騰
>> <wells.lu@sunplus.com>; Lh Kuo 郭力豪 <lh.Kuo@sunplus.com>
>> Subject: Re: [PATCH v2 1/2] SPI: Add SPI driver for Sunplus SP7021
>>
>> On 11/9/21 1:01 AM, LH.Kuo wrote:
>>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index
>>> 596705d..30ce0ed 100644
>>> --- a/drivers/spi/Kconfig
>>> +++ b/drivers/spi/Kconfig
>>> @@ -866,6 +866,17 @@ config SPI_SUN6I
>>>    	help
>>>    	  This enables using the SPI controller on the Allwinner A31 SoCs.
>>>
>>> +config SPI_SUNPLUS_SP7021
>>> +	tristate "Sunplus SP7021 SPI controller"
>>> +	depends on SOC_SP7021
>>> +	help
>>> +	  This enable Sunplus SP7021 spi controller driver on the SP7021 SoCs.
>>
>> 	       enables the Sunplus SP021 SPI
>>
>>> +	  This driver can also be built as a module. If so, the module will be
>>> +	  called as spi-sunplus-sp7021.
>>> +
>>> +	  If you have a  Sunplus SP7021 platform say Y here.
>>
>> 	         have a Sunplus
>> (i.e., drop one space)
>>
>>> +	  If unsure, say N.
>>
>>
> 
> I will make change as below  is it OK ?
> 
> config SPI_SUNPLUS_SP7021
> 	tristate "Sunplus SP7021 SPI controller"
> 	depends on SOC_SP7021
> 	help
> 	  This enable Sunplus SP7021 spi controller driver on the SP7021 SoCs.

	       enables               SPI

> 	  This driver can also be built as a module. If so, the module will be
> 	  called as spi-sunplus-sp7021.
> 
> 	  If you have a  Sunplus SP7021 platform say Y here.

drop one space:       a Sunplus

> 
> 	  If unsure, say N.
> 
>> --
>> ~Randy


-- 
~Randy
