Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5723A0E39
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhFIICc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 04:02:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28582 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhFIICb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 04:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1623225637; x=1654761637;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=zFZ6+Q6SWpwN89b6p/8yoeRZ1pCvucT0hx1LyvO5AWw=;
  b=NL3Z77pTKP1CsouXmBCyi4JdODGTR/mUIWNw2jUlhMUOIE54Gid+TFj8
   5KydK4fT+yJyiFhX8NA5b3OoulMA6JKDFurNi43hNPbOo00w4IVJ6ueBf
   W0fX2huqybPacg3ih2X7skyoI2qHc03S5OFPeA7fk2EA9uEq+rbttSmzA
   QVgEJxORCoEQqroY8XEJWHU3hzSqBhpyUH/ZzEBkCchRMrhqqSDSS7ZPf
   Bt/Dlm4/46ugSZwASgfVqJmWtu10gxkIZ/BcJrmX8w5MC8G4lF6Fjhwan
   1gOgJwvjebq+dZmtZIh/EL9KwMHmnNQPTfn9UA3ghHximkCmM+ILxCbDw
   w==;
IronPort-SDR: vwuga5tWXE8Ukmgn8W1HbaXBoECOGHl/BkSlGigNhZnAoZ71FlzHC85Bltvz6y1nxHb68nQ1zz
 rK6QxfiRah4bQJwwRW16/9In0693Qh0NfPhevf6qiwzPBYceX1sS2wol/3rAkK4VFg+3x1L8Py
 yIKLojF210ckyh5xJablEV8XxxdYRXY2SU7USGO1W/AlspYqBT5bw9kfqvFddNTZzDpCRbF1MK
 ug+0NNt7Ba3gBXpjLT/2fYIlvWJ1+qs6u3TV92f0oRH9ldG7P/XhPao9fYyaArX5bNrNSj6JOi
 7fQ=
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="58321815"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2021 01:00:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 01:00:36 -0700
Received: from [10.12.74.10] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 9 Jun 2021 01:00:34 -0700
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2=5d_spi=3a_spi-at91-usart=3a=c2=a0Fix_wr?=
 =?UTF-8?Q?ong_goto_jump_label_when_spi=5falloc=5fmaster=28=29_returns_error?=
 =?UTF-8?Q?=2e?=
To:     zpershuai <zpershuai@gmail.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1623206895-8282-1-git-send-email-zpershuai@gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <65351f67-4d35-b175-83a7-bb1dbe1b6f86@microchip.com>
Date:   Wed, 9 Jun 2021 10:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623206895-8282-1-git-send-email-zpershuai@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 09/06/2021 at 04:48, zpershuai wrote:
> When spi_alloc_master() returns null pointer, it’s no need to use
> spi_master_put() to release the memory, although spi_master_put()
> function has null pointer checks.

So, I don't see the benefit in changing then.
at91_usart_spi_probe_fail label is nicely unified across the probe 
function and having it called once more or once less is no interest to me.

Sorry but NACK until someone persuades me it's needed or common pattern 
among spi drivers.

Regards,
   Nicolas

> Signed-off-by: zpershuai <zpershuai@gmail.com>
> ---
>   drivers/spi/spi-at91-usart.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index 8c83526..e5c2d2c 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -531,10 +531,9 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
>          if (IS_ERR(clk))
>                  return PTR_ERR(clk);
> 
> -       ret = -ENOMEM;
>          controller = spi_alloc_master(&pdev->dev, sizeof(*aus));
>          if (!controller)
> -               goto at91_usart_spi_probe_fail;
> +               return -ENOMEM;
> 
>          ret = at91_usart_gpio_setup(pdev);
>          if (ret)
> --
> 2.7.4
> 


-- 
Nicolas Ferre
