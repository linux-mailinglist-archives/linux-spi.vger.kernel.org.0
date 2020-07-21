Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6863228156
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 15:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGUNvn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 21 Jul 2020 09:51:43 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41515 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgGUNvm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 09:51:42 -0400
Received: from windsurf.home (lfbn-bay-1-589-66.w90-30.abo.wanadoo.fr [90.30.52.66])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9F80224000B;
        Tue, 21 Jul 2020 13:51:40 +0000 (UTC)
Date:   Tue, 21 Jul 2020 15:51:39 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Cc:     <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: High CPU load when using MAX14830 SPI UART controller
Message-ID: <20200721155139.40fdb835@windsurf.home>
In-Reply-To: <4c5c972b-c8b8-4326-a1f9-438d88217a4a@cesnet.cz>
References: <20200519163353.20c03286@windsurf.home>
        <4c5c972b-c8b8-4326-a1f9-438d88217a4a@cesnet.cz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Jan,

On Wed, 20 May 2020 12:44:43 +0200
Jan Kundrát <jan.kundrat@cesnet.cz> wrote:

> I was getting something similar when I first wrote that patch. The TL;DR 
> version is that even though this UART has 128 byte FIFO per each direction 
> of each UART, I wanted my patch to stay conservative and only batch reads 
> in an opportunistic manner -- I wanted not to risk a possible RX FIFO 
> overflow. That's why the IRQ handler is eager to trigger as soon as there 
> are some data in the RX FIFO. Our setup has no HW flow control (no RTS/CTS, 
> no software flow control), so one has to hope that the IRQ latency is low 
> enough...
> 
> The MAX14830 supports also another mode of operation where the interrupt 
> fires only when the RX buffer gets filled over a configurable minimal 
> threshold. This can be combined with yet another interrupt which fires 
> whenever there's some data in the RX FIFO for "too long". Unfortunately, 
> this timer starts over again upon reception of any additional data, so it's 
> the *youngest* byte in the RX FIFO that controls triggering of this delayed 
> interrupt.

Do you have some more details about this mode of operation? I looked a
bit at the MAX14830 datasheet and code, but couldn't spot what allows
an interrupt to be triggered after X bytes have been received *OR* if
data has been sitting in the FIFO for too long.

> I am not sure how to balance the latency ("how soon is userspace notified 
> about this byte") with CPU utilization ("don't read data byte-by-byte from 
> this 128 byte buffer"). If there's some cross-driver support for "something 
> like that" in the TTY layer, I'm sure that max310x.c could be adopted to 
> make use of that. Otherwise, we could always add a pair of DT properties 
> for controling:
> 
> a) the "start reading from RX FIFO" timeout,
> b) "allow up to X bytes in the RX FIFO, I know that my platform has enough 
> CPU and SPI bandwidth to finish reading that before the RX FIFO overflows"
> 
> BTW, there are also real SPI bus throughput limitations, see 
> 2258761213cb239e5e6c11b4ec9b1700fcb4fdcd for some numbers from my platform. 
> The chip supports up to 26 MHz (but not all bus masters have clock 
> granularities fine enough to use this), that's 3.25 MBps of raw throughput 
> divided among four UARTs. Reading each register takes at least two bytes, 
> one has to check the top-level IRQ status register (to decide which UART to 
> check), then read per-UART IRQ registers, and only then start reading the 
> data. Also, batched reading can only happen if userspace explicitly ignores 
> framing errors, parity errors, etc, otherwise the driver will have to read 
> byte-by-byte, and check the line status register, etc.

Yes, there is definitely some significant overhead with all those SPI
transactions. But here I'm mostly concerned about CPU usage rather than
actual bandwidth on the UART.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
