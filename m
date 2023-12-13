Return-Path: <linux-spi+bounces-264-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE187811A21
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 17:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3D6282764
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86130D07;
	Wed, 13 Dec 2023 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed1EoIz9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47942FC21
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 16:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E336AC433C8;
	Wed, 13 Dec 2023 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702486397;
	bh=c9396rzJpQMCgoS0HFAEP3AaubNKsYmbveoIApJ3W0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ed1EoIz9HtfzFm+gX8+V1NlQ6GTiBeBFnVs5rUN5Y/SUQGcmKYgAD891vQQ1Qxk8v
	 vqCAB7ttBSVmP+ZL0NMohzeHl33g4EzLCuk/OSpfoBOVfDzeJqR6o7iZksYVWhnMEV
	 i8obc8ZDbTrw0QwU+VisE2FZFyD/EBFiGI5zvFgShBY/BBgb7DPLE/cAZ5znCMKpI7
	 iiTurFKBA9rTvIZ2mTNdRZmgztlYFsZb/SaCLNFboT8NDdCOGcuKcNtj02dSJxjrsf
	 MYRioI7i0EdEyrZXBWGYK45XxnhrEeeJtKCRWxikP7T6o+ScuZJF1zjz5ktXQP4SQ5
	 Do+R9mI1Vfi5g==
From: Michael Walle <mwalle@kernel.org>
To: haibo.chen@nxp.com
Cc: broonie@kernel.org,
	han.xu@nxp.com,
	linux-imx@nxp.com,
	linux-spi@vger.kernel.org,
	yogeshgaur.83@gmail.com,
	Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH 3/5] spi: spi-nxp-fspi: add DTR mode support
Date: Wed, 13 Dec 2023 17:53:05 +0100
Message-Id: <20231213165305.2773796-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213091346.956789-3-haibo.chen@nxp.com>
References: <20231213091346.956789-3-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> For LUT, add DTR command support.

Please elaborate a bit more.


> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 9d6b4d22263c..2562d524149e 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -552,12 +552,22 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>  	int lutidx = 1, i;
>  
>  	/* cmd */
> -	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> -			     op->cmd.opcode);
> +	if (op->cmd.dtr) {
> +		lutval[0] |= LUT_DEF(0, LUT_CMD_DDR, LUT_PAD(op->cmd.buswidth),
> +				     op->cmd.opcode >> 8);

Shouldn't we check cmd.nbytes here? You seem to mix dtr with cmd.nbytes ==
2 here.

> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_CMD_DDR,
> +					      LUT_PAD(op->cmd.buswidth),
> +					      op->cmd.opcode & 0x00ff);

And you seem to assume dtr is always octal mode?

-michael

> +		lutidx++;
> +	} else {
> +		lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> +				     op->cmd.opcode);
> +	}
>  
>  	/* addr bytes */
>  	if (op->addr.nbytes) {
> -		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ?
> +					      LUT_ADDR_DDR : LUT_ADDR,
>  					      LUT_PAD(op->addr.buswidth),
>  					      op->addr.nbytes * 8);
>  		lutidx++;
> @@ -565,7 +575,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>  
>  	/* dummy bytes, if needed */
>  	if (op->dummy.nbytes) {
> -		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->dummy.dtr ?
> +					      LUT_DUMMY_DDR : LUT_DUMMY,
>  		/*
>  		 * Due to FlexSPI controller limitation number of PAD for dummy
>  		 * buswidth needs to be programmed as equal to data buswidth.
> @@ -580,7 +591,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>  	if (op->data.nbytes) {
>  		lutval[lutidx / 2] |= LUT_DEF(lutidx,
>  					      op->data.dir == SPI_MEM_DATA_IN ?
> -					      LUT_NXP_READ : LUT_NXP_WRITE,
> +					      (op->data.dtr ? LUT_READ_DDR : LUT_NXP_READ) :
> +					      (op->data.dtr ? LUT_WRITE_DDR : LUT_NXP_WRITE),
>  					      LUT_PAD(op->data.buswidth),
>  					      0);
>  		lutidx++;
> @@ -1152,6 +1164,10 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
>  	.get_name = nxp_fspi_get_name,
>  };
>  
> +static struct spi_controller_mem_caps nxp_fspi_mem_caps = {
> +	.dtr = true,
> +};
> +
>  static int nxp_fspi_probe(struct platform_device *pdev)
>  {
>  	struct spi_controller *ctlr;
> @@ -1254,6 +1270,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>  	ctlr->bus_num = -1;
>  	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
>  	ctlr->mem_ops = &nxp_fspi_mem_ops;
> +	ctlr->mem_caps = &nxp_fspi_mem_caps;
>  
>  	nxp_fspi_default_setup(f);
>  
> -- 
> 2.34.1

