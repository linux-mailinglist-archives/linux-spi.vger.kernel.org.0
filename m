Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE97146B64D
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 09:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhLGIrk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 7 Dec 2021 03:47:40 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:39147 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLGIrj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 03:47:39 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 9A91E20000C;
        Tue,  7 Dec 2021 08:44:06 +0000 (UTC)
Date:   Tue, 7 Dec 2021 09:44:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <p.yadav@ti.com>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <monstr@monstr.eu>,
        <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: mtd: spi-nor: Allow two CS per
 device
Message-ID: <20211207094405.6083b141@xps13>
In-Reply-To: <e5d05d00-8823-f9a2-156e-ac0c268d705c@microchip.com>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
        <20211206095921.33302-2-miquel.raynal@bootlin.com>
        <e5d05d00-8823-f9a2-156e-ac0c268d705c@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Tudor,

Tudor.Ambarus@microchip.com wrote on Tue, 7 Dec 2021 07:16:11 +0000:

> Hi, Miquel,
> 
> On 12/6/21 11:59 AM, Miquel Raynal wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > The Xilinx QSPI controller has two advanced modes which allow the
> > controller to behave differently and consider two flashes as one single
> > storage.
> > 
> > One of these two modes is quite complex to support from a binding point
> > of view and is the dual parallel memories. In this mode, each byte of
> > data is stored in both devices: the even bits in one, the odd bits in
> > the other. The split is automatically handled by the QSPI controller and
> > is transparent for the user.
> > 
> > The other mode is simpler to support, it is called dual stacked
> > memories. The controller shares the same SPI bus but each of the devices
> > contain half of the data. Once in this mode, the controller does not
> > follow CS requests but instead internally wires the two CS levels with
> > the value of the most significant address bit.  
> 
> The stacked mode that you describe seems particular to a specific
> vendor. There are multi die NOR flashes which do not require any
> controller intervention, the logic is held at the flash level:
> https://media-www.micron.com/-/media/client/global/documents/products/technical-note/nor-flash/tn2505_n25q_mt25q_stacked_devices.pdf?rev=7a23cc95238e46f7b22e2a9f6bc736b7
> 
> Can you point us to which kind of memories you're willing to add
> support for? Some datasheets will be best.

Unfortunately I don't have any datasheets to propose, I think this mode
must be seen like a controller abstraction of any device with several
physical cs.

The question: "should these properties be common to all devices" is
still open, I don't have a strong opinion, whether we should make these
Xilinx specific, or not. For now they are, but in the near future, it
is not so sure (and my crystal ball is under maintenance ;) ).

Thanks,
Miquèl
