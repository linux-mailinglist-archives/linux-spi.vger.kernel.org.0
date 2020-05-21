Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FB71DCD50
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 14:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgEUMwx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 08:52:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43508 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgEUMww (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 08:52:52 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LCqQBM073519;
        Thu, 21 May 2020 07:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590065547;
        bh=HhdS0k1uvFyYcnFyKdAE7u2FGKBzACV32jA6ddp5U90=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=B6AX0BmewPmUOKJI5DJ3cIZn+mQtSxDXO9Avzp912H0DIeRRFYLdBCq5F1P0K/PX7
         ZBFr4KNidcljuogeJKGXNVIzLhPqoT8rUaNRB9jQktX4F+5LUYW8hpz+7HKo+ea875
         9xBCwVXNAZY05h0iL5muyCMfD/8jR9tAittuvtXQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LCqQkD089935
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 07:52:26 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 07:52:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 07:52:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LCqPlK071033;
        Thu, 21 May 2020 07:52:26 -0500
Date:   Thu, 21 May 2020 18:22:25 +0530
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
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v5 05/19] mtd: spi-nor: add support for DTR protocol
Message-ID: <20200521125225.odxcdjkoy5lckrbx@ti.com>
References: <20200519142642.24131-1-p.yadav@ti.com>
 <20200519142642.24131-6-p.yadav@ti.com>
 <OF6C754784.29BF11CD-ON4825856F.0032D83F-4825856F.0033A4F1@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OF6C754784.29BF11CD-ON4825856F.0032D83F-4825856F.0033A4F1@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 21/05/20 05:24PM, masonccyang@mxic.com.tw wrote:
> 
> Hi Pratyush,
> 
> 
> > @@ -311,6 +313,7 @@ struct flash_info {
> >                  * BP3 is bit 6 of status register.
> >                  * Must be used with SPI_NOR_4BIT_BP.
> >                  */
> > +#define SPI_NOR_OCTAL_DTR_READ   BIT(19) /* Flash supports octal DTR 
> Read. */
> 
> #define SPI_NOR_OCTAL_DTR_RDWR  BIT(19) /* Support Octal DTR Read & Write 
> */

This flag only enables SNOR_HWCAPS_READ_8_8_8_DTR. It does not affect 
SNOR_HWCAPS_PP_8_8_8_DTR. So it shouldn't be called RDWR.
 
> more precisely and clearly ?
> 
> thanks,
> Mason
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
