Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823FA339428
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 18:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCLRA6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 12:00:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33758 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhCLRAc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 12:00:32 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12CH08kt121082;
        Fri, 12 Mar 2021 11:00:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615568408;
        bh=zaa/mRSUMAXzQt5H0aezjgMFIyojIQMSj0VLcmmYG0Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZJYQk2vaku81q9JFcftwYrDwiWbZAGlKsxDCS7xolALzY4tOV4aVF0BWT02/gjsTp
         wiE2GWxclQRfYGBLI08wpZYK4vWqCWAfNIIbz7pXQZkZ1gu8Y/UYMWawOwyep9KYhn
         7OqlbC/XkucryFWnndJAdBy0aUZO5x7G+oqOfb3k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12CH07Vl049603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Mar 2021 11:00:08 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 12
 Mar 2021 11:00:07 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 12 Mar 2021 11:00:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12CH06Rj086882;
        Fri, 12 Mar 2021 11:00:07 -0600
Date:   Fri, 12 Mar 2021 22:30:02 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for
 spi-cadence-quadspi
Message-ID: <20210312170000.szh55346o7sm6ase@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <b9450a151cce89cde47b4d6a76c74b32@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b9450a151cce89cde47b4d6a76c74b32@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/03/21 02:32PM, Michael Walle wrote:
> Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> > The main problem here is telling the controller where to find the
> > pattern and how to read it. This RFC uses nvmem cells which point to a
> > fixed partition containing the data to do the reads. It depends on [0]
> > and [1].
> > 
> > The obvious problem with this is it won't work when the partitions are
> > defined via command line. I don't see any good way to add nvmem cells to
> > command line partitions. I would like some help or ideas here. We don't
> > necessarily have to use nvmem either. Any way that can cleanly and
> > consistently let the controller find out where the pattern is stored is
> > good.
> 
> The NXP LS1028A SoC has a similar calibration (although there its done
> in hardware it seems) and there the datasheet mentions there are flash
> devices which supports a preamble before a read function. The preamble
> is then some kind of learning pattern. Did you see a flash which actually
> supports that in the wild? I can't find any publicly available datasheets
> of 8bit I/O SPI NOR flashes.

I haven't seen any such flash but it looks like Tudor has.

> 
> -michael

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
