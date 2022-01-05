Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1771C484DD2
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jan 2022 06:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiAEFx2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jan 2022 00:53:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55892 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiAEFx1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jan 2022 00:53:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2055r0Ad001334;
        Tue, 4 Jan 2022 23:53:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641361980;
        bh=/WMiPucFmgFtZ2e4Rr8TyX/mCLA1MdVKUZrRErTD3Es=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=j6msjA9nyx23L4TJshzpZD9mEJWM85Y2JaFXcDAqnKzYQjGmA9FtvZwtozIsYsW9q
         wlSLCg0oQO11Agwr+tZgOBUbZylx7PJHMwZCci0uzFmuBG6tlt2PjFCSAqlpuv2/Hf
         yavt3uAYuioTXHOAbw6XBggbFN1Lp1IGEgxeK7BE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2055r04q046086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jan 2022 23:53:00 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 4
 Jan 2022 23:53:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 4 Jan 2022 23:52:59 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2055qxsA031870;
        Tue, 4 Jan 2022 23:52:59 -0600
Date:   Wed, 5 Jan 2022 11:22:58 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 01/13] spi: spi-mem: Introduce a capability structure
Message-ID: <20220105055256.whshpo2pdbqfkzuh@ti.com>
References: <20220104083631.40776-1-miquel.raynal@bootlin.com>
 <20220104083631.40776-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220104083631.40776-2-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/01/22 09:36AM, Miquel Raynal wrote:
> Create a spi_controller_mem_caps structure and put it within the
> spi_controller structure close to the spi_controller_mem_ops
> strucure. So far the only field in this structure is the support for dtr
> operations, but soon we will add another parameter.
> 
> Also create a helper to parse the capabilities and check if the
> requested capability has been set or not.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
