Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEF31DDFEB
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 08:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEVGb6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 02:31:58 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:40374 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgEVGb5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 02:31:57 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 04M6Uv0L024143;
        Fri, 22 May 2020 14:30:57 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 392FE906D490C16CE7F1;
        Fri, 22 May 2020 14:30:58 +0800 (CST)
In-Reply-To: <20200519142642.24131-6-p.yadav@ti.com>
References: <20200519142642.24131-1-p.yadav@ti.com> <20200519142642.24131-6-p.yadav@ti.com>
To:     "Pratyush Yadav" <p.yadav@ti.com>
Cc:     "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        "Mark Brown" <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Sekhar Nori" <nsekhar@ti.com>, "Pratyush Yadav" <p.yadav@ti.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>, juliensu@mxic.com.tw
Subject: Re: [PATCH v5 05/19] mtd: spi-nor: add support for DTR protocol
MIME-Version: 1.0
X-KeepSent: AC48157A:F337A12A-48258570:0021F23B;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFAC48157A.F337A12A-ON48258570.0021F23B-48258570.0023CB62@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 22 May 2020 14:30:58 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/05/22 PM 02:30:58,
        Serialize complete at 2020/05/22 PM 02:30:58
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com 04M6Uv0L024143
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Pratyush,


> +/**
> + * spi_nor_spimem_setup_op() - Set up common properties of a spi-mem 
op.
> + * @nor:      pointer to a 'struct spi_nor'
> + * @op:         pointer to the 'struct spi_mem_op' whose properties
> + *         need to be initialized.
> + * @proto:      the protocol from which the properties need to be set.
> + */
> +void spi_nor_spimem_setup_op(const struct spi_nor *nor,
> +              struct spi_mem_op *op,
> +              const enum spi_nor_protocol proto)
> +{
> +   u8 ext;
> +
> +   op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(proto);
> +
> +   if (op->addr.nbytes)
> +      op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
> +
> +   if (op->dummy.nbytes)
> +      op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
> +
> +   if (op->data.nbytes)
> +      op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
> +
> +   if (spi_nor_protocol_is_dtr(proto)) {

As mentioned before that I am also patching mx25* which supports 8S-8S-8S 
and 
8D-8D-8D mode.

please patch to spi_nor_protocol_is_8_8_8(proto) for 8S-8S-8S mode 
support.

> +      /*
> +       * spi-mem supports mixed DTR modes, but right now we can only
> +       * have all phases either DTR or STR. IOW, spi-mem can have
> +       * something like 4S-4D-4D, but spi-nor can't. So, set all 4
> +       * phases to either DTR or STR.
> +       */

        if (spi_nor_protocol_is_8D_8D_8D(proto) {

> +      op->cmd.dtr = op->addr.dtr = op->dummy.dtr
> +                = op->data.dtr = true;
> +
> +      /* 2 bytes per clock cycle in DTR mode. */
> +      op->dummy.nbytes *= 2;

        }

> +
> +      ext = spi_nor_get_cmd_ext(nor, op);
> +      op->cmd.opcode = (op->cmd.opcode << 8) | ext;
> +      op->cmd.nbytes = 2;
> +   }
> +}
> +

thanks & best regards,
Mason


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

