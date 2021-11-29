Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9225446116D
	for <lists+linux-spi@lfdr.de>; Mon, 29 Nov 2021 10:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245498AbhK2Jzo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 29 Nov 2021 04:55:44 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40961 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347390AbhK2Jxm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Nov 2021 04:53:42 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 52A52E000D;
        Mon, 29 Nov 2021 09:50:21 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:50:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/20] External ECC engines & Macronix support
Message-ID: <20211129105020.00233264@xps13>
In-Reply-To: <YaDrjkjfK/y/n+BO@sirena.org.uk>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
        <YaDjDhOhpHMdxiqA@sirena.org.uk>
        <20211126151059.10c19ec7@xps13>
        <YaDrjkjfK/y/n+BO@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Fri, 26 Nov 2021 14:13:34 +0000:

> On Fri, Nov 26, 2021 at 03:10:59PM +0100, Miquel Raynal wrote:
> 
> > If you acknowledge the SPI bits I believe I can carry the entire series
> > through the MTD tree. If you fear conflicts and need an immutable tag I
> > can also do that.  
> 
> It'd be good to have the tag just in case, there's generally a lot of
> work in this area.

Sure.

> Reviewed-by: Mark Brown <broonie@kernel.org>

I'll need to send a v3, shall I add this tag to all the spi and spi binding changes?

Thanks,
Miquèl
