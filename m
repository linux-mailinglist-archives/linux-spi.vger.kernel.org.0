Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93B647B346
	for <lists+linux-spi@lfdr.de>; Mon, 20 Dec 2021 19:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhLTSzn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Dec 2021 13:55:43 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59766 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbhLTSzm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Dec 2021 13:55:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKItKea023931;
        Mon, 20 Dec 2021 12:55:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640026520;
        bh=P7JkFi+LBZjD9ILv70AdUzMgiXN4qffn1W2EvwhJXps=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=q0yd/O/h55zMvGkSk554wZTDxkNrcec8sMdPeAmlHcrtPEnLgeXaqPJ/hHBMTMwKO
         aB3p69eb5YjJ272zMK62BVeez3txQCHIezmHkfF9K0h3WyyzyNJN0i03p0YDCuvBG8
         2XG8L82r1Jh7XnnT8PzRoUPe9DWhTZhEBPoIcm3g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKItKab004062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 12:55:20 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 12:55:20 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 12:55:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKItIJQ127935;
        Mon, 20 Dec 2021 12:55:19 -0600
Date:   Tue, 21 Dec 2021 00:25:18 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v7 04/14] spi: cadence: Provide a capability structure
Message-ID: <20211220185515.wujhgn66mnwns7bw@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
 <20211217161654.367782-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217161654.367782-5-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> Subject: [PATCH v7 04/14] spi: cadence: Provide a capability structure

s/cadence/cadence-quadspi/

On 17/12/21 05:16PM, Miquel Raynal wrote:
> This controller has DTR support, so advertize it with a capability now
> that the spi_controller_mem_ops structure contains this new field. This
> will later be used by the core to discriminate whether an operation is
> supported or not, in a more generic way than having different helpers.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 101cc71bffa7..98e0cc4236e3 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1388,10 +1388,15 @@ static const char *cqspi_get_name(struct spi_mem *mem)
>  	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
>  }
>  
> +static const struct spi_controller_mem_caps cqspi_mem_caps = {
> +	.dtr = true,
> +};
> +
>  static const struct spi_controller_mem_ops cqspi_mem_ops = {
>  	.exec_op = cqspi_exec_mem_op,
>  	.get_name = cqspi_get_name,
>  	.supports_op = cqspi_supports_mem_op,
> +	.caps = &cqspi_mem_caps,

I just noticed you put it under struct spi_mem_ops, not under struct 
spi_mem. This is not an operation per se so wouldn't it be better if it 
is moved to struct spi_mem?

Anyway, the change itself looks good to me. The cqspi_supports_mem_op()
already checks for mixed DTR modes so we should be good.

>  };
>  
>  static int cqspi_setup_flash(struct cqspi_st *cqspi)
> -- 
> 2.27.0
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
