Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4F136FC4C
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhD3OX6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Apr 2021 10:23:58 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46680 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233324AbhD3OXl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Apr 2021 10:23:41 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13UEBMcd003318;
        Fri, 30 Apr 2021 16:22:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : subject : to
 : cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=J4APUBnnwkt4C4FWB9LU9doGK2aOwOIh3hIas7b7Xrc=;
 b=JB0YRl6+Q+CFdExdWWPYFQ/dwxPqRJPGfOT4HIBG1ynFWVYAb2rDWvzJ5ftT2G6zSsZd
 YWEzLNWPSX9ANwzMCcZPuA/2mFLPzZWZjJyaZJXxIFqJvc6cIfYaA/CP2YCnAdHaJj6C
 ZTqC0dlCpPo0r9q1uauC9O4GRHTxcyXSQpSofuYyoVNOr58TGPy7lVw3V0Dp8Z7aaSuv
 Ho0F8CUzE2qENrlbHc8diStjMEWxrsN8w+j90hKdB8FOJQf1BmPWTbO7sm7pmmwGK75d
 RmCQXwp2peMaw7mBe3TPnNRvBy6iFYu+dwI/XaDh0Y2Y+cfNIDoLHol6X1t7pwEkOXkV Cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 388emrsvt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 16:22:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7539810002A;
        Fri, 30 Apr 2021 16:22:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5BBCC24185E;
        Fri, 30 Apr 2021 16:22:42 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 30 Apr
 2021 16:22:35 +0200
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 1/3] spi: spi-mem: add automatic poll status functions
To:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20210426143934.25275-1-patrice.chotard@foss.st.com>
 <20210426143934.25275-2-patrice.chotard@foss.st.com>
 <20210426162610.erpt5ubeddx7paeq@ti.com>
 <20210426165118.GH4590@sirena.org.uk>
Message-ID: <28acedfd-6cd5-a8ad-0182-e61c3c30c27d@foss.st.com>
Date:   Fri, 30 Apr 2021 16:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426165118.GH4590@sirena.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_08:2021-04-30,2021-04-30 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark, Pratyush

On 4/26/21 6:51 PM, Mark Brown wrote:
> On Mon, Apr 26, 2021 at 09:56:12PM +0530, Pratyush Yadav wrote:
>> On 26/04/21 04:39PM, patrice.chotard@foss.st.com wrote:
> 
>>> + * spi_mem_poll_status() - Poll memory device status
>>> + * @mem: SPI memory device
>>> + * @op: the memory operation to execute
>>> + * @mask: status bitmask to ckeck
>>> + * @match: status expected value
> 
>> Technically, (status & mask) expected value. Dunno if that is obvious 
>> enough to not spell out explicitly.
> 
> Is it possible there's some situation where you're waiting for some bits
> to clear as well?
> 
Yes, we are waiting STATUS_BUSY bit to be cleared, see patch 2 which is making 
usage of this API.

>>> +		ret = ctlr->mem_ops->poll_status(mem, op, mask, match, timeout);
> 
> I'm not sure I like this name since it makes me think the driver is
> going to poll when really it's offloaded to the hardware, but I can't
> think of any better ideas either and it *is* what the hardware is going
> to be doing so meh.
> 
>> I wonder if it is better to let spi-mem core take care of the timeout 
>> part. On one hand it reduces code duplication on the driver side a 
>> little bit. Plus it makes sure drivers don't mess anything up with bad 
>> (or no) handling of the timeout. But on the other hand the interface 
>> becomes a bit awkward since you'd have to pass a struct completion 
>> around, and it isn't something particularly hard to get right either. 
>> What do you think?
> 
> We already have the core handling other timeouts.  We don't pass around
> completions but rather have an API function that the driver has to call
> when the operation completes, a similar pattern might work here.  Part

So, if i correctly understood, you make allusion to what is already done
in SPI core framework with spi_finalize_current_transfer() right ?

> of the thing with those APIs which I'm missing here is that this will
> just return -EOPNOTSUPP if the driver can't do the delay in hardware, I
> think it would be cleaner if this API were similar and the core dealt
> with doing the delay/poll on the CPU.  That way the users don't need to
> repeat the handling for the offload/non-offload cases.

Sorry, i didn't catch what you mean here. In PATCH 2, that's the case,
if spi_mem_poll_status() is not supported, the core is dealing with 
the delay/poll on the CPU in spinand_wait().

Patrice
Thanks


> 

