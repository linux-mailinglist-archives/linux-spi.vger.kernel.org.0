Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D779D18A2D1
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 20:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgCRTDb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 15:03:31 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43647 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRTDb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 15:03:31 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5513123F27;
        Wed, 18 Mar 2020 20:03:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584558208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dOp+Q10aNwI+UYVrwdygu1rxeT9KhHvcajdkwSJHkkM=;
        b=Tsb9fURAvN+x5CkSFEW2TdBb5KXCI1JXLKf0R0HbHyyNOGa9E+T1KSOKHlFkGZQRBJhI1z
        Tve698+u7Vjo7k35bvgXMh6ARTCYFvEFSt9G+h9cjzP2u3ih8cjKZJ2oZO20hZfaQVhy+A
        1bri3ZjtkWG0N+tjVr+dhUHa0PbYdfI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Mar 2020 20:03:28 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, peng.ma@nxp.com
Subject: Re: [PATCH v5 00/12] NXP DSPI bugfixes and support for LS1028A
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
Message-ID: <d37b6e0f8a35ae61bbfe147cd5809ec2@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 5513123F27
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.599];
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

Am 2020-03-18 01:15, schrieb Vladimir Oltean:
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
> Compared to earlier v4, the only change is in patch 05/12 to fix a race
> condition signaled by Michael Walle here:
> https://lkml.org/lkml/2020/3/17/740
> 
> I don't expect the "fixes" patches to reach very far down the stable
> pipe, since there has been pretty heavy refactoring in this driver.
> 
> For testing, benchmarking and debugging, the mikroBUS connector on the
> LS1028A-RDB is made available via spidev.

Patches 1-11:
Tested-by: Michael Walle <michael@walle.cc>

Thanks Vladimir for the great work.

-michael

> 
> Vladimir Oltean (12):
>   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
>   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
>   spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
>   spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
>   spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
>   spi: spi-fsl-dspi: Replace interruptible wait queue with a simple
>     completion
>   spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA
>     mode
>   spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code
>     path
>   spi: spi-fsl-dspi: Move invariant configs out of
>     dspi_transfer_one_message
>   spi: spi-fsl-dspi: Add support for LS1028A
>   arm64: dts: ls1028a: Specify the DMA channels for the DSPI 
> controllers
>   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> 
>  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 +
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
>  drivers/spi/spi-fsl-dspi.c                    | 324 +++++++++---------
>  3 files changed, 182 insertions(+), 162 deletions(-)
