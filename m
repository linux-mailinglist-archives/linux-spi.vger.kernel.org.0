Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F5C1F9548
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgFOLZ4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 07:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgFOLZ4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 07:25:56 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C58E20663;
        Mon, 15 Jun 2020 11:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592220355;
        bh=hheBwTSFc6iwBWB8MsUTDTdzd+3OLaOnprLkDFHzJZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8rK1weuyASMxJgo3gsh7sPxRrQAYD12kwRU1DXbJp57frQ+XcatZNTgVFVlxrzQI
         HOg/s3WpJX7CJxde07iTNDrw+n3kKCCoA2P+oBdHx2M9cBJqLd2p4ITInuMOO2Twgz
         poRfTxYiKMbsrXKoOOM3hCXA5vN9EbhrexQch/hA=
Date:   Mon, 15 Jun 2020 16:55:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Message-ID: <20200615112549.GL1393454@vkoul-mobl>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615071931.GK1393454@vkoul-mobl>
 <VE1PR04MB6638959679C644C76B4D3D3A899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638959679C644C76B4D3D3A899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Robin,

On 15-06-20, 08:59, Robin Gong wrote:
> On 2020/06/15 15:20 Vinod Koul <vkoul@kernel.org> wrote:

> > > Yes, but both assume spi controller driver could detect such dma
> > > failure before dmaengine_prep_*(). Let's wait Vinod's comment for that
> > > if dmaengine_slave_config could keep direction.
> > 
> > The direction is already in the prep_ call, so sending in dmaengine_slave_config
> > is not required, pls pass it in the prep_ call
> Hi Vinod,
> 	Is there any way to let the device driver to know dma controller is ready
> (in sdma case is sdma firmware loaded or not)before prep_call? Hence, spi core
> could map dma buffer or not. Prep_call is too late for spi core since the buffers
> have been already mapped. 

Can you use .device_alloc_chan_resources for that? This is where all
the resource allocation for a channel should happen...

> 	From my view, seems dmaengine_slave_config is the only one...Further,
> sdma need direction in dmaengine_slave_config phase, because currently
> what's the tx/rx script used on sdma channel is decided not only peripheral_type
> but also direction. For example, spi tx dma is running ram script to workaround
> ecspi ERR009165 while rx dma is running rom script, so only spi tx dma channel
> depends on sdma firmware loaded(now that could be detect by ' load_address
> < 0' in sdma_load_context() and prep_ call finally).
>    I knew direction is deprecated in dmaengine_slave_config, but that's really
> very useful for sdma to check if firmware loaded and spi core could get it earlier
> before prep_call(fallback to PIO if dma is not ready).

I think that is wrong expectation, dmaengine_slave_config should pass
the slave_config to driver and nothing else. The relevant action should
be taken in respective prep_ calls here, so that should be fixed as well

-- 
~Vinod
