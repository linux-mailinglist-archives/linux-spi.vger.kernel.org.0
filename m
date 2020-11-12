Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A9B2B0E78
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 20:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKLTsw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 14:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKLTsw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Nov 2020 14:48:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D42C0613D1
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2020 11:48:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a9so9231682lfh.2
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2020 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nTNqu/no78+V2+owXn2w1B78uWSM/GyiYE0GjYzPXI=;
        b=kt+/hRE9zu76oTbRa2EMx9hhLtEB5RXhe7KU11iccBfbdld/wUySUGaFNEMP+jJVfN
         ckBvAHh7lySu7KmIj1fV3pKb/OsKE+XBS+QkV2+BVHohbxHpRq9kgDaDkV/XVKnBfsTL
         mzEKB+hUg1BUmB9EB1I5hR15L2EpkhN1GmvmTIaN6HdfsTzAMOaT7WllrH5HAVTfYsj8
         wcmhbb1PWhcvW5tAC+9eQM6CRcC19IRpyqOOx7hEBq1d3Xf+HX4HkveIVhWimrZjKbHr
         JAXn/6LU8PU3iD5DF1HHLIkeC0xIf6TP1ezP+6QsyjOLezhIANhN4RuxElyOI5x6jACm
         gOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nTNqu/no78+V2+owXn2w1B78uWSM/GyiYE0GjYzPXI=;
        b=FljIvZOxRDQdIAsSiBigVBS2CAEA6Ki9RssRxt3ynLf1Upxt00xbiJpc95r231CUIr
         uYgcC1tdU24VT6TNn1XbUNg5V1kaXzjKYm0xujWzTPYhWf+qdgR6qfJ5E9bxIDefuTp5
         JaaewI2JW0tXN2ymLxBCZaJmg8Di87IeM3Nyw72zKN9Mqljlny9HBAhHEoPYuCaJp1fm
         5iXqy8RpxrCmbYNnfBZX957J2KMJJ24HiDhhmm3mT+ZCaleMxtdr0AFHUipr0GgnR03X
         RVLReCj7s9pVxk0u7CQLiM5GkCkBi3qRJYePOHGzEmeS9WqSXdC32spyagXF6gpvFGOD
         y8lQ==
X-Gm-Message-State: AOAM531/z7DMrMF0UN/KJLxVxlVH508b6pImh6+hziae4vgzR/FEzK5b
        Va4eOu4d8MPjv8/xMy8B1UREYJ5ciFaA+vkJtepX82EojJWOlw==
X-Google-Smtp-Source: ABdhPJwayHjidgcyyftcMOBzNFkCvUBJ68ZjmXTKvxzhL0SV1Os3sDcpuH0Uf/SZ8NaAqoA2R9/dQQx2qqDnc+Nlyf8=
X-Received: by 2002:a19:9110:: with SMTP id t16mr389469lfd.300.1605210530044;
 Thu, 12 Nov 2020 11:48:50 -0800 (PST)
MIME-Version: 1.0
References: <CAMS2kBHyempbPTT5dnJ8Vb+FMop4-BjyKa4A=tB+U-cS4h7aDw@mail.gmail.com>
 <1ef36838-81f1-5b64-bcf5-69c1bb1ff082@ti.com>
In-Reply-To: <1ef36838-81f1-5b64-bcf5-69c1bb1ff082@ti.com>
From:   Glenn Schmottlach <gschmottlach@gmail.com>
Date:   Thu, 12 Nov 2020 14:48:38 -0500
Message-ID: <CAMS2kBFmr3s8Y=ssyFGcZTNFRg3rAS_23X6UyxEYWSr8ere+wQ@mail.gmail.com>
Subject: Re: Linux SPI Slave fails to respond under high load on BeagleBone Black
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 10, 2020 at 2:06 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:

> Could you trace how much of data is left in TX FIFO using MCSPI_CHSTAT_0
> and MCSPI_XFERLEVEL registers?
>

When the SPI slave is no longer responding to the SPI master the
following was observed on the SPI slave:

devmem2 0x48030130 w    (CHSTAT_0)
Read at address  0x48030130 (0xb6f5c130): 0x0000004F

So  0x4F means:
      RXFFF=1 (FIFO RX buffer is full)
      TXFFE=1 (FIFO transmit buffer is empty)
      EOT=1 (Set to 1 at end of SPI transfer)
      TXS=1 (TX register status: register is empty)
      RXS=1 (RX register status: register is full)

So it appears there is data ready to be read from the SPI master and
there is no data scheduled to be sent.

devmem2 0x4803017C w  (XFERLEVEL)
Read at address  0x4803017C (0xb6fd717c): 0x00000000

So WCNT = 0 and it appears no words are scheduled to be transferred on
the channel.

Again, the SPI slave appears to be "stuck"

Here is a function trace on the SPI slave leading up to it being "stuck"

root@beaglebone:~# spi-pipe -d /dev/spidev0.0 -s 24000000 -b 32 -n -1
< /dev/random | hexdump -vC
[ 9895.479249] omap2_mcspi_setup(1136): enter
[ 9895.483597] omap_mcspi_runtime_resume(1480): enter
[ 9895.488569] omap_mcspi_runtime_resume(1503): exit
[ 9895.499704] omap2_mcspi_setup_transfer(987): enter
[ 9895.505606] omap2_mcspi_setup_transfer(1068): exit
[ 9895.510429] omap2_mcspi_setup(1175): exit
[ 9895.522659] omap2_mcspi_set_cs(273): enter -> enable = 1
[ 9895.528052] omap2_mcspi_set_cs(304): exit
[ 9895.532392] omap2_mcspi_prepare_message(1378): enter
[ 9895.542695] omap2_mcspi_prepare_message(1396): exit
[ 9895.547606] omap2_mcspi_can_dma(1404): enter
[ 9895.551889] omap2_mcspi_can_dma(1415): exit
[ 9895.560061] omap2_mcspi_set_cs(273): enter -> enable = 0
[ 9895.566406] omap2_mcspi_set_cs(304): exit
[ 9895.570578] omap2_mcspi_transfer_one(1254): enter
[ 9895.581994] omap2_mcspi_set_enable(255): enter -> enable = 0
[ 9895.588708] omap2_mcspi_set_enable(265): exit
[ 9895.596666] omap2_mcspi_setup_transfer(987): enter
[ 9895.601536] omap2_mcspi_setup_transfer(1068): exit
[ 9895.612715] omap2_mcspi_can_dma(1404): enter
[ 9895.617007] omap2_mcspi_can_dma(1415): exit
[ 9895.621202] omap2_mcspi_set_fifo(343): enter -> enable = 1
[ 9895.635896] mcspi_bytes_per_word(214): enter
[ 9895.640190] mcspi_bytes_per_word(223): exit
[ 9895.647441] omap2_mcspi_set_fifo(376): exit
[ 9895.651646] omap2_mcspi_set_enable(255): enter -> enable = 1
[ 9895.662705] omap2_mcspi_set_enable(265): exit
[ 9895.667085] omap2_mcspi_can_dma(1404): enter
[ 9895.671368] omap2_mcspi_can_dma(1415): exit
[ 9895.681567] omap2_mcspi_txrx_dma(675): enter
[ 9895.686832] omap2_mcspi_irq_handler(1203): enter
[ 9895.691495] omap2_mcspi_irq_handler(1215): exit
[ 9895.701131] omap2_mcspi_tx_dma(472): enter
[ 9895.706728] omap2_mcspi_set_dma_req(232): enter
[ 9895.711344] omap2_mcspi_tx_callback(454): enter
[ 9895.715943] omap2_mcspi_set_dma_req(232): enter
[ 9895.720528] omap2_mcspi_set_dma_req(247): exit
[ 9895.725001] omap2_mcspi_tx_callback(459): exit
[ 9895.743431] omap2_mcspi_set_dma_req(247): exit
[ 9895.747902] omap2_mcspi_tx_dma(492): exit
[ 9895.751924] omap2_mcspi_rx_dma(512): enter
[ 9895.758134] omap2_mcspi_set_dma_req(232): enter
[ 9895.765133] omap2_mcspi_set_dma_req(247): exit
[ 9895.769599] mcspi_wait_for_completion(418): enter
[ 9906.203277] omap2_mcspi_rx_callback(440): enter
[ 9906.207876] omap2_mcspi_set_dma_req(232): enter
[ 9906.212568] omap2_mcspi_set_dma_req(247): exit
[ 9906.217114] omap2_mcspi_rx_callback(445): exit
[ 9906.232642] omap2_mcspi_set_dma_req(232): enter
[ 9906.238512] omap2_mcspi_set_dma_req(247): exit
[ 9906.253163] omap2_mcspi_rx_dma(594): exit
[ 9906.257206] mcspi_wait_for_completion(418): enter
[ 9906.261934] omap2_mcspi_set_dma_req(232): enter
[ 9906.275168] omap2_mcspi_set_dma_req(247): exit
[ 9906.279637] omap2_mcspi_txrx_dma(723): exit
[ 9906.290659] omap2_mcspi_setup_transfer(987): enter
[ 9906.296541] omap2_mcspi_setup_transfer(1068): exit
[ 9906.301357] omap2_mcspi_set_enable(255): enter -> enable = 0
[ 9906.313084] omap2_mcspi_set_enable(265): exit
[ 9906.317466] omap2_mcspi_set_fifo(343): enter -> enable = 0
[ 9906.329195] omap2_mcspi_set_fifo(389): exit
[ 9906.339782] omap2_mcspi_transfer_one(1367): exit
[ 9906.345438] omap2_mcspi_set_cs(273): enter -> enable = 1
[ 9906.350821] omap2_mcspi_set_cs(304): exit
[ 9906.361383] omap2_mcspi_can_dma(1404): enter
[ 9906.366773] omap2_mcspi_can_dma(1415): exit
[ 9906.371820] omap2_mcspi_prepare_message(1378): enter

>>> The SPI slave **does** receive/transmit the 1st 32 byte buffer from/to the SPI master here
00000000  7c 25 73 69 f2 f7 67 7a  2e 49 89 1d 15 a3 82 14  ||%si..gz.I......|
00000010  b9 6a 9d 61 84 40 fb 65  92 93 95 47 74 eb 86 70  |.j.a.@.e...Gt..p|
>>>

[ 9906.383655] omap2_mcspi_prepare_message(1396): exit
[ 9906.392478] omap2_mcspi_can_dma(1404): enter
[ 9906.400989] omap2_mcspi_can_dma(1415): exit
[ 9906.406039] omap2_mcspi_set_cs(273): enter -> enable = 0
[ 9906.411665] omap2_mcspi_set_cs(304): exit
[ 9906.422574] omap2_mcspi_transfer_one(1254): enter
[ 9906.428205] omap2_mcspi_set_enable(255): enter -> enable = 0
[ 9906.434843] omap2_mcspi_set_enable(265): exit
[ 9906.439219] omap2_mcspi_setup_transfer(987): enter
[ 9906.448176] omap2_mcspi_setup_transfer(1068): exit
[ 9906.460740] omap2_mcspi_can_dma(1404): enter
[ 9906.471370] omap2_mcspi_can_dma(1415): exit
[ 9906.475873] omap2_mcspi_set_fifo(343): enter -> enable = 1
[ 9906.481411] mcspi_bytes_per_word(214): enter
[ 9906.488991] mcspi_bytes_per_word(223): exit
[ 9906.494172] omap2_mcspi_set_fifo(376): exit
[ 9906.498376] omap2_mcspi_set_enable(255): enter -> enable = 1
[ 9906.510844] omap2_mcspi_set_enable(265): exit
[ 9906.518939] omap2_mcspi_can_dma(1404): enter
[ 9906.524126] omap2_mcspi_can_dma(1415): exit
[ 9906.528332] omap2_mcspi_txrx_dma(675): enter
[ 9906.532636] omap2_mcspi_irq_handler(1203): enter
[ 9906.537291] omap2_mcspi_irq_handler(1215): exit
[ 9906.548202] omap2_mcspi_tx_dma(472): enter
[ 9906.552342] omap2_mcspi_set_dma_req(232): enter
[ 9906.558436] omap2_mcspi_set_dma_req(247): exit
[ 9906.562903] omap2_mcspi_tx_dma(492): exit
[ 9906.573147] omap2_mcspi_rx_dma(512): enter
[ 9906.578230] omap2_mcspi_set_dma_req(232): enter
[ 9906.582834] omap2_mcspi_rx_callback(440): enter
[ 9906.587432] omap2_mcspi_set_dma_req(232): enter
[ 9906.592017] omap2_mcspi_set_dma_req(247): exit
[ 9906.596498] omap2_mcspi_rx_callback(445): exit
[ 9906.615645] omap2_mcspi_set_dma_req(247): exit
[ 9906.620115] mcspi_wait_for_completion(418): enter
[ 9906.627340] omap2_mcspi_set_dma_req(232): enter
[ 9906.631940] omap2_mcspi_set_dma_req(247): exit
[ 9906.643142] omap2_mcspi_rx_dma(594): exit
[ 9906.647177] mcspi_wait_for_completion(418): enter

At this point it's waiting for a completion that appears to never come.

> One possible reason may be that driver sets up  MCSPI_XFERLEVEL WCNT and
> enables channel before setting up TX DMA. So if there a master that is
> continuously requesting data, then there is a possibility that WCNT goes
> down to 0 (due to shifting of 0s) before DMA had chance to put actual
> the data into the FIFO.
>
> Does it help if you move the programming of WCNT field to
> omap2_mcspi_tx_dma()?
>

That sounds plausible and I *attempted* to move this code but I
must've implemented it incorrectly because the driver stopped
functioning. It's likely my implementation and/or interpretation of
your suggestion is wrong. If you could provide a more explicit
description of the changes or a patch I would certainly be willing to
attempt it again.

> Main intention of adding SPI slave support was to support limited
> usecase where master and slave exchange very small known messages of
> predetermined length such as to support at sparse interval (such as dead

I was hoping to pass high-speed/bandwidth telemetry data from the SPI
slave to the SPI master. Apparently my use case may not match the one
described. With that said, I think it may still be achievable with
tweaking by someone with more experience with the McSPI driver. I
introduced a "usleep()" inside spi-pipe() just after the SPI transfer
on the SPI master application. With a long enough delay between
transfers (~2-10 msec) the SPI master/slave succeeds indefinitely and
the SPI slave never gets "stuck". Unfortunately, this kills my
telemetry throughput. So, there is likely some kind of race condition
in the SPI slave controller code.

Any additional suggestions or patches to try would be very
appreciated. I think the potential to work reliably under load is
there but it still needs a few changes. Hopefully these are small
changes, localized to a single file, and don't require a big refactor.
