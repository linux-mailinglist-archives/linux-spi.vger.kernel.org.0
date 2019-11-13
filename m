Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76720FBCE6
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2019 01:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfKNAQb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Nov 2019 19:16:31 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:55240 "EHLO
        6.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNAQa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Nov 2019 19:16:30 -0500
X-Greylist: delayed 2115 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 19:16:30 EST
Received: from player758.ha.ovh.net (unknown [10.109.146.19])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id C61AA1130E0
        for <linux-spi@vger.kernel.org>; Thu, 14 Nov 2019 00:41:13 +0100 (CET)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id 17468C1C43CF;
        Wed, 13 Nov 2019 23:40:50 +0000 (UTC)
Date:   Thu, 14 Nov 2019 01:40:49 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, radu_nicolae.pirea@upb.ro, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linus.walleij@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, andi@etezian.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, vkoul@kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, linux-arm-msm@vger.kernel.org,
        kgene@kernel.org, krzk@kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for
 channel request
Message-ID: <20191113234049.GA1249@jack.zhora.eu>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-8-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113094256.1108-8-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Ovh-Tracer-Id: 10707589591967711931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefvddgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucfkpheptddrtddrtddrtddpkedurddujeehrddvvdefrdduudeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Peter,

>  	if (!is_polling(sdd)) {
>  		/* Acquire DMA channels */
> -		sdd->rx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
> -								  "rx");
> +		sdd->rx_dma.ch = dma_request_chan(&pdev->dev, "rx");

I have a little concern here. We have two funcions
'dma_request_chan' and  'dma_request_channel' don't we end up
making some confusion here?

Wouldn't it make more sense renaming 'dma_request_chan' to
'dma_request_slave_channel_reason'?

Thanks,
Andi
