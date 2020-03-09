Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E1F17E64A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCISDK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:03:10 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43203 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCISDK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:03:10 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 81D7723EDA;
        Mon,  9 Mar 2020 19:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583776986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYAsbg2s3Mo8kPRtJGAKizEqhE6GcsxTsCs9SgyjEoc=;
        b=XSTizcLYC0Z1wEWo+0FNnboZ+ZkjmWPYViMSAUgFbvUsl485/Orepr/YJ+rfQXfRzOQYV/
        OmxLRL0SBS8yJqiDREkAfEVxidWmuskeYXtCN/ntN4cancVoCcUMI7JD3or8vBp8wDRdYV
        vLJXclUFqy7Nra9BH503GqNW1D+dlUg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 19:03:06 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, peng.ma@nxp.com
Subject: Re: [PATCH 0/6] NXP DSPI bugfixes and support for LS1028A
In-Reply-To: <20200309145624.10026-1-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
Message-ID: <f530a0740f34b2cf26a8055d4eae2527@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 81D7723EDA
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.528];
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

Am 2020-03-09 15:56, schrieb Vladimir Oltean:
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

If it is not compatible with the LS1021A the second compatible string
should be removed. Depending on the other remark about the endianess,
it might still be compatible, though.


> The device tree for the LS1028A SoC is extended with DMA channels
> definition, such that even though the default operating mode is XSPI,
> one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
> devtype_data structure of the driver and use that instead.

wouldn't it make more sense, to use DMA is the dma node is present
in the device tree? otherwise use XSPI mode? I don't think it is
really handy to change the mode inside the driver.

-michael

> 
> For testing, benchmarking and debugging, the mikroBUS connector on the
> LS1028A-RDB is made available via spidev.
> 
> Vladimir Oltean (6):
>   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
>   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
>   spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
>   spi: spi-fsl-dspi: Add support for LS1028A
>   arm64: dts: ls1028a: Specify the DMA channels for the DSPI 
> controllers
>   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> 
>  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 14 +++++
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  6 +++
>  drivers/spi/spi-fsl-dspi.c                    | 54 +++++++++++++++----
>  3 files changed, 64 insertions(+), 10 deletions(-)
