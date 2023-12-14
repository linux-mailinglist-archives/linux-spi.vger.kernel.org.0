Return-Path: <linux-spi+bounces-276-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F436812BE5
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 10:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E811F2173B
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755BB2EB1C;
	Thu, 14 Dec 2023 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNoPCknq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5288C2E64B
	for <linux-spi@vger.kernel.org>; Thu, 14 Dec 2023 09:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE5DC433C7;
	Thu, 14 Dec 2023 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702547113;
	bh=C9mB5qGeKW/kprHEYI/zTLHKA7Twaorch9KF1KkT6vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNoPCknqT62k2Q7BBiYk5Yi5MPji9d8YBP+SKqQy7hh4fqsLbk/ZA1SZqXZlEzaTj
	 gfO467W4WPtRMKLrQs/XxLL/aVEEfnhjuOFakM3pKy3c+cky2mhtrEezTPO+WUXGDW
	 WNUKnDxPQD4dzfnIbfFYhoiLPAupTxku257ay5UezUW4k52so0ErPxW4aFOyJs5y1y
	 PwRBC8vODwEUY+MZO7yLWpTacHfROt6xiSM05/YV3TetS+kXOIRco6zyC31WdlIswK
	 8n5jYVrHfV0k8OE3iRU+tZ/U4+k6svH9Ewa9dx4+CYt+u+5sOjQOIw7e6NbTTVJDKX
	 puzrdYk8I/j3A==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Dec 2023 10:45:09 +0100
From: Michael Walle <mwalle@kernel.org>
To: Bough Chen <haibo.chen@nxp.com>
Cc: broonie@kernel.org, Han Xu <han.xu@nxp.com>, dl-linux-imx
 <linux-imx@nxp.com>, linux-spi@vger.kernel.org, yogeshgaur.83@gmail.com
Subject: Re: [PATCH 3/5] spi: spi-nxp-fspi: add DTR mode support
In-Reply-To: <DB7PR04MB4010647E3087EBF90E8BA7B1908CA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20231213091346.956789-3-haibo.chen@nxp.com>
 <20231213165305.2773796-1-mwalle@kernel.org>
 <DB7PR04MB4010647E3087EBF90E8BA7B1908CA@DB7PR04MB4010.eurprd04.prod.outlook.com>
Message-ID: <8d7892a37897520109cc8e609b63a1fc@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
>> > index 9d6b4d22263c..2562d524149e 100644
>> > --- a/drivers/spi/spi-nxp-fspi.c
>> > +++ b/drivers/spi/spi-nxp-fspi.c
>> > @@ -552,12 +552,22 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>> >  	int lutidx = 1, i;
>> >
>> >  	/* cmd */
>> > -	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
>> > -			     op->cmd.opcode);
>> > +	if (op->cmd.dtr) {
>> > +		lutval[0] |= LUT_DEF(0, LUT_CMD_DDR,
>> LUT_PAD(op->cmd.buswidth),
>> > +				     op->cmd.opcode >> 8);
>> 
>> Shouldn't we check cmd.nbytes here? You seem to mix dtr with 
>> cmd.nbytes ==
>> 2 here.
> 
> Currently, for DTR mode, all cmd.nbytes == 2. Refer to
> drivers/mtd/spi-nor/core.c : spi_nor_spimem_setup_op()
> But better to check the cmd.nbytes here to make the code more strong.

I'm aware of that, but that might change.

>> > +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_CMD_DDR,
>> > +					      LUT_PAD(op->cmd.buswidth),
>> > +					      op->cmd.opcode & 0x00ff);
>> 
>> And you seem to assume dtr is always octal mode?
> 
> Currently, I only test the octa dtr mode(8D-8D-8D). but here, we config 
> the
> op->cmd.buswidth, op->addr.buswidth, op->dummy.buswidth, 
> op->data.buswidth.
> So I think current LUT config can cover other dts mode, like 1D-8D-8D,
> 1D-4D-4D, 1D-2D-2D, 1D-1D-1D.

Agreed, for the code that follows this. But the 16bit opcode, ie. the
LUT above only makes sense for 8d8d8d. There you have to have
16bit because thats what transferred in one clock cycle.

You could add that to your .supports_op(). I.e. restrict this
driver to only support 8d8d8d. I know that the default op will
already check that, but better be safe.

-michael

