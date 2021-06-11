Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F083A4382
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jun 2021 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhFKN5U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Jun 2021 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhFKN5F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Jun 2021 09:57:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF5C0617AF;
        Fri, 11 Jun 2021 06:54:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so8759504wms.0;
        Fri, 11 Jun 2021 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t4GhLZNbe4X2F3Nkr5l8ySaeJ4eizRMsuR8A0/1Zt0Y=;
        b=a/f8+4vbE1r6uJlb7Fjan9+4imWd4Zedf0Xckjd0d4AB2QSBHX5peJ7wmUNKD6RqI+
         to/2lPyvcfU4XkwCX1knG7AuwfjX7/O2OISnaQPZ87aakBd6RbyLw4/U7RX49QraOXlq
         QfLh4HN4i3aXmH2Ho1av8xEWIPTj/5AC3Myk3hLxEyLEmLS1IFpJ0UJssFbeGA2vAQ48
         f6RIU2Tg+qkYwbz1YGFE2faT4qXVsIjz43HqDnXCDFi/AC/y3IdrajUzl6YjzxwxkJPz
         e1RASmN2Y/FUn76nkutOI1G//cDXb97TqWLuuFECkcD3Pv2EU49R9fhmMV08LGh6AlGI
         KWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4GhLZNbe4X2F3Nkr5l8ySaeJ4eizRMsuR8A0/1Zt0Y=;
        b=czkb4mmxLCh9+hF4Dr+8hYEm2HLwGYwjnSazLrglourXsj5nXl289k0x+dRLfCFQB5
         kn37tvUV2T7MKvVD7annefuk3iBmbTABDpL8cHcWaw+kIRxNaYIHoLffZ35x6nj8FuhM
         Tya0dkL5sExAincEoniFYGAJJKs7nfNKMwxmjkPI1YgJm2kOKfwpErVtlZ6K+Ym4bQ2L
         4sngD8EpJfvgFLhGKqJ67yIRpcDD9Opg+cdhs45H0kS5Hb9M7wrS1bVyWkPOwiCl8u8/
         Yb7QXQXeZNbonOgk2p0Sj+uhkogclaU9eW/hCuTRhCkxb0NDXWAC/gsFilrHQfnQrgLo
         7Vzg==
X-Gm-Message-State: AOAM532MszD2/gEI1m+9pRikShl7Ix4DsSdG13tY8Pt+uwQej1GZHfCI
        45ti6gB5WBsPd0VSetiNB3XssyggSBX2SQ==
X-Google-Smtp-Source: ABdhPJwGotQnlGnQ6Y9vwgx6pMAyzR0pOVPeMeus0XIW6adAlKXjSYCF3sSJwsvgh9y7r9m7GBGYrQ==
X-Received: by 2002:a1c:1d04:: with SMTP id d4mr4074792wmd.126.1623419693316;
        Fri, 11 Jun 2021 06:54:53 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id d15sm7025666wri.58.2021.06.11.06.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 06:54:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
To:     Mason Zhang <mason.zhang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        hanks.chen@mediatek.com, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1623413625.22727.10.camel@mbjsdccf07>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a00f4055-4f44-9acf-5a0f-579c300bd5c0@gmail.com>
Date:   Fri, 11 Jun 2021 15:54:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1623413625.22727.10.camel@mbjsdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On 11/06/2021 14:13, Mason Zhang wrote:
> 
> this patch update spi document for MT6779 SOC.
> 
> Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> index 9e43721fa7d6..7bae7eef26c7 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -13,6 +13,7 @@ Required properties:
>      - mediatek,mt8183-spi: for mt8183 platforms
>      - "mediatek,mt8192-spi", "mediatek,mt6765-spi": for mt8192 platforms
>      - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
> +    - "mediatek,mt6779-spi", "mediatek,mt6765-spi": for mt6779 platforms
>  
>  - #address-cells: should be 1.
>  
> 
> Hi Matthias:
> 	
> 	I'm sorry to disturb you, this patch is stay here for a long time, Do
> you have any suggestions about this patch? 
> 	We hope this patch will be merged as soon as possible,If you have any
> concern, I will fix it in time.
> 
> 	Looking forward to your reply~  
> 
> Thanks
> Mason
> 

Please put any comments below --- but before the diff, otherwise you break the
patch.

This patch was already upstreamed by:
260864f797f2 ("spi: mt6779: update spi document")


Regards,
Matthias
