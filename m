Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D32A47B2FE
	for <lists+linux-spi@lfdr.de>; Mon, 20 Dec 2021 19:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhLTSjx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Dec 2021 13:39:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45632 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbhLTSjp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Dec 2021 13:39:45 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKIdL8P120848;
        Mon, 20 Dec 2021 12:39:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640025561;
        bh=DhGSC8bEQr1M3DMsp0Ai0zt4i1WtjcERkbiYFOKSENo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MYFnfeziksMihSLS2Z7u8goP/fhQ937yFV4aURA27Fy4PP+8yvzl/bGDVnv4gWicv
         2vk8JOYsTxBdXi9sqKVzwMk+M8TvJHPMCmEnVZqa5nORlp+cXuaJGthXhcNBp41TVt
         3bz47er625znAnqZfvsio8Umz6ay9jbZ7xUvear0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKIdLnR126024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 12:39:21 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 12:39:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 12:39:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKIdKvA110518;
        Mon, 20 Dec 2021 12:39:20 -0600
Date:   Tue, 21 Dec 2021 00:09:19 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v7 01/14] spi: spi-mem: Fix a DTR related check in
 spi_mem_dtr_supports_op()
Message-ID: <20211220183917.m3mywavgxsgq7yar@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
 <20211217161654.367782-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217161654.367782-2-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/12/21 05:16PM, Miquel Raynal wrote:
> It seems that the number of command bytes must be "2" only when the
> command itself is sent in DTR mode. The current logic checks if the
> number of command bytes is "2" when any of the cycles is a DTR cycle. It
> is likely that so far no device was actually mixing DTR/non-DTR cycles
> in the same operation, explaining why this was left undetected until
> now.

This was intentional. spi_mem_dtr_supports_op() must only be called when 
the operation is DTR in all phases so I did not add any sanity checks if 
someone was using it for non-DTR ops. In fact, I added on to this 
function in [0] to check nbytes for other phases as well. The patch fell 
off my radar unfortunately, and it didn't get merged.

I would like to keep this as it is since we have no user of mixed 
DTR/non-DTR modes yet. But if you really want to support it, please 
apply my patch first to make sure we check for every phase, not just 
command.

[0] https://lore.kernel.org/all/20210531181757.19458-5-p.yadav@ti.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
