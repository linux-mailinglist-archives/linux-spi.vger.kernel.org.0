Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604992B4598
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 15:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgKPOLW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 16 Nov 2020 09:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgKPOLV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 09:11:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FA9C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 06:11:21 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kefDt-0005DC-QV; Mon, 16 Nov 2020 15:11:13 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kefDs-0004wE-Tm; Mon, 16 Nov 2020 15:11:12 +0100
Message-ID: <ed042bbef3432805de6f3bb745286b3823c80d6a.camel@pengutronix.de>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix error return code in
 cqspi_probe
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>, broonie@kernel.org,
        tudor.ambarus@microchip.com,
        vadivel.muruganx.ramuthevar@linux.intel.com, vigneshr@ti.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Date:   Mon, 16 Nov 2020 15:11:12 +0100
In-Reply-To: <20201116141014.2364260-1-chengzhihao1@huawei.com>
References: <20201116141014.2364260-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Zhihao,

On Mon, 2020-11-16 at 22:10 +0800, Zhihao Cheng wrote:
> Fix to return the error code from
> devm_reset_control_get_optional_exclusive() instaed of 0
> in cqspi_probe().
>
> Fixes: 31fb632b5d43ca ("spi: Move cadence-quadspi driver to drivers/spi/")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 40938cf3806d..22d7158edb71 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1260,12 +1260,14 @@ static int cqspi_probe(struct platform_device *pdev)
>  	/* Obtain QSPI reset control */
>  	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
>  	if (IS_ERR(rstc)) {
> +		ret = PTR_ERR(rstc);
>  		dev_err(dev, "Cannot get QSPI reset.\n");
>  		goto probe_reset_failed;
>  	}
>  
>  	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
>  	if (IS_ERR(rstc_ocp)) {
> +		ret = PTR_ERR(rstc);

This should be
		ret = PTR_ERR(rstc_ocp);
instead.

regards
Philipp
