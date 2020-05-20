Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB25A1DACC7
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 10:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgETIAb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 04:00:31 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:37646 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETIAa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 May 2020 04:00:30 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 04K7xUdE096136;
        Wed, 20 May 2020 15:59:30 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id B9D79C5271EE9FAE1410;
        Wed, 20 May 2020 15:59:30 +0800 (CST)
In-Reply-To: <20200519142642.24131-10-p.yadav@ti.com>
References: <20200519142642.24131-1-p.yadav@ti.com> <20200519142642.24131-10-p.yadav@ti.com>
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
Subject: Re: [PATCH v5 09/19] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
MIME-Version: 1.0
X-KeepSent: 83616464:480FA751-4825856E:002A4483;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF83616464.480FA751-ON4825856E.002A4483-4825856E.002BE6AF@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 20 May 2020 15:59:31 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/05/20 PM 03:59:30,
        Serialize complete at 2020/05/20 PM 03:59:30
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 04K7xUdE096136
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Pratyush, 

> +/**
> + * spi_nor_parse_profile1() - parse the xSPI Profile 1.0 table
> + * @nor:      pointer to a 'struct spi_nor'
> + * @param_header:   pointer to the 'struct sfdp_parameter_header' 
describing
> + *         the 4-Byte Address Instruction Table length and version.
> + * @params:      pointer to the 'struct spi_nor_flash_parameter' to be.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_parse_profile1(struct spi_nor *nor,
> +              const struct sfdp_parameter_header *profile1_header,
> +              struct spi_nor_flash_parameter *params)
> +{
> +   u32 *table, opcode, addr;
> +   size_t len;
> +   int ret, i;
> +
> +   len = profile1_header->length * sizeof(*table);
> +   table = kmalloc(len, GFP_KERNEL);
> +   if (!table)
> +      return -ENOMEM;
> +
> +   addr = SFDP_PARAM_HEADER_PTP(profile1_header);
> +   ret = spi_nor_read_sfdp(nor, addr, len, table);
> +   if (ret)
> +      goto out;
> +
> +   /* Fix endianness of the table DWORDs. */
> +   for (i = 0; i < profile1_header->length; i++)
> +      table[i] = le32_to_cpu(table[i]);
> +
> +   /* Get 8D-8D-8D fast read opcode and dummy cycles. */
> +   opcode = FIELD_GET(PROFILE1_DWORD1_RD_FAST_CMD, table[0]);
> +
> +   /*
> +    * Update the fast read settings. We set the default dummy cycles to 
20
> +    * here. Flashes can change this value if they need to when enabling
> +    * octal mode.
> +    */
> +   spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
> +              0, 20, opcode,
> +              SNOR_PROTO_8_8_8_DTR);
> +


I thought we have a agreement that only do parse here, no other read 
parameters setting.

Driver should get dummy cycles used for various frequencies 
from 4th and 5th DWORD of xSPI table.[1]
 
[1] 
https://patchwork.ozlabs.org/project/linux-mtd/patch/1587451187-6889-3-git-send-email-masonccyang@mxic.com.tw/ 


In addition, 20 dummy cycles is for 200MHz but not for 100MHz, 133MHz and 
166MHz
in case of read performance concern.

Given a correct dummy cycles for a specific device. [2] 

[2] 
https://patchwork.ozlabs.org/project/linux-mtd/patch/1587451187-6889-5-git-send-email-masonccyang@mxic.com.tw/ 



> +   /*
> +    * Set the Read Status Register dummy cycles and dummy address 
bytes.
> +    */
> +   if (table[0] & PROFILE1_DWORD1_RDSR_DUMMY)
> +      params->rdsr_dummy = 8;
> +   else
> +      params->rdsr_dummy = 4;
> +
> +   if (table[0] & PROFILE1_DWORD1_RDSR_ADDR_BYTES)
> +      params->rdsr_addr_nbytes = 4;
> +   else
> +      params->rdsr_addr_nbytes = 0;
> +
> +out:
> +   kfree(table);
> +   return ret;
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

