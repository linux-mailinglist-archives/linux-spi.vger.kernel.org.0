Return-Path: <linux-spi+bounces-477-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC40882E9FF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 08:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D9EB22325
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 07:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA7F10A2B;
	Tue, 16 Jan 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ikLEvVdC"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB1111AA;
	Tue, 16 Jan 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 125C3C0006;
	Tue, 16 Jan 2024 07:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705389913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeKbNaDH9WzNbslvD9DfQIEbXzFmT1ZQqgwjLB1s6b0=;
	b=ikLEvVdCD+X+WowoLvn5BtIrmM2iwZABTiW/IA9z83Gu5sZmbu7fN/y2wDqya+eOuJsbrk
	J2psNzmMhyUs00v1f3DLaU7pF5LWxwbDYz0hckykuilRrLGnz8v8DLZ3lZwQJx7p7+oqSc
	Qx9CH6ZlScmQq41cypWoOMQTNZF9oGDA04fLAGEvt6Fja+IFC+ttkvErN+9oujIQMtpg8F
	Ld2L45GdZ1DH1VY4NBLvufF25TF99xOqc6513NvMerllI6vLE2OX7ykSWw4JZdLEsXWL9s
	qefnk7ngBp9OaEjnQHMU0VuE2wsAsIL+mxLeZUlsashmwCpCsBjYLz5sGm2eoA==
Date: Tue, 16 Jan 2024 08:25:11 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-spi@vger.kernel.org,
 kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH 28/33] usb: gadget: max3420_udc: Follow renaming of SPI
 "master" to "controller"
Message-ID: <20240116082511.31b9bbbc@bootlin.com>
In-Reply-To: <e3d14feb1650c5b0cb1b6e8442255917c9c91529.1705348270.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
	<e3d14feb1650c5b0cb1b6e8442255917c9c91529.1705348270.git.u.kleine-koenig@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Uwe,

On Mon, 15 Jan 2024 21:13:14 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/usb/gadget/udc/max3420_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
> index 89e8cf2a2a7d..7349ea774adf 100644
> --- a/drivers/usb/gadget/udc/max3420_udc.c
> +++ b/drivers/usb/gadget/udc/max3420_udc.c
> @@ -1201,7 +1201,7 @@ static int max3420_probe(struct spi_device *spi)
>  	int err, irq;
>  	u8 reg[8];
>  
> -	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> +	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
>  		dev_err(&spi->dev, "UDC needs full duplex to work\n");
>  		return -EINVAL;
>  	}

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

