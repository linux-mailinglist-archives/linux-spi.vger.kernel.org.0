Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF89387CCD
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245284AbhERPu0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 11:50:26 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60983 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245015AbhERPu0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 11:50:26 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IFdFL9004337;
        Tue, 18 May 2021 17:48:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=x8rk4SF8kUA9lhdRyqORx0Hd48/7Wmd859uaIYQogP8=;
 b=kv4K43tO4C1zplxFDnyeWJau3vyR+Z596aA0Q7/dnzf8URn32MUzKeBxueu7VK+Kj2gM
 VCbYRSJMEa27L58x/BifhZmKeQC5v7kSpNwuxi+VvaxbUsArah1PtynF74fSlyI+2NqC
 E+dufxOxh1Ywwd8DT8D+utAvmUECxCdtFfJ0nfASR34hEmU2C1SKi89vb+vapSYN7LEv
 dLMZZUDbW4k+sM7BfGSj18NFdDPFC+WxvLr6Rrf/WaICczsfvmogOciJAi5FncHJ6k2u
 3wWtbru2Jq6X+j/y0MR7+82odg+1rRWkg//WySUFID1G4055o/0M4miblz3vTl3LUore dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38maunt66k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 17:48:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A90C10002A;
        Tue, 18 May 2021 17:48:49 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3508F231DCF;
        Tue, 18 May 2021 17:48:49 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.46) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May
 2021 17:48:48 +0200
Subject: Re: [PATCH v4 3/3] spi: stm32-qspi: add automatic poll status feature
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
References: <20210518134332.17826-1-patrice.chotard@foss.st.com>
 <20210518134332.17826-4-patrice.chotard@foss.st.com>
 <20210518163707.0e6bd120@collabora.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <e0abdaf9-0f30-91a3-7cd4-c0e4140d6aa4@foss.st.com>
Date:   Tue, 18 May 2021 17:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518163707.0e6bd120@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_08:2021-05-18,2021-05-18 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 5/18/21 4:37 PM, Boris Brezillon wrote:
> On Tue, 18 May 2021 15:43:32 +0200
> <patrice.chotard@foss.st.com> wrote:
> 
>> +static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *op,
>> +				  u16 mask, u16 match,
>> +				  unsigned long initial_delay_us,
>> +				  unsigned long polling_rate_us,
>> +				  unsigned long timeout_ms)
>> +{
>> +	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
>> +	int ret;
>> +
> 
> The spi_mem_supports_op() call is still missing.

Yes, i forgot it

Thanks
Patrice

> 
>> +	ret = pm_runtime_get_sync(qspi->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(qspi->dev);
>> +		return ret;
>> +	}
>> +
>> +	mutex_lock(&qspi->lock);
>> +
>> +	writel_relaxed(mask, qspi->io_base + QSPI_PSMKR);
>> +	writel_relaxed(match, qspi->io_base + QSPI_PSMAR);
>> +	qspi->fmode = CCR_FMODE_APM;
>> +	qspi->status_timeout = timeout_ms;
>> +
>> +	ret = stm32_qspi_send(mem, op);
>> +	mutex_unlock(&qspi->lock);
>> +
>> +	pm_runtime_mark_last_busy(qspi->dev);
>> +	pm_runtime_put_autosuspend(qspi->dev);
>> +
>> +	return ret;
>> +}
