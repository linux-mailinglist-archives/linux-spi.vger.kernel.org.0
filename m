Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF21757B8
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 10:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgCBJyM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 04:54:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50012 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBJyM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Mar 2020 04:54:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0229rlXE038637;
        Mon, 2 Mar 2020 03:53:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583142827;
        bh=MaPO+Y+GFt8NojyCTT0VA83fEm+Nn1m3L1ToA+6WYhk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=n8wx694Zu850t8rho+LltUhbikx5WUkA5L6N7d1S0Uxo+N7tAk8V8nj0E6CsXohLq
         V0yjLlqMWSuyTlFVIkSZM5CTsb/W7QhWErbHvvYfpoHA9QJCi4pXF5uPoVfTviXUle
         Sw3XNYzuziw8iYcrh0aXMLK5Yy4mY7Rh06njFALE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0229rkWa040407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Mar 2020 03:53:47 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Mar
 2020 03:53:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Mar 2020 03:53:46 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0229rjSg028864;
        Mon, 2 Mar 2020 03:53:46 -0600
Date:   Mon, 2 Mar 2020 15:23:45 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR
 capability
Message-ID: <20200302095343.3yec6inur52vx6bg@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-2-p.yadav@ti.com>
 <20200227171147.32cc6fcf@collabora.com>
 <20200227162842.GE4062@sirena.org.uk>
 <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g@mail.gmail.com>
 <20200227164425.GF4062@sirena.org.uk>
 <CAMuHMdV_1RfGFgDjJYzAnGd_x57zSwjZd8si=UTPp8ksgdwYGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV_1RfGFgDjJYzAnGd_x57zSwjZd8si=UTPp8ksgdwYGA@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 27/02/20 06:03PM, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Thu, Feb 27, 2020 at 5:44 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Feb 27, 2020 at 05:40:31PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Feb 27, 2020 at 5:28 PM Mark Brown <broonie@kernel.org> wrote:
> > > > It's what we do for other properties, and if this is anything like the
> > > > other things adding extra wiring you can't assume that the ability to
> > > > use the feature for TX implies RX.
> >
> > > Double Transfer Rate uses the same wire.
> >
> > But is it still on either the TX or RX signals?
> 
> E.g. good old Spansion S25FL512S supports single/dual/quad DDR, but
> apparently only for read, not write.
> Other FLASHes may support both directions. I guess.

The flash datasheet says under section 9.4 (Read Memory Array Commands):

  Some commands transfer address and data on both the rising edge and 
  falling edge of SCK. These are called Double Data Rate (DDR) commands.

Since the address is transferred in DDR mode, both Tx and Rx signals use 
DDR.

So, unless we have a flash that supports a mode like 1S-1S-8D, we don't 
really need two properties.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
