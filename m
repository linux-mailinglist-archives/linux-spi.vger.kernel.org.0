Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA31E87B
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 08:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbfEOGrf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 02:47:35 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:47370 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfEOGrf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 02:47:35 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x4F6k794019550;
        Wed, 15 May 2019 14:46:07 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 8F91689F5AB5F1D369B3;
        Wed, 15 May 2019 14:46:07 +0800 (CST)
In-Reply-To: <20190512142835.4caddc8e@xps13>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-2-git-send-email-masonccyang@mxic.com.tw> <20190512142835.4caddc8e@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        geert@linux-m68k.org, juliensu@mxic.com.tw, lee.jones@linaro.org,
        liang.yang@amlogic.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, paul.burton@mips.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 1/4]  mfd: Add Macronix MX25F0A MFD controller driver
MIME-Version: 1.0
X-KeepSent: 4F52243F:0954FF8C-482583FB:0023B249;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF4F52243F.0954FF8C-ON482583FB.0023B249-482583FB.00252E6F@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 15 May 2019 14:46:07 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/15 PM 02:46:07,
        Serialize complete at 2019/05/15 PM 02:46:07
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x4F6k794019550
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Miquel,

 
> > Add a driver for Macronix MX25F0A multifunction device controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  drivers/mfd/Kconfig              |   9 ++
> >  drivers/mfd/Makefile             |   1 +
> >  drivers/mfd/mxic-mx25f0a.c       |  84 +++++++++++++++++++
> >  include/linux/mfd/mxic-mx25f0a.h | 175 
+++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 269 insertions(+)
> >  create mode 100644 drivers/mfd/mxic-mx25f0a.c
> >  create mode 100644 include/linux/mfd/mxic-mx25f0a.h
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 26ad646..7e99e93 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -823,6 +823,15 @@ config MFD_MAX8998
> >       additional drivers must be enabled in order to use the 
functionality
> >       of the device.
> > 
> > +config MFD_MXIC_MX25F0A
> > +   tristate "Macronix mx25f0a multifunction device support"
> > +   select MFD_CORE
> > +   help
> > +     This supports for Macronix mx25f0a multifunction device 
controller
> > +     for raw nand or spi. You have to select individual components 
like
> 
> Please use upper case for acronyms in plain English: NAND, SPI

okay, will fix.

And I also would like to remove "mx25f0a" char.

patch to:
------------------------------------------------------------------------
config MFD_MXIC_FMC
   tristate "Macronix Flash Memory Controller support"
   select MFD_CORE
   help
     This supports Macronix Flash Memory Controller for raw NAND and SPI.
     You have to select individual components like raw NAND controller
     or SPI host controller under the corresponding  menus.
-------------------------------------------------------------------------

thanks for your review.

best regards,
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

