Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9C3B80AA
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhF3KNY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 06:13:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22388 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233959AbhF3KNY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Jun 2021 06:13:24 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UA6khj016476;
        Wed, 30 Jun 2021 12:10:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=AaMW5guJyM9rrWLGwovSkn6cyMpP8PMNR7duyIEQJ58=;
 b=fDMTM7DZq0BMclC4XSEwNFhCjNN+K0ndPMpiIvIrPSKzpGUUPdfC/E/2oWpdLBfzGtqc
 PJhIoXRogEnOZQP5Nn8aZ9MNl35HWooLPkkacd23cbKEJp3j5faHN+6JHP3Vd2Ib9P41
 Me/U07xzrr7bTvlymsjqX57VtYKclWGsrumBOkBRCDTClTmBcsL2WVk3YxGvwymqHuwJ
 jBVJi9DnHHI7y1xdpXZ18Q4FHyk+TwMav96e1myVX74hYWgETUUXvX2r45+qcWlcK0ha
 8b1A/HgCdL0uuc3QVRo3CE/uXJH2lwf2sOYuBpmDWHjfnMSwcQrenJtHRtFMNA5E2aJQ SQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39ghqhv9hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 12:10:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 61EFE10002A;
        Wed, 30 Jun 2021 12:10:33 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 512E8221787;
        Wed, 30 Jun 2021 12:10:33 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Jun
 2021 12:10:32 +0200
Subject: Re: [PATCH 0/6] spi: stm32: various fixes & cleanup
To:     Alain Volmat <alain.volmat@foss.st.com>, <broonie@kernel.org>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>
References: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <5008768a-5647-ea57-c772-6d783704f292@foss.st.com>
Date:   Wed, 30 Jun 2021 12:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_02:2021-06-29,2021-06-30 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/30/21 10:45 AM, Alain Volmat wrote:
> This series contains fixes & cleanup mainly regarding fifo
> and the way end of transfer triggered, when used with or
> without DMA.
> An additional patch cleans up the pm_runtime calls.
> 
> Alain Volmat (5):
>    spi: stm32: fixes pm_runtime calls in probe/remove
>    spi: stm32h7: fix full duplex irq handler handling
>    Revert "spi: stm32: properly handle 0 byte transfer"
>    spi: stm32h7: don't wait for EOT and flush fifo on disable
>    spi: stm32: finalize message either on dma callback or EOT
> 
> Amelie Delaunay (1):
>    spi: stm32h7: rework rx fifo read function
> 
>   drivers/spi/spi-stm32.c | 146 +++++++++++++++++-----------------------
>   1 file changed, 61 insertions(+), 85 deletions(-)
> 

For the whole series,

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Thanks Alain!

Regards,
Amelie
