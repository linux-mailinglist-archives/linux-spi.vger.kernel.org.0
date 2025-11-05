Return-Path: <linux-spi+bounces-11039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6064C3668C
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 16:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D85B6233FB
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB932572D;
	Wed,  5 Nov 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpHWiSc9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B797248F68
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356137; cv=none; b=kLUYyKk7gqbDmCHsld9MBKqIU1JnDE0A5AcRbcruta9o3uoON9Vd0qU6/X6IWram2LnOXtQFqJ95dsg/593d98fG6hj/RS/C4jqARZSMg1qy6KJyP7h7MXVHAB9tnWj/xXco4h72JbC719t2vPp25pRPgqWcTHaoZ2mfoiIMMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356137; c=relaxed/simple;
	bh=jqtz59RGFdJvFaswV9emqsl5w70AIS6w1ugMBZOlSEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO3pZ3PVRLOFR2RR4ytTB0nlnssq8CPXubDqId4antmD7xgxKD7Scf2DoMNvsZyRDYHszD2h343R0UWSzgeB8/30LzwINgDccyI5Fva7HK+e8QseGbffMLxaC9m4dexUhOPNtgUAX8FSSsUPuvy1f14Ns62KSUWlMzJJUvEi2vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpHWiSc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2352DC4CEF5
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762356137;
	bh=jqtz59RGFdJvFaswV9emqsl5w70AIS6w1ugMBZOlSEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MpHWiSc9yBPx2N/X8gxHUOoNSvRZP+2WlfAADj8uiZj2TvdlplpqIEnQTZy0sm4Y5
	 HTxd3bu5gFZLwmp7AXoyiddcnBNyxfgss1J4K3mK5FCIXHFx16ZAL4Z2C52oGSv1Y4
	 1GPp8VrUOL8HxCupoqjJ1ka55JLNIgse2MiwTd3NRqZx3nWZ/ZU1/agV9db88qAgbO
	 eEqLpokVe2rjP7D5lcpRGBDI6FA7uRB2JeglXZrihiIuCSOANgapwnZ5FMzxKNGEQX
	 pKUAbLnROJAQLOXzMtlUcpJRDG/ter32SmzrXgnq67kx3C8PQXZssShdr8CTdGVaVR
	 V6i6e1znss9Sw==
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5db221488bfso6614951137.1
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 07:22:17 -0800 (PST)
X-Gm-Message-State: AOJu0YzAUmUVZyEmxK1eJZzSoQ6GJiRuev96vDjMoRmTztbyghSd16ce
	58aQ457C2rdjgHIslSYBqiEEyTOgTN6yqwbFWIbGQCv7hwoXKWEs5auT3JDS6ewIVRSXcO2qNL8
	kQ/QwmJMkSn3J/wXzJLz+ttgmASsgo4w=
X-Google-Smtp-Source: AGHT+IHjqS09pm2AxROS46W8+6FELNZsUmro7soWN375QovRXlZ4lj6MXc7uB5qWN4zdZlIZ0BXRr70RRhOlhl3Ai5A=
X-Received: by 2002:a05:6102:c54:b0:5db:ebb4:fded with SMTP id
 ada2fe7eead31-5dd891b080emr1277564137.25.1762356136094; Wed, 05 Nov 2025
 07:22:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ea5e6915f997d4f1482cb8ab16c81e4406b224a3.camel@hazent.com>
In-Reply-To: <ea5e6915f997d4f1482cb8ab16c81e4406b224a3.camel@hazent.com>
From: Ricardo Ribalda Delgado <ribalda@kernel.org>
Date: Wed, 5 Nov 2025 16:21:58 +0100
X-Gmail-Original-Message-ID: <CAPybu_1w+Jnt5YjLKhcP0cThyVg5a=ZNYL7dG+4pR=6cQUdGhw@mail.gmail.com>
X-Gm-Features: AWmQ_bk0O3LeWCzhVSv1OR7o_-ZW7bZkZIjjigrLoUp9a4mC5jh6zCn66m0nags
Message-ID: <CAPybu_1w+Jnt5YjLKhcP0cThyVg5a=ZNYL7dG+4pR=6cQUdGhw@mail.gmail.com>
Subject: Re: spi-xilinx.c: Xilinx axi_quad_spi "Detected stall. Check
 C_SPI_MODE and C_SPI_MEMORY" in spidev mode and in spi-nor with MT25QL02G
To: =?UTF-8?B?w4FsdmFybyBHLiBNLg==?= <alvaro.gamez@hazent.com>
Cc: linux-spi@vger.kernel.org, Michal Simek <michal.simek@amd.com>, 
	Mark Brown <broonie@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alvaro


On Wed, Nov 5, 2025 at 3:28=E2=80=AFPM =C3=81lvaro G. M. <alvaro.gamez@haze=
nt.com> wrote:
>
> Xilinx axi_quad_spi "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY" i=
n
> spidev mode and in spi-nor with MT25QL02G
>
> Hi,
>
> We're making a new version of a PCB we had back in 2016 which used kernel=
 4.4
> and we are now upgrading to 6.12 series. The board fits an xc7100t fpga f=
rom
> Xilinx, which is running a microblaze soft-core and has two axi_quad_spi =
cores.
>
> The first of them, in Quad mode is connected to an spi-nor flash, while t=
he
> second spi core is used to interface with two adc3442 from Texas Instrume=
nts
> from userspace, so I patch spidev.c to include a line for the device tree=
 as
> ti,adc344x.
>

Do you know the C_SPI_MODE and C_SPI_MEMORY C_PARAMs of both cores?


> The old PCB used an mt25ql128 flash, while the new version uses MT25QL02G=
. My
> intent is to upgrade the software for both PCBs.
>
> - The SPIDEV problem
>
> The first issue that I've noticed is that spidev device detects an stall =
in
> the new kernel, as whenever I access /dev/spidev1.0 or /dev/spidev1.1 to
> configure one of the ADCs, the following message is generated, and readin=
g
> from the ADC fails (I'm not sure about writes though, since I can't readb=
ack
> what I sent, but from the behaviour of the ADC regarding its sampling
> functionality, it could very be properly receiving writes):
>
> spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> spidev spi1.0: SPI transfer failed: -5
> spi_master spi1: failed to transfer one message from queue
> spi_master spi1: noqueue transfer failed
>
> This stall detection was introduced just a little after 4.4 which I was u=
sing
> before. The explanation, however, seems to talk only about spi-nor probin=
g,
> which is not the case since I'm using spidev.
>
> commit 5a1314fa697fc65cefaba64cd4699bfc3e6882a6
> Author: Ricardo Ribalda <ribalda@kernel.org>
> Date:   Tue Nov 21 10:09:02 2017 +0100
>
>     spi: xilinx: Detect stall with Unknown commands
>
>     When the core is configured in C_SPI_MODE > 0, it integrates a
>     lookup table that automatically configures the core in dual or quad m=
ode
>     based on the command (first byte on the tx fifo).
>
>     Unfortunately, that list mode_?_memoy_*.mif does not contain all the
>     supported commands by the flash.
>
>     Since 4.14 spi-nor automatically tries to probe the flash using SFDP
>     (command 0x5a), and that command is not part of the list_mode table.
>
>     Whit the right combination of C_SPI_MODE and C_SPI_MEMORY this leads
>     into a stall that can only be recovered with a soft rest.
>
>     This patch detects this kind of stall and returns -EIO to the caller =
on
>     those commands. spi-nor can handle this error properly:
>
>     m25p80 spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY. 0x2=
1
> 0x2404
>     m25p80 spi0.0: SPI transfer failed: -5
>     spi_master spi0: failed to transfer one message from queue
>     m25p80 spi0.0: s25sl064p (8192 Kbytes)
>
>
> So, what I did then was removing the side effects of this stall detection=
, just
> to see if I could readback from the ADC (also enabled debug):
>
> diff --git i/drivers/spi/spi-xilinx.c w/drivers/spi/spi-xilinx.c
> index d59cc8a18484..3281623c59e6 100644
> --- i/drivers/spi/spi-xilinx.c
> +++ w/drivers/spi/spi-xilinx.c
> @@ -307,8 +307,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *sp=
i,
> struct spi_transfer *t)
>                 (sr & XSPI_SR_RX_EMPTY_MASK)) {
>                 dev_err(&spi->dev,
>                     "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\n"=
);
> -               xspi_init_hw(xspi);
> -               return -EIO;
>             }
>
>             if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {
>
> And so it happened that I can now readback the registers I previously wri=
te to
> the ADC.
>
> ## Writing instruction
> # art_adc322x -D /dev/spidev1.0  -r 0x13 -w 1
> spidev spi1.0: spi mode 0
> spidev spi1.0: msb first
> spidev spi1.0: 8 bits per word
> spidev spi1.0:   xfer len 3 tx 8bits 0 usec 0 usec 10000000Hz
> spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> ## Reading instruction
> # art_adc322x -D /dev/spidev1.0  -R 0x13
> spidev spi1.0: spi mode 0
> spidev spi1.0: msb first
> spidev spi1.0: 8 bits per word
> spidev spi1.0:   xfer len 3 rx tx 8bits 0 usec 0 usec 10000000Hz
> spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> Reg: 13 =3D 01
>
> Before I (partially) reverted 5a1314fa697fc65cefaba64cd4699bfc3e6882a6, t=
his
> procedure of course would only return 0 as the read register, since it wa=
s
> returning early with that error.
>
> This seems to indicate that the stall detection is not correct, at least
> when it's not working with a NOR mtd memory.
>
> I tried to add some more debug to check out the conditions of the stall
> detection, so I inserted this:
>
> if (spi->dev.driver && !!strcmp(spi->dev.driver->name, "spi-nor"))
>         dev_err(&spi->dev, "N=3D%s, rx_words =3D %d, n_words =3D %d, stal=
led =3D %d, sr
> =3D 0x%02x, TX_EMPTY_MASK =3D 0x%02x, RX_EMPTY_MASK =3D 0x%02x\n",
>                 spi->dev.init_name,
>                 rx_words, n_words, stalled, sr, XSPI_SR_TX_EMPTY_MASK,
> XSPI_SR_RX_EMPTY_MASK);
> #endif
> if (rx_words =3D=3D n_words && !(stalled--) &&
>     !(sr & XSPI_SR_TX_EMPTY_MASK) &&
>     (sr & XSPI_SR_RX_EMPTY_MASK)) {
>         dev_err(&spi->dev,
>                 "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\n");
> }
>
> And the "Detected stall" didn't appear anymore, so I guess that there is =
some
> race condition going on that's been triggered by the kernel printing to c=
onsole:


Could you try to increase the value of the variable stalled. Lets say
from 10 to 10000 ?

If that solves your issue, please try to figure out what value of
stalled is the minimal that works for you?


>
> # art_adc322x -D /dev/spidev1.0  -r 0x13 -w 1
> spidev spi1.0: spi mode 0
> spidev spi1.0: msb first
> spidev spi1.0: 8 bits per word
> spidev spi1.0:   xfer len 3 tx 8bits 0 usec 0 usec 10000000Hz
> spidev spi1.0: rx_words =3D 3, n_words =3D 3, stalled =3D 10, sr =3D 0x21=
, TX_EMPTY_MASK
> =3D 0x04, RX_EMPTY_MASK =3D 0x01
> spidev spi1.0: rx_words =3D 2, n_words =3D 3, stalled =3D 9, sr =3D 0x24,=
 TX_EMPTY_MASK
> =3D 0x04, RX_EMPTY_MASK =3D 0x01
> spidev spi1.0: rx_words =3D 1, n_words =3D 3, stalled =3D 9, sr =3D 0x24,=
 TX_EMPTY_MASK
> =3D 0x04, RX_EMPTY_MASK =3D 0x01
> # art_adc322x -D /dev/spidev1.0  -R 0x13
> spidev spi1.0: spi mode 0
> spidev spi1.0: msb first
> spidev spi1.0: 8 bits per word
> spidev spi1.0:   xfer len 3 rx tx 8bits 0 usec 0 usec 10000000Hz
> spidev spi1.0: rx_words =3D 3, n_words =3D 3, stalled =3D 10, sr =3D 0x21=
, TX_EMPTY_MASK
> =3D 0x04, RX_EMPTY_MASK =3D 0x01
> spidev spi1.0: rx_words =3D 2, n_words =3D 3, stalled =3D 9, sr =3D 0x24,=
 TX_EMPTY_MASK
> =3D 0x04, RX_EMPTY_MASK =3D 0x01
> spidev spi1.0: rx_words =3D 1, n_words =3D 3, stalled =3D 9, sr =3D 0x24,=
 TX_EMPTY_MASK
> =3D 0x04, RX_EMPTY_MASK =3D 0x01
> Reg: 13 =3D 01
>
> If this race condition is true, it may be related to the fact that SR is =
being
> read without the use of an interrupt, and transmission/reception hasn't y=
et
> happened when it is read, so I checked to see if these transfers were bei=
ng made
> with an IRQ active or not, so I built the driver with these changes, undo=
ing
> all the other tests from before:
>
> diff --git i/drivers/spi/spi-xilinx.c w/drivers/spi/spi-xilinx.c
> index d59cc8a18484..93abb0bd9481 100644
> --- i/drivers/spi/spi-xilinx.c
> +++ w/drivers/spi/spi-xilinx.c
> @@ -248,6 +248,10 @@ static int xilinx_spi_txrx_bufs(struct spi_device *s=
pi,
> struct spi_transfer *t)
>     xspi->rx_ptr =3D t->rx_buf;
>     remaining_words =3D t->len / xspi->bytes_per_word;
>
> +   if (!strcmp(spi->dev.driver->name, "spidev"))
> +       dev_err(&spi->dev, "xspi->irq =3D %d, xspi->force_irq =3D %d,
> remaining_words =3D %d, xspi->buffer_size =3D %d\n",
> +           xspi->irq, xspi->force_irq, remaining_words, xspi->buffer_siz=
e);
> +
>     if (xspi->irq >=3D 0 &&
>         (xspi->force_irq || remaining_words > xspi->buffer_size)) {
>         u32 isr;
> @@ -307,8 +311,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *sp=
i,
> struct spi_transfer *t)
>                 (sr & XSPI_SR_RX_EMPTY_MASK)) {
>                 dev_err(&spi->dev,
>                     "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\n"=
);
> -               xspi_init_hw(xspi);
> -               return -EIO;
>             }
>
>             if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {
>
> and I get
>
> Configuring ADCs: spidev spi1.0: xspi->irq =3D 4, xspi->force_irq =3D 0,
> remaining_words =3D 3, xspi->buffer_size =3D 16
> spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
>
> So it does seem in fact that there's no IRQ being used, so of course the =
next
> thing I did was check out the purpose of xspi->force_irq:
>
> commit 1dd46599f83ac5323a175d32955b1270e95cd11b
> Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Date:   Tue Feb 14 05:59:28 2023 -0800
>
>     spi: xilinx: add force_irq for QSPI mode
>
>     Xilinx PG158 page 80 [1] states that master transaction inhibit bit m=
ust
>     be set to properly setup the transaction in QSPI mode. Add the force_=
irq
>     flag to follow this sequence.
>
>     [1]
> https://docs.xilinx.com/r/en-US/pg153-axi-quad-spi/Dual/Quad-SPI-Mode-Tra=
nsactions
>
>     Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>     Link: https://lore.kernel.org/r/20230214135928.1253205-1-vadfed@meta.=
com
>     Signed-off-by: Mark Brown <broonie@kernel.org>
>
>
> I can understand that, but I don't understand why IRQ is only used if
> remaining_words
> is bigger than buffer size, nor why this force_irq is only being set to t=
rue if
> it's defined as such using platform_data, if I understand correctly:

For small transactions, polling is significantly more efficient than
waiting for the IRQ.


>
>         if (pdata) {
>                 num_cs =3D pdata->num_chipselect;
>                 bits_per_word =3D pdata->bits_per_word;
>                 force_irq =3D pdata->force_irq;
>         } else {
>                 of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits=
",
>                                           &num_cs);
>                 ret =3D of_property_read_u32(pdev->dev.of_node,
>                                            "xlnx,num-transfer-bits",
>                                            &bits_per_word);
>                 if (ret)
>                         bits_per_word =3D 8;
>         }
>
> since the final assignment is just
>
>         xspi->force_irq =3D force_irq;
>
> So, the next step was to set force_irq to true, so no matter how the devi=
ce is
> being defined (dts or elsewhere) nor the number of words remaining, IRQ m=
ode
> will always be used.
>
> This apparently solved the issue, but I wouldn't dare to send this as a p=
atch
> because I don't fully understand all the implications of this, so I would=
 be
> grateful is someone can help understand all this. I get that the transact=
ion
> in QSPI mode may require this value to be set, but my ADC is a simple SPI
> device with a single lane, and the SPI core is configured as such.
>
> Also, it seems strange to me that I am the only one person in the world u=
sing
> this core to work with SPI devices in userspace and this has gone unnotic=
ed for
> so long, so I wouldn't discard a) me being a weird guy or b) me being com=
pletely
> wrong about everything.

I bet that you are not weirder than the rest of the people posting to
lkml (me included) :P

I just think that the spi clock is configured extremely slow compared
to the microblaze speed and we are faulty detecting a stall.
Increasing the stalled variable will probably be the best approach and
I think it could be sent upstream.


>
> - Now, onto the flash problem
>
> As I said, the old board had an mt25ql128 while the new one has an mt25ql=
02g.
> The old flash chip did work without any issue with kernel 4.4, and does w=
ork
> as well with kernel 6.12. However, new flash won't work correctly with ke=
rnel
> 6.12 (it didn't have support back in 4.4 times so I can't compare), and t=
he
> same stalling message will be repeated all the time.
>
> Even though it keeps marking transactions as stalled, it seems to be able=
 to
> load
> the squashfs filesystem stored in the flash, but mounting a jffs2 partiti=
on will
> result in pages and pages of:
>
>
> spi-nor spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> spi-nor spi0.0: SPI transfer failed: -5
> spi_master spi0: failed to transfer one message from queue
> spi_master spi0: noqueue transfer failed
> jffs2: Erase at 0x00001000 failed immediately: errno -5
> spi-nor spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> spi-nor spi0.0: SPI transfer failed: -5
> spi_master spi0: failed to transfer one message from queue
> spi_master spi0: noqueue transfer failed
> jffs2: Erase at 0x001ff000 failed immediately: errno -5
>
> And writing to the flash will generate some other messages.
>
> # echo hello > /mnt/persistent/bar
> jffs2: Node totlen on flash (0xffffffff) !=3D totlen from node ref (0x000=
00044)
>
> Umounting and remounting that partition will produce another stream of st=
alls
> like above, and the short file I created won't be there at all.
>
> I disabled CONFIG_MTD_SPI_NOR_USE_4K_SECTORS, because it seems this new f=
lash
> has 64K sized sectors, and there seem to be less stall messages than befo=
re, but
> still it doesn't seem capable of writing into the filesystem.

Forcing the irq solve the issue here?

Increasing the  stalled variable solves the issue?

If the answer is no to both, you need to check C_SPI_MODE and
C_SPI_MEMORY. The core needs to know about your flash. yeah I know....


>
> And finally, the most strange thing is that resetting the FPGA so it relo=
ads
> the full bitfile, including microblaze, spi core, and everything at all
> but the flash has its reset pin hardwired to inactive) will produce that =
the
> FSBL is suddenly unable to load the kernel from flash, (haven't debugged =
this
> yet), and the only way for the system to fully bootup again is to power-c=
ycle
> the board.
>
> This is doubly worrisome as the FPGA itself reads from this very same SPI=
 flash
> to gather its own bitfile, so how come the FSBL (a short C program inheri=
ted
> from Vivado 2016) isn't now able to read the kernel from this same flash =
and
> load it into memory? So much I don't understand.

Powercycing works, but resetting doesnt?

I would bet that linux is leaving the flash in quad mode (or other
mode) than FSBL do not understand.

You can probably patch fsbl... Or maybe your fpga guy can change the
way the flash is reseted: longer reset or what not, it has been a
while since I used this ;)


>
> This is even stranger than the spidev thing, because new kernel does work=
 with
> the old flash, but it doesn't with the new one, which aren't that differe=
nt
> to each other.
>
> Now, are this problem and the SPIDEV one related? I have no idea, so I wo=
uld
> really appreciate any pointer to the right direction to debug this. I hav=
en't
> gone as deep on this issue because it looks related to the spidev and so =
I've
> spent most of my time in diagnosing spi-xilinx.c, but I could be wrong ab=
out
> it too.
>
> Sorry for the wall of text, I hope my step-by-step description of what's
> happening is useful.


Hope this helped... good luck :)
>
> Best regards,
>

