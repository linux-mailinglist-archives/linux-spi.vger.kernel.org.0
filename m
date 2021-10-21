Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271244363C9
	for <lists+linux-spi@lfdr.de>; Thu, 21 Oct 2021 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhJUOLx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 21 Oct 2021 10:11:53 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56153 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUOLw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Oct 2021 10:11:52 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E960C1C0012;
        Thu, 21 Oct 2021 14:09:32 +0000 (UTC)
Date:   Thu, 21 Oct 2021 16:09:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Julien Su <juliensu@mxic.com.tw>,
        linux-spi@vger.kernel.org, Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/18] dt-bindings: mtd: spi-nand: Convert spi-nand
 description file to yaml
Message-ID: <20211021160932.4169f66f@xps13>
In-Reply-To: <1634764487.038982.2962586.nullmailer@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
        <20211020142809.349347-5-miquel.raynal@bootlin.com>
        <1634764487.038982.2962586.nullmailer@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Wed, 20 Oct 2021 16:14:47 -0500:

> On Wed, 20 Oct 2021 16:27:55 +0200, Miquel Raynal wrote:
> > Let's get rid of spi-nand.txt by converting it to yaml schema. While at
> > converting this file, let's actually pull all the generic properties
> > from nand-chip.yaml which might apply to a SPI-NAND chip.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../devicetree/bindings/mtd/spi-nand.txt      |  5 ----
> >  .../devicetree/bindings/mtd/spi-nand.yaml     | 27 +++++++++++++++++++
> >  2 files changed, 27 insertions(+), 5 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
> >  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
> >   
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/nand-chip.yaml'
> xargs: dt-doc-validate: exited with status 255; aborting
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml'
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/nand-chip.yaml'
> make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml] Error 255
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1441: dt_binding_check] Error 2

I am not able to reproduce this error and in general I don't understand
it. There is no relationship between this change and
snps,dw-apb-ssi.yaml. Also the fact that nand-chip-yaml do not exist,
it was just created in the patch before so I wonder how much I should
trust this error.

Also, maybe I am not using the tools properly, but it is very hard to
send correct bindings at the first try. Running make dt_binding_check
takes ages, any change in one yaml file will recheck the entire data
base and filtering out on a single yaml file is generally too
restrictive and still prints unrelated errors of syntax on other files.
I don't know how much of this is actually expected and/or if someone is
working on it.

Thanks,
Miquèl
