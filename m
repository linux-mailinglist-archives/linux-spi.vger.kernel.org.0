Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260861CE223
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 20:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbgEKSBg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 14:01:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42296 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgEKSBf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 14:01:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04BI1JcN074891;
        Mon, 11 May 2020 13:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589220079;
        bh=4hUaTl/w7V55aG/pzRHCWNRooX3Cd6J39x6QfIzCmS8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GGEICkGv2Gv87Dluudb293qzSwzPaLlh6xLIGeNSFwS5M7/uN8DkoHUW34FAVrJlU
         wJ89Lgft6U/1kQoqCexYtNg4RzOjO8uEx/yV67lsxUOh05Pt/4PUpFdOoITGzjAi1J
         Q69o29d9FVvUZ7FSYiloNfGSUZgggZKo3+DW5Opg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04BI1JMc123744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 13:01:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 May 2020 13:01:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 May 2020 13:01:19 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04BI1IO4038165;
        Mon, 11 May 2020 13:01:19 -0500
Date:   Mon, 11 May 2020 23:31:17 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>
Subject: Re: [PATCH v4 12/16] mtd: spi-nor: perform a Soft Reset on shutdown
Message-ID: <20200511180115.zpbfecwdeuhy5qzr@ti.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <20200424184410.8578-13-p.yadav@ti.com>
 <6809202.hICg0JTlGu@192.168.0.120>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6809202.hICg0JTlGu@192.168.0.120>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/05/20 11:22AM, Tudor.Ambarus@microchip.com wrote:
> Hi, Pratyush,
> 
> On Friday, April 24, 2020 9:44:06 PM EEST Pratyush Yadav wrote:
> > A Software Reset sequence will return the flash to Power-on-Reset (POR)
> > state. It consists of two commands: Soft Reset Enable and Soft Reset.
> > 
> > Perform a Soft Reset on shutdown on flashes that support it so that the
> > flash can be reset to its initial state and any configurations made by
> > spi-nor (given that they're only done in volatile registers) will be
> > reset. This will hand back the flash in pristine state for any further
> > operations on it.
> 
> Please don't introduce SPI_NOR_SOFT_RESET yet. We should instead determine the 
> software reset sequence by inspecting BFPT[16], bits 13:8.
 
 Ok. Will do.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
