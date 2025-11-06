Return-Path: <linux-spi+bounces-11077-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E894C3AC19
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 13:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444CF4FE448
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9D031771E;
	Thu,  6 Nov 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr52+QHn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252153168E7
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430182; cv=none; b=Idau8k9H925/hbQZ6++qAe3fBJgdm7834n/ey7Jr80WEDR4EDVtEKqwrgUUoyVOaY+YIuyeDkePP6rIs1B05zXoT046h/1yUNobY32+vsj0BbaII9G/hB0nzYl3Hb/9V+AFG0ExienrduvCGQYnH7iUrU0AEaVrP1rtlq8TKqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430182; c=relaxed/simple;
	bh=a2/7I/F4c2uHPgBW13dEJ79Ju9qZZw2dDBdoOEP/vI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxqlsqT4JLCjJOYvOXSSa08p7JLolVfugahwmLIdZVILRkQuRcG0mVoCAc2NdVALMoEmdkniwOuoK5kyNGLr5Sapo0XFgNNlBWV2BV42MhVpx1b4u0rJI/rxsQc84qeNumyFaCBo8FKu6Sxo3/+1GZORKjCSYxwddlRGhvqj3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr52+QHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF51C4CEFB
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762430181;
	bh=a2/7I/F4c2uHPgBW13dEJ79Ju9qZZw2dDBdoOEP/vI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xr52+QHnX1nvMrzZS1JKLVUCvDK5B1Lnr8v0PV7ljIDgiaQT1C04CWTkJrQEG5m+o
	 Srh8H4685ZEXiIq3DW0urY1ETrVPA4+cxC/78shYgV6XiikJw5AXyVsZdvpQY8L3aA
	 WJFfSvaq6x6VdzTkSYGrX8XwjoXmKhsFDwAtAzKdGDGoZo4CSd5KCfPhIYDZt0IoXO
	 LbIhwq/fJ+hwe0K+9RfhcJ/d+23GNuF7CpXzTGaVMXgiv6oVFTtOX5QCMMDY7J2lvK
	 S5xf1v+Is9FcXP5DEDoToYrMMDask6Rc0M2yg1r0/U/JcgnJoDmmrqVQ+dLuZLrQp8
	 Rs3HzNt0zXJag==
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbddd71c46so386411137.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 03:56:21 -0800 (PST)
X-Gm-Message-State: AOJu0YxSsDIrMpPBeyLJ+uR5Y4xMB3oy9xWJTlLy0ywunw+Jv4X1CUv/
	DRCBQWnq3NeLjpyBEAdf6x2Ti5mUmKPGLqPIYq04VWg7Ukelo6j9GhxR5802EZi2kPplhmDq3zC
	9JT+/2M2+d6TT07BRfLfKugbLlksvTiA=
X-Google-Smtp-Source: AGHT+IG1kNSkfurcd1DH5f/2Pr7cyDoTH/Fu1RKhlww67IRA/omxJAzSBiYdKyl+7dvqcGscg/nG5lOAv78diRs/wvs=
X-Received: by 2002:a05:6102:3eca:b0:525:33a9:c71 with SMTP id
 ada2fe7eead31-5dd894c29f5mr2363638137.24.1762430180455; Thu, 06 Nov 2025
 03:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ea5e6915f997d4f1482cb8ab16c81e4406b224a3.camel@hazent.com>
 <CAPybu_1w+Jnt5YjLKhcP0cThyVg5a=ZNYL7dG+4pR=6cQUdGhw@mail.gmail.com> <a4cb5c7727ff15efed53af0ec07b4f7f3135adc0.camel@hazent.com>
In-Reply-To: <a4cb5c7727ff15efed53af0ec07b4f7f3135adc0.camel@hazent.com>
From: Ricardo Ribalda Delgado <ribalda@kernel.org>
Date: Thu, 6 Nov 2025 12:56:02 +0100
X-Gmail-Original-Message-ID: <CAPybu_1U7Wns0Cm7Qxc_noZfiesn293CM1yDeTnQttPxyMPMng@mail.gmail.com>
X-Gm-Features: AWmQ_bmng5HXIKSAIUv7ysMhRixRAC1-cmJ7LRUkVe5RCJP5X4GY1Kp6fUI7uUk
Message-ID: <CAPybu_1U7Wns0Cm7Qxc_noZfiesn293CM1yDeTnQttPxyMPMng@mail.gmail.com>
Subject: Re: spi-xilinx.c: Xilinx axi_quad_spi "Detected stall. Check
 C_SPI_MODE and C_SPI_MEMORY" in spidev mode and in spi-nor with MT25QL02G
To: =?UTF-8?B?w4FsdmFybyBHLiBNLg==?= <alvaro.gamez@hazent.com>
Cc: linux-spi@vger.kernel.org, Michal Simek <michal.simek@amd.com>, 
	Mark Brown <broonie@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alvaro

On Thu, Nov 6, 2025 at 12:35=E2=80=AFPM =C3=81lvaro G. M. <alvaro.gamez@haz=
ent.com> wrote:
>
> Hi Ricardo!
>
> On Wed, 2025-11-05 at 16:21 +0100, Ricardo Ribalda Delgado wrote:
> > Hi Alvaro
> >
> >
> > On Wed, Nov 5, 2025 at 3:28=E2=80=AFPM =C3=81lvaro G. M. <alvaro.gamez@=
hazent.com> wrote:
> > >
> > > Xilinx axi_quad_spi "Detected stall. Check C_SPI_MODE and C_SPI_MEMOR=
Y" in
> > > spidev mode and in spi-nor with MT25QL02G
> > >
> > > Hi,
> > >
> > > We're making a new version of a PCB we had back in 2016 which used ke=
rnel 4.4
> > > and we are now upgrading to 6.12 series. The board fits an xc7100t fp=
ga from
> > > Xilinx, which is running a microblaze soft-core and has two axi_quad_=
spi cores.
> > >
> > > The first of them, in Quad mode is connected to an spi-nor flash, whi=
le the
> > > second spi core is used to interface with two adc3442 from Texas Inst=
ruments
> > > from userspace, so I patch spidev.c to include a line for the device =
tree as
> > > ti,adc344x.
> > >
> >
> > Do you know the C_SPI_MODE and C_SPI_MEMORY C_PARAMs of both cores?
>
> Yes, the SPI dedicated to the ADC is just set in Standard mode (C_SPI_MOD=
E=3D0),
> and C_SPI_MEMORY=3D1, but this value shouldn't apply since there's no fla=
sh
> attached here, right?
>
> The flash dedicated SPI has C_SPI_MODE =3D> 2, C_SPI_MEMORY =3D> 2, which
> correspond to QUAD mode and Micron(Numonyx) values. It's the same
> configuration we use in the PCB with the mt25ql128 flash, but now we have
> an mt25ql02g. Shouldn't be that different, but I haven't compared datashe=
ets.

If my memory is correct, the value of C_SPI_MEMORY was used by the
core to know which SPI codes worked in quad/dual/single.

>
>
> >
> >
> > > The old PCB used an mt25ql128 flash, while the new version uses MT25Q=
L02G. My
> > > intent is to upgrade the software for both PCBs.
> > >
> > > - The SPIDEV problem
> > >
> > > The first issue that I've noticed is that spidev device detects an st=
all in
> > > the new kernel, as whenever I access /dev/spidev1.0 or /dev/spidev1.1=
 to
> > > configure one of the ADCs, the following message is generated, and re=
ading
> > > from the ADC fails (I'm not sure about writes though, since I can't r=
eadback
> > > what I sent, but from the behaviour of the ADC regarding its sampling
> > > functionality, it could very be properly receiving writes):
> > >
> > > spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > > spidev spi1.0: SPI transfer failed: -5
> > > spi_master spi1: failed to transfer one message from queue
> > > spi_master spi1: noqueue transfer failed
> > >
> > > This stall detection was introduced just a little after 4.4 which I w=
as using
> > > before. The explanation, however, seems to talk only about spi-nor pr=
obing,
> > > which is not the case since I'm using spidev.
> > >
> > > commit 5a1314fa697fc65cefaba64cd4699bfc3e6882a6
> > > Author: Ricardo Ribalda <ribalda@kernel.org>
> > > Date:   Tue Nov 21 10:09:02 2017 +0100
> > >
> > >     spi: xilinx: Detect stall with Unknown commands
> > >
> > >     When the core is configured in C_SPI_MODE > 0, it integrates a
> > >     lookup table that automatically configures the core in dual or qu=
ad mode
> > >     based on the command (first byte on the tx fifo).
> > >
> > >     Unfortunately, that list mode_?_memoy_*.mif does not contain all =
the
> > >     supported commands by the flash.
> > >
> > >     Since 4.14 spi-nor automatically tries to probe the flash using S=
FDP
> > >     (command 0x5a), and that command is not part of the list_mode tab=
le.
> > >
> > >     Whit the right combination of C_SPI_MODE and C_SPI_MEMORY this le=
ads
> > >     into a stall that can only be recovered with a soft rest.
> > >
> > >     This patch detects this kind of stall and returns -EIO to the cal=
ler on
> > >     those commands. spi-nor can handle this error properly:
> > >
> > >     m25p80 spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY.=
 0x21
> > > 0x2404
> > >     m25p80 spi0.0: SPI transfer failed: -5
> > >     spi_master spi0: failed to transfer one message from queue
> > >     m25p80 spi0.0: s25sl064p (8192 Kbytes)
> > >
> > >
> > > So, what I did then was removing the side effects of this stall detec=
tion, just
> > > to see if I could readback from the ADC (also enabled debug):
> > >
> > > diff --git i/drivers/spi/spi-xilinx.c w/drivers/spi/spi-xilinx.c
> > > index d59cc8a18484..3281623c59e6 100644
> > > --- i/drivers/spi/spi-xilinx.c
> > > +++ w/drivers/spi/spi-xilinx.c
> > > @@ -307,8 +307,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device=
 *spi,
> > > struct spi_transfer *t)
> > >                 (sr & XSPI_SR_RX_EMPTY_MASK)) {
> > >                 dev_err(&spi->dev,
> > >                     "Detected stall. Check C_SPI_MODE and C_SPI_MEMOR=
Y\n");
> > > -               xspi_init_hw(xspi);
> > > -               return -EIO;
> > >             }
> > >
> > >             if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {
> > >
> > > And so it happened that I can now readback the registers I previously=
 write to
> > > the ADC.
> > >
> > > ## Writing instruction
> > > # art_adc322x -D /dev/spidev1.0  -r 0x13 -w 1
> > > spidev spi1.0: spi mode 0
> > > spidev spi1.0: msb first
> > > spidev spi1.0: 8 bits per word
> > > spidev spi1.0:   xfer len 3 tx 8bits 0 usec 0 usec 10000000Hz
> > > spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > > ## Reading instruction
> > > # art_adc322x -D /dev/spidev1.0  -R 0x13
> > > spidev spi1.0: spi mode 0
> > > spidev spi1.0: msb first
> > > spidev spi1.0: 8 bits per word
> > > spidev spi1.0:   xfer len 3 rx tx 8bits 0 usec 0 usec 10000000Hz
> > > spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > > Reg: 13 =3D 01
> > >
> > > Before I (partially) reverted 5a1314fa697fc65cefaba64cd4699bfc3e6882a=
6, this
> > > procedure of course would only return 0 as the read register, since i=
t was
> > > returning early with that error.
> > >
> > > This seems to indicate that the stall detection is not correct, at le=
ast
> > > when it's not working with a NOR mtd memory.
> > >
> > > I tried to add some more debug to check out the conditions of the sta=
ll
> > > detection, so I inserted this:
> > >
> > > if (spi->dev.driver && !!strcmp(spi->dev.driver->name, "spi-nor"))
> > >         dev_err(&spi->dev, "N=3D%s, rx_words =3D %d, n_words =3D %d, =
stalled =3D %d, sr
> > > =3D 0x%02x, TX_EMPTY_MASK =3D 0x%02x, RX_EMPTY_MASK =3D 0x%02x\n",
> > >                 spi->dev.init_name,
> > >                 rx_words, n_words, stalled, sr, XSPI_SR_TX_EMPTY_MASK=
,
> > > XSPI_SR_RX_EMPTY_MASK);
> > > #endif
> > > if (rx_words =3D=3D n_words && !(stalled--) &&
> > >     !(sr & XSPI_SR_TX_EMPTY_MASK) &&
> > >     (sr & XSPI_SR_RX_EMPTY_MASK)) {
> > >         dev_err(&spi->dev,
> > >                 "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\n"=
);
> > > }
> > >
> > > And the "Detected stall" didn't appear anymore, so I guess that there=
 is some
> > > race condition going on that's been triggered by the kernel printing =
to console:
> >
> >
> > Could you try to increase the value of the variable stalled. Lets say
> > from 10 to 10000 ?
> >
> > If that solves your issue, please try to figure out what value of
> > stalled is the minimal that works for you?
>
> Right, so a value of 16 still fails, but a value of 20 makes the ADC
> communication flawless. Maybe we should just increase this a bit,
> maybe to 32, for example?

32 sounds like a good compromise. Could you please send a patch for that?

>
>
> >
> > >
> > > # art_adc322x -D /dev/spidev1.0  -r 0x13 -w 1
> > > spidev spi1.0: spi mode 0
> > > spidev spi1.0: msb first
> > > spidev spi1.0: 8 bits per word
> > > spidev spi1.0:   xfer len 3 tx 8bits 0 usec 0 usec 10000000Hz
> > > spidev spi1.0: rx_words =3D 3, n_words =3D 3, stalled =3D 10, sr =3D =
0x21, TX_EMPTY_MASK
> > > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > > spidev spi1.0: rx_words =3D 2, n_words =3D 3, stalled =3D 9, sr =3D 0=
x24, TX_EMPTY_MASK
> > > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > > spidev spi1.0: rx_words =3D 1, n_words =3D 3, stalled =3D 9, sr =3D 0=
x24, TX_EMPTY_MASK
> > > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > > # art_adc322x -D /dev/spidev1.0  -R 0x13
> > > spidev spi1.0: spi mode 0
> > > spidev spi1.0: msb first
> > > spidev spi1.0: 8 bits per word
> > > spidev spi1.0:   xfer len 3 rx tx 8bits 0 usec 0 usec 10000000Hz
> > > spidev spi1.0: rx_words =3D 3, n_words =3D 3, stalled =3D 10, sr =3D =
0x21, TX_EMPTY_MASK
> > > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > > spidev spi1.0: rx_words =3D 2, n_words =3D 3, stalled =3D 9, sr =3D 0=
x24, TX_EMPTY_MASK
> > > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > > spidev spi1.0: rx_words =3D 1, n_words =3D 3, stalled =3D 9, sr =3D 0=
x24, TX_EMPTY_MASK
> > > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > > Reg: 13 =3D 01
> > >
> > > If this race condition is true, it may be related to the fact that SR=
 is being
> > > read without the use of an interrupt, and transmission/reception hasn=
't yet
> > > happened when it is read, so I checked to see if these transfers were=
 being made
> > > with an IRQ active or not, so I built the driver with these changes, =
undoing
> > > all the other tests from before:
> > >
> > > diff --git i/drivers/spi/spi-xilinx.c w/drivers/spi/spi-xilinx.c
> > > index d59cc8a18484..93abb0bd9481 100644
> > > --- i/drivers/spi/spi-xilinx.c
> > > +++ w/drivers/spi/spi-xilinx.c
> > > @@ -248,6 +248,10 @@ static int xilinx_spi_txrx_bufs(struct spi_devic=
e *spi,
> > > struct spi_transfer *t)
> > >     xspi->rx_ptr =3D t->rx_buf;
> > >     remaining_words =3D t->len / xspi->bytes_per_word;
> > >
> > > +   if (!strcmp(spi->dev.driver->name, "spidev"))
> > > +       dev_err(&spi->dev, "xspi->irq =3D %d, xspi->force_irq =3D %d,
> > > remaining_words =3D %d, xspi->buffer_size =3D %d\n",
> > > +           xspi->irq, xspi->force_irq, remaining_words, xspi->buffer=
_size);
> > > +
> > >     if (xspi->irq >=3D 0 &&
> > >         (xspi->force_irq || remaining_words > xspi->buffer_size)) {
> > >         u32 isr;
> > > @@ -307,8 +311,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device=
 *spi,
> > > struct spi_transfer *t)
> > >                 (sr & XSPI_SR_RX_EMPTY_MASK)) {
> > >                 dev_err(&spi->dev,
> > >                     "Detected stall. Check C_SPI_MODE and C_SPI_MEMOR=
Y\n");
> > > -               xspi_init_hw(xspi);
> > > -               return -EIO;
> > >             }
> > >
> > >             if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {
> > >
> > > and I get
> > >
> > > Configuring ADCs: spidev spi1.0: xspi->irq =3D 4, xspi->force_irq =3D=
 0,
> > > remaining_words =3D 3, xspi->buffer_size =3D 16
> > > spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > >
> > > So it does seem in fact that there's no IRQ being used, so of course =
the next
> > > thing I did was check out the purpose of xspi->force_irq:
> > >
> > > commit 1dd46599f83ac5323a175d32955b1270e95cd11b
> > > Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > > Date:   Tue Feb 14 05:59:28 2023 -0800
> > >
> > >     spi: xilinx: add force_irq for QSPI mode
> > >
> > >     Xilinx PG158 page 80 [1] states that master transaction inhibit b=
it must
> > >     be set to properly setup the transaction in QSPI mode. Add the fo=
rce_irq
> > >     flag to follow this sequence.
> > >
> > >     [1]
> > > https://docs.xilinx.com/r/en-US/pg153-axi-quad-spi/Dual/Quad-SPI-Mode=
-Transactions
> > >
> > >     Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> > >     Link: https://lore.kernel.org/r/20230214135928.1253205-1-vadfed@m=
eta.com
> > >     Signed-off-by: Mark Brown <broonie@kernel.org>
> > >
> > >
> > > I can understand that, but I don't understand why IRQ is only used if
> > > remaining_words
> > > is bigger than buffer size, nor why this force_irq is only being set =
to true if
> > > it's defined as such using platform_data, if I understand correctly:
> >
> > For small transactions, polling is significantly more efficient than
> > waiting for the IRQ.
>
>
> I see. But having that loop there, with a much increased value could be w=
orse,
> right? Ideally we should measure how much time it takes one thing vs the =
other,
> and in different situations (CPU and SPI clocks).

AFAIK, a bigger stalled value will just mean that stalls are detected
later. It will not affect normal behaviour.

Stalls should not happen, so I do not worry too much about a higher stalled=
.

>
> >
> >
> > >
> > >         if (pdata) {
> > >                 num_cs =3D pdata->num_chipselect;
> > >                 bits_per_word =3D pdata->bits_per_word;
> > >                 force_irq =3D pdata->force_irq;
> > >         } else {
> > >                 of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-=
bits",
> > >                                           &num_cs);
> > >                 ret =3D of_property_read_u32(pdev->dev.of_node,
> > >                                            "xlnx,num-transfer-bits",
> > >                                            &bits_per_word);
> > >                 if (ret)
> > >                         bits_per_word =3D 8;
> > >         }
> > >
> > > since the final assignment is just
> > >
> > >         xspi->force_irq =3D force_irq;
> > >
> > > So, the next step was to set force_irq to true, so no matter how the =
device is
> > > being defined (dts or elsewhere) nor the number of words remaining, I=
RQ mode
> > > will always be used.
> > >
> > > This apparently solved the issue, but I wouldn't dare to send this as=
 a patch
> > > because I don't fully understand all the implications of this, so I w=
ould be
> > > grateful is someone can help understand all this. I get that the tran=
saction
> > > in QSPI mode may require this value to be set, but my ADC is a simple=
 SPI
> > > device with a single lane, and the SPI core is configured as such.
> > >
> > > Also, it seems strange to me that I am the only one person in the wor=
ld using
> > > this core to work with SPI devices in userspace and this has gone unn=
oticed for
> > > so long, so I wouldn't discard a) me being a weird guy or b) me being=
 completely
> > > wrong about everything.
> >
> > I bet that you are not weirder than the rest of the people posting to
> > lkml (me included) :P
> >
> > I just think that the spi clock is configured extremely slow compared
> > to the microblaze speed and we are faulty detecting a stall.
> > Increasing the stalled variable will probably be the best approach and
> > I think it could be sent upstream.
> >
>
> Ah, right. The SPI driving the ADCs is using a 10MHz clock as ext_spi_clo=
ck
> signal and a divider of 16, so that makes it a 625KHz clock. The microbla=
ze
> is working at 83.25MHz, so it could definitely be the cause. I can try an=
d
> increase that speed to check if that solves the issue. We chose that freq=
uency
> because we absolutely don't care about its speed and preferred the commun=
ication
> be robust, but we don't mind either if it needs to be faster.

Up to you. If you cannot land the patch/do not want to have a local
patch-> increase the ADC speed.

>
>
> >
> > >
> > > - Now, onto the flash problem
> > >
> > > As I said, the old board had an mt25ql128 while the new one has an mt=
25ql02g.
> > > The old flash chip did work without any issue with kernel 4.4, and do=
es work
> > > as well with kernel 6.12. However, new flash won't work correctly wit=
h kernel
> > > 6.12 (it didn't have support back in 4.4 times so I can't compare), a=
nd the
> > > same stalling message will be repeated all the time.
> > >
> > > Even though it keeps marking transactions as stalled, it seems to be =
able to
> > > load
> > > the squashfs filesystem stored in the flash, but mounting a jffs2 par=
tition will
> > > result in pages and pages of:
> > >
> > >
> > > spi-nor spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > > spi-nor spi0.0: SPI transfer failed: -5
> > > spi_master spi0: failed to transfer one message from queue
> > > spi_master spi0: noqueue transfer failed
> > > jffs2: Erase at 0x00001000 failed immediately: errno -5
> > > spi-nor spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > > spi-nor spi0.0: SPI transfer failed: -5
> > > spi_master spi0: failed to transfer one message from queue
> > > spi_master spi0: noqueue transfer failed
> > > jffs2: Erase at 0x001ff000 failed immediately: errno -5
> > >
> > > And writing to the flash will generate some other messages.
> > >
> > > # echo hello > /mnt/persistent/bar
> > > jffs2: Node totlen on flash (0xffffffff) !=3D totlen from node ref (0=
x00000044)
> > >
> > > Umounting and remounting that partition will produce another stream o=
f stalls
> > > like above, and the short file I created won't be there at all.
> > >
> > > I disabled CONFIG_MTD_SPI_NOR_USE_4K_SECTORS, because it seems this n=
ew flash
> > > has 64K sized sectors, and there seem to be less stall messages than =
before, but
> > > still it doesn't seem capable of writing into the filesystem.
> >
> > Forcing the irq solve the issue here?
> >
> > Increasing the  stalled variable solves the issue?
>
> A little increase to 32 didn't solve the issue, and a high value (32000) =
what
> caused was the bootup sequence to get stuck (I didn't wait more than a co=
uple
> of minutes), so it probably really needs a lot of time to finish all the
> transactions. Since the rootfs is sitting on a squashfs on the flash, I g=
uess
> it has a lot to read from there.
>
> Forcing the IRQ seemed to solve the stalling issue at first. I have been =
able
> to mount the jffs2 partition, write to it, umount, power cycle, mount it =
again
> and check its contents are still there.
>
> But then I've power cycled again and now it gets stuck trying to mount ro=
otfs,
> so there's still something fishy there. Probably related to the same thin=
g as
> the boot failure, something to do with the state of the flash memory at b=
oot?
>
> I have been trying all morning to replicate those working conditions but =
I
> haven't been able to. I'm quite frustrated right now, because for a while=
 it
> seemed that simply forcing the irq would solve the issue with the flash a=
s well,
> but now I can't find the way to make it work again. Maybe I dreamed it.
>
> >
> > If the answer is no to both, you need to check C_SPI_MODE and
> > C_SPI_MEMORY. The core needs to know about your flash. yeah I know....
> >
>
> Oh my... I know what happened and it wasn't a dream. I have the design in=
 Vivado
> 2016.2 and also in Vivado 2025.1. They must have added something to the S=
PI core
> so it now works with this new flash, and this must have been the design I=
 was
> loading when tried to force the IRQ.
>
> I still need to increase the initial stalled value to access the slow SPI=
 core,
> but it seems that using new Vivado there's no need to change anything for=
 this
> flash to work. I'm astonished, because the SPI core version supposedly ha=
sn't
> changed, so the FPGA-hardware should be identical from one version to the=
 other,
> but it clearly isn't.

If you really care I guess you can check the vhl files and compare them.

>
> So... we can't patch this up in the kernel because it's the hardware that=
 is
> defective (or, let's say, old hardware doesn't support modern flash, alth=
ough I
> can't see why the SPI core needs to even know what a flash is and limit i=
tself
> to move bytes from one device to the other).
>
> > >
> > > And finally, the most strange thing is that resetting the FPGA so it =
reloads
> > > the full bitfile, including microblaze, spi core, and everything at a=
ll
> > > but the flash has its reset pin hardwired to inactive) will produce t=
hat the
> > > FSBL is suddenly unable to load the kernel from flash, (haven't debug=
ged this
> > > yet), and the only way for the system to fully bootup again is to pow=
er-cycle
> > > the board.
> > >
> > > This is doubly worrisome as the FPGA itself reads from this very same=
 SPI flash
> > > to gather its own bitfile, so how come the FSBL (a short C program in=
herited
> > > from Vivado 2016) isn't now able to read the kernel from this same fl=
ash and
> > > load it into memory? So much I don't understand.
> >
> > Powercycing works, but resetting doesnt?
> >
> > I would bet that linux is leaving the flash in quad mode (or other
> > mode) than FSBL do not understand.
> >
> > You can probably patch fsbl... Or maybe your fpga guy can change the
> > way the flash is reseted: longer reset or what not, it has been a
> > while since I used this ;)
> >
>
> The boot problem seems to exist even with thew new Vivado version, so I n=
eed to
> dive deeper on this.
>
> I am also the FPGA guy, which has its good things because I know how all =
the
> system is built, but on the other side I have no one to blame when someth=
ing
> doesn't work. Sadly, I can't reset the flash, as the flash pin isn't rout=
ed to
> the FPGA (hey, I can blame the hardware engineer there!), so I'll try to =
see
> what I can do about it.

Always a good idea to blame someone else. :P

I remember that back in the days we ended up implementing our own
first stage boot loader. Xilinx 1sl was not great, but this was 15
years ago.

Have you tried pinging your Field Support Engineer? They used to be
very helpful.

>
>
> >
> > >
> > > This is even stranger than the spidev thing, because new kernel does =
work with
> > > the old flash, but it doesn't with the new one, which aren't that dif=
ferent
> > > to each other.
> > >
> > > Now, are this problem and the SPIDEV one related? I have no idea, so =
I would
> > > really appreciate any pointer to the right direction to debug this. I=
 haven't
> > > gone as deep on this issue because it looks related to the spidev and=
 so I've
> > > spent most of my time in diagnosing spi-xilinx.c, but I could be wron=
g about
> > > it too.
> > >
> > > Sorry for the wall of text, I hope my step-by-step description of wha=
t's
> > > happening is useful.
> >
> >
> > Hope this helped... good luck :)
>
> A lot, thank you!

You are welcome. Your message brought back a lot of good memories :)

>
> > >
> > > Best regards,
> > >

