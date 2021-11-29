Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE23461106
	for <lists+linux-spi@lfdr.de>; Mon, 29 Nov 2021 10:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbhK2J2l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 29 Nov 2021 04:28:41 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59953 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242457AbhK2J0k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Nov 2021 04:26:40 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D7499E000B;
        Mon, 29 Nov 2021 09:23:19 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:23:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mtd@lists.infradead.org,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 5/5] spi: dt-bindings: Add an example with two
 stacked flashes
Message-ID: <20211129102319.1efe1841@xps13>
In-Reply-To: <YaO0ahOhM3XwLqND@robh.at.kernel.org>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
        <20211126163450.394861-6-miquel.raynal@bootlin.com>
        <1638054802.100671.1973542.nullmailer@robh.at.kernel.org>
        <YaO0ahOhM3XwLqND@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Sun, 28 Nov 2021 10:55:06 -0600:

> On Sat, Nov 27, 2021 at 04:13:22PM -0700, Rob Herring wrote:
> > On Fri, 26 Nov 2021 17:34:50 +0100, Miquel Raynal wrote:  
> > > Provide an example of how to describe two flashes in eg. stacked mode.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >   
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/spi/spi-controller.example.dts:40.23-45.15: Warning (spi_bus_reg): /example-0/spi@80010000/flash@2,3: SPI bus unit address format error, expected "2"  
> 
> Unit-addresses are based on the first reg entry.

Yes, I believe this error is expected since dtc has not been yet
updated. Below the patch for adapting dtc to this new situation and
keep the robots happy.

How should we proceed?

Thanks,
Miquèl

---

Author: Miquel Raynal <miquel.raynal@bootlin.com>
Date:   Fri Nov 26 16:08:27 2021 +0100

    dtc: checks: spi: Allow describing flashes with two CS
    
    The Xilinx QSPI controller has two advanced modes which allow the
    controller to behave differently and consider two flashes as one single
    storage.
    
    One of these two modes is quite complex to support from a binding point
    of view and is the dual parallel memories. In this mode, each byte of
    data is stored in both devices: the even bits in one, the odd bits in
    the other. The split is automatically handled by the QSPI controller and
    is transparent for the user.
    
    The other mode is simpler to support, it is called dual stacked
    memories. The controller shares the same SPI bus but each of the devices
    contain half of the data. Once in this mode, the controller does not
    follow CS requests but instead internally wires the two CSlevels with
    the value of the most significant address bit.
    
    Supporting these two modes will involve core changes which include the
    possibility of providing two CS for a single SPI device.
    
    Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 781ba1129a8e..4eaa925c3442 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -1094,7 +1094,7 @@ static const struct bus_type spi_bus = {
 
 static void check_spi_bus_bridge(struct check *c, struct dt_info *dti, struct node *node)
 {
-       int spi_addr_cells = 1;
+       int spi_addr_cells = 2;
 
        if (strprefixeq(node->name, node->basenamelen, "spi")) {
                node->bus = &spi_bus;
@@ -1125,7 +1125,7 @@ static void check_spi_bus_bridge(struct check *c, struct dt_info *dti, struct no
 
        if (get_property(node, "spi-slave"))
                spi_addr_cells = 0;
-       if (node_addr_cells(node) != spi_addr_cells)
+       if (node_addr_cells(node) > spi_addr_cells)
                FAIL(c, dti, node, "incorrect #address-cells for SPI bus");
        if (node_size_cells(node) != 0)
                FAIL(c, dti, node, "incorrect #size-cells for SPI bus");
@@ -1137,8 +1137,8 @@ static void check_spi_bus_reg(struct check *c, struct dt_info *dti, struct node
 {
        struct property *prop;
        const char *unitname = get_unitname(node);
-       char unit_addr[9];
-       uint32_t reg = 0;
+       char unit_addr[18];
+       uint32_t reg0 = 0, reg1 = 0;
        cell_t *cells = NULL;
 
        if (!node->parent || (node->parent->bus != &spi_bus))
@@ -1156,11 +1156,17 @@ static void check_spi_bus_reg(struct check *c, struct dt_info *dti, struct node
                return;
        }
 
-       reg = fdt32_to_cpu(*cells);
-       snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
-       if (!streq(unitname, unit_addr))
-               FAIL(c, dti, node, "SPI bus unit address format error, expected \"%s\"",
-                    unit_addr);
+       reg0 = fdt32_to_cpu(cells[0]);
+       snprintf(unit_addr, sizeof(unit_addr), "%x", reg0);
+       if (!streq(unitname, unit_addr)) {
+               reg1 = fdt32_to_cpu(cells[1]);
+               snprintf(unit_addr, sizeof(unit_addr), "%x,%x", reg0, reg1);
+               if (!streq(unitname, unit_addr)) {
+                       FAIL(c, dti, node,
+                            "SPI bus unit address format error, expected \"%s\"",
+                            unit_addr);
+               }
+       }
 }
 WARNING(spi_bus_reg, check_spi_bus_reg, NULL, &reg_format, &spi_bus_bridge);
 

