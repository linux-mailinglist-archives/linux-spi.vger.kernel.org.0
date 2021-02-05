Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E871310EA4
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 18:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhBEPoY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 10:44:24 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:45162 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233355AbhBEPmV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 10:42:21 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115HKjfw028480;
        Fri, 5 Feb 2021 18:23:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=+LWNApjAf8DcKkiePDnRirGOK1rD4544v3if96uJetI=;
 b=Sb5L6Qa8IoG8EZ+XqiYmFr4eNa4c0ZCRFecO3z6bft6MLNwxmfw4THXbnCvU26pO/vU0
 Z9Cyz6KVmiPtcYtBRFZu+wIiBaOXjxNaABy6Ce5ugh4MFJrLmkgaStALXaTF+eIeob5m
 5UgpnJSHf1Sr1JWwXCxCxc3WuZNpEX2NZg3dc5eOGSqWIp3OLPMgjVJ8u3ertUnyfdzk
 CAKzySopELWNgsRuuu+kuZl6a7PUcKR30gV6vltvJV8hzLYwlobknUvvWw7RkMxWUPwV
 HJ0lunmQSYRTtIijAibzwxjkAqdaBgOOdNe1lbBFgbkxzGZMtSgvQZNfXW8+e9c9xwlu lA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36ey7hhrah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 18:23:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20ABC10002A;
        Fri,  5 Feb 2021 18:23:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1213025F3FD;
        Fri,  5 Feb 2021 18:23:47 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 18:23:46 +0100
Date:   Fri, 5 Feb 2021 18:23:43 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <amelie.delaunay@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <mcoquelin.stm32@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/8] spi: stm32: defer probe for reset
Message-ID: <20210205172343.GA26795@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
        amelie.delaunay@foss.st.com, linux-kernel@vger.kernel.org,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        mcoquelin.stm32@gmail.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
 <1612523342-10466-6-git-send-email-alain.volmat@foss.st.com>
 <20210205164154.GA8179@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210205164154.GA8179@sirena.org.uk>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

sorry about that, I've just noticed the issue. This is probably due to
modification of patches ordering I did. STM32H7_SPI_TSIZE_MAX is introduced
in the PATCH 6/8 and this is the reason why PATCH 5/8 doesn't build properly.
I'll rework that to ensure that all patches compile properly.

Sorry again,
Alain

On Fri, Feb 05, 2021 at 04:41:54PM +0000, Mark Brown wrote:
> On Fri, Feb 05, 2021 at 12:08:59PM +0100, Alain Volmat wrote:
> > Defer the probe operation when a reset controller device is expected
> > but have not yet been probed.
> > 
> > This change replaces use of devm_reset_control_get_exclusive() with
> > devm_reset_control_get_optional_exclusive() as reset controller is
> > optional which is now explicitly stated.
> 
> This has trouble building an x86 allmodconfig build:
> 
> /mnt/kernel/drivers/spi/spi-stm32.c: In function 'stm32_spi_prepare_msg':
> /mnt/kernel/drivers/spi/spi-stm32.c:1022:9: error: 'STM32H7_SPI_TSIZE_MAX' undeclared (first use in this function); did you mean 'STM32H7_SPI_CR1_MASRX'?
>          STM32H7_SPI_TSIZE_MAX,
>          ^~~~~~~~~~~~~~~~~~~~~
>          STM32H7_SPI_CR1_MASRX
> /mnt/kernel/drivers/spi/spi-stm32.c:1022:9: note: each undeclared identifier is reported only once for each function it appears in
> 
> This may be due to an earlier patch in the series, my script is working
> back through the patch series.


