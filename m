Return-Path: <linux-spi+bounces-11037-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E98C360FA
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 15:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CAC188402E
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDDF12CDBE;
	Wed,  5 Nov 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="AYEMnKyp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BC1A3172
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352886; cv=none; b=UQkiO6kCTaivzupfoSo/Ki+B88QDflEkWHueEwU2J7K9oMYDSk6syHBEjp+ldVFlW2pKed8jgeAxCd8RkE94SSO5LNiwatnfUfHlGctOyxAJpkLTOJKTlE/KCneFLMLec2FghwE8Es6iwRz3eiRSp8Ot7DkTV079/dtlVgl2Ctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352886; c=relaxed/simple;
	bh=kMvg3iVwyCEqJLAtW8aDUjZcN6md28fkk4sWWSLXvd8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=YLIZAjUJgQQ2+TQYiB9fZG602abXgZ5uHpBGjdtkOSP9Mn4PpNKmTVQSeymT00v7kBhF7qWbVYNlrz9Q7r4MsjjUj548xwDpcbnRckyB7kEoYIHUplkno5yuqO4wYB6HQDjuy8GcRqLQ9+33rIlorwIFiCu45/5nFUMX+L/TkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=AYEMnKyp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47755a7652eso15662095e9.0
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1762352881; x=1762957681; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=anHtmFyNR3BrpW+OmKpYv4FdpOGERtzD5hPDTfAa5sM=;
        b=AYEMnKypylbFvQRb24aozRTrASmZ/hl28yC6PmX/XwhGQdGbhm2oFWEDKqf7Dks7Dt
         K/LCRWPDSvu8HVx4pJeC6Ym+ICkCcYLrn0YX4/20tuAicY/nLzBYCw6q0OJcK72Z+oos
         HLQeg0EdaJB+DNvfILVVDNjMrSfr2QhkJIzPOvOtUUmIo1RUPsv0JL1TD8cb5Wzavj9b
         KVJKAYb4YIFrvNB3ZDa1bDLA4E+QeIj7hAtobhQgLhfqUdxpkcFx8meHIdVt7SPjJY1+
         BuDDSQCQLz13bvmL8ojEgFA/UD40wiwldK+9c30I7KxHLYPoiPyYl6Oc1At+YSLvyEKs
         9txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352881; x=1762957681;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anHtmFyNR3BrpW+OmKpYv4FdpOGERtzD5hPDTfAa5sM=;
        b=cnmUWNdAfAvUeUwW1CwNWcevGnA3RnPFQRwgLVDTLs16ZAFW/oKG5yFACf0EuMSguI
         HVlyi4g5x72kdPXfOhIGZa9+40IaMn1+0IEHEAkbZs1BxYoAtwEk7o968stzofAh1kcP
         5UCyAlMJMCNr5KusVn3aVp/pQb7pBiPriuH/n1wqaiik2+CeHoaIlFndVa51NLgNZckY
         t8keql76efpdh8sAZM2AF5/fgnR6m/mrbuPBjkg9oZAXUo9JnXaHynEe4Gsgo7XuYFNu
         hDpfER6nxeum60nbFQ95hlxIDs/Swe7bB9QYfGOb8xxLyIK9/kKtOXqCyZM4436xjY0o
         9dqQ==
X-Gm-Message-State: AOJu0YxO9MEQ4vpuSoQsElBxV3remAsOfAYpuhFQ9o5rBt1xGAoUBS8t
	iNbZqb09iyxB/zeLmpT0a2ZqacO3PjxitdHYsb3hA0gG5HlYN4FF1PhCVxeoOalSVkoCX8MS8JN
	k7Og=
X-Gm-Gg: ASbGnctOJbviY/d60q8fkToFzQLzZanQIqhJetxwS3XASARrE0mcwCh04c1ZphaJjNl
	aEGcgN1CYGCVaZ5tvdos+DuOQRS793Z77H/3d/JDHRxSWmPEuOvBW36GEVKrJFFM4/E4vC+uxC6
	ROT7zw5fCb7nlAKpVtYVAWvZoEXtMZ55BzmBdB+t07anxgXGAtvEGNRTFbWcQ0e49zikSwLPDYg
	uDtr4EgTVcoMP7qgNZD2k2JX5woYWBj2gelRugVZ+KpOKPGYTjix6NI9W5xZUC4VqQNAX4WAqM1
	wutkk8tpiQIeEMm4MuKTSwHWx+NOJcrqCkYndAsgUI0g2FnhkaBbR5t+X6GhUCxaezpubZBX9H8
	IfkiSncb0qHpVkHVS0E9aatgPDVp+4iXzOn36MmUX9uhT+LLr9Ke7aaDiGdRexVIMOlHZBMUvV2
	acZE4Je57UrejIpmFR/Og=
X-Google-Smtp-Source: AGHT+IEr4LOSCVp+wasWAWQYX2jO+VYRKn4aGMdT/1mt6G+Obl236RDlEEHU4oo3Egi9u1VzEns0Rw==
X-Received: by 2002:a05:600c:1910:b0:46e:4783:1a7a with SMTP id 5b1f17b1804b1-4775cdf467emr31896025e9.3.1762352881041;
        Wed, 05 Nov 2025 06:28:01 -0800 (PST)
Received: from [192.168.2.3] ([109.227.153.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc19227csm11203438f8f.11.2025.11.05.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:28:00 -0800 (PST)
Message-ID: <ea5e6915f997d4f1482cb8ab16c81e4406b224a3.camel@hazent.com>
Subject: spi-xilinx.c: Xilinx axi_quad_spi "Detected stall. Check C_SPI_MODE
 and C_SPI_MEMORY" in spidev mode and in spi-nor with MT25QL02G
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: linux-spi@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>, Mark Brown <broonie@kernel.org>, 
 Ricardo Ribalda <ribalda@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Date: Wed, 05 Nov 2025 15:27:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Xilinx axi_quad_spi "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY" in
spidev mode and in spi-nor with MT25QL02G

Hi,

We're making a new version of a PCB we had back in 2016 which used kernel 4=
.4
and we are now upgrading to 6.12 series. The board fits an xc7100t fpga fro=
m
Xilinx, which is running a microblaze soft-core and has two axi_quad_spi co=
res.

The first of them, in Quad mode is connected to an spi-nor flash, while the
second spi core is used to interface with two adc3442 from Texas Instrument=
s
from userspace, so I patch spidev.c to include a line for the device tree a=
s
ti,adc344x.

The old PCB used an mt25ql128 flash, while the new version uses MT25QL02G. =
My
intent is to upgrade the software for both PCBs.

- The SPIDEV problem

The first issue that I've noticed is that spidev device detects an stall in
the new kernel, as whenever I access /dev/spidev1.0 or /dev/spidev1.1 to
configure one of the ADCs, the following message is generated, and reading
from the ADC fails (I'm not sure about writes though, since I can't readbac=
k
what I sent, but from the behaviour of the ADC regarding its sampling
functionality, it could very be properly receiving writes):

spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
spidev spi1.0: SPI transfer failed: -5
spi_master spi1: failed to transfer one message from queue
spi_master spi1: noqueue transfer failed

This stall detection was introduced just a little after 4.4 which I was usi=
ng
before. The explanation, however, seems to talk only about spi-nor probing,
which is not the case since I'm using spidev.=20

commit 5a1314fa697fc65cefaba64cd4699bfc3e6882a6
Author: Ricardo Ribalda <ribalda@kernel.org>
Date:   Tue Nov 21 10:09:02 2017 +0100

    spi: xilinx: Detect stall with Unknown commands
   =20
    When the core is configured in C_SPI_MODE > 0, it integrates a
    lookup table that automatically configures the core in dual or quad mod=
e
    based on the command (first byte on the tx fifo).
   =20
    Unfortunately, that list mode_?_memoy_*.mif does not contain all the
    supported commands by the flash.
   =20
    Since 4.14 spi-nor automatically tries to probe the flash using SFDP
    (command 0x5a), and that command is not part of the list_mode table.
   =20
    Whit the right combination of C_SPI_MODE and C_SPI_MEMORY this leads
    into a stall that can only be recovered with a soft rest.
   =20
    This patch detects this kind of stall and returns -EIO to the caller on
    those commands. spi-nor can handle this error properly:
   =20
    m25p80 spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY. 0x21
0x2404
    m25p80 spi0.0: SPI transfer failed: -5
    spi_master spi0: failed to transfer one message from queue
    m25p80 spi0.0: s25sl064p (8192 Kbytes)


So, what I did then was removing the side effects of this stall detection, =
just
to see if I could readback from the ADC (also enabled debug):

diff --git i/drivers/spi/spi-xilinx.c w/drivers/spi/spi-xilinx.c
index d59cc8a18484..3281623c59e6 100644
--- i/drivers/spi/spi-xilinx.c
+++ w/drivers/spi/spi-xilinx.c
@@ -307,8 +307,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi,
struct spi_transfer *t)
                (sr & XSPI_SR_RX_EMPTY_MASK)) {
                dev_err(&spi->dev,
                    "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\n");
-               xspi_init_hw(xspi);
-               return -EIO;
            }
=20
            if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {

And so it happened that I can now readback the registers I previously write=
 to
the ADC.

## Writing instruction
# art_adc322x -D /dev/spidev1.0  -r 0x13 -w 1
spidev spi1.0: spi mode 0
spidev spi1.0: msb first
spidev spi1.0: 8 bits per word
spidev spi1.0:   xfer len 3 tx 8bits 0 usec 0 usec 10000000Hz
spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
## Reading instruction
# art_adc322x -D /dev/spidev1.0  -R 0x13=20
spidev spi1.0: spi mode 0
spidev spi1.0: msb first
spidev spi1.0: 8 bits per word
spidev spi1.0:   xfer len 3 rx tx 8bits 0 usec 0 usec 10000000Hz
spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
Reg: 13 =3D 01

Before I (partially) reverted 5a1314fa697fc65cefaba64cd4699bfc3e6882a6, thi=
s
procedure of course would only return 0 as the read register, since it was
returning early with that error.

This seems to indicate that the stall detection is not correct, at least
when it's not working with a NOR mtd memory.

I tried to add some more debug to check out the conditions of the stall
detection, so I inserted this:

if (spi->dev.driver && !!strcmp(spi->dev.driver->name, "spi-nor"))
        dev_err(&spi->dev, "N=3D%s, rx_words =3D %d, n_words =3D %d, stalle=
d =3D %d, sr
=3D 0x%02x, TX_EMPTY_MASK =3D 0x%02x, RX_EMPTY_MASK =3D 0x%02x\n",
                spi->dev.init_name,
                rx_words, n_words, stalled, sr, XSPI_SR_TX_EMPTY_MASK,
XSPI_SR_RX_EMPTY_MASK);
#endif
if (rx_words =3D=3D n_words && !(stalled--) &&
    !(sr & XSPI_SR_TX_EMPTY_MASK) &&
    (sr & XSPI_SR_RX_EMPTY_MASK)) {
        dev_err(&spi->dev,
                "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\n");
}

And the "Detected stall" didn't appear anymore, so I guess that there is so=
me
race condition going on that's been triggered by the kernel printing to con=
sole:

# art_adc322x -D /dev/spidev1.0  -r 0x13 -w 1
spidev spi1.0: spi mode 0
spidev spi1.0: msb first
spidev spi1.0: 8 bits per word
spidev spi1.0:   xfer len 3 tx 8bits 0 usec 0 usec 10000000Hz
spidev spi1.0: rx_words =3D 3, n_words =3D 3, stalled =3D 10, sr =3D 0x21, =
TX_EMPTY_MASK
=3D 0x04, RX_EMPTY_MASK =3D 0x01
spidev spi1.0: rx_words =3D 2, n_words =3D 3, stalled =3D 9, sr =3D 0x24, T=
X_EMPTY_MASK
=3D 0x04, RX_EMPTY_MASK =3D 0x01
spidev spi1.0: rx_words =3D 1, n_words =3D 3, stalled =3D 9, sr =3D 0x24, T=
X_EMPTY_MASK
=3D 0x04, RX_EMPTY_MASK =3D 0x01
# art_adc322x -D /dev/spidev1.0  -R 0x13
spidev spi1.0: spi mode 0
spidev spi1.0: msb first
spidev spi1.0: 8 bits per word
spidev spi1.0:   xfer len 3 rx tx 8bits 0 usec 0 usec 10000000Hz
spidev spi1.0: rx_words =3D 3, n_words =3D 3, stalled =3D 10, sr =3D 0x21, =
TX_EMPTY_MASK
=3D 0x04, RX_EMPTY_MASK =3D 0x01
spidev spi1.0: rx_words =3D 2, n_words =3D 3, stalled =3D 9, sr =3D 0x24, T=
X_EMPTY_MASK
=3D 0x04, RX_EMPTY_MASK =3D 0x01
spidev spi1.0: rx_words =3D 1, n_words =3D 3, stalled =3D 9, sr =3D 0x24, T=
X_EMPTY_MASK
=3D 0x04, RX_EMPTY_MASK =3D 0x01
Reg: 13 =3D 01

If this race condition is true, it may be related to the fact that SR is be=
ing
read without the use of an interrupt, and transmission/reception hasn't yet
happened when it is read, so I checked to see if these transfers were being=
 made
with an IRQ active or not, so I built the driver with these changes, undoin=
g
all the other tests from before:

diff --git i/drivers/spi/spi-xilinx.c w/drivers/spi/spi-xilinx.c
index d59cc8a18484..93abb0bd9481 100644
--- i/drivers/spi/spi-xilinx.c
+++ w/drivers/spi/spi-xilinx.c
@@ -248,6 +248,10 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi=
,
struct spi_transfer *t)
    xspi->rx_ptr =3D t->rx_buf;
    remaining_words =3D t->len / xspi->bytes_per_word;
=20
+   if (!strcmp(spi->dev.driver->name, "spidev"))
+       dev_err(&spi->dev, "xspi->irq =3D %d, xspi->force_irq =3D %d,
remaining_words =3D %d, xspi->buffer_size =3D %d\n",
+           xspi->irq, xspi->force_irq, remaining_words, xspi->buffer_size)=
;
+
    if (xspi->irq >=3D 0 &&
        (xspi->force_irq || remaining_words > xspi->buffer_size)) {
        u32 isr;
@@ -307,8 +311,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi,
struct spi_transfer *t)
                (sr & XSPI_SR_RX_EMPTY_MASK)) {
                dev_err(&spi->dev,
                    "Detected stall. Check C_SPI_MODE and C_SPI_MEMORY\n");
-               xspi_init_hw(xspi);
-               return -EIO;
            }
=20
            if ((sr & XSPI_SR_TX_EMPTY_MASK) && (rx_words > 1)) {

and I get

Configuring ADCs: spidev spi1.0: xspi->irq =3D 4, xspi->force_irq =3D 0,
remaining_words =3D 3, xspi->buffer_size =3D 16
spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY

So it does seem in fact that there's no IRQ being used, so of course the ne=
xt
thing I did was check out the purpose of xspi->force_irq:

commit 1dd46599f83ac5323a175d32955b1270e95cd11b
Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Date:   Tue Feb 14 05:59:28 2023 -0800

    spi: xilinx: add force_irq for QSPI mode
   =20
    Xilinx PG158 page 80 [1] states that master transaction inhibit bit mus=
t
    be set to properly setup the transaction in QSPI mode. Add the force_ir=
q
    flag to follow this sequence.
   =20
    [1]
https://docs.xilinx.com/r/en-US/pg153-axi-quad-spi/Dual/Quad-SPI-Mode-Trans=
actions
   =20
    Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
    Link: https://lore.kernel.org/r/20230214135928.1253205-1-vadfed@meta.co=
m
    Signed-off-by: Mark Brown <broonie@kernel.org>


I can understand that, but I don't understand why IRQ is only used if
remaining_words
is bigger than buffer size, nor why this force_irq is only being set to tru=
e if
it's defined as such using platform_data, if I understand correctly:

        if (pdata) {
                num_cs =3D pdata->num_chipselect;
                bits_per_word =3D pdata->bits_per_word;
                force_irq =3D pdata->force_irq;
        } else {
                of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
                                          &num_cs);
                ret =3D of_property_read_u32(pdev->dev.of_node,
                                           "xlnx,num-transfer-bits",
                                           &bits_per_word);
                if (ret)
                        bits_per_word =3D 8;
        }

since the final assignment is just

	xspi->force_irq =3D force_irq;

So, the next step was to set force_irq to true, so no matter how the device=
 is
being defined (dts or elsewhere) nor the number of words remaining, IRQ mod=
e
will always be used.

This apparently solved the issue, but I wouldn't dare to send this as a pat=
ch
because I don't fully understand all the implications of this, so I would b=
e
grateful is someone can help understand all this. I get that the transactio=
n
in QSPI mode may require this value to be set, but my ADC is a simple SPI
device with a single lane, and the SPI core is configured as such.

Also, it seems strange to me that I am the only one person in the world usi=
ng
this core to work with SPI devices in userspace and this has gone unnoticed=
 for
so long, so I wouldn't discard a) me being a weird guy or b) me being compl=
etely
wrong about everything.

- Now, onto the flash problem

As I said, the old board had an mt25ql128 while the new one has an mt25ql02=
g.
The old flash chip did work without any issue with kernel 4.4, and does wor=
k
as well with kernel 6.12. However, new flash won't work correctly with kern=
el
6.12 (it didn't have support back in 4.4 times so I can't compare), and the
same stalling message will be repeated all the time.

Even though it keeps marking transactions as stalled, it seems to be able t=
o
load
the squashfs filesystem stored in the flash, but mounting a jffs2 partition=
 will
result in pages and pages of:


spi-nor spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
spi-nor spi0.0: SPI transfer failed: -5
spi_master spi0: failed to transfer one message from queue
spi_master spi0: noqueue transfer failed
jffs2: Erase at 0x00001000 failed immediately: errno -5
spi-nor spi0.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY
spi-nor spi0.0: SPI transfer failed: -5
spi_master spi0: failed to transfer one message from queue
spi_master spi0: noqueue transfer failed
jffs2: Erase at 0x001ff000 failed immediately: errno -5

And writing to the flash will generate some other messages.

# echo hello > /mnt/persistent/bar
jffs2: Node totlen on flash (0xffffffff) !=3D totlen from node ref (0x00000=
044)

Umounting and remounting that partition will produce another stream of stal=
ls
like above, and the short file I created won't be there at all.

I disabled CONFIG_MTD_SPI_NOR_USE_4K_SECTORS, because it seems this new fla=
sh
has 64K sized sectors, and there seem to be less stall messages than before=
, but
still it doesn't seem capable of writing into the filesystem.

And finally, the most strange thing is that resetting the FPGA so it reload=
s
the full bitfile, including microblaze, spi core, and everything at all=20
but the flash has its reset pin hardwired to inactive) will produce that th=
e
FSBL is suddenly unable to load the kernel from flash, (haven't debugged th=
is
yet), and the only way for the system to fully bootup again is to power-cyc=
le
the board.

This is doubly worrisome as the FPGA itself reads from this very same SPI f=
lash
to gather its own bitfile, so how come the FSBL (a short C program inherite=
d
from Vivado 2016) isn't now able to read the kernel from this same flash an=
d
load it into memory? So much I don't understand.

This is even stranger than the spidev thing, because new kernel does work w=
ith
the old flash, but it doesn't with the new one, which aren't that different
to each other.

Now, are this problem and the SPIDEV one related? I have no idea, so I woul=
d
really appreciate any pointer to the right direction to debug this. I haven=
't
gone as deep on this issue because it looks related to the spidev and so I'=
ve
spent most of my time in diagnosing spi-xilinx.c, but I could be wrong abou=
t
it too.

Sorry for the wall of text, I hope my step-by-step description of what's
happening is useful.

Best regards,


