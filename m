Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6E642B989
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 09:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhJMHvs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 03:51:48 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:59884 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbhJMHvr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 03:51:47 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 19D7OIYj019580;
        Wed, 13 Oct 2021 15:24:18 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 19D7NkaN019186;
        Wed, 13 Oct 2021 15:23:46 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 4B960207F6AF699EF3AD;
        Wed, 13 Oct 2021 15:23:47 +0800 (CST)
In-Reply-To: <OF86339F0C.88E145E3-ON4825876D.002567AA-4825876D.002569D9@LocalDomain>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com> <20211008162228.1753083-10-miquel.raynal@bootlin.com> <OF86339F0C.88E145E3-ON4825876D.002567AA-4825876D.002569D9@LocalDomain>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Brown" <broonie@kernel.org>,
        "Xiangsheng Hou" <Xiangsheng.Hou@mediatek.com>,
        "Boris Brezillon" <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaimeliao@mxic.com.tw,
        juliensu@mxic.com.tw,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>
Subject: =?Big5?B?UmU6IKZeq0g6IFtSRkMgUEFUQ0ggMDkvMTBdIHNwaTogbXhpYzogQWRk?=
 =?Big5?B?IHN1cHBvcnQgZm9yIGRpcmVjdCBtYXBwaW5n?=
MIME-Version: 1.0
X-KeepSent: 2120B7BA:FA9EA9F2-4825876D:002705BD;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OF2120B7BA.FA9EA9F2-ON4825876D.002705BD-4825876D.0028A142@mxic.com.tw>
From:   zhengxunli@mxic.com.tw
Date:   Wed, 13 Oct 2021 15:23:47 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/10/13 PM 03:23:47,
        Serialize complete at 2021/10/13 PM 03:23:47
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 19D7NkaN019186
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> Implement the ->dirmap_create() and ->dirmap_read/write() hooks to
> provide a fast path for read and write accesses.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-mxic.c | 171 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 144 insertions(+), 27 deletions(-)

Hi Miquel,

I verified it by reading, writing, and erasing through normal and quad 
modes
on the Xilinx Zynq PicoZed FPGA board. Except for the need to update the 
SPI
MXIC driver version, it looks good.

Tested-by: Zhengxun Li <zhengxunli@mxic.com.tw>
Reviewed-by: Zhengxun Li <zhengxunli@mxic.com.tw>



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

