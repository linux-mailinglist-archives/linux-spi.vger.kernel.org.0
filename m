Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D91425DC
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jan 2020 09:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgATIiz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jan 2020 03:38:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37947 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgATIiz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jan 2020 03:38:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so28552876wrh.5
        for <linux-spi@vger.kernel.org>; Mon, 20 Jan 2020 00:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rQFcL2jcWZJExt1pJvgNmGZQG6G5eQtrXtrdmESpdhU=;
        b=rN0DdGff7euhnoh1U14uSXN28jZJpMISMBspCPJ/TDrYW7d/NN9zt+tsw71ueCKIi0
         2ka2QOCL+c5VAo1YwQ5Swlyn00EvFHOsxpOBH1pw2vJ2V8eqe49plmXXI4gchWm84bD8
         x/0hz2EZ+d4SqZrMrww3SR345LtI0qBaAwiEQmvxapGkqaxS8DDyASll4c9R6U7NMiCU
         fkjkHToX/+l+h84FFOF3KUqJXiLcYTY1+CazuTEmixtHes4S9njkn4hkWD0jzjnIH/mi
         7lWToqDLao0YD5J7RqFW2lAqFRhlcvQFFROq5MxDWZPlA3PI9ie/uzv46MZN5hAh41tT
         PwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rQFcL2jcWZJExt1pJvgNmGZQG6G5eQtrXtrdmESpdhU=;
        b=QNh6xDqGVTELyZE8kgf52fVlWhCt+deO4rc1q7YRUBpZRCUr0CqNHCnQHpIG+ZEXUz
         7bDgzLGKDze8xg7j83BNbpCXZahJHHTa72ptkKZve+o7rl3saDqVcH5uQYG8uj6oAn6a
         eS4gLiWcIX/lrbGgsupwcM6zGVvjrzLFuK1gUcqRJJKfpDWP/z1aOQ41WjqNQQ3tbqWx
         KHjj+aSET+A/dOXdxucVgRLu2k0whMXseVADJ+qthRKVZtKlcnkacK+DqpNyoCDSp1wv
         PmXeExbJ+OEBW0Wt+iZa+Ph+o2A0zEs5UToHHyFvkXIiMwFcj7h7ZCMOd8KH8zjT6+LT
         Btpw==
X-Gm-Message-State: APjAAAXvs6F4l+egJRrzhiUEfoxrXtk8ad90GsQddg01dmcODtH0Nn7L
        6E+QuQsmmLmi4SatXkCFdtliqA==
X-Google-Smtp-Source: APXvYqzeVB7HzioVZsHsLXa6sKg0B7Lo1W1Bz8s9/s9W1MM97QSS0Z9RkuMkfW2z8/7a0vF9xowEaw==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr16714639wrt.15.1579509533039;
        Mon, 20 Jan 2020 00:38:53 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id x11sm47604751wre.68.2020.01.20.00.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:38:52 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:39:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: atmel-usart: remove wildcard
Message-ID: <20200120083908.GT15507@dell>
References: <1579262309-6542-1-git-send-email-claudiu.beznea@microchip.com>
 <1579262309-6542-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579262309-6542-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 17 Jan 2020, Claudiu Beznea wrote:

> Remove chip whildcard and introduce the list of compatibles instead.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-usart.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
