Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2554F73D
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jun 2022 14:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381162AbiFQMI5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jun 2022 08:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiFQMI5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jun 2022 08:08:57 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB456BFD3
        for <linux-spi@vger.kernel.org>; Fri, 17 Jun 2022 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=WQEzN1z9JdrOwUYyYwPfBhECzcvvDPvmPa4bypeUCA4=;
        b=J3eyzyoKA0AEccz6/+3WKHXBddcvLn5RinGuTxBBR5h13aGGddQwQOpzVA5YV9aUpvlfySNkdFPRI
         M+9nnW914j5f/6JZd93bM5DKrLfHcoAeHAAqjGxjNSfOuep3ASv8me8uRFW0ZUxoM8xyeTwQv2CrYW
         dGEsQiTTrrRuficYFDY8zAbSma/HUF0oy66PiFxq3VN6wUzrvIQX3T2qvNLI3lJGVpY1Oc89/xWBi0
         AvlH1V9JFguq0WD/NN1YXn1Qv2OawX8S5R9Dpk5sPjzMWf5inq3tLGTphJAVd9G24ExtL65xws43U9
         AUYAzzocK8rKnPA/Is7P4DNbvcqeapQ==
X-MSG-ID: 3f3ee5cb-ee36-11ec-8a45-0050569d11ae
Date:   Fri, 17 Jun 2022 14:08:49 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Message-ID: <20220617140849.41c3b8c8@erd992>
In-Reply-To: <20220616173003.7202d19a@erd992>
References: <20220615124634.3302867-1-david@protonic.nl>
        <YqsuhfN1I54J+1gw@sirena.org.uk>
        <20220616161323.7f1b9e84@erd992>
        <YqtEYTgL+wJXp9QU@sirena.org.uk>
        <20220616173003.7202d19a@erd992>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Jun 2022 17:30:03 +0200
David Jander <david@protonic.nl> wrote:
> [...]
> > > Ideally this would get as much different hardware testing as possible before
> > > going further upstream. Do you have access to some platforms suitable for
> > > stressing SPI with multiple clients simultaneously? Known "problematic"
> > > controllers maybe?    
> > 
> > Well, the fastest way to get it into a wide range of CI is for me to
> > apply it so people who test -next will start covering it...  I was going
> > to kick it into my test branch KernelCI once I've got it reviewed
> > properly which will get at least some boot testing on a bunch of
> > platforms.  
> 
> Ah, great. I will see if I can get it tested on some more other platforms from
> our side.

Ok, I have managed to test kernel 5.19-rc2 with this patch set on an i.MX6DL
machine. This is an arm cortex-a9 dual core (32bit), but it does have the same
spi-imx controller that my 64-bit board has. It does have two SPI peripherals,
each on a separate bus unfortunately: A tsc2046e touchscreen controller using
the IIO ADC backend driver, and a SPI NOR flash chip.
Everything works fine. Hammering the NOR flash and the touchscreen
simultaneously works as expected. But I have some interesting performance
figures for several different kernel configurations.

First of all, the spi-imx driver seems to perform really, really bad in DMA
mode in all cases. Probably something wrong with SDMA on this board, or the
transfers are too small for DMA? The driver has two module parameters: use_dma
and polling_limit_us. Disabling DMA gets the driver to "normal" performance
levels, and setting polling_limit_us to a very big value forces the driver to
work in polling mode, i.e. to not use IRQs. Since the system isn't doing
anything apart from these tests, it is expected that forced polling mode will
likely give the highest throughput, but could be considered cheating.

Test procedure:

Frist create some continuous stress on the SPI bus:

$ (while true; do dd if=/dev/mtdblock2 of=/dev/null bs=1024; done) >/dev/null
2>&1 &

The histogram shows this:

$ for t in /sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_*; do printf "%s:\t%d\n" $t `cat $t`; done
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_0-1:        228583
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_1024-2047:  0
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_128-255:    1
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_16-31:      1
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_16384-32767:        0
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_2-3:        228579
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_2048-4095:  0
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_256-511:    0
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_32-63:      1
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_32768-65535:        0
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_4-7:        1
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_4096-8191:  0
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_512-1023:   228576
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_64-127:     0
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_65536+:     0
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_8-15:       0
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_8192-16383: 0

There are no spi_async() transfers involved. The spi-nor driver apparently
only issues sync calls in this scenario, which makes sense. Note that even
though I specified "bs=1024" to the dd command, the spi-nor driver seems to
want to do 512 byte transfers anyway. Making "bs" very small doesn't change
this either, so we cannot simulate many very small transfers this way
unfortunately. This means that performance impact is likely very limited in
this scenario since the overhead of a single transfer isn't that much compared
to the size of it.

The below data shows the CPU load distribution while running the above command
(this is the topmost line of the "top" tool I have on this board) and the
throughput of a single call to dd:

Tested kernel builds:

 1. Kernel 5.19-rc2 vanilla
 1.1. use_dma = true (default):

CPU:  0.4% usr 20.4% sys  0.0% nic  0.0% idle 77.5% io  0.0% irq  1.5% sirq
3604480 bytes (3.4MB) copied, 3.685375 seconds, 955.1KB/s

 1.2. use_dma = false:

CPU:  0.5% usr 55.9% sys  0.0% nic  0.0% idle 43.2% io  0.0% irq  0.2% sirq
3604480 bytes (3.4MB) copied, 2.017914 seconds, 1.7MB/s

 1.3. forced polling:

CPU:  0.3% usr 99.4% sys  0.0% nic  0.0% idle  0.0% io  0.0% irq  0.1% sirq
3604480 bytes (3.4MB) copied, 1.330517 seconds, 2.6MB/s

 2. Kernel 5.19-rc2 with only the per-cpu stat patch:
 2.1. use_dma = true (default):

CPU:  0.2% usr 20.1% sys  0.0% nic  0.0% idle 78.3% io  0.0% irq  1.3% sirq
3604480 bytes (3.4MB) copied, 3.682393 seconds, 955.9KB/s

 2.2. use_dma = false:

CPU:  0.5% usr 56.8% sys  0.0% nic  0.0% idle 42.3% io  0.0% irq  0.2% sirq
3604480 bytes (3.4MB) copied, 2.015509 seconds, 1.7MB/s

 2.3. forced polling:

CPU:  0.3% usr 99.4% sys  0.0% nic  0.0% idle  0.0% io  0.0% irq  0.1% sirq
3604480 bytes (3.4MB) copied, 1.319247 seconds, 2.6MB/s

 3. Kernel 5.19-rc2 with both per-cpu stats and optimized sync path patches:
 3.1. use_dma = true (default):

CPU:  0.0% usr 17.8% sys  0.0% nic  0.0% idle 81.0% io  0.0% irq  1.1% sirq
3604480 bytes (3.4MB) copied, 3.650646 seconds, 964.2KB/s

 3.2. use_dma = false:

CPU:  0.6% usr 43.8% sys  0.0% nic  0.0% idle 55.2% io  0.0% irq  0.3% sirq
3604480 bytes (3.4MB) copied, 1.971478 seconds, 1.7MB/s

 3.3. forced polling:

CPU:  0.3% usr 99.6% sys  0.0% nic  0.0% idle  0.0% io  0.0% irq  0.0% sirq
3604480 bytes (3.4MB) copied, 1.314353 seconds, 2.6MB/s

Of course I measured each value several times. Results were very consistent,
and I picked the median result for each of the cases above.
The differences are small, as is expected given the fact that data transfers
are rather big, but specially if you look at the "seconds" value returned by
"dd", there is an incremental improvement for each of the patches. The total
improvement seems to be around 1.5-2% less CPU overhead in total... which IMHO
is still remarkable given how insensitive this test is for transfer overhead.

Testing the impact on the touchscreen driver doesn't make much sense though,
since it runs on a 1MHz clock rate and is already optimized to only do very
large single SPI transfers, so the overhead will definitely be noise at best.

Will report more results if I can test on other platforms.

Best regards,

-- 
David Jander

