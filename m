Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EFF38779E
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhERL37 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 07:29:59 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:16774 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240850AbhERL36 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 07:29:58 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IBMvhb005094;
        Tue, 18 May 2021 13:28:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=jIHeIpLexvh71jo95l2Q1zRybn6F6JJrMnWG91BQdYI=;
 b=W/PyzKsyKG1YtdseKpWomCRLeDWCe5BgGmTwczcvDKNlNKSoesN+prfkb16Qqq3cjsFm
 6vC2W47RWwvxz4s85LCw3hnyiYzKjnnurfLPxtYI/Qrt4xoLlxnweIUvjh9Fp8XNSZds
 LdpEP12+jF5gLgNiPjuTXdn7Zb8q0DCMh3Wo55hGdootAcGzCY96gt5pV3tdhDAY9beL
 6cF1Imso3LE8RVc88R35MHnbxuurovfwK8ggPS1o0UzcjqB8TLEeh3LuQWiCNI7arBac
 MD4T7ZpEQljQolMZnlhrj4bQIO/RTPv+4zWqSD/o8OMlTGNvcAqg9LDUoAF08HRoOjPz 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38maunrpw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 13:28:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E110D10002A;
        Tue, 18 May 2021 13:28:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CC51C221F77;
        Tue, 18 May 2021 13:28:25 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May
 2021 13:28:24 +0200
Subject: Re: [PATCH v3 0/3] MTD: spinand: Add spi_mem_poll_status() support
To:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <christophe.kerello@foss.st.com>
References: <20210518093951.23136-1-patrice.chotard@foss.st.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <b4fb34ad-b70f-b8b9-3fcb-09dd812acfa9@foss.st.com>
Date:   Tue, 18 May 2021 13:28:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518093951.23136-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_04:2021-05-18,2021-05-18 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Just saw a missing update, i am sending a v4.
Sorry
Patrice

On 5/18/21 11:39 AM, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> This series adds support for the spi_mem_poll_status() spinand
> interface.
> Some QSPI controllers allows to poll automatically memory 
> status during operations (erase, read or write). This allows to 
> offload the CPU for this task.
> STM32 QSPI is supporting this feature, driver update are also
> part of this series.
> 
> Chnages in v3:
>   - Add spi_mem_read_status() which allows to read 8 or 16 bits status.
>   - Add initial_delay_us and polling_delay_us parameters to spi_mem_poll_status().
>     and also to poll_status() callback.
>   - Move spi_mem_supports_op() in SW-based polling case.
>   - Add delay before invoquing read_poll_timeout().
>   - Remove the reinit/wait_for_completion() added in v2.
>   - Add initial_delay_us and polling_delay_us parameters to spinand_wait().
>   - Add SPINAND_READ/WRITE/ERASE/RESET_INITIAL_DELAY_US and
>     SPINAND_READ/WRITE/ERASE/RESET_POLL_DELAY_US defines.
>   - Remove spi_mem_finalize_op() API added in v2.
> 
> Changes in v2:
>   - Indicates the spi_mem_poll_status() timeout unit
>   - Use 2-byte wide status register
>   - Add spi_mem_supports_op() call in spi_mem_poll_status()
>   - Add completion management in spi_mem_poll_status()
>   - Add offload/non-offload case management in spi_mem_poll_status()
>   - Optimize the non-offload case by using read_poll_timeout()
>   - mask and match stm32_qspi_poll_status()'s parameters are 2-byte wide
>   - Make usage of new spi_mem_finalize_op() API in
>     stm32_qspi_wait_poll_status()
> 
> Patrice Chotard (3):
>   spi: spi-mem: add automatic poll status functions
>   mtd: spinand: use the spi-mem poll status APIs
>   spi: stm32-qspi: add automatic poll status feature
> 
>  drivers/mtd/nand/spi/core.c  | 45 +++++++++++++------
>  drivers/spi/spi-mem.c        | 85 ++++++++++++++++++++++++++++++++++++
>  drivers/spi/spi-stm32-qspi.c | 83 +++++++++++++++++++++++++++++++----
>  include/linux/mtd/spinand.h  | 11 ++++-
>  include/linux/spi/spi-mem.h  | 14 ++++++
>  5 files changed, 216 insertions(+), 22 deletions(-)
> 
