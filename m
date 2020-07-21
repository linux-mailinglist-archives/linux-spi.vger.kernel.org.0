Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F72F227A10
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 10:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgGUIBE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGUIBD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 04:01:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C13FC061794
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2020 01:01:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so1863835wme.0
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2020 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xe1xj2UJLfRzN8/gTK/6++OrG88WTatlRMlGCyzzmm0=;
        b=zsvHmLfjJ3qIlSGraoav1lLUCKJ/WL8hivFRPMZNBQHsH2XPKEh2SAQzhDCIpwiats
         fhjY+KetWr8J33BQn6NZHAg3Y+MFvouR4bFQir9X3ZmFALluilzLXqoXzlXbHA8zsWpB
         Qwou99IYa9UBi509MshAlJ0GqkURcmdzNgsK6216LL03oMhW52Tc1WFpdUAE3HgrmOwi
         IEbV1Zc1MQjLOSNutwmxJsoU7CNK38wPZXKz1lBOd81g6NGj9mydvIWrHiBeg3DLWd17
         P9+ttlijTMJJeJNmHKoh3TbEEy+/cQe2LRixU9JTBkbl91gjmY9mS4f58ehOhhJzkyZq
         leCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Xe1xj2UJLfRzN8/gTK/6++OrG88WTatlRMlGCyzzmm0=;
        b=ikRAhIqz9RpTzl1eNk8nRLxdL+X2fZQfpStnApG3gTfqzi86rssvS5QSEOHVK3EFu3
         cagOBjT2M6cA5feTOAAH02vY3NQXI+SqHjVKTZyj6kCGr+JPqUeCyi8d5xMFKSaJA6oG
         Db13VqqgSUnefif/LA9hgZPMIptm035eoCJqxeBbKeJhxM3Jk1xiiilXUISog1UyTQag
         AlhXhfjJPrmepnbgArJHT2+/BWDMlWqwx4SGpoc6v9xIJ0Sxw9BCjNMasfPV+SJ2L9kN
         E2AxJZ8WBGh+wXhrXFrRgXm+NaY6P+9RKdGdbqryfAwrm2yp+7uejExCVR5KWpDGZffn
         aUPw==
X-Gm-Message-State: AOAM531bxYT4JQiVKHzboe8fte4UTruNMA0vAXzEqD9OxTXqaEj9maMt
        G/u+QbfsEKpZLqp37b8UrTXuCw==
X-Google-Smtp-Source: ABdhPJxIG3rVQw6vw0k3oB8t3+wUKdYuDLOTbrVMTvJW5oh4CXFN4wQ+Swr+xv7YFmD05HcBhlsuEQ==
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr2796746wma.58.1595318461729;
        Tue, 21 Jul 2020 01:01:01 -0700 (PDT)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 26sm2294065wmj.25.2020.07.21.01.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 01:01:00 -0700 (PDT)
Subject: Re: [PATCH v2 05/14] spi: spi-meson-spifc: Fix misdocumenting of
 'dev' in 'struct meson_spifc'
To:     Lee Jones <lee.jones@linaro.org>, broonie@kernel.org
Cc:     Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Beniamino Galvani <b.galvani@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200717135424.2442271-1-lee.jones@linaro.org>
 <20200717135424.2442271-6-lee.jones@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <6655a485-fc5a-690e-b752-59f12d545cc0@baylibre.com>
Date:   Tue, 21 Jul 2020 10:00:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717135424.2442271-6-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/07/2020 15:54, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/spi/spi-meson-spifc.c:80: warning: Function parameter or member 'dev' not described in 'meson_spifc'
> 
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Beniamino Galvani <b.galvani@gmail.com>
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/spi/spi-meson-spifc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
> index c7b0399802913..8eca6f24cb799 100644
> --- a/drivers/spi/spi-meson-spifc.c
> +++ b/drivers/spi/spi-meson-spifc.c
> @@ -70,7 +70,7 @@
>   * @master:	the SPI master
>   * @regmap:	regmap for device registers
>   * @clk:	input clock of the built-in baud rate generator
> - * @device:	the device structure
> + * @dev:	the device structure
>   */
>  struct meson_spifc {
>  	struct spi_master *master;
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
