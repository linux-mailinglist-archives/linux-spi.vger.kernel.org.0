Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20B534002E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Mar 2021 08:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCRHXC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Mar 2021 03:23:02 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:16758 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhCRHWy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Mar 2021 03:22:54 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I7LtGj001011;
        Thu, 18 Mar 2021 08:22:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=pDW8yn2SZ/DbGcux/g2wzgkS5pR7fc1/nVjggeXN9tw=;
 b=cOvalR7kVeuzluO4TYFTsP0yBenXFghs20yQGwLlev3XFJs5ykKpZ6EuamiFVPcR0OcL
 4f2YSr9VHO5E2YosblW+rSUsLUQ4TPfoJ2M25HJ6IFFi3hrQcXmPlFIHAg63A0QX6n0Y
 lWizRwePjQUY9W37o0sPuRn8oPy+w9Bamq1mFIKtl5WtvpVQvvZiFMdbf6c06wAkYcEO
 oONTv0XQKWdnBqCdEITxTD/06Nqq56sgR9Bj31iI21OMt/W9hdxLfw8xtDBFgNVQQz6G
 zAKcZ2KbrClLLcmNo2SFTSTtkU1v997EqEYbTVJleSQApCGnZxcYKqY/KwWcxLCEhJa+ Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 378pr63nqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 08:22:43 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6038D100034;
        Thu, 18 Mar 2021 08:22:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D156220FAA;
        Thu, 18 Mar 2021 08:22:42 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Mar
 2021 08:22:41 +0100
Date:   Thu, 18 Mar 2021 08:22:38 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <antonio.borneo@foss.st.com>
Subject: Re: [PATCH] spi: stm32: drop devres version of spi_register_master
Message-ID: <20210318072238.GA10567@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Lukas Wunner <lukas@wunner.de>, broonie@kernel.org,
        amelie.delaunay@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@foss.st.com, antonio.borneo@foss.st.com
References: <1615545286-5395-1-git-send-email-alain.volmat@foss.st.com>
 <20210316211744.GA25311@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210316211744.GA25311@wunner.de>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_02:2021-03-17,2021-03-18 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lukas,

On Tue, Mar 16, 2021 at 10:17:44PM +0100, Lukas Wunner wrote:
> On Fri, Mar 12, 2021 at 11:34:46AM +0100, Alain Volmat wrote:
> > --- a/drivers/spi/spi-stm32.c
> > +++ b/drivers/spi/spi-stm32.c
> > @@ -1960,6 +1960,7 @@ static int stm32_spi_remove(struct platform_device *pdev)
> >  	struct spi_master *master = platform_get_drvdata(pdev);
> >  	struct stm32_spi *spi = spi_master_get_devdata(master);
> >  
> > +	spi_unregister_master(master);
> >  	spi->cfg->disable(spi);
> >  
> >  	if (master->dma_tx)
> 
> This introduces a use-after-free because spi_unregister_master()
> drops the last reference on the spi_master allocation (which includes
> the struct stm32_spi), causing it to be freed, yet the stm32_spi
> struct is accessed afterwards.

Indeed. Thanks. I've fixed that and will post it.

> You need to convert the driver to devm_spi_alloc_master() to
> fix the use-after-free.  See commit 6cfd39e212de for an example.
> 
> Thanks,
> 
> Lukas
