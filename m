Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4243A6771
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jun 2021 15:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFNNLV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 09:11:21 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35556 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhFNNLP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Jun 2021 09:11:15 -0400
Received: by mail-wr1-f51.google.com with SMTP id m18so14494252wrv.2
        for <linux-spi@vger.kernel.org>; Mon, 14 Jun 2021 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hStNeExndAJKlr2+D1oBe+je+9Di+B0AKJsmhmeHTHQ=;
        b=zIfPjNFCiHxfObTFs8ltCt7sZ9oD7I2SfVX1afkSlrtXayb9culO2R5WYKq/e+R9/+
         gZJ08pzrH9I/bNRndmH6uhaFMZhakSpKCZWtdV/RsA8AntfFXpi6mykw6LyjOMI1R2lL
         OiCPiyg6YL0rjkobE198CFEKdvLW/3mvr/n7CGkrPAAQg3Ox+m6qk1YjRBq0g+yVESPH
         PiqvzF8Ws8MVwVNhz46e+j0MRL31iAAP7wtdT0U42M3EXjkkB7ZGHiUROoxO/adSSOVQ
         EPdAymMh0bgA3s0q/5Gj7eqf/kby/SrINUTUwWE7hs4avz+4JTko1aGxDExjjf+lwLuo
         Bwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hStNeExndAJKlr2+D1oBe+je+9Di+B0AKJsmhmeHTHQ=;
        b=eD/dQ9TuGrLdc1qxy5NpotM+Wx97dOJmWBzQlvWfRa5KY/b3R1MhTIqqjfvBkjzWkR
         QwgVBHLbdbhPeP0KkN4zoKUjiG0BGN5RW4AXEv6fhqkr+zHV6eYIYfmupigc71HxfTHR
         8hKyA7d7SVLdpdh2VLSJwvy44QxwB/57Nv/FIEhGqLbY2VlT2l4yz88kTNAPQ7y28MjS
         2ixddsvTJlfaTfFdrDwHMREBMFb23QyB1CKXog7oAiD7vQrwjY4zhQc2oGesjguwJx7H
         ERAN5Q1UhVakIOH6ZsCwFycIC67mt2x91xRrehQtDbUpSXTZj0b7c2KTgowwovV56DLr
         rEkA==
X-Gm-Message-State: AOAM532l5lkIBh8saq11Yi+s4z2y8/tWJsf19kFsR001Au/WNSwYLRv1
        huLqTfGXBtSvpwE3RSnHng0B7A==
X-Google-Smtp-Source: ABdhPJzhrbsLUQYWmMLMpZ5iObfaCDIXTZ3flWw2olgqdOuaNg4kbgxCwgzzFk8AtkZqvNIeEdQSAg==
X-Received: by 2002:a05:6000:1847:: with SMTP id c7mr18646898wri.368.1623676092087;
        Mon, 14 Jun 2021 06:08:12 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:f0d4:3c02:f06a:77bb? ([2a01:e0a:90c:e290:f0d4:3c02:f06a:77bb])
        by smtp.gmail.com with ESMTPSA id r7sm25083457wma.9.2021.06.14.06.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 06:08:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] spi: meson-spicc: fix memory leak in
 meson_spicc_probe
To:     zpershuai <zpershuai@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1623562156-21995-1-git-send-email-zpershuai@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <8317e3b1-120a-eb55-95bc-7cb3cd1777c5@baylibre.com>
Date:   Mon, 14 Jun 2021 15:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623562156-21995-1-git-send-email-zpershuai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 13/06/2021 07:29, zpershuai wrote:
> when meson_spicc_clk_init returns failed, it should goto the
> out_clk label.
> 
> Signed-off-by: zpershuai <zpershuai@gmail.com>
> ---
>  drivers/spi/spi-meson-spicc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index ecba6b4..d675334 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -752,7 +752,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  	ret = meson_spicc_clk_init(spicc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "clock registration failed\n");
> -		goto out_master;
> +		goto out_clk;
>  	}
>  
>  	ret = devm_spi_register_master(&pdev->dev, master);
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
