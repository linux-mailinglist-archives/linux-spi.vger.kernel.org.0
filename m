Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC21DB0B7
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 12:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgETKyG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 06:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETKyF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 May 2020 06:54:05 -0400
X-Greylist: delayed 559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 May 2020 03:54:05 PDT
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:1:101::144:244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D53C061A0F
        for <linux-spi@vger.kernel.org>; Wed, 20 May 2020 03:54:05 -0700 (PDT)
Received: from localhost (ip-94-112-198-29.net.upcbroadband.cz [94.112.198.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 4C322400065;
        Wed, 20 May 2020 12:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1589971484;
        bh=yVrOQlSMXLkUQo61nYnYIft5x9dvSb8aaySUwpLJgQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lrkh8mrQbYF60iY891AfJns9TKhVLe9/zV2BSLdt4cAjUnGB4IowIDHSadjkFziBO
         IAJ+3Qq5ob/LZ6DD6aGK46haBsa2ZiKyk2a19hTPxBOVcFMBe8qNTr4TSBI/WwMEps
         HUQthtMVAPY0MEv8KOujsGvfr46iRei7kz9M6InI8kSk5fJ6127BB7s4uBjExc4IZW
         j2ZvRLf3dDaCmmMFNCgN8i0AetiHyaSZTkJrFUH36rzMta+Nd88Uw/Qb6w89gqhg83
         zsR0OTG/pMnK9a/0tN51lnuyXhjI3bv7jbBMgBbKlzOxN+LKJBlZd7aoPjVlvxcsEW
         Q/NAGPS8sTJpQ==
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: High CPU load when using MAX14830 SPI UART controller
Date:   Wed, 20 May 2020 12:44:43 +0200
MIME-Version: 1.0
Message-ID: <4c5c972b-c8b8-4326-a1f9-438d88217a4a@cesnet.cz>
In-Reply-To: <20200519163353.20c03286@windsurf.home>
References: <20200519163353.20c03286@windsurf.home>
Organization: CESNET
User-Agent: Trojita/v0.7-412-g2869c385e; Qt/5.13.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> With the sending of 20 bytes data frames every 16 ms, it means data is
> send ~62.5 per seconds.
>
> Looking at /proc/interrupts, I get ~260 interrupts per second on the
> MAX14830, which means that the "batch reading" implemented in
> 2b4bac48c10848ccffd484e7cd025dc085c1bd32 is effective but not to the
> point where I have a single interrupt per received frame.

Hi,
I was getting something similar when I first wrote that patch. The TL;DR=20
version is that even though this UART has 128 byte FIFO per each direction=20=

of each UART, I wanted my patch to stay conservative and only batch reads=20
in an opportunistic manner -- I wanted not to risk a possible RX FIFO=20
overflow. That's why the IRQ handler is eager to trigger as soon as there=20
are some data in the RX FIFO. Our setup has no HW flow control (no RTS/CTS,=20=

no software flow control), so one has to hope that the IRQ latency is low=20
enough...

The MAX14830 supports also another mode of operation where the interrupt=20
fires only when the RX buffer gets filled over a configurable minimal=20
threshold. This can be combined with yet another interrupt which fires=20
whenever there's some data in the RX FIFO for "too long". Unfortunately,=20
this timer starts over again upon reception of any additional data, so it's=20=

the *youngest* byte in the RX FIFO that controls triggering of this delayed=20=

interrupt.

I am not sure how to balance the latency ("how soon is userspace notified=20
about this byte") with CPU utilization ("don't read data byte-by-byte from=20=

this 128 byte buffer"). If there's some cross-driver support for "something=20=

like that" in the TTY layer, I'm sure that max310x.c could be adopted to=20
make use of that. Otherwise, we could always add a pair of DT properties=20
for controling:

a) the "start reading from RX FIFO" timeout,
b) "allow up to X bytes in the RX FIFO, I know that my platform has enough=20=

CPU and SPI bandwidth to finish reading that before the RX FIFO overflows"

BTW, there are also real SPI bus throughput limitations, see=20
2258761213cb239e5e6c11b4ec9b1700fcb4fdcd for some numbers from my platform.=20=

The chip supports up to 26 MHz (but not all bus masters have clock=20
granularities fine enough to use this), that's 3.25 MBps of raw throughput=20=

divided among four UARTs. Reading each register takes at least two bytes,=20
one has to check the top-level IRQ status register (to decide which UART to=20=

check), then read per-UART IRQ registers, and only then start reading the=20
data. Also, batched reading can only happen if userspace explicitly ignores=20=

framing errors, parity errors, etc, otherwise the driver will have to read=20=

byte-by-byte, and check the line status register, etc.

Anyway, I'll be happy to review and test any patches you might have; we're=20=

using these chips and we are interested in their performance and error-free=20=

operation.

With kind regards,
Jan
