Return-Path: <linux-spi+bounces-1125-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6D84C671
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 09:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEEA1F22ACB
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37385FBE5;
	Wed,  7 Feb 2024 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YQ4bdOVX"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1C2231F;
	Wed,  7 Feb 2024 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295387; cv=none; b=BEd8Irouyaz2lAUu5AbEN04AQ7RLEitUr4wLQDhINxamimmrdJxayCFwqSJMZE1o7+4t9w8GTPUduvkuuSHThtDnQC5j/lEbPy9DgnZYh80NbS8uPn1n72zWF9x/BE7IbXm7+t0+BChF4tWNUb3maApbouZyAJqleKtGh8O2rmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295387; c=relaxed/simple;
	bh=iDiKQY8q5ltjX8ENZ+sgq/WXnlBPN6BX7cO0TQvWkuE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N92pZtlz53Dj1X4LuKpy57B2k8GoUvgdpZ5BwyG8bXD1FkCyebRdbZpadtxmOrPjJST8YhQnz2vdxzw7N+4Ytp0IHlKQN9XV5u3/OpbC0rotpLPoOWm4kFQPIbOGW+0HgSdXpZizoLYM+Ozs0JQsp+VJL9roxZ7hnlg3vdQMxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YQ4bdOVX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4178gtpJ061988;
	Wed, 7 Feb 2024 02:42:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707295375;
	bh=G7dgSHhP0N06vgiT4jQE6KpIIh0597u9fGyYroAeJUk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YQ4bdOVXlt+WzrsxXtuMSk+oBRH0991qSeTvqE1UUODSw+Kjowj+C3aE1d4pMyoiL
	 AcR4V7cUvqidoWIzoLJVGvXDjMU8SXnw2LnEN5GxgG7l/gT1TSiUWb8S5zByWAfJDN
	 ydjCuHSF//TJDgEg4Zx2Hh1eHMEqnA7mdLpcSeDU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4178gtZg063646
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 02:42:55 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 02:42:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 02:42:54 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4178gsMH075858;
	Wed, 7 Feb 2024 02:42:54 -0600
Date: Wed, 7 Feb 2024 14:12:53 +0530
From: Dhruva Gole <d-gole@ti.com>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
CC: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT
	<gregory.clement@bootlin.com>,
        Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 2/4] spi: cadence-qspi: fix pointer reference in
 runtime PM hooks
Message-ID: <20240207084253.fxrnoskda5x6usqo@dhruva>
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
 <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Feb 05, 2024 at 15:57:30 +0100, Th�o Lebrun wrote:
> dev_get_drvdata() gets used to acquire the pointer to cqspi and the SPI
> controller. Neither embed the other; this lead to memory corruption.
> 
> On a given platform (Mobileye EyeQ5) the memory corruption is hidden
> inside cqspi->f_pdata. Also, this uninitialised memory is used as a
> mutex (ctlr->bus_lock_mutex) by spi_controller_suspend().
> 
> Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementations")
> Signed-off-by: Th�o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 720b28d2980c..1a27987638f0 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1930,10 +1930,9 @@ static void cqspi_remove(struct platform_device *pdev)
>  static int cqspi_runtime_suspend(struct device *dev)
>  {
>  	struct cqspi_st *cqspi = dev_get_drvdata(dev);
> -	struct spi_controller *host = dev_get_drvdata(dev);

Or you could do:
+	struct spi_controller *host = cqspi->host;

>  	int ret;
>  
> -	ret = spi_controller_suspend(host);
> +	ret = spi_controller_suspend(cqspi->host);

And avoid changing these?

>  	cqspi_controller_enable(cqspi, 0);
>  
>  	clk_disable_unprepare(cqspi->clk);
> @@ -1944,7 +1943,6 @@ static int cqspi_runtime_suspend(struct device *dev)
>  static int cqspi_runtime_resume(struct device *dev)
>  {
>  	struct cqspi_st *cqspi = dev_get_drvdata(dev);
> -	struct spi_controller *host = dev_get_drvdata(dev);
>  
>  	clk_prepare_enable(cqspi->clk);
>  	cqspi_wait_idle(cqspi);
> @@ -1953,7 +1951,7 @@ static int cqspi_runtime_resume(struct device *dev)
>  	cqspi->current_cs = -1;
>  	cqspi->sclk = 0;
>  
> -	return spi_controller_resume(host);
> +	return spi_controller_resume(cqspi->host);

ditto.

Thanks,
Dhruva Gole <d-gole@ti.com>

>  }
>  
>  static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,
> 
> -- 
> 2.43.0
> 
> 


