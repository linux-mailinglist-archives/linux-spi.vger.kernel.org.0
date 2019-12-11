Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CA11A864
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 10:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfLKJ7B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 04:59:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57379 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfLKJ7B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Dec 2019 04:59:01 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ieyll-0002rK-EC; Wed, 11 Dec 2019 10:58:57 +0100
Message-ID: <60952c5ac36510ff5be0733b15352828e0f2e41f.camel@pengutronix.de>
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Wed, 11 Dec 2019 10:58:53 +0100
In-Reply-To: <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
         <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei,

On Tue, 2019-12-10 at 22:39 +0300, Sergei Shtylyov wrote:
[...]
> --- /dev/null
> +++ linux/drivers/memory/renesas-rpc-if.c
> @@ -0,0 +1,590 @@
[...]
> +int rpcif_io_xfer(struct rpcif *rpc)
> +{
[...]
> +	default:
> +		regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
> +		regmap_write(rpc->regmap, RPCIF_SMCR,
> +			     rpc->smcr | RPCIF_SMCR_SPIE);
> +		ret = wait_msg_xfer_end(rpc);
> +		if (ret)
> +			goto err_out;
> +	}
> +
> +exit:
> +	pm_runtime_put(rpc->dev);
> +	return ret;
> +
> +err_out:
> +	ret = reset_control_reset(rpc->rstc);

If wait_msg_xfer_end() returned an error, but the reset succeeds, this
will cause rpcif_io_xfer() to report success as well. I suspect you do
not want to overwrite ret at this point.

> +	rpcif_hw_init(rpc, rpc->bus_size == 2);
> +	goto exit;
> +}
> +EXPORT_SYMBOL(rpcif_io_xfer);

regards
Philipp

