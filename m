Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DADE465EA9
	for <lists+linux-spi@lfdr.de>; Thu,  2 Dec 2021 08:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbhLBHaA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 2 Dec 2021 02:30:00 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:33511 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbhLBHaA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Dec 2021 02:30:00 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 314DF200005;
        Thu,  2 Dec 2021 07:26:35 +0000 (UTC)
Date:   Thu, 2 Dec 2021 08:26:34 +0100
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
Message-ID: <20211202082634.0592fecf@xps13>
In-Reply-To: <YagL29VKiKZcu7KQ@robh.at.kernel.org>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
        <20211126163450.394861-6-miquel.raynal@bootlin.com>
        <1638054802.100671.1973542.nullmailer@robh.at.kernel.org>
        <YaO0ahOhM3XwLqND@robh.at.kernel.org>
        <20211129102319.1efe1841@xps13>
        <YagL29VKiKZcu7KQ@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Wed, 1 Dec 2021 17:57:15 -0600:

> On Mon, Nov 29, 2021 at 10:23:19AM +0100, Miquel Raynal wrote:
> > Hi Rob,
> > 
> > robh@kernel.org wrote on Sun, 28 Nov 2021 10:55:06 -0600:
> >   
> > > On Sat, Nov 27, 2021 at 04:13:22PM -0700, Rob Herring wrote:  
> > > > On Fri, 26 Nov 2021 17:34:50 +0100, Miquel Raynal wrote:    
> > > > > Provide an example of how to describe two flashes in eg. stacked mode.
> > > > > 
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >     
> > > > 
> > > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > > 
> > > > yamllint warnings/errors:
> > > > 
> > > > dtschema/dtc warnings/errors:
> > > > Documentation/devicetree/bindings/spi/spi-controller.example.dts:40.23-45.15: Warning (spi_bus_reg): /example-0/spi@80010000/flash@2,3: SPI bus unit address format error, expected "2"    
> > > 
> > > Unit-addresses are based on the first reg entry.  
> > 
> > Yes, I believe this error is expected since dtc has not been yet
> > updated. Below the patch for adapting dtc to this new situation and
> > keep the robots happy.
> > 
> > How should we proceed?  
> 
> No, I'm saying you have this wrong. A unit-address is composed of 
> different fields, not different entries of the same field. For 
> example, an external parallel bus has a chip select plus address, so the 
> unit-address is '<cs>,<addr>'. If you have 2 SPI chip selects, that's 2 
> entries of the same thing. The SPI bus is not 2 address cells, but 1 
> cell with 2 entries.

My bad, now I get it, thanks.

Cheers,
Miquèl
