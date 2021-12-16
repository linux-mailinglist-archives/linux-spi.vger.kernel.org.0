Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7EC476B6E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 09:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhLPIHh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 16 Dec 2021 03:07:37 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60421 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhLPIHg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 03:07:36 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 78D2CE0009;
        Thu, 16 Dec 2021 08:07:31 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:07:30 +0100
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
Message-ID: <20211216090730.17cc5619@xps13>
In-Reply-To: <Ybo/r8neydqTxN6N@sirena.org.uk>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
        <20211214114140.54629-13-miquel.raynal@bootlin.com>
        <20211214172410.2b26c17e@collabora.com>
        <20211215184426.67fd3912@xps13>
        <20211215200548.75630b61@collabora.com>
        <Ybo/r8neydqTxN6N@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris, Mark,

broonie@kernel.org wrote on Wed, 15 Dec 2021 19:19:11 +0000:

> On Wed, Dec 15, 2021 at 08:05:48PM +0100, Boris Brezillon wrote:
> 
> > There's also a second option that doesn't involve patching existing
> > users: add a spi_mem_controller_caps to the spi_controller struct, and
> > check this instance in your spi_mem_default_supports_op()
> > implementation. Note that the buswidth check done in the generic
> > helper is already based on caps exposed by the controller
> > through spi_controller.mode_bits ({RX/TX}_{DUAL,QUAD,OCTAL} bits).  
> 
> This approach is quite nice for things like this - having things as data
> rather than code.  The only issue is if any of the caps end up varying
> by operation and we need different capabilities but that doesn't look
> too likely here I think?

Sure, that's a good idea, I'll look into it.

Thanks,
Miquèl
