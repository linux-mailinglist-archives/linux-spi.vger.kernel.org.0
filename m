Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CB747B34D
	for <lists+linux-spi@lfdr.de>; Mon, 20 Dec 2021 19:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbhLTS7A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Dec 2021 13:59:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36374 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbhLTS67 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Dec 2021 13:58:59 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKIwhTO005478;
        Mon, 20 Dec 2021 12:58:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640026723;
        bh=AKdr7jyMz7gRpPAjrABem0B3PL3aJ+32yCdhKQS2QVY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uwtHvDyW2t1LptjKMzt1V6qQIIDoeJ+2LpAXHAMWYYDj7Kw0zCWwmo4rRMz4Psy4r
         8R6LYpPcLVs+t757QCHv4FALvgwgkZW4ztiZHvyiiOaa9CCf4ItZMfGW0oORBEuKIJ
         t/zl1sgXQvuUWaGt/DjaEt1nPPRrbkIV6p/qvw7c=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKIwhIJ008405
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 12:58:43 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 12:58:43 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 12:58:43 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKIwgGi016575;
        Mon, 20 Dec 2021 12:58:43 -0600
Date:   Tue, 21 Dec 2021 00:28:42 +0530
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
Subject: Re: [PATCH v7 06/14] spi: spi-mem: Kill the
 spi_mem_dtr_supports_op() helper
Message-ID: <20211220185840.ox5hs44hej6nhkxo@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
 <20211217161654.367782-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217161654.367782-7-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/12/21 05:16PM, Miquel Raynal wrote:
> Now that spi_mem_default_supports_op() has access to the static
> controller capabilities (related to memory operations), and now that
> these capabilities have been filled by the impacted controllers, there
> is no need for a specific helper checking only DTR operations, so let's
> just kill spi_mem_dtr_supports_op() and simply use
> spi_mem_default_supports_op() instead.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c |  5 +----
>  drivers/spi/spi-mem.c             | 10 ----------
>  drivers/spi/spi-mxic.c            | 10 +---------
>  include/linux/spi/spi-mem.h       | 11 -----------
>  4 files changed, 2 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> index e137b1ec85d4..67d05ee8d6a0 100644
> --- a/drivers/spi/spi-mxic.c
> +++ b/drivers/spi/spi-mxic.c
> @@ -335,8 +335,6 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
>  static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
>  				     const struct spi_mem_op *op)
>  {
> -	bool all_false;
> -
>  	if (op->data.buswidth > 8 || op->addr.buswidth > 8 ||
>  	    op->dummy.buswidth > 8 || op->cmd.buswidth > 8)
>  		return false;
> @@ -348,13 +346,7 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
>  	if (op->addr.nbytes > 7)
>  		return false;
>  
> -	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
> -		    !op->data.dtr;
> -
> -	if (all_false)
> -		return spi_mem_default_supports_op(mem, op);
> -	else
> -		return spi_mem_dtr_supports_op(mem, op);
> +	return spi_mem_default_supports_op(mem, op);

Does this controller support mixed DTR modes? If it doesn't then it 
should reject mixed DTR ops before calling 
spi_mem_default_supports_op(). Anyway, the current driver doesn't check 
for it either so this change does not make anything worse at the very 
least.

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>


-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
