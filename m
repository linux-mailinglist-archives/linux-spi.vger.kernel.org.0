Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FDA13DC02
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2020 14:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgAPNbs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 08:31:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45555 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgAPNbs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jan 2020 08:31:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so19125969wrj.12
        for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2020 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=92j60HxqCEoOKu+L2rR0tiLdjI3nwfWARg8KDYeQ1Hc=;
        b=qk6nnIvTtbXj8z3WH8gRV5cDnpDpuGi+k9gfNf1M5gPU/SGXQeF/OouzDTCtsNTspO
         jyP6vddeW+PKwwlJcW1RP21/2yahoHU1oy+mijDa2/YmNpFjQnN+Nw5ZVbe0AWOQ8MSL
         HBq+5c4mm6oTtx2gT0pdFAPlhYfXLZEfvcZosCXRs5amTmpo77tfKqiIsleJOfsQjgga
         N44KBEzn3cxNeeG/4wciOEzUQeA0kvBvBXm4m5SY6lBEh9Z2QmrSoJhbikrjDyvbLnCJ
         IBP5kISG7AL6GQlWy1nJ2oOGDn6FNgcRO4ZaczOg9Ptv6lg4qvqOhbD6ZkzIKeekalBk
         w7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=92j60HxqCEoOKu+L2rR0tiLdjI3nwfWARg8KDYeQ1Hc=;
        b=d3949hutZfya7BUlL8HjEbqCLpCab36DYg+aT+dGVIGHSGAT0YzHnNFcxqpT6BT17g
         lnbY9ATsw5awWRWpQIyD4HSxRJ6TS62GMmJUAnzDQA2Lbrq0OjCw/Tmvgx4JJcss+TBQ
         qB0HhcchguNroCaeOsriA9aOf8MHIhr9L2z4t1/LEsm9WVm6yP9EplNHuLFpHq9E3gZB
         HH+ruG47J32CfFq+admbs0YpAJ+M+dC0+8t/5A7Lg50REXlGkU7bzsZ50Dgfr5NLqYXk
         79uhyBC+ywzuSktZEuPUcYd5D5kbf1olgygbtDa3r+obRhFoXRLXlJYIsN0INwSKtRSW
         qxTg==
X-Gm-Message-State: APjAAAWEvhXEyzL9XiI5HUGQXWFgvSh68813m59TuP6XqnDDQhzzGDiI
        qso42hGbpWMze12Go0LwkMpCQg==
X-Google-Smtp-Source: APXvYqwlMDSGPaX00R2t+Jwt5d47l+TNIJ+hn5XsewXTyhaLBWjnyKNucc5zVRNV2/RZ5WqI12aE5g==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr3190596wrt.136.1579181506919;
        Thu, 16 Jan 2020 05:31:46 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id s3sm4550461wmh.25.2020.01.16.05.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:31:46 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:32:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: atmel-usart: add
 microchip,sam9x60-{usart, dbgu}
Message-ID: <20200116133204.GP325@dell>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578997397-23165-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 14 Jan 2020, Claudiu Beznea wrote:

> Add microchip,sam9x60-usart and add microchip,sam9x60-dbgu to DT
> bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-usart.txt | 1 +
>  1 file changed, 1 insertion(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
