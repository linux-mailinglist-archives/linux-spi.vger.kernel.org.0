Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12607475C33
	for <lists+linux-spi@lfdr.de>; Wed, 15 Dec 2021 16:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbhLOPuz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 15 Dec 2021 10:50:55 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46749 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbhLOPuy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Dec 2021 10:50:54 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CD618E0003;
        Wed, 15 Dec 2021 15:50:48 +0000 (UTC)
Date:   Wed, 15 Dec 2021 16:50:47 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v3 03/22] dt-bindings: mtd: nand-controller: Harmonize
 the property types
Message-ID: <20211215165047.2d089269@xps13>
In-Reply-To: <YbjYNVOVL/sLda9H@robh.at.kernel.org>
References: <20211207093422.166934-1-miquel.raynal@bootlin.com>
        <20211207093422.166934-4-miquel.raynal@bootlin.com>
        <YbjYNVOVL/sLda9H@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Tue, 14 Dec 2021 11:45:25 -0600:

> On Tue, Dec 07, 2021 at 10:34:03AM +0100, Miquel Raynal wrote:
> > Harmonize the different properties in this file by:
> > * dropping the non-necessary allOf's
> > * always defining the keywords in the following order:
> >     - first: "type"/"$ref",
> >     - second: "description" (when relevant),  
> 
> If we're going to muck with this, really I prefer description first or 
> last and everything else together.

Ok, no problem.

This is just a patch cleaning things up before moving the properties
around anyway.

Can I add your Reviewed-by when sending the updated version? I would
like to merge the first halve of this series soon enough.

> 
> >     - then the other generic keywords ("enum", "default", etc).
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
