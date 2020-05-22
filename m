Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1331DE22C
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgEVIiF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 04:38:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50460 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbgEVIiD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 04:38:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04M8bcmh118407;
        Fri, 22 May 2020 03:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590136658;
        bh=yF4xwwVycaty1YYtrvz7tn0azR2eb+OYgNKHjKytnkc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LCwSPwdXFLyyOmJwtl+CdoShpJ5fp9tEao2X9/zf2kbnHkrfB6daeZc+naZsHvv10
         kiw+7ivb0aZ9ids8iQc7RtWrDqU/qMfeuR0E1icglIzgqW8EySon+4xkhX8cnKfZl5
         zCPoF810ubD13ZCtI79ERZZo13Wjwa8lPZlnB+gI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04M8bc0U071990
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 03:37:38 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 03:37:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 03:37:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04M8baqV054658;
        Fri, 22 May 2020 03:37:37 -0500
Date:   Fri, 22 May 2020 14:07:36 +0530
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
Subject: Re: [PATCH v5 05/19] mtd: spi-nor: add support for DTR protocol
Message-ID: <20200522083734.hs4wmfplch7icecv@ti.com>
References: <20200519142642.24131-1-p.yadav@ti.com>
 <20200519142642.24131-6-p.yadav@ti.com>
 <OFAC48157A.F337A12A-ON48258570.0021F23B-48258570.0023CB62@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OFAC48157A.F337A12A-ON48258570.0021F23B-48258570.0023CB62@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/05/20 02:30PM, masonccyang@mxic.com.tw wrote:
> 
> Hi Pratyush,
> 
> 
> > +/**
> > + * spi_nor_spimem_setup_op() - Set up common properties of a spi-mem 
> op.
> > + * @nor:      pointer to a 'struct spi_nor'
> > + * @op:         pointer to the 'struct spi_mem_op' whose properties
> > + *         need to be initialized.
> > + * @proto:      the protocol from which the properties need to be set.
> > + */
> > +void spi_nor_spimem_setup_op(const struct spi_nor *nor,
> > +              struct spi_mem_op *op,
> > +              const enum spi_nor_protocol proto)
> > +{
> > +   u8 ext;
> > +
> > +   op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(proto);
> > +
> > +   if (op->addr.nbytes)
> > +      op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
> > +
> > +   if (op->dummy.nbytes)
> > +      op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
> > +
> > +   if (op->data.nbytes)
> > +      op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
> > +
> > +   if (spi_nor_protocol_is_dtr(proto)) {
> 
> As mentioned before that I am also patching mx25* which supports 8S-8S-8S 
> and 
> 8D-8D-8D mode.
> 
> please patch to spi_nor_protocol_is_8_8_8(proto) for 8S-8S-8S mode 
> support.

Like I said before, we should try to avoid creeping up the scope of this 
series. This series aims to add 8D support. Once this lands, I don't see 
why you can't 8S support on top. Unless we make a fundamental change 
that makes it impossible to add 8S support, it should stay as-is.

All that said, I fail to see why 8S would have any problems with this 
function. We just fill in the buswidths from the protocol, and adjust 
the op if it is DTR. So in case of 8S mode, this function as it is will 
fill in the buswidths to 8 for all phases. And it won't hit the if block 
here so this code is of no concern to 8S mode.
 
> > +      /*
> > +       * spi-mem supports mixed DTR modes, but right now we can only
> > +       * have all phases either DTR or STR. IOW, spi-mem can have
> > +       * something like 4S-4D-4D, but spi-nor can't. So, set all 4
> > +       * phases to either DTR or STR.
> > +       */
> 
>         if (spi_nor_protocol_is_8D_8D_8D(proto) {

No. The adjustments below apply to _all_ DTR ops, not just 8D-8D-8D 
ones. So in case someone wants to use 4D-4D-4D mode, they won't have to 
touch this code at all.
 
> > +      op->cmd.dtr = op->addr.dtr = op->dummy.dtr
> > +                = op->data.dtr = true;
> > +
> > +      /* 2 bytes per clock cycle in DTR mode. */
> > +      op->dummy.nbytes *= 2;
> 
>         }
> 
> > +
> > +      ext = spi_nor_get_cmd_ext(nor, op);
> > +      op->cmd.opcode = (op->cmd.opcode << 8) | ext;
> > +      op->cmd.nbytes = 2;
> > +   }
> > +}
> > +

-- 
Regards,
Pratyush Yadav
Texas Instruments India
