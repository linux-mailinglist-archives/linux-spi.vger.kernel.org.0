Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354A9477477
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 15:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhLPO1Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 16 Dec 2021 09:27:24 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37673 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbhLPO1Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 09:27:24 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6F35CFF804;
        Thu, 16 Dec 2021 14:27:19 +0000 (UTC)
Date:   Thu, 16 Dec 2021 15:27:17 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v5 12/13] spi: mxic: Use spi_mem_generic_supports_op()
Message-ID: <20211216152717.30774928@xps13>
In-Reply-To: <YbtHYtcYsyrl5HaR@sirena.org.uk>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
        <20211214114140.54629-13-miquel.raynal@bootlin.com>
        <20211214172410.2b26c17e@collabora.com>
        <20211215184426.67fd3912@xps13>
        <20211215200548.75630b61@collabora.com>
        <Ybo/r8neydqTxN6N@sirena.org.uk>
        <20211216100147.46c307ff@xps13>
        <20211216105739.395a174d@xps13>
        <YbtHYtcYsyrl5HaR@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Thu, 16 Dec 2021 14:04:18 +0000:

> On Thu, Dec 16, 2021 at 10:57:39AM +0100, Miquel Raynal wrote:
> 
> > Actually as the spi-mem.h header is not included in spi.h, it makes
> > defining a static mem_caps entry harder. I'll go for another approach.
> > Maybe putting the capabilities within the spi_controller_mem_ops
> > structure, as these are highly related.  
> 
> Yeah, or putting a pointer to a static declaration of the caps in there
> rather than the caps directly.

Yeah, that's what I ended up doing. Each controller driver supporting
mem-ops must provide a capabilities structure. Drivers without specific
capabilities can just reference the static &spi_mem_no_caps struct
instead of defining their empty one.

Thanks,
Miquèl
