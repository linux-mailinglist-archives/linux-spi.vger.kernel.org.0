Return-Path: <linux-spi+bounces-11075-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E830C3AAAB
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CFF561D23
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B5030F7E9;
	Thu,  6 Nov 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="QI9r16H0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E2303A1C
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428942; cv=none; b=Y85MdPxbHOcQRNz8qD1fOcrZy78sJTHcAztKVzyMFnXfcT4qrYxY5/IHoMSukB1KaU286aY6z+3F/9yFNJSgVakl6G+peEB10jlzBjhbvf/jcrTD8SPi3cV/AC6u6+q3emDeRagQheA5jhaI3QQ0bwdVZvS79dZGgoplc+WzqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428942; c=relaxed/simple;
	bh=YhaLbNw8Ee/1QNzZIY43kHqhxnhK+0cpZsT/M+IM+To=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YaDfmzx16PU5NGnjYnqwD1MxHYv4U2cg2cu5Kp9QAwySNUd8AdxLYirp1ezJ7p9HmbqILni/+4TjLkwD4Tv+W3YZ9h9+JcgXXE/bNyex+4av6vYThphvLyZ3dFjKbqlleHmLs3kbFQeiychfhyzJy+3jNSRJW6uTZ9xQ4MQORRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=QI9r16H0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632d45c9so4541135e9.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 03:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1762428937; x=1763033737; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9EYNGXx2EUKSrVSYlk7fVhZqdus6Enyg7xbAmwuf768=;
        b=QI9r16H0kMztZYc9RFH42dOfbW8DzpgBdmvEvsYCI1isSR83Oh9zfNsxl2eh9Bb6zG
         1ow2MAi1bG+olINJknu+Vb4HDkaDxkkHVU/HlHS/2PEoAqbFtvpHhcDVJD6PkWAXT1fp
         M+yAZGNucWVzpVrBQ4bA5jjGe8TAS46re2Z3ZZzlqJZK3U3+nnDligTRcmmUPFoeug3X
         KuOqRLlT5xYdRmcl1PAYFImI3zgR/I9yVkexRuv0uqqO/zRiWW4JUeKnnVLsESGUSbCG
         PcHQIiYC7+Mh58I3ZrYwKHco6AeN/a23V4KpbmhvPcvFk5T08M+cGfZx2xI9pJTPBgnp
         fTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428937; x=1763033737;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9EYNGXx2EUKSrVSYlk7fVhZqdus6Enyg7xbAmwuf768=;
        b=ORnmnIwuixy3rG743wg2+8T7B15FdJjEaa/6lSEMaThJWFoJbntkU0nP7C7dAGKW1B
         h3dXQuW9PNTXTz0leGwgh9Xco8/HGGFl48s4zOcgxSBvYvCGSUxyWoEZj1WJKlEFcDc9
         75ULUTFShOYHDZK+GEhTlHxJGB5AOjpdtx/H95oWJQvDawDUQ7lH4ZJzQVbH0ObVXOpg
         NtQNGDglN94Yo5S6z2X5+4wej6mK0/LW44WzQGEzVxmojHJO8chtivV3JDiYl8W6Wfrg
         U5jDtkrF+kVXxl8dlCniaDZpPngSUWAF1Sg+wmpsk48DBI0KDGhbdGLmU0H+HUtm65/1
         s0BA==
X-Gm-Message-State: AOJu0YzxBRkyVQSfSp1M1DPzRQQPIGO9nrP2Ega9uSJUKQLdzLECSRxb
	gbMQyNAAWgxtgbtJDnHpIyM0JBUgxs/rAAh9d5CANM21ZZJQbe6oiJsXNrNdpX8juw==
X-Gm-Gg: ASbGncuTbBRop+1IG6uc0hVGhIHMCT3xNd2tShcAIc3VIApQMM6+yJpmnbr+u27ByIV
	PcnYOZZbnreTJSELHUKrP28fSIpA8iFqwIUhbVathB9wWX6+CSvg58JHPVoHYSlHlh+cAks3BON
	pE3H2v0jFEp3cFA9gEW2AEMwcSfddLpDyro24O2tV6CHk8Webr7YGck0MujgGjemWWWM8xPjTax
	JeS/RpUnW3RnI/E1yjhxX6GdVmF4ktUMmAYnV19i++7jRoka2DKl4B9Fuqx/h6in+RDji5k5azq
	ASbK9by7c4NBACkjfKAlAjabQC/8ofvgK66+8jPU6rfTo5SVWN+ALUHJg/jegPlOJ6HhbwRg73a
	foRGZSX7HBE7yKcUp27xiQLaEue2VoMicRSDhtdygArECv19Owu8cnSeNmHULtL6iwddu8v21SF
	pYDBrwx8IQ
X-Google-Smtp-Source: AGHT+IH4gHJ2UdGaDF90BeI1HWxn7lM4cL0YoMVi138lFZtO1+7QRAbdRWoNGi8DUIep418kSwc7Rw==
X-Received: by 2002:a05:600c:45c7:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-4775cdad652mr66509165e9.6.1762428937094;
        Thu, 06 Nov 2025 03:35:37 -0800 (PST)
Received: from [192.168.2.3] ([109.227.153.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47767749916sm20776675e9.4.2025.11.06.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:35:36 -0800 (PST)
Message-ID: <a4cb5c7727ff15efed53af0ec07b4f7f3135adc0.camel@hazent.com>
Subject: Re: spi-xilinx.c: Xilinx axi_quad_spi "Detected stall. Check
 C_SPI_MODE and C_SPI_MEMORY" in spidev mode and in spi-nor with MT25QL02G
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: Ricardo Ribalda Delgado <ribalda@kernel.org>
Cc: linux-spi@vger.kernel.org, Michal Simek <michal.simek@amd.com>, Mark
 Brown	 <broonie@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Date: Thu, 06 Nov 2025 12:35:35 +0100
In-Reply-To: <CAPybu_1w+Jnt5YjLKhcP0cThyVg5a=ZNYL7dG+4pR=6cQUdGhw@mail.gmail.com>
References: <ea5e6915f997d4f1482cb8ab16c81e4406b224a3.camel@hazent.com>
	 <CAPybu_1w+Jnt5YjLKhcP0cThyVg5a=ZNYL7dG+4pR=6cQUdGhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ricardo!

On Wed, 2025-11-05 at 16:21 +0100, Ricardo Ribalda Delgado wrote:
> Hi Alvaro
>=20
>=20
> On Wed, Nov 5, 2025 at 3:28=E2=80=AFPM =C3=81lvaro G. M. <alvaro.gamez@ha=
zent.com> wrote:
> >=20
> > Xilinx axi_quad_spi "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY"=
 in
> > spidev mode and in spi-nor with MT25QL02G
> >=20
> > Hi,
> >=20
> > We're making a new version of a PCB we had back in 2016 which used kern=
el 4.4
> > and we are now upgrading to 6.12 series. The board fits an xc7100t fpga=
 from
> > Xilinx, which is running a microblaze soft-core and has two axi_quad_sp=
i cores.
> >=20
> > The first of them, in Quad mode is connected to an spi-nor flash, while=
 the
> > second spi core is used to interface with two adc3442 from Texas Instru=
ments
> > from userspace, so I patch spidev.c to include a line for the device tr=
ee as
> > ti,adc344x.
> >=20
>=20
> Do you know the C_SPI_MODE and C_SPI_MEMORY C_PARAMs of both cores?

Yes, the SPI dedicated to the ADC is just set in Standard mode (C_SPI_MODE=
=3D0),
and C_SPI_MEMORY=3D1, but this value shouldn't apply since there's no flash
attached here, right?

The flash dedicated SPI has C_SPI_MODE =3D> 2, C_SPI_MEMORY =3D> 2, which
correspond to QUAD mode and Micron(Numonyx) values. It's the same
configuration we use in the PCB with the mt25ql128 flash, but now we have
an mt25ql02g. Shouldn't be that different, but I haven't compared datasheet=
s.


>=20
>=20
> > The old PCB used an mt25ql128 flash, while the new version uses MT25QL0=
2G. My
> > intent is to upgrade the software for both PCBs.
> >=20
> > - The SPIDEV problem
> >=20
> > The first issue that I've noticed is that spidev device detects an stal=
l in
> > the new kernel, as whenever I access /dev/spidev1.0 or /dev/spidev1.1 t=
o
> > configure one of the ADCs, the following message is generated, and read=
ing
> > from the ADC fails (I'm not sure about writes though, since I can't rea=
dback
> > what I sent, but from the behaviour of the ADC regarding its sampling
> > functionality, it could very be properly receiving writes):
> >=20
> > spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > spidev spi1.0: SPI transfer failed: -5
> > spi_master spi1: failed to transfer one message from queue
> > spi_master spi1: noqueue transfer failed
> >=20
> > This stall detection was introduced just a little after 4.4 which I was=
 using
> > before. The explanation, however, seems to talk only about spi-nor prob=
ing,
> > which is not the case since I'm using spidev.
> >=20
> > commit 5a1314fa697fc65cefaba64cd4699bfc3e6882a6
> > Author: Ricardo Ribalda <ribalda@kernel.org>
> > Date:   Tue Nov 21 10:09:02 2017 +0100
> >=20
> >     spi: xilinx: Detect stall with Unknown commands
> >=20
> >     When the core is configured in C_SPI_MODE > 0, it integrates a
> >     lookup table that automatically configures the core in dual or quad=
 mode
> >     based on the command (first byte on the tx fifo).
> >=20
> >     Unfortunately, that list mode_?_memoy_*.mif does not contain all th=
e
> >     supported commands by the flash.
> >=20
> >     Since 4.14 spi-nor automatically tries to probe the flash using SFD=
P
> >     (command 0x5a), and that command is not part of the list_mode table=
.
> >=20
> >     Whit the right combination of C_SPI_MODE and C_SPI_MEMORY this lead=
s
> >     into a stall that can only be recovered with a soft rest.
> >=20
> >     This patch detects this kind of stall and returns -EIO to the calle=
r on
> >     those commands. spi-nor can handle this error properly:
> >=20
> >     m25p80 spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY. 0=
x21
> > 0x2404
> >     m25p80 spi0.0: SPI transfer failed: -5
> >     spi_master spi0: failed to transfer one message from queue
> >     m25p80 spi0.0: s25sl064p (8192 Kbytes)
> >=20
> >=20
> > So, what I did then was removing the side effects of this stall detecti=
on, just
> > to see if I could readback from the ADC (also enabled debug):
> >=20
> > diff --git i/drivers/spi/spi-xilinx.c w/drivers/spi/spi-xilinx.c
> > index d59cc8a18484..3281623c59e6 100644
> > --- i/drivers/spi/spi-xilinx.c
> > +++ w/drivers/spi/spi-xilinx.c
> > @@ -307,8 +307,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *=
spi,
> > struct spi_transfer *t)
> >                 (sr & XSPI_SR_RX_EMPTY_MASK)) {
> >                 dev_err(&spi->dev,
> >                     "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\=
n");
> > -               xspi_init_hw(xspi);
> > -               return -EIO;
> >             }
> >=20
> >             if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {
> >=20
> > And so it happened that I can now readback the registers I previously w=
rite to
> > the ADC.
> >=20
> > ## Writing instruction
> > # art_adc322x -D /dev/spidev1.0  -r 0x13 -w 1
> > spidev spi1.0: spi mode 0
> > spidev spi1.0: msb first
> > spidev spi1.0: 8 bits per word
> > spidev spi1.0:   xfer len 3 tx 8bits 0 usec 0 usec 10000000Hz
> > spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > ## Reading instruction
> > # art_adc322x -D /dev/spidev1.0  -R 0x13
> > spidev spi1.0: spi mode 0
> > spidev spi1.0: msb first
> > spidev spi1.0: 8 bits per word
> > spidev spi1.0:   xfer len 3 rx tx 8bits 0 usec 0 usec 10000000Hz
> > spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > Reg: 13 =3D 01
> >=20
> > Before I (partially) reverted 5a1314fa697fc65cefaba64cd4699bfc3e6882a6,=
 this
> > procedure of course would only return 0 as the read register, since it =
was
> > returning early with that error.
> >=20
> > This seems to indicate that the stall detection is not correct, at leas=
t
> > when it's not working with a NOR mtd memory.
> >=20
> > I tried to add some more debug to check out the conditions of the stall
> > detection, so I inserted this:
> >=20
> > if (spi->dev.driver && !!strcmp(spi->dev.driver->name, "spi-nor"))
> >         dev_err(&spi->dev, "N=3D%s, rx_words =3D %d, n_words =3D %d, st=
alled =3D %d, sr
> > =3D 0x%02x, TX_EMPTY_MASK =3D 0x%02x, RX_EMPTY_MASK =3D 0x%02x\n",
> >                 spi->dev.init_name,
> >                 rx_words, n_words, stalled, sr, XSPI_SR_TX_EMPTY_MASK,
> > XSPI_SR_RX_EMPTY_MASK);
> > #endif
> > if (rx_words =3D=3D n_words && !(stalled--) &&
> >     !(sr & XSPI_SR_TX_EMPTY_MASK) &&
> >     (sr & XSPI_SR_RX_EMPTY_MASK)) {
> >         dev_err(&spi->dev,
> >                 "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\n");
> > }
> >=20
> > And the "Detected stall" didn't appear anymore, so I guess that there i=
s some
> > race condition going on that's been triggered by the kernel printing to=
 console:
>=20
>=20
> Could you try to increase the value of the variable stalled. Lets say
> from 10 to 10000 ?
>=20
> If that solves your issue, please try to figure out what value of
> stalled is the minimal that works for you?

Right, so a value of 16 still fails, but a value of 20 makes the ADC
communication flawless. Maybe we should just increase this a bit,
maybe to 32, for example?


>=20
> >=20
> > # art_adc322x -D /dev/spidev1.0  -r 0x13 -w 1
> > spidev spi1.0: spi mode 0
> > spidev spi1.0: msb first
> > spidev spi1.0: 8 bits per word
> > spidev spi1.0:   xfer len 3 tx 8bits 0 usec 0 usec 10000000Hz
> > spidev spi1.0: rx_words =3D 3, n_words =3D 3, stalled =3D 10, sr =3D 0x=
21, TX_EMPTY_MASK
> > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > spidev spi1.0: rx_words =3D 2, n_words =3D 3, stalled =3D 9, sr =3D 0x2=
4, TX_EMPTY_MASK
> > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > spidev spi1.0: rx_words =3D 1, n_words =3D 3, stalled =3D 9, sr =3D 0x2=
4, TX_EMPTY_MASK
> > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > # art_adc322x -D /dev/spidev1.0  -R 0x13
> > spidev spi1.0: spi mode 0
> > spidev spi1.0: msb first
> > spidev spi1.0: 8 bits per word
> > spidev spi1.0:   xfer len 3 rx tx 8bits 0 usec 0 usec 10000000Hz
> > spidev spi1.0: rx_words =3D 3, n_words =3D 3, stalled =3D 10, sr =3D 0x=
21, TX_EMPTY_MASK
> > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > spidev spi1.0: rx_words =3D 2, n_words =3D 3, stalled =3D 9, sr =3D 0x2=
4, TX_EMPTY_MASK
> > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > spidev spi1.0: rx_words =3D 1, n_words =3D 3, stalled =3D 9, sr =3D 0x2=
4, TX_EMPTY_MASK
> > =3D 0x04, RX_EMPTY_MASK =3D 0x01
> > Reg: 13 =3D 01
> >=20
> > If this race condition is true, it may be related to the fact that SR i=
s being
> > read without the use of an interrupt, and transmission/reception hasn't=
 yet
> > happened when it is read, so I checked to see if these transfers were b=
eing made
> > with an IRQ active or not, so I built the driver with these changes, un=
doing
> > all the other tests from before:
> >=20
> > diff --git i/drivers/spi/spi-xilinx.c w/drivers/spi/spi-xilinx.c
> > index d59cc8a18484..93abb0bd9481 100644
> > --- i/drivers/spi/spi-xilinx.c
> > +++ w/drivers/spi/spi-xilinx.c
> > @@ -248,6 +248,10 @@ static int xilinx_spi_txrx_bufs(struct spi_device =
*spi,
> > struct spi_transfer *t)
> >     xspi->rx_ptr =3D t->rx_buf;
> >     remaining_words =3D t->len / xspi->bytes_per_word;
> >=20
> > +   if (!strcmp(spi->dev.driver->name, "spidev"))
> > +       dev_err(&spi->dev, "xspi->irq =3D %d, xspi->force_irq =3D %d,
> > remaining_words =3D %d, xspi->buffer_size =3D %d\n",
> > +           xspi->irq, xspi->force_irq, remaining_words, xspi->buffer_s=
ize);
> > +
> >     if (xspi->irq >=3D 0 &&
> >         (xspi->force_irq || remaining_words > xspi->buffer_size)) {
> >         u32 isr;
> > @@ -307,8 +311,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *=
spi,
> > struct spi_transfer *t)
> >                 (sr & XSPI_SR_RX_EMPTY_MASK)) {
> >                 dev_err(&spi->dev,
> >                     "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\=
n");
> > -               xspi_init_hw(xspi);
> > -               return -EIO;
> >             }
> >=20
> >             if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {
> >=20
> > and I get
> >=20
> > Configuring ADCs: spidev spi1.0: xspi->irq =3D 4, xspi->force_irq =3D 0=
,
> > remaining_words =3D 3, xspi->buffer_size =3D 16
> > spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> >=20
> > So it does seem in fact that there's no IRQ being used, so of course th=
e next
> > thing I did was check out the purpose of xspi->force_irq:
> >=20
> > commit 1dd46599f83ac5323a175d32955b1270e95cd11b
> > Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Date:   Tue Feb 14 05:59:28 2023 -0800
> >=20
> >     spi: xilinx: add force_irq for QSPI mode
> >=20
> >     Xilinx PG158 page 80 [1] states that master transaction inhibit bit=
 must
> >     be set to properly setup the transaction in QSPI mode. Add the forc=
e_irq
> >     flag to follow this sequence.
> >=20
> >     [1]
> > https://docs.xilinx.com/r/en-US/pg153-axi-quad-spi/Dual/Quad-SPI-Mode-T=
ransactions
> >=20
> >     Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >     Link: https://lore.kernel.org/r/20230214135928.1253205-1-vadfed@met=
a.com
> >     Signed-off-by: Mark Brown <broonie@kernel.org>
> >=20
> >=20
> > I can understand that, but I don't understand why IRQ is only used if
> > remaining_words
> > is bigger than buffer size, nor why this force_irq is only being set to=
 true if
> > it's defined as such using platform_data, if I understand correctly:
>=20
> For small transactions, polling is significantly more efficient than
> waiting for the IRQ.


I see. But having that loop there, with a much increased value could be wor=
se,
right? Ideally we should measure how much time it takes one thing vs the ot=
her,
and in different situations (CPU and SPI clocks).

>=20
>=20
> >=20
> >         if (pdata) {
> >                 num_cs =3D pdata->num_chipselect;
> >                 bits_per_word =3D pdata->bits_per_word;
> >                 force_irq =3D pdata->force_irq;
> >         } else {
> >                 of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bi=
ts",
> >                                           &num_cs);
> >                 ret =3D of_property_read_u32(pdev->dev.of_node,
> >                                            "xlnx,num-transfer-bits",
> >                                            &bits_per_word);
> >                 if (ret)
> >                         bits_per_word =3D 8;
> >         }
> >=20
> > since the final assignment is just
> >=20
> >         xspi->force_irq =3D force_irq;
> >=20
> > So, the next step was to set force_irq to true, so no matter how the de=
vice is
> > being defined (dts or elsewhere) nor the number of words remaining, IRQ=
 mode
> > will always be used.
> >=20
> > This apparently solved the issue, but I wouldn't dare to send this as a=
 patch
> > because I don't fully understand all the implications of this, so I wou=
ld be
> > grateful is someone can help understand all this. I get that the transa=
ction
> > in QSPI mode may require this value to be set, but my ADC is a simple S=
PI
> > device with a single lane, and the SPI core is configured as such.
> >=20
> > Also, it seems strange to me that I am the only one person in the world=
 using
> > this core to work with SPI devices in userspace and this has gone unnot=
iced for
> > so long, so I wouldn't discard a) me being a weird guy or b) me being c=
ompletely
> > wrong about everything.
>=20
> I bet that you are not weirder than the rest of the people posting to
> lkml (me included) :P
>=20
> I just think that the spi clock is configured extremely slow compared
> to the microblaze speed and we are faulty detecting a stall.
> Increasing the stalled variable will probably be the best approach and
> I think it could be sent upstream.
>=20

Ah, right. The SPI driving the ADCs is using a 10MHz clock as ext_spi_clock
signal and a divider of 16, so that makes it a 625KHz clock. The microblaze
is working at 83.25MHz, so it could definitely be the cause. I can try and
increase that speed to check if that solves the issue. We chose that freque=
ncy
because we absolutely don't care about its speed and preferred the communic=
ation
be robust, but we don't mind either if it needs to be faster.


>=20
> >=20
> > - Now, onto the flash problem
> >=20
> > As I said, the old board had an mt25ql128 while the new one has an mt25=
ql02g.
> > The old flash chip did work without any issue with kernel 4.4, and does=
 work
> > as well with kernel 6.12. However, new flash won't work correctly with =
kernel
> > 6.12 (it didn't have support back in 4.4 times so I can't compare), and=
 the
> > same stalling message will be repeated all the time.
> >=20
> > Even though it keeps marking transactions as stalled, it seems to be ab=
le to
> > load
> > the squashfs filesystem stored in the flash, but mounting a jffs2 parti=
tion will
> > result in pages and pages of:
> >=20
> >=20
> > spi-nor spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > spi-nor spi0.0: SPI transfer failed: -5
> > spi_master spi0: failed to transfer one message from queue
> > spi_master spi0: noqueue transfer failed
> > jffs2: Erase at 0x00001000 failed immediately: errno -5
> > spi-nor spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
> > spi-nor spi0.0: SPI transfer failed: -5
> > spi_master spi0: failed to transfer one message from queue
> > spi_master spi0: noqueue transfer failed
> > jffs2: Erase at 0x001ff000 failed immediately: errno -5
> >=20
> > And writing to the flash will generate some other messages.
> >=20
> > # echo hello > /mnt/persistent/bar
> > jffs2: Node totlen on flash (0xffffffff) !=3D totlen from node ref (0x0=
0000044)
> >=20
> > Umounting and remounting that partition will produce another stream of =
stalls
> > like above, and the short file I created won't be there at all.
> >=20
> > I disabled CONFIG_MTD_SPI_NOR_USE_4K_SECTORS, because it seems this new=
 flash
> > has 64K sized sectors, and there seem to be less stall messages than be=
fore, but
> > still it doesn't seem capable of writing into the filesystem.
>=20
> Forcing the irq solve the issue here?
>=20
> Increasing the  stalled variable solves the issue?

A little increase to 32 didn't solve the issue, and a high value (32000) wh=
at
caused was the bootup sequence to get stuck (I didn't wait more than a coup=
le
of minutes), so it probably really needs a lot of time to finish all the
transactions. Since the rootfs is sitting on a squashfs on the flash, I gue=
ss
it has a lot to read from there.

Forcing the IRQ seemed to solve the stalling issue at first. I have been ab=
le
to mount the jffs2 partition, write to it, umount, power cycle, mount it ag=
ain
and check its contents are still there.

But then I've power cycled again and now it gets stuck trying to mount root=
fs,
so there's still something fishy there. Probably related to the same thing =
as
the boot failure, something to do with the state of the flash memory at boo=
t?

I have been trying all morning to replicate those working conditions but I
haven't been able to. I'm quite frustrated right now, because for a while i=
t
seemed that simply forcing the irq would solve the issue with the flash as =
well,
but now I can't find the way to make it work again. Maybe I dreamed it.

>=20
> If the answer is no to both, you need to check C_SPI_MODE and
> C_SPI_MEMORY. The core needs to know about your flash. yeah I know....
>=20

Oh my... I know what happened and it wasn't a dream. I have the design in V=
ivado
2016.2 and also in Vivado 2025.1. They must have added something to the SPI=
 core
so it now works with this new flash, and this must have been the design I w=
as
loading when tried to force the IRQ.

I still need to increase the initial stalled value to access the slow SPI c=
ore,
but it seems that using new Vivado there's no need to change anything for t=
his
flash to work. I'm astonished, because the SPI core version supposedly hasn=
't
changed, so the FPGA-hardware should be identical from one version to the o=
ther,
but it clearly isn't.

So... we can't patch this up in the kernel because it's the hardware that i=
s
defective (or, let's say, old hardware doesn't support modern flash, althou=
gh I
can't see why the SPI core needs to even know what a flash is and limit its=
elf
to move bytes from one device to the other).

> >=20
> > And finally, the most strange thing is that resetting the FPGA so it re=
loads
> > the full bitfile, including microblaze, spi core, and everything at all
> > but the flash has its reset pin hardwired to inactive) will produce tha=
t the
> > FSBL is suddenly unable to load the kernel from flash, (haven't debugge=
d this
> > yet), and the only way for the system to fully bootup again is to power=
-cycle
> > the board.
> >=20
> > This is doubly worrisome as the FPGA itself reads from this very same S=
PI flash
> > to gather its own bitfile, so how come the FSBL (a short C program inhe=
rited
> > from Vivado 2016) isn't now able to read the kernel from this same flas=
h and
> > load it into memory? So much I don't understand.
>=20
> Powercycing works, but resetting doesnt?
>=20
> I would bet that linux is leaving the flash in quad mode (or other
> mode) than FSBL do not understand.
>=20
> You can probably patch fsbl... Or maybe your fpga guy can change the
> way the flash is reseted: longer reset or what not, it has been a
> while since I used this ;)
>=20

The boot problem seems to exist even with thew new Vivado version, so I nee=
d to
dive deeper on this.

I am also the FPGA guy, which has its good things because I know how all th=
e
system is built, but on the other side I have no one to blame when somethin=
g
doesn't work. Sadly, I can't reset the flash, as the flash pin isn't routed=
 to
the FPGA (hey, I can blame the hardware engineer there!), so I'll try to se=
e
what I can do about it.


>=20
> >=20
> > This is even stranger than the spidev thing, because new kernel does wo=
rk with
> > the old flash, but it doesn't with the new one, which aren't that diffe=
rent
> > to each other.
> >=20
> > Now, are this problem and the SPIDEV one related? I have no idea, so I =
would
> > really appreciate any pointer to the right direction to debug this. I h=
aven't
> > gone as deep on this issue because it looks related to the spidev and s=
o I've
> > spent most of my time in diagnosing spi-xilinx.c, but I could be wrong =
about
> > it too.
> >=20
> > Sorry for the wall of text, I hope my step-by-step description of what'=
s
> > happening is useful.
>=20
>=20
> Hope this helped... good luck :)

A lot, thank you!

> >=20
> > Best regards,
> >=20

