Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AC7382557
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 09:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhEQHbB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 03:31:01 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60780 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230527AbhEQHbB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 03:31:01 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14H7C2Y0012348;
        Mon, 17 May 2021 09:29:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=IBklEhJOoqnRyM5eXyLESodNBjnwwQeXasaYr+V1Hs8=;
 b=AXloOSyjoJBa8hQbEwYVFThW80uykJN6iVPny5RTPDvvzEuUAG2oPtk4xmHFuGF7AoJ1
 aIkKBc+W8RoTown7zPNJmSxbpGK8xeNanQ92dHzxrernkIElpge/31I8CDumzyI3a/0X
 BgvlrEqU9ZJYqvN+7EFaW4yh0DTtvF7H6JWbLPYL6ek+RhL0xfmx/66qFhs/yrAtcUd4
 XnRviqW2iaRTVxSnEz59/QU/vWOIFsV9BJw1ICHfS25lFqvMUuGDmlVxQs83ttA/N6uX
 44PybUlC573C6fw9oCoe5ZMUWbe8GjXDfzK9fxUjzfezG7CIM/4a44x9PTx2ePPGpF0c Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38k5dq34pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 09:29:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4D53100034;
        Mon, 17 May 2021 09:29:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4B34214D36;
        Mon, 17 May 2021 09:29:26 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 May
 2021 09:29:25 +0200
Subject: Re: [PATCH v2 1/3] spi: spi-mem: add automatic poll status functions
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20210507131756.17028-1-patrice.chotard@foss.st.com>
 <20210507131756.17028-2-patrice.chotard@foss.st.com>
 <20210508095506.4d0d628a@collabora.com>
 <542000b4-1a65-5090-72f9-441c75ee1098@foss.st.com>
 <20210510112249.5613978e@collabora.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <48d8774c-9868-27e5-b8b0-fdbf99c84ba2@foss.st.com>
Date:   Mon, 17 May 2021 09:29:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210510112249.5613978e@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_01:2021-05-12,2021-05-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris

On 5/10/21 11:22 AM, Boris Brezillon wrote:
> On Mon, 10 May 2021 10:46:48 +0200
> Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:
> 
>>>   
>>>> +
>>>> +	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
>>>> +		ret = spi_mem_access_start(mem);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		reinit_completion(&ctlr->xfer_completion);
>>>> +
>>>> +		ret = ctlr->mem_ops->poll_status(mem, op, mask, match,
>>>> +						 timeout_ms);
>>>> +
>>>> +		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
>>>> +						 msecs_to_jiffies(timeout_ms));  
>>>
>>> Why do you need to wait here? I'd expect the poll_status to take care
>>> of this wait.  
>>
>> It was a request from Mark Brown [1]. The idea is to implement
>> similar mechanism already used in SPI framework.
> 
> Well, you have to choose, either you pass a timeout to ->poll_status()
> and let the driver wait for the status change (and return -ETIMEDOUT if
> it didn't happen in time), or you do it here and the driver only has to
> signal the core completion object. I think it's preferable to let the
> driver handle the timeout though, because you don't know how the
> status check will be implemented, and it's not like the
> reinit_completion()+wait_for_completion_timeout() done here would
> greatly simplify the drivers wait logic anyway.
> 

Ok i will remove the reinit/wait_completion() as you suggested.
Thanks
Patrice
