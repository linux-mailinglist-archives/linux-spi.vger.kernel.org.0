Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA217FFD9
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 15:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCJOLP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 10:11:15 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:50739 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJOLP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 10:11:15 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CBC9B23ECA;
        Tue, 10 Mar 2020 15:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583849471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IsAsAFMQdm4t+w+VAii6/sLzY0pLLvWgOGV7ZznUbU4=;
        b=XUcaxUjX/EyhUVCFQ8WJ/QIphEfVQc3pzpMavTS22ctpJXWyUsIL+MX1lMsQUN4xmDrfCa
        PXmfSgyReung2xDwbzq4xbVdWoxJJFLCD6/68E/YQPjt4HOcKFRFbeAbehXWiQbnlhx1m2
        AIu5qnlG/vh7upvko9aeIRF9chpTwjI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Mar 2020 15:11:10 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, peng.ma@nxp.com
Subject: Re: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
In-Reply-To: <20200310125542.5939-1-olteanv@gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
Message-ID: <615284875b709f602d57e4a4621a83c1@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: CBC9B23ECA
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.551];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vladimir,

Am 2020-03-10 13:55, schrieb Vladimir Oltean:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This series addresses a few issues that were missed during the previous
> series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
> SoCs other than LS1021A and LS1043A. DMA mode has been completely 
> broken
> by that series, and XSPI mode never worked on little-endian 
> controllers.
> 
> Then it introduces support for the LS1028A chip, whose compatible has
> recently been documented here:
> 
> https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael@walle.cc/
> 
> The device tree for the LS1028A SoC is extended with DMA channels
> definition, such that even though the default operating mode is XSPI,
> one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
> devtype_data structure of the driver and use that instead.
> 
> I don't expect the "fixes" patches to reach very far down the stable
> pipe, since there has been pretty heavy refactoring in this driver.
> 
> For testing, benchmarking and debugging, the mikroBUS connector on the
> LS1028A-RDB is made available via spidev.


XSPI mode, while now I cannot reproduce the kernel oops anymore, I've 
found two
other problems (1), (2). Which are likely the same underlying problem. 
DMA mode
works "better" now, still one problem (3).

(1) It seems like the first write/read/erase after the aborted 
instruction
don't get through:

# hexdump -C /dev/mtd0
00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
[  627.914654] fsl-dspi 2120000.spi: Waiting for transfer to complete 
failed!
^C[  627.921649] spi_master spi1: failed to transfer one message from 
queue

#
# echo huhu > /dev/mtd0
# hexdump -C /dev/mtd0
00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
003df000
# echo huhu > /dev/mtd0
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
[  642.738905] fsl-dspi 2120000.spi: Waiting for transfer to complete 
failed!
^C[  642.745832] spi_master spi1: failed to transfer one message from 
queue
#
# flash_erase /dev/mtd0 0 1
Erasing 4 Kibyte @ 0 -- 100 % complete
#
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
0023d000
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*

(2) Also, reading the flash, every second time there is (reproducibly) 
an
IO error:

# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
01000000
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00dc0000
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
01000000
# hexdump -C /dev/mtd0
00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|huhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00e6a000

(3) Depening on the content length there is also an IO error. Funny 
enough,
the content is still written to the SPI flash.

# echo -n 1 > /dev/mtd10
# echo -n 12 > /dev/mtd10
# echo -n 123 > /dev/mtd10
# echo -n 1234 > /dev/mtd10
# echo -n 12345 > /dev/mtd10
sh: write error: Input/output error
# echo -n 123456 > /dev/mtd10
# echo -n 1234567 > /dev/mtd10
sh: write error: Input/output error
# echo -n 12345678 > /dev/mtd10
# echo -n 123456789 > /dev/mtd10
# echo -n 1234567890 > /dev/mtd10
# echo -n 12345678901 > /dev/mtd10
# echo -n 123456789012 > /dev/mtd10
# echo -n 1234567890123 > /dev/mtd10
sh: write error: Input/output error
# echo -n 12345678901234 > /dev/mtd10
# echo -n 123456789012345 > /dev/mtd10
sh: write error: Input/output error
# echo -n 1234567890123456 > /dev/mtd10
# echo -n 12345678901234567 > /dev/mtd10
# echo -n 123456789012345678 > /dev/mtd10


# flash_erase /dev/mtd10 0 1
Erasing 4 Kibyte @ 0 -- 100 % complete
# hexdump -C /dev/mtd10
00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
^C
# echo -n 12345 > /dev/mtd10
sh: write error: Input/output error
# hexdump -C /dev/mtd10
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
^C


-michael

> 
> Vladimir Oltean (7):
>   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
>   spi: spi-fsl-dspi: Avoid use-after-free in interrupt mode
>   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
>   spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
>   spi: spi-fsl-dspi: Add support for LS1028A
>   arm64: dts: ls1028a: Specify the DMA channels for the DSPI 
> controllers
>   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> 
>  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 ++
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
>  drivers/spi/spi-fsl-dspi.c                    | 188 +++++++++++-------
>  3 files changed, 134 insertions(+), 74 deletions(-)
