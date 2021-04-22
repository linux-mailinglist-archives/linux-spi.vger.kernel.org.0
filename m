Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C774367B23
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhDVHco (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 03:32:44 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51035 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231262AbhDVHcn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Apr 2021 03:32:43 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13M7RMLf020720;
        Thu, 22 Apr 2021 09:31:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=wTJYNLz+GeIRx9UYWWVLcnY81+zxFAKyL59IOj+tgpk=;
 b=LY/jstysQPl3u7xXFTEOpByLaLm1oYHRFir4cFClLkEt75V/f/T5PpCY9HTqIAdPW/c5
 eR7X4IgRsNiaRIoroxxRmMWXfbIsEGDRp97wBeDz0Weny/nZ/ZDzyHtnPUpg4PiKmGgm
 UbiowOdNdV8KQifSXNJD+p5P6uUq7WsHDeQxCrRv5ZRN7GMiqxqMbrswpDnd+UPgp0p8
 9vwcHe0d0wYTqd3dtc7fUfhj2CYc5Jdxf4xHN8P6eGqcK5hQCanarYS2u+aXoJUl5SRz
 DQ0vh5ml/EuoR78PtkbgDo+6xdZm9hfmSwTj1yeB1h1HEvKy0eS58LaenJcLuxLT8cJL mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 382fften23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 09:31:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7CDE310002A;
        Thu, 22 Apr 2021 09:31:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6B5A321F0AA;
        Thu, 22 Apr 2021 09:31:46 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 09:31:45 +0200
Subject: Re: [PATCH] spi: stm32-qspi: fix debug format string
To:     Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210421140653.3964725-1-arnd@kernel.org>
 <20210421150510.GA36785@sirena.org.uk>
 <CAK8P3a0CWp_H-tm2QcZyH1FDXwzMgxY_9dc1Y8pA28MQKT-q=A@mail.gmail.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <b970a557-b869-c867-3825-370a36feef68@foss.st.com>
Date:   Thu, 22 Apr 2021 09:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0CWp_H-tm2QcZyH1FDXwzMgxY_9dc1Y8pA28MQKT-q=A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_01:2021-04-21,2021-04-21 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark, Arnd

Regarding this issue, how do you prefer to proceed ? 

Patrice

On 4/21/21 5:22 PM, Arnd Bergmann wrote:
> On Wed, Apr 21, 2021 at 5:05 PM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Wed, Apr 21, 2021 at 04:06:48PM +0200, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Printing size_t needs a special %zd format modifier to avoid a
>>> warning like:
>>
>> This doesn't apply against current code, please check and resend.
> 
> It appears that you just applied 1b8a7d4282c0 ("spi: stm32-qspi:
> Fix compilation warning in ARM64") after today's linux-next was
> cut.
> 
> I suspect Patrice's patch now causes a warning on all architectures
> on which size_t is defined as 'unsigned int'.
> 
>        Arnd
> 
