Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED56129AB5
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2019 21:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLWUHR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Dec 2019 15:07:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43314 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfLWUHR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Dec 2019 15:07:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so18848677ljm.10
        for <linux-spi@vger.kernel.org>; Mon, 23 Dec 2019 12:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jlswyEc6xIGtbVUwHi52dwuY4ajQKEt5NuNVOiiskgw=;
        b=uL3/M8VWDFlVkz/n3D6NfSRboQct3/dGTYUJkfrsxjqaSw+powfOuZNJS8Yisdolf3
         W7IdrXrcukkSoUTcbrjnTjyzvK3o32XmMoRRaBsXYUZEKO77cMrZyWnhupiTXMTkBU9k
         RonZlzpJd09zJbBr+QvizRpPOxIC5B3UTBFDz5NoI3PVi4CxnhnzcS5A9s8y3fBpCgqE
         rHP/9xDBTHCHsiRYa+8tweT2HmhoBWCfTHwA2a1tDrV6gybMJDoeixrLXigLp1U5LKRT
         RB3L2xh97Av0TbaI/9N3wkT2tJitiCzqLpiRuwEunA+jLbSKTOEozf2WVXdVB0cVrLAw
         R2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jlswyEc6xIGtbVUwHi52dwuY4ajQKEt5NuNVOiiskgw=;
        b=I0IAzJDQeVQjf1U2JhdWEQ4aKQOuEFH4rkk7ljS9jcKXrf5rs9mKlx0vC6gqsklvZ0
         yoMuulFyiL0YH7V/YPzRAlt4jlmRZqBabzmHT1A5+Iwsi66qr63Eofbq2nskNyNmfOEH
         +2CT0I3w5rMeZP7EfyL3AajWT0R7rBl2VKWbpEQY8AYyWRv613F6pexSSRpt9U7J1Ydp
         rt6qxfKLI3MelS+yGc9kZ5MnQpGGCvB7Nmz1WxVXCKO4fLTE49Sv6iKKgr1xgn6OEaPs
         ni6QQtQVU368Y24W/VrTqTkyNZzRJQqEedptE/Riysi3i1qzp7DvUdPeUF1OQo+vr5zQ
         aiew==
X-Gm-Message-State: APjAAAV1zskkkpa69ri9UcfIUmlgVd5Q7JyzZKbkZObuoov091T+mniK
        zw6NimR439j/EjWGhSOfWYj4rA==
X-Google-Smtp-Source: APXvYqx5g4M0uhRd+Jgki+03Npwwmd4lXlZjXrbkgxQkR/xuSqUXP1tnYgb7OvSuShD1VKlGh6Jykw==
X-Received: by 2002:a2e:a486:: with SMTP id h6mr11540184lji.235.1577131635009;
        Mon, 23 Dec 2019 12:07:15 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:855:9d36:483b:5fb3:f1dd:f0d5])
        by smtp.gmail.com with ESMTPSA id i19sm8915307lfj.17.2019.12.23.12.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 12:07:14 -0800 (PST)
Subject: Re: [PATCH v17 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        lee.jones@linaro.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com
References: <1565060061-11588-1-git-send-email-masonccyang@mxic.com.tw>
 <1565060061-11588-2-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0e65db61-00e5-73cc-347a-023abfd138ba@cogentembedded.com>
Date:   Mon, 23 Dec 2019 23:07:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1565060061-11588-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 08/06/2019 05:54 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

   Mark Brown did have some comments to my variant of the RPC-IF SPI driver,
which didn't get addressed in your SPI driver... Relaying his comments to you,
I'd appreciate if you could reply to them...

[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..52537b7
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,756 @@
[...]
> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
> +				   struct spi_message *msg)
> +{
> +	struct spi_transfer *t, xfer[4] = { };

Don't mix initialized and non-initialized declarations in a single line
(as per coding style).

> +	u32 i, xfercnt, xferpos = 0;
> +
> +	rpc->totalxferlen = 0;
> +	rpc->xfer_dir = SPI_MEM_NO_DATA;
> +
> +	list_for_each_entry(t, &msg->transfers, transfer_list) {
> +		if (t->tx_buf) {
> +			xfer[xferpos].tx_buf = t->tx_buf;
> +			xfer[xferpos].tx_nbits = t->tx_nbits;

xfer is hard coded to 4 elements but I'm not seeing any validation that
we don't have more transfers than that in the message, and there's lots
of assumptions later on about the number of transfers.

[...]
> +		if (list_is_last(&t->transfer_list, &msg->transfers)) {
> +			if (xferpos > 1) {
> +				if (t->rx_buf) {
> +					rpc->xfer_dir = SPI_MEM_DATA_IN;
> +					rpc->smcr = RPC_SMCR_SPIRE;
> +				} else if (t->tx_buf) {
> +					rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +					rpc->smcr = RPC_SMCR_SPIWE;
> +				}
> +			}

Transfers can be bidirectional...  if the device can't support that it
should set SPI_CONTROLLER_HALF_DUPLEX.

[...]
> +static inline int rpc_spi_xfer_message(struct rpc_spi *rpc,
> +				       struct spi_transfer *data_xfer)

This has exactly one caller and contains a single statement - why have a
separate function?

> +{
> +	int ret;
> +
> +	ret = rpc_spi_set_freq(rpc, data_xfer->speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	ret = rpc_spi_io_xfer(rpc,
> +			      rpc->xfer_dir == SPI_MEM_DATA_OUT ?
> +			      data_xfer->tx_buf : NULL,
> +			      rpc->xfer_dir == SPI_MEM_DATA_IN ?
> +			      data_xfer->rx_buf : NULL);

This is really hard to read.  Why are we abusing the ternery operator
here, especially when there's other places where we already set things
up based on the direction?

[...]
[...]
> +static int rpc_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	spi_unregister_controller(ctlr);
> +
> +	return 0;
> +}
> +

Shouldn't we unregister the controller before we disable the RPM?  The
probe was the other way around and this means that we might still be
processing messages while the hardware is disabled which doesn't seem
good.

[...]

MBR, Sergei
