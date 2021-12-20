Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD0747B32E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Dec 2021 19:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhLTStC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Dec 2021 13:49:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46712 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhLTStC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Dec 2021 13:49:02 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKImm1A123038;
        Mon, 20 Dec 2021 12:48:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640026128;
        bh=/T1KlvRGCrqJigM5Lsa6ORubwwr2PfFh8APQa+sTe6Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oQAqO9jy1e9zReyLJ8hkKtHz11C1d9K8tdrwsJiL67CpQzZ+jjTaDctos66iPKUeM
         JC7UqkIDwP7MfQmO2Luyj5FkdqkkbgmMrGEBx6MFEsplyJ03Mt6qMNyEhSzxRNjM12
         gnv94putwInfCJA8wAE3A6dwgzq7DQk1FLhnELp8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKImmI7008687
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 12:48:48 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 12:48:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 12:48:48 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKImlDV018502;
        Mon, 20 Dec 2021 12:48:48 -0600
Date:   Tue, 21 Dec 2021 00:18:47 +0530
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
Subject: Re: [PATCH v7 03/14] spi: spi-mem: Check the controller extra
 capabilities
Message-ID: <20211220184845.o4jg2qy5ngt3ekiy@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
 <20211217161654.367782-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217161654.367782-4-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/12/21 05:16PM, Miquel Raynal wrote:
> Controllers can now provide a spi-mem capabilities structure. Let's make
> use of it in spi_mem_controller_default_supports_op(). As we want to
> check for DTR operations as well as normal operations in a single
> helper, let's pull the necessary checks from spi_mem_dtr_supports_op()
> for now.
> 
> However, because no controller provide these extra capabilities, this
> change has no effect so far.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-mem.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index c4da0c9b05e9..677e54221ebc 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -173,11 +173,20 @@ EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
>  bool spi_mem_default_supports_op(struct spi_mem *mem,
>  				 const struct spi_mem_op *op)
>  {
> -	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
> -		return false;
> +	struct spi_controller *ctlr = mem->spi->controller;
> +	bool op_is_dtr =
> +		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
>  
> -	if (op->cmd.nbytes != 1)
> -		return false;
> +	if (op_is_dtr) {
> +		if (!spi_mem_controller_is_capable(ctlr, dtr))
> +			return false;
> +
> +		if (op->cmd.dtr && op->cmd.nbytes != 2)
> +			return false;

As I mentioned in patch 1, you want to do this check for all phases. For 
controllers that do not support mixed DTR modes, this does not allow the 
controller to make sure those ops are rejected. So that check would have 
to then move in the controller's supports_op() before 
spi_mem_default_supports_op() is called.

> +	} else {
> +		if (op->cmd.nbytes != 1)
> +			return false;

Technically speaking there is nothing stopping a device from using 2 or 
3 or even 4 byte opcodes. But that is a different topic that we don't 
really need to look at until the need comes up.

> +	}
>  
>  	return spi_mem_check_buswidth(mem, op);
>  }
> -- 
> 2.27.0
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
