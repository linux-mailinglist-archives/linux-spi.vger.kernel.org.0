Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5037C465
	for <lists+linux-spi@lfdr.de>; Wed, 12 May 2021 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhELPaw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 May 2021 11:30:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11946 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235024AbhELP0Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 May 2021 11:26:24 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CFNHAn015842;
        Wed, 12 May 2021 17:25:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=wJLJQ5SzNztbYrcDqSHgy2c5s42y5qxKpGMFMYg/TAc=;
 b=Jf+ZLjmYTrNYe2RuYPfvLJ0ntYho5lGTyFYjvJYq0rVJgdzfvM0qiJr+I9DBx+Y7oRuH
 vYGT3zzmu5HSRZ8T2ntD+ovw0XRr9zEX++Y1O8izeynEWSsQoHA8ktOf2sk7MlIiH9r1
 6CcB/ZCy2Jjml/IggDovjJN/wF9PRxR8WzYbsbKx45MGPZLOkEEgOUfeEAuFeZi2MPOE
 emyN5KPsYUdBc9BhhGs00Tm79NBQbydRfT9uQ/yiR0LUJPK6SG9L1P/V7LLy7RBlHYZk
 6eKwF8+Nofe6HR5VKAJsn6XC/E5ZB2M/3y7OrbgOzOjFia0HFB0k2Gf8U3IgvW6bnTT2 xA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38gcfahwb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 17:25:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 05040100034;
        Wed, 12 May 2021 17:25:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E778122B9DB;
        Wed, 12 May 2021 17:24:59 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 17:24:59 +0200
Subject: Re: [PATCH] MAINTAINERS: Add Alain Volmat as STM32 SPI maintainer
To:     Alain Volmat <alain.volmat@foss.st.com>, <broonie@kernel.org>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>
References: <1620796842-23546-1-git-send-email-alain.volmat@foss.st.com>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <6a553a54-ca1f-8fb5-1a50-e29a858798bf@foss.st.com>
Date:   Wed, 12 May 2021 17:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1620796842-23546-1-git-send-email-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_07:2021-05-12,2021-05-12 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 5/12/21 7:20 AM, Alain Volmat wrote:
> Add Alain Volmat as STM32 SPI maintainer.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index de412b9813eb..3d98375ea6f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16981,6 +16981,12 @@ L:	linux-i2c@vger.kernel.org
>   S:	Maintained
>   F:	drivers/i2c/busses/i2c-stm32*
>   
> +ST STM32 SPI DRIVER
> +M:	Alain Volmat <alain.volmat@foss.st.com>
> +L:	linux-spi@vger.kernel.org
> +S:	Maintained
> +F:	drivers/spi/spi-stm32.c
> +
>   ST VL53L0X ToF RANGER(I2C) IIO DRIVER
>   M:	Song Qiang <songqiang1304521@gmail.com>
>   L:	linux-iio@vger.kernel.org
> 

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
