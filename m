Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7239A1DD594
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgEUSFj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 14:05:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60216 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgEUSFi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 14:05:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LI5DJV011706;
        Thu, 21 May 2020 13:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590084313;
        bh=cBsuSs5XQOpsuV0CecqCZ/lRLSi2so73QLU1KFL+2mY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FLO65yzDuTlgGUCUQ7nHNXlT4uLcDc+hgAhVu0jeL9+geY1C0p7coynxs+WK7Yu4L
         5vfHTjmN/KIWEdxbxN9I7BNVIGKnhOE79nr2G2S12qpCrHDKkJmUrUQpU3E5ZdUUkT
         lQJX9Q/39W1YZJQEGY1SkXFUnmB9PZtZVZzCicMU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LI5DiY012172;
        Thu, 21 May 2020 13:05:13 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 13:05:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 13:05:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LI5CJE066205;
        Thu, 21 May 2020 13:05:12 -0500
Date:   Thu, 21 May 2020 23:35:11 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: Re: [PATCH v6 00/19] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20200521180511.4axjf46g6b25mp3k@ti.com>
References: <20200520163053.24357-1-p.yadav@ti.com>
 <20200521163957.GG4770@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200521163957.GG4770@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 21/05/20 05:39PM, Mark Brown wrote:
> On Wed, May 20, 2020 at 10:00:34PM +0530, Pratyush Yadav wrote:
> > Hi,
> > 
> > This series adds support for octal DTR flashes in the spi-nor framework,
> > and then adds hooks for the Cypress Semper and Mircom Xcella flashes to
> > allow running them in octal DTR mode. This series assumes that the flash
> > is handed to the kernel in Legacy SPI mode.
> 
> Are people happy with the SPI bits of this from a MTD point of view?  I
> don't have any concerns and could apply them on a branch even if more
> revisions are needed for the MTD side.

There were a couple small changes suggested for spi-mem. Will send a 
re-roll in a few minutes.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
