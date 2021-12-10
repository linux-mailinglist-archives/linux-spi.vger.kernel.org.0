Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6A0470B75
	for <lists+linux-spi@lfdr.de>; Fri, 10 Dec 2021 21:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhLJULO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 10 Dec 2021 15:11:14 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:57891 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhLJULN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Dec 2021 15:11:13 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1B467200003;
        Fri, 10 Dec 2021 20:07:31 +0000 (UTC)
Date:   Fri, 10 Dec 2021 21:07:30 +0100
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
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <20211210210730.07dc672d@xps13>
In-Reply-To: <Ya5++vUkIKXtE1ja@robh.at.kernel.org>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
        <20211206095921.33302-3-miquel.raynal@bootlin.com>
        <Ya5++vUkIKXtE1ja@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Mon, 6 Dec 2021 15:22:02 -0600:

> On Mon, Dec 06, 2021 at 10:59:20AM +0100, Miquel Raynal wrote:
> > Describe two new memories modes:
> > - A stacked mode when the bus is common but the address space extended
> >   with an additinals wires.
> > - A parallel mode with parallel busses accessing parallel flashes where
> >   the data is spread.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/spi/spi-peripheral-props.yaml    | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I am sending a new version of this series so that I can get feedback on
other way of describing the flashes, so I'll drop your tag because I'll
need you to re-check that I'm not doing anything silly (it took me a
while to understand the array vs. matrix logic).

Thanks,
Miquèl
