Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8389E1DE4B9
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgEVKqF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 06:46:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34826 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgEVKqF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 06:46:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MAjcHd017015;
        Fri, 22 May 2020 05:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590144338;
        bh=+ZG6P8BF3dJ9QHRvqtMY+fgKzn83Sk8LyDmqXrBTqds=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gZG3x5VZ9tES5/HMESW0XZnj+Gjnop5Bkkzsqrh5ftpSGzE4b//BXjEmxHjCxwZRp
         MYdmEh8a+w5hDkWhmBRW3VmWA9gqKS5UD9RwFKQYFrZl/b8NXFki0AfeZ83Nqb7OBv
         KETO8hkfXGbgdvmch/dSPK1FaA/Hdf7a+E/shLOM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MAjcK1091662;
        Fri, 22 May 2020 05:45:38 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 05:45:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 05:45:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MAjbIc013302;
        Fri, 22 May 2020 05:45:37 -0500
Date:   Fri, 22 May 2020 16:15:36 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <masonccyang@mxic.com.tw>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <juliensu@mxic.com.tw>
Subject: Re: [PATCH v5 01/19] spi: spi-mem: allow specifying whether an op is
 DTR or not
Message-ID: <20200522104536.4ikmhiaxg7keahdp@ti.com>
References: <20200519142642.24131-1-p.yadav@ti.com>
 <20200519142642.24131-2-p.yadav@ti.com>
 <OF1FE36FB9.9FBEFCD6-ON4825856F.002D767F-4825856F.002E7D42@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OF1FE36FB9.9FBEFCD6-ON4825856F.002D767F-4825856F.002E7D42@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[Seems like I forgot to send this and it stayed in my Drafts folder. 
Anyway, fixed in v7]

Hi Mason,

On 21/05/20 04:27PM, masonccyang@mxic.com.tw wrote:
> 
> Hi Pratyush,
> 
> Given cmd.nbytes a initial value & check it !
> 
> > 
> > [PATCH v5 01/19] spi: spi-mem: allow specifying whether an op is DTR or 
> not
> > 
> > Each phase is given a separate 'dtr' field so mixed protocols like
> > 4S-4D-4D can be supported.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/spi/spi-mem.c       | 3 +++
> >  include/linux/spi/spi-mem.h | 8 ++++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index 9a86cc27fcc0..93e255287ab9 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -156,6 +156,9 @@ bool spi_mem_default_supports_op(struct spi_mem 
> *mem,
> >                 op->data.dir == SPI_MEM_DATA_OUT))
> >        return false;
> > 
> > +   if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
> > +      return false;
> > +
> 
> +       if (op->cmd.nbytes != 1)
> +               return false;

Good catch. Will fix.
 
> >     return true;
> >  }
> >  EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
> 
> 
>  static int spi_mem_check_op(const struct spi_mem_op *op)
>  {
> -                if (!op->cmd.buswidth)
> +                if (!op->cmd.buswidth || op->cmd.nbytes < 1 || 
> op->cmd.nbytes > 2)
>                                  return -EINVAL;

Will fix.
 
> 
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index af9ff2f0f1b2..e3dcb956bf61 100644
> > --- a/include/linux/spi/spi-mem.h
> > +++ b/include/linux/spi/spi-mem.h
> 
> #define SPI_MEM_OP_CMD(__opcode, __buswidth)                    \
>          {                                                       \
>                  .buswidth = __buswidth,                         \
>                  .opcode = __opcode,                             \
> +                .nbytes = 1,                                    \
>          }

Will fix. Thanks.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
