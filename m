Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484AA1DEF19
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgEVSXd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 14:23:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45178 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgEVSXd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 14:23:33 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MIN774009732;
        Fri, 22 May 2020 13:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590171787;
        bh=7meOCcO9PMV0pe9bY/23KTU7Rz1Q8mk5VlyvR5wCnuc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pTQvFN0STMEPQPpZPpmVYr4o6kbNIsw7va17SVHSEGB2jijhOpPHCBpQpble/dVXz
         Ari1n8V9ilSNJt5irlpBbGjzlhlf9kaKRbj5xfz2Ov7Np+v2ZqFyS30huXNNr5zCtN
         qJgFGGdnVwiKmkOD1iz8fjnw6u4VW1554DId/mNw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04MIN73n079237
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 13:23:07 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 13:23:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 13:23:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MIN6kR049061;
        Fri, 22 May 2020 13:23:06 -0500
Date:   Fri, 22 May 2020 23:53:05 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: Re: [PATCH v6 04/19] spi: spi-mem: allow specifying a command's
 extension
Message-ID: <20200522182257.wneqsmfm22farzus@ti.com>
References: <20200520163053.24357-1-p.yadav@ti.com>
 <20200520163053.24357-5-p.yadav@ti.com>
 <20200521202256.5816eb32@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200521202256.5816eb32@collabora.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

On 21/05/20 08:22PM, Boris Brezillon wrote:
> On Wed, 20 May 2020 22:00:38 +0530
> Pratyush Yadav <p.yadav@ti.com> wrote:
> 
> As mentioned in one of my previous review, you should patch the mxic
> driver before extending the opcode field:
> 
> --->8---
> diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> index 69491f3a515d..c3f4136a7c1d 100644
> --- a/drivers/spi/spi-mxic.c
> +++ b/drivers/spi/spi-mxic.c
> @@ -356,6 +356,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
>         int nio = 1, i, ret;
>         u32 ss_ctrl;
>         u8 addr[8];
> +       u8 cmd[2];

Regarding your comment about bisect-ability, how about I change this to:
  
  u8 cmd[sizeof(op->cmd.opcode)];

and put this patch before the change to 2-byte opcodes. This should also 
make it resistent to further changes in opcode size. Does that sound 
like a sane idea?
  
>         ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
>         if (ret)
> @@ -393,7 +394,10 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
>         writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
>                mxic->regs + HC_CFG);
>  
> -       ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, 1);
> +       for (i = 0; i < op->cmd.nbytes; i++)
> +               cmd[i] = op->cmd.opcode >> (8 * (op->cmd.nbytes - i - 1));
> +
> +       ret = mxic_spi_data_xfer(mxic, cmd, NULL, op->cmd.nbytes);
>         if (ret)
>                 goto out;
>  

-- 
Regards,
Pratyush Yadav
Texas Instruments India
