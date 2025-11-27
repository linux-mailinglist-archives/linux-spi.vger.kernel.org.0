Return-Path: <linux-spi+bounces-11624-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86983C8F56E
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 16:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CEB14E9908
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6563375AE;
	Thu, 27 Nov 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FTrn9gY1"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27F3375C2;
	Thu, 27 Nov 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258535; cv=none; b=uufGLxEQOIyzWZYyqlM2G4sKw6M4CxDrrZ0ZeeSeS29LSMXRF3rDKRl11k+eT1pZ0Q2Xmxwh7/lku3unIfyosgwnnDsL/AxEecF0cr/jgpW7np6TovlXE2YTdp8z99KgmoVDBtQGSnZRz3wIamwp+Y6kCK4MhSbVmRENwhuSTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258535; c=relaxed/simple;
	bh=A6e5eOrgjkdaZ8Hvc0dv9Cd98pps7qbiwhQj+eGL6As=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b0bJHgjipTmf3qXo/HwvdQc6mi1ZIw8HXyz0eLbpI/kSe/2a1OTpjVPyCd19VYc1YBLE/q8qkRUHbCfY3bh9t9QY9XypXe/C9wjvvHxWBi98/lGDx99u3gXZB4fxa+aEuICYI2ABvYnjhG3CJ13dAc371vERjS5bRNI4YQ70fvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FTrn9gY1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764258533; x=1795794533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A6e5eOrgjkdaZ8Hvc0dv9Cd98pps7qbiwhQj+eGL6As=;
  b=FTrn9gY1+V5LUuN0l6PQ6y03NgyKXhXMBmeX5Z0h9z9tC2QW2XngFDuS
   WfoWhemIS3ha/VVSTg6Betab46VYOOX6w8UOlQzuQOmqhhDmspC01FV6k
   GqB8gndiLqxr8xHlkCx9msYBIojfvcSVDPbR0dJNvJf3pzHr4orkr7aqm
   svbsTUxx9iYDnCPV5rpG0EXyPGf2S5nLLd83eF9fn+ONtf25qI/EoagiL
   0oUh82Imi02Cw29n0QDAxPDBAakuk6B1g9awALp8Nh3cWh4H2Q9Xr1cNE
   bml1gwDJPwCSVj6ReNi0ulCv1lD5qMcNocVh9OHxT6YdsXqYVo+L+mIEy
   Q==;
X-CSE-ConnectionGUID: L/KLStcpQHOTJw9U/3W+ZA==
X-CSE-MsgGUID: mdBtaBoMQMmnjW8MQhIgIg==
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="50260225"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2025 08:48:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 27 Nov 2025 08:48:52 -0700
Received: from [10.205.167.104] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 27 Nov 2025 08:48:50 -0700
Message-ID: <39651aeb-668b-483c-b326-56adf38a7e63@microchip.com>
Date: Thu, 27 Nov 2025 15:59:54 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] spi: microchip-core: Utilise temporary variable
 for struct device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>, Conor Dooley - M52691
	<Conor.Dooley@microchip.com>, Prajna Rajendra Kumar - M74368
	<prajna.rajendrakumar@microchip.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-5-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
In-Reply-To: <20251126075558.2035012-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2025 07:54, Andy Shevchenko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> Add a temporary variable to keep a pointer to struct device.
> Utilise it where it makes sense.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
>   drivers/spi/spi-microchip-core-spi.c | 44 +++++++++++++---------------
>   1 file changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
> index 8ea382c6fee7..0dca46dcdc2f 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -284,6 +284,7 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
>   static int mchp_corespi_probe(struct platform_device *pdev)
>   {
>          const char *protocol = "motorola";
> +       struct device *dev = &pdev->dev;
>          struct spi_controller *host;
>          struct mchp_corespi *spi;
>          struct resource *res;
> @@ -291,13 +292,13 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>          bool assert_ssel;
>          int ret = 0;
>
> -       host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
> +       host = devm_spi_alloc_host(dev, sizeof(*spi));
>          if (!host)
>                  return -ENOMEM;
>
>          platform_set_drvdata(pdev, host);
>
> -       if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
> +       if (of_property_read_u32(dev->of_node, "num-cs", &num_cs))
>                  num_cs = MCHP_CORESPI_MAX_CS;
>
>          /*
> @@ -305,12 +306,12 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>           * CoreSPI can be configured for Motorola, TI or NSC.
>           * The current driver supports only Motorola mode.
>           */
> -       ret = of_property_read_string(pdev->dev.of_node, "microchip,protocol-configuration",
> +       ret = of_property_read_string(dev->of_node, "microchip,protocol-configuration",
>                                        &protocol);
>          if (ret && ret != -EINVAL)
> -               return dev_err_probe(&pdev->dev, ret, "Error reading protocol-configuration\n");
> +               return dev_err_probe(dev, ret, "Error reading protocol-configuration\n");
>          if (strcmp(protocol, "motorola") != 0)
> -               return dev_err_probe(&pdev->dev, -EINVAL,
> +               return dev_err_probe(dev, -EINVAL,
>                                       "CoreSPI: protocol '%s' not supported by this driver\n",
>                                        protocol);
>
> @@ -318,11 +319,11 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>           * Motorola mode (0-3): CFG_MOT_MODE
>           * Mode is fixed in the IP configurator.
>           */
> -       ret = of_property_read_u32(pdev->dev.of_node, "microchip,motorola-mode", &mode);
> +       ret = of_property_read_u32(dev->of_node, "microchip,motorola-mode", &mode);
>          if (ret)
>                  mode = MCHP_CORESPI_DEFAULT_MOTOROLA_MODE;
>          else if (mode > 3)
> -               return dev_err_probe(&pdev->dev, -EINVAL,
> +               return dev_err_probe(dev, -EINVAL,
>                                       "invalid 'microchip,motorola-mode' value %u\n", mode);
>
>          /*
> @@ -330,9 +331,9 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>           * The hardware allows frame sizes <= APB data width.
>           * However, this driver currently only supports 8-bit frames.
>           */
> -       ret = of_property_read_u32(pdev->dev.of_node, "microchip,frame-size", &frame_size);
> +       ret = of_property_read_u32(dev->of_node, "microchip,frame-size", &frame_size);
>          if (!ret && frame_size != 8)
> -               return dev_err_probe(&pdev->dev, -EINVAL,
> +               return dev_err_probe(dev, -EINVAL,
>                                       "CoreSPI: frame size %u not supported by this driver\n",
>                                       frame_size);
>
> @@ -342,9 +343,9 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>           * To prevent CS deassertion when TX FIFO drains, the ssel-active property
>           * keeps CS asserted for the full SPI transfer.
>           */
> -       assert_ssel = of_property_read_bool(pdev->dev.of_node, "microchip,ssel-active");
> +       assert_ssel = of_property_read_bool(dev->of_node, "microchip,ssel-active");
>          if (!assert_ssel)
> -               return dev_err_probe(&pdev->dev, -EINVAL,
> +               return dev_err_probe(dev, -EINVAL,
>                                       "hardware must enable 'microchip,ssel-active' to keep CS asserted for the SPI transfer\n");
>
>          spi = spi_controller_get_devdata(host);
> @@ -356,9 +357,9 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>          host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>          host->transfer_one = mchp_corespi_transfer_one;
>          host->set_cs = mchp_corespi_set_cs;
> -       host->dev.of_node = pdev->dev.of_node;
> +       host->dev.of_node = dev->of_node;
>
> -       ret = of_property_read_u32(pdev->dev.of_node, "fifo-depth", &spi->fifo_depth);
> +       ret = of_property_read_u32(dev->of_node, "fifo-depth", &spi->fifo_depth);
>          if (ret)
>                  spi->fifo_depth = MCHP_CORESPI_DEFAULT_FIFO_DEPTH;
>
> @@ -370,24 +371,21 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>          if (spi->irq < 0)
>                  return spi->irq;
>
> -       ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
> -                              IRQF_SHARED, dev_name(&pdev->dev), host);
> +       ret = devm_request_irq(dev, spi->irq, mchp_corespi_interrupt, IRQF_SHARED,
> +                              dev_name(dev), host);
>          if (ret)
> -               return dev_err_probe(&pdev->dev, ret,
> -                                    "could not request irq\n");
> +               return dev_err_probe(dev, ret, "could not request irq\n");
>
> -       spi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +       spi->clk = devm_clk_get_enabled(dev, NULL);
>          if (IS_ERR(spi->clk))
> -               return dev_err_probe(&pdev->dev, PTR_ERR(spi->clk),
> -                                    "could not get clk\n");
> +               return dev_err_probe(dev, PTR_ERR(spi->clk), "could not get clk\n");
>
>          mchp_corespi_init(host, spi);
>
> -       ret = devm_spi_register_controller(&pdev->dev, host);
> +       ret = devm_spi_register_controller(dev, host);
>          if (ret) {
>                  mchp_corespi_disable(spi);
> -               return dev_err_probe(&pdev->dev, ret,
> -                                    "unable to register host for CoreSPI controller\n");
> +               return dev_err_probe(dev, ret, "unable to register host for CoreSPI controller\n");
>          }
>
>          return 0;
> --
> 2.50.1
>


