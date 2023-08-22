Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6FE7841A4
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjHVNLL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjHVNLL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:11:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF95D7
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692709869; x=1724245869;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=b3bOQh8s2MNIWOzb+6lIclctOMPenXqfybuUgl8Tq3M=;
  b=1kc8bGHnkZP/5xShJVxkQiK7U/V+dLOqAFbzcYeD4x07SIykBHfHm+C1
   zIEud4n3H1OdUZcdR3UoVXkIV33gGiAodCPNeObkVgAuIoAk4Q7fDqZAH
   AjTJBT9rOPcnoousNW6Bl5GZL2mA0Bi/9qPRYMyO+Z4y15pUMMpAGyKLE
   dLCoTiOHdm6HGf0zMMSqsEkOH7+yYL8Ebmj7mkTbLSsUzZ6qVzY8dur/6
   kTgIt4j7wd+4e740uffoafxXVDiiagN+sjy9tVvbkF9o1ifLuzx89O922
   +9ihnbbdCxqpvAHQYCitDzKVk+Zih8QttbVwIZdR6V3csIkCuDNSvKDzO
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="671407"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2023 06:11:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 22 Aug 2023 06:11:07 -0700
Received: from [10.159.245.205] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 22 Aug 2023 06:11:05 -0700
Message-ID: <52e3a5df-41ae-db71-fe4c-f46db22db4c3@microchip.com>
Date:   Tue, 22 Aug 2023 15:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] spi: at91-usart: Use PTR_ERR_OR_ZERO() to simplify
 code
Content-Language: en-US, fr-FR
To:     Jinjie Ruan <ruanjinjie@huawei.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20230822124643.987079-1-ruanjinjie@huawei.com>
CC:     Russell King - ARM Linux <linux@arm.linux.org.uk>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230822124643.987079-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/08/2023 at 14:46, Jinjie Ruan wrote:
> Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
> simplify code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Do we really need these changes?... oh well, no strong opinion but is it 
worth the effort?

Regards,
   Nicolas

> ---
>   drivers/spi/spi-at91-usart.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index 75d9bc606442..b11d0f993cc7 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -485,10 +485,7 @@ static int at91_usart_gpio_setup(struct platform_device *pdev)
> 
>          cs_gpios = devm_gpiod_get_array_optional(&pdev->dev, "cs", GPIOD_OUT_LOW);
> 
> -       if (IS_ERR(cs_gpios))
> -               return PTR_ERR(cs_gpios);
> -
> -       return 0;
> +       return PTR_ERR_OR_ZERO(cs_gpios);
>   }
> 
>   static int at91_usart_spi_probe(struct platform_device *pdev)
> --
> 2.34.1
> 

