Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C11E0CAE
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390138AbgEYLRR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390128AbgEYLRQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 May 2020 07:17:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DF4C061A0E
        for <linux-spi@vger.kernel.org>; Mon, 25 May 2020 04:17:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jdB6Q-0002IF-Jj; Mon, 25 May 2020 13:17:06 +0200
Received: from [IPv6:2a03:f580:87bc:d400:d406:10d7:6286:51e5] (unknown [IPv6:2a03:f580:87bc:d400:d406:10d7:6286:51e5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7C801505AAD;
        Mon, 25 May 2020 11:17:03 +0000 (UTC)
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <schluessler@krause.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 mQINBFFVq30BEACtnSvtXHoeHJxG6nRULcvlkW6RuNwHKmrqoksispp43X8+nwqIFYgb8UaX
 zu8T6kZP2wEIpM9RjEL3jdBjZNCsjSS6x1qzpc2+2ivjdiJsqeaagIgvy2JWy7vUa4/PyGfx
 QyUeXOxdj59DvLwAx8I6hOgeHx2X/ntKAMUxwawYfPZpP3gwTNKc27dJWSomOLgp+gbmOmgc
 6U5KwhAxPTEb3CsT5RicsC+uQQFumdl5I6XS+pbeXZndXwnj5t84M+HEj7RN6bUfV2WZO/AB
 Xt5+qFkC/AVUcj/dcHvZwQJlGeZxoi4veCoOT2MYqfR0ax1MmN+LVRvKm29oSyD4Ts/97cbs
 XsZDRxnEG3z/7Winiv0ZanclA7v7CQwrzsbpCv+oj+zokGuKasofzKdpywkjAfSE1zTyF+8K
 nxBAmzwEqeQ3iKqBc3AcCseqSPX53mPqmwvNVS2GqBpnOfY7Mxr1AEmxdEcRYbhG6Xdn+ACq
 Dq0Db3A++3PhMSaOu125uIAIwMXRJIzCXYSqXo8NIeo9tobk0C/9w3fUfMTrBDtSviLHqlp8
 eQEP8+TDSmRP/CwmFHv36jd+XGmBHzW5I7qw0OORRwNFYBeEuiOIgxAfjjbLGHh9SRwEqXAL
 kw+WVTwh0MN1k7I9/CDVlGvc3yIKS0sA+wudYiselXzgLuP5cQARAQABtCZNYXJjIEtsZWlu
 ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPokCVAQTAQoAPgIbAwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUsSbBQkM366zAAoJECte4hHF
 iupUgkAP/2RdxKPZ3GMqag33jKwKAbn/fRqAFWqUH9TCsRH3h6+/uEPnZdzhkL4a9p/6OeJn
 Z6NXqgsyRAOTZsSFcwlfxLNHVxBWm8pMwrBecdt4lzrjSt/3ws2GqxPsmza1Gs61lEdYvLST
 Ix2vPbB4FAfE0kizKAjRZzlwOyuHOr2ilujDsKTpFtd8lV1nBNNn6HBIBR5ShvJnwyUdzuby
 tOsSt7qJEvF1x3y49bHCy3uy+MmYuoEyG6zo9udUzhVsKe3hHYC2kfB16ZOBjFC3lH2U5An+
 yQYIIPZrSWXUeKjeMaKGvbg6W9Oi4XEtrwpzUGhbewxCZZCIrzAH2hz0dUhacxB201Y/faY6
 BdTS75SPs+zjTYo8yE9Y9eG7x/lB60nQjJiZVNvZ88QDfVuLl/heuIq+fyNajBbqbtBT5CWf
 mOP4Dh4xjm3Vwlz8imWW/drEVJZJrPYqv0HdPbY8jVMpqoe5jDloyVn3prfLdXSbKPexlJaW
 5tnPd4lj8rqOFShRnLFCibpeHWIumqrIqIkiRA9kFW3XMgtU6JkIrQzhJb6Tc6mZg2wuYW0d
 Wo2qvdziMgPkMFiWJpsxM9xPk9BBVwR+uojNq5LzdCsXQ2seG0dhaOTaaIDWVS8U/V8Nqjrl
 6bGG2quo5YzJuXKjtKjZ4R6k762pHJ3tnzI/jnlc1sXz
Message-ID: <e0f641bc-5473-792d-fea9-0a2e81fe1e38@pengutronix.de>
Date:   Mon, 25 May 2020 13:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 5/21/20 10:19 PM, Tim Harvey wrote:
> On Wed, Feb 26, 2020 at 2:19 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Sorry for the long delay... I'm finally getting back to this issue.
> 
> I'm told by Marvell/Cavium that the OcteonTX SPI hardware does not
> support full duplex although I don't see this in any of their errata
> or reference manuals. Perhaps someone familiar with the CN81xx/CN80xx
> OcteonTX hardware from Marvell/Cavium can weigh in here as I'm not
> clear if this limitation is in all hardware that uses the
> spi-cavium-thunderx.c driver (I've added Jan to the list who authored
> the driver)

If the hardware doesn't support full duplex transfers you should add
SPI_CONTROLLER_HALF_DUPLEX to the driver.

If the hardware supports full duplex, but the driver doesn't the driver should
be fixed, or SPI_CONTROLLER_HALF_DUPLEX with the appropriate explanation.

> As you point out setting SPI_CONTROLLER_HALF_DUPLEX will cause
> spi_{sync,async,async_locked} calls to fail with -EINVAL if they have
> both a tx and rx buf, so this should be done to help catch these
> issues:
> diff --git a/drivers/spi/spi-cavium-thunderx.c
> b/drivers/spi/spi-cavium-thunderx.c
> index fd6b9ca..76fdb94 100644
> --- a/drivers/spi/spi-cavium-thunderx.c
> +++ b/drivers/spi/spi-cavium-thunderx.c
> @@ -64,6 +65,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
>                 p->sys_freq = SYS_FREQ_DEFAULT;
>         dev_info(dev, "Set system clock to %u\n", p->sys_freq);
> 
> +       master->flags = SPI_MASTER_HALF_DUPLEX;
>         master->num_chipselect = 4;
>         master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
>                             SPI_LSB_FIRST | SPI_3WIRE;
> 
> Now, with regards to the mcp251x.c driver you were correct that I was
> missing dealing with the full-duplex call from mcp251x_hw_rx_frame()
> which indeed was causing data corruption on recieve.
> 
> So the following patch to mcp251x.c properly converts mcp251x to half-duplex:
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 5009ff2..016c1e5 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -290,23 +290,23 @@ static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
>         priv->spi_tx_buf[0] = INSTRUCTION_READ;
>         priv->spi_tx_buf[1] = reg;
> 
> -       mcp251x_spi_trans(spi, 3);
> -       val = priv->spi_rx_buf[2];
> +       spi_write_then_read(spi, priv->spi_tx_buf, 2, &val, 1);
> 
>         return val;
>  }
> 
>  static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
>  {
> +       u8 val[2] = {0};
>         struct mcp251x_priv *priv = spi_get_drvdata(spi);
> 
>         priv->spi_tx_buf[0] = INSTRUCTION_READ;
>         priv->spi_tx_buf[1] = reg;
> 
> -       mcp251x_spi_trans(spi, 4);
> +       spi_write_then_read(spi, priv->spi_tx_buf, 2, val, 2);
> 
> -       *v1 = priv->spi_rx_buf[2];
> -       *v2 = priv->spi_rx_buf[3];
> +       *v1 = val[0];
> +       *v2 = val[1];
>  }
> 
>  static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
> @@ -409,8 +409,9 @@ static void mcp251x_hw_rx_frame(struct spi_device
> *spi, u8 *buf,
>                         buf[i] = mcp251x_read_reg(spi, RXBCTRL(buf_idx) + i);
>         } else {
>                 priv->spi_tx_buf[RXBCTRL_OFF] = INSTRUCTION_READ_RXB(buf_idx);
> -               mcp251x_spi_trans(spi, SPI_TRANSFER_BUF_LEN);
> -               memcpy(buf, priv->spi_rx_buf, SPI_TRANSFER_BUF_LEN);
> +               spi_write_then_read(spi, priv->spi_tx_buf, 1, priv->spi_rx_buf,
> +                                   SPI_TRANSFER_BUF_LEN);
> +               memcpy(buf + 1, priv->spi_rx_buf, SPI_TRANSFER_BUF_LEN - 1);
>         }
>  }
> 
> I do have hardware to test with and without this patch my CN80xx board
> with an MCP25625 fails device probing (mcp251x spi0.1: MCP251x didn't
> enter in conf mode after reset) because read values are corrupt. With
> this patch my the MCP25625 works fine on the CN80xx detecting,
> sending, and receiving frames.

nice!

> Should I be submitting this patch with logic that only does
> half-duplex if the spi controller doesn't support it (if
> (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)) or is it
> acceptable to simply make the driver half-duplex like this for all
> cases?

Please make half duplex transfers depending on SPI_CONTROLLER_HALF_DUPLEX as
most drivers have a considerable overhead at the end of a transfer.

Most of them wait for a transfer complete interrupt. Which might take longer
than the actual SPI transfer. Splitting one full duplex read-register transfer
(which is a write followed by a read) into two half duplex transfers would kill
performance on full duplex capable controllers.

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
