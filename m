Return-Path: <linux-spi+bounces-480-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29782ECA2
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 11:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3443C28532B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B7134C7;
	Tue, 16 Jan 2024 10:18:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F9117594;
	Tue, 16 Jan 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from [192.168.4.14] (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 3A4D663AC3;
	Tue, 16 Jan 2024 11:17:51 +0100 (CET)
Message-ID: <dd1e05f3-dab6-41ac-8813-92a757f4badb@gpxsee.org>
Date: Tue, 16 Jan 2024 11:17:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] media: mgb4: Follow renaming of SPI "master" to
 "controller"
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, kernel@pengutronix.de,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <6c6e38ee916b4268c617d2603cfbe01ae083ecea.1705348269.git.u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
In-Reply-To: <6c6e38ee916b4268c617d2603cfbe01ae083ecea.1705348269.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15. 01. 24 21:12, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/media/pci/mgb4/mgb4_core.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
> index 5bfb8a06202e..9bcf10a77fd3 100644
> --- a/drivers/media/pci/mgb4/mgb4_core.c
> +++ b/drivers/media/pci/mgb4/mgb4_core.c
> @@ -144,7 +144,7 @@ static int match_spi_adap(struct device *dev, void *data)
>   	return to_spi_device(dev) ? 1 : 0;
>   }
>   
> -static struct spi_master *get_spi_adap(struct platform_device *pdev)
> +static struct spi_controller *get_spi_adap(struct platform_device *pdev)
>   {
>   	struct device *dev;
>   
> @@ -152,7 +152,7 @@ static struct spi_master *get_spi_adap(struct platform_device *pdev)
>   	dev = device_find_child(&pdev->dev, NULL, match_spi_adap);
>   	mutex_unlock(&pdev->dev.mutex);
>   
> -	return dev ? container_of(dev, struct spi_master, dev) : NULL;
> +	return dev ? container_of(dev, struct spi_controller, dev) : NULL;
>   }
>   
>   static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
> @@ -179,7 +179,7 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
>   	};
>   	struct pci_dev *pdev = mgbdev->pdev;
>   	struct device *dev = &pdev->dev;
> -	struct spi_master *master;
> +	struct spi_controller *ctlr;
>   	struct spi_device *spi_dev;
>   	u32 irq;
>   	int rv, id;
> @@ -207,8 +207,8 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
>   		return PTR_ERR(mgbdev->spi_pdev);
>   	}
>   
> -	master = get_spi_adap(mgbdev->spi_pdev);
> -	if (!master) {
> +	ctlr = get_spi_adap(mgbdev->spi_pdev);
> +	if (!ctlr) {
>   		dev_err(dev, "failed to get SPI adapter\n");
>   		rv = -EINVAL;
>   		goto err_pdev;
> @@ -242,8 +242,8 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
>   
>   	spi_info.platform_data = &mgbdev->flash_data;
>   
> -	spi_dev = spi_new_device(master, &spi_info);
> -	put_device(&master->dev);
> +	spi_dev = spi_new_device(ctlr, &spi_info);
> +	put_device(&ctlr->dev);
>   	if (!spi_dev) {
>   		dev_err(dev, "failed to create MTD device\n");
>   		rv = -EINVAL;

Reviewed-by: Martin Tůma <martin.tuma@digiteqautomotive.com>


