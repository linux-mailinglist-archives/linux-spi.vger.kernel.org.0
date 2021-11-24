Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47A845C5AC
	for <lists+linux-spi@lfdr.de>; Wed, 24 Nov 2021 14:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353286AbhKXN7w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 24 Nov 2021 08:59:52 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:37749 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352984AbhKXN5v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Nov 2021 08:57:51 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 22E4A24000A;
        Wed, 24 Nov 2021 13:54:36 +0000 (UTC)
Date:   Wed, 24 Nov 2021 14:54:35 +0100
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/18] dt-bindings: mtd: spi-nand: Convert spi-nand
 description file to yaml
Message-ID: <20211124145435.4bd01001@xps13>
In-Reply-To: <YXM84oCOAr6pSOw2@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
        <20211020142809.349347-5-miquel.raynal@bootlin.com>
        <1634764487.038982.2962586.nullmailer@robh.at.kernel.org>
        <20211021160932.4169f66f@xps13>
        <YXM84oCOAr6pSOw2@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Fri, 22 Oct 2021 17:36:18 -0500:

> On Thu, Oct 21, 2021 at 04:09:32PM +0200, Miquel Raynal wrote:
> > Hi Rob,
> > 
> > robh@kernel.org wrote on Wed, 20 Oct 2021 16:14:47 -0500:
> >   
> > > On Wed, 20 Oct 2021 16:27:55 +0200, Miquel Raynal wrote:  
> > > > Let's get rid of spi-nand.txt by converting it to yaml schema. While at
> > > > converting this file, let's actually pull all the generic properties
> > > > from nand-chip.yaml which might apply to a SPI-NAND chip.
> > > > 
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  .../devicetree/bindings/mtd/spi-nand.txt      |  5 ----
> > > >  .../devicetree/bindings/mtd/spi-nand.yaml     | 27 +++++++++++++++++++
> > > >  2 files changed, 27 insertions(+), 5 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > > >     
> > > 
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/nand-chip.yaml'
> > > xargs: dt-doc-validate: exited with status 255; aborting
> > > make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml'
> > > Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/nand-chip.yaml'
> > > make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml] Error 255
> > > make[1]: *** Waiting for unfinished jobs....
> > > make: *** [Makefile:1441: dt_binding_check] Error 2  
> > 
> > I am not able to reproduce this error and in general I don't understand
> > it. There is no relationship between this change and
> > snps,dw-apb-ssi.yaml. Also the fact that nand-chip-yaml do not exist,
> > it was just created in the patch before so I wonder how much I should
> > trust this error.  
> 
> I think you can ignore this. The prior patch should have been applied, 
> but looks like it wasn't. My script's patch applying logic is not what 
> I'd call robust.

Ok, I understand what's happening behind the scenes, no problem with
this.

> 
> > Also, maybe I am not using the tools properly, but it is very hard to
> > send correct bindings at the first try. Running make dt_binding_check
> > takes ages, any change in one yaml file will recheck the entire data
> > base and filtering out on a single yaml file is generally too
> > restrictive and still prints unrelated errors of syntax on other files.  
> 
> Do you set 'DT_SCHEMA_FILES'? That will check just the schema you set 
> it to. You still need to not set it at the end because any schema could 
> apply to any example, so we have to check everything.

Actually I think this is what could be enhanced: when I use
DT_SCHEMA_FILES the output is always polluted with errors with nothing
(at least from my user point of view) related to the files I am
working on. See [1] for an example of output that I found hard to parse
for errors related to my changes: I am looking for issues in
nand-chip.yaml and (50 seconds later) I get warnings for:
- ilitek,ili9341.yaml
- snps,dwcmshc-sdhci.yaml
- ti,sn65dsi83.yaml
- nxp,dwmac-imx.yaml
- fsl,imx6q-pcie.yaml

Do you think the reporting can be improved?

> Also using DT_SCHEMA_FILES should be a bit faster with what's queued for 
> 5.16.

Great!

> 
> > I don't know how much of this is actually expected and/or if someone is
> > working on it.  
> 
> Due to python startup times being slow, it turns out to generally be 
> faster to not have make track changes and do things incrementally. 
> That's why all the schema are checked at once (though sharded with 
> xargs). So I'm not really sure there's much we can do. I've certainly 
> investigated it.

I understand it's not that easy and takes a lot of time, thanks anyway
for all your work on this topic.

Thanks,
Miquèl

[1]
$ time make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/mtd/nand-chip.yaml
  LINT    Documentation/devicetree/bindings
./Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
/home/mraynal/macronix/linux/Documentation/devicetree/bindings/pci/: properties:interrupt-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'msi'}] is too short
	False schema does not allow 1
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/home/mraynal/macronix/linux/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml: properties:reg: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'Offset and length of the register set for the device'}] is too short
	False schema does not allow 1
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/home/mraynal/macronix/linux/Documentation/devicetree/bindings/display/bridge/: properties:ports:properties:port@0:properties:endpoint:properties:data-lanes: {'required': ['maxItems']} is not allowed for {'description': 'array of physical DSI data lane indexes.', 'minItems': 1, 'maxItems': 4, 'items': [{'const': 1}, {'const': 2}, {'const': 3}, {'const': 4}]}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/home/mraynal/macronix/linux/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml: properties:ports:properties:port@1:properties:endpoint:properties:data-lanes: {'required': ['maxItems']} is not allowed for {'description': 'array of physical DSI data lane indexes.', 'minItems': 1, 'maxItems': 4, 'items': [{'const': 1}, {'const': 2}, {'const': 3}, {'const': 4}]}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/home/mraynal/macronix/linux/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml: properties:clocks: {'required': ['maxItems']} is not allowed for {'minItems': 3, 'maxItems': 5, 'items': [{'description': 'MAC host clock'}, {'description': 'MAC apb clock'}, {'description': 'MAC timer clock'}, {'description': 'MAC RGMII TX clock'}, {'description': 'EQOS MEM clock'}]}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
/home/mraynal/macronix/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml: ignoring, error in schema: properties: interrupt-names
warning: no schema found in file: ./Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
/home/mraynal/macronix/linux/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml: ignoring, error in schema: properties: reg
warning: no schema found in file: ./Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
/home/mraynal/macronix/linux/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml: ignoring, error in schema: properties: ports: properties: port@0: properties: endpoint: properties: data-lanes
warning: no schema found in file: ./Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
/home/mraynal/macronix/linux/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml: ignoring, error in schema: properties: clocks
warning: no schema found in file: ./Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
  DTEX    Documentation/devicetree/bindings/mtd/nand-chip.example.dts
  DTC     Documentation/devicetree/bindings/mtd/nand-chip.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/mtd/nand-chip.example.dt.yaml

real	0m38,958s
user	0m51,604s
sys	0m0,632s
