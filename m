Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4B1DC9F6
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgEUJZA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 05:25:00 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:57049 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgEUJZA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 05:25:00 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 04L9O5xV009999;
        Thu, 21 May 2020 17:24:05 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 625C4A326BAAEB7806BC;
        Thu, 21 May 2020 17:24:06 +0800 (CST)
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
        "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH v5 05/19] mtd: spi-nor: add support for DTR protocol
MIME-Version: 1.0
X-KeepSent: 6C754784:29BF11CD-4825856F:0032D83F;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF6C754784.29BF11CD-ON4825856F.0032D83F-4825856F.0033A4F1@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Thu, 21 May 2020 17:24:05 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/05/21 PM 05:24:06,
        Serialize complete at 2020/05/21 PM 05:24:06
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 04L9O5xV009999
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Pratyush,


> @@ -311,6 +313,7 @@ struct flash_info {
>                  * BP3 is bit 6 of status register.
>                  * Must be used with SPI_NOR_4BIT_BP.
>                  */
> +#define SPI_NOR_OCTAL_DTR_READ   BIT(19) /* Flash supports octal DTR 
Read. */

#define SPI_NOR_OCTAL_DTR_RDWR  BIT(19) /* Support Octal DTR Read & Write 
*/

more precisely and clearly ?

thanks,
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

