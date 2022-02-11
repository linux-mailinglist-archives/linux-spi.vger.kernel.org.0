Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5E84B24A8
	for <lists+linux-spi@lfdr.de>; Fri, 11 Feb 2022 12:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349561AbiBKLok (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Feb 2022 06:44:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349555AbiBKLoj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Feb 2022 06:44:39 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3FBEAB
        for <linux-spi@vger.kernel.org>; Fri, 11 Feb 2022 03:44:39 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0EECD3F1D1
        for <linux-spi@vger.kernel.org>; Fri, 11 Feb 2022 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644579878;
        bh=ecHVwDlq+AQYKeIGcf4CvkI7mMqME8Svegbv9eL0bmA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IXlLL6OtfmBNivpUQXvoQnsXfGg/xds0/6qPxL9Rcg9KV00mIceMRzOgBggycQOjk
         cVpZeURair+Lb3f7VrgYdDSrms0SVrT75BMmnbxIJV69JZIUyUyqId8D+jsWNRgnZo
         Sz92XcVZ4MjhgmuKnnT+/dM9pLbOhnqEPoUskJfga/bK/5UDtOAgA9uU2Io5ZXsDpb
         SkL8rX9INOTOCFJh9Yg4VmpTwLskgPCNrZtiuIo2RrMeL/Pejb72kLAhpfTd7NvHz4
         LylNYwyaIEvmO8gpjP5yji7kwPfTLk3exsC12f/t5BShX2SjR2RkopCZhduCB9bhXV
         IAzMaX7OsmTNQ==
Received: by mail-ej1-f71.google.com with SMTP id m4-20020a170906160400b006be3f85906eso3973744ejd.23
        for <linux-spi@vger.kernel.org>; Fri, 11 Feb 2022 03:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ecHVwDlq+AQYKeIGcf4CvkI7mMqME8Svegbv9eL0bmA=;
        b=Yx2lMJcRUNfiSJxrKFJezq91pxUJFOltF+Fw5dybIuTAbdtTWsJdVJThguVxfY0ZcI
         ejkVYZP47kExU1tEnYuvUuS8hK4f4PH6E78V3L0t9kLyI2a1XHEXNIEoe98Hyus0ttLr
         pLLWuYQ1zr7hZnHPaNTL8jxMLDJaNa1NOVo6tV9rpQFAXOzgpq5B/4awNUvfl3gCh+hp
         2x7bP4zlb+/GkXgDmdgg+qmIity5T6JySpqukrniRx47RiCRrje3eUwLQLIiUBMWjNRf
         OzNbrH6opDQl6ydVn6OzC1R8UW06/lcvwVKeNjk4Zx+5Dq+x8qELS/zvMMY3GDaZw9v5
         03qQ==
X-Gm-Message-State: AOAM533Toe6n7y2iLJxslKaiXk0k5z//mmb7sq67nNiOYGMnn8durdH/
        swJ7bjrXYG4EVgiom7dPPAQQ6Dff7SC4bc3JDChOeREZ35UVouYwaLtYKddhUEHi598bv5tG8yF
        xjxIrPW5MgaUtEZIGUv5T/5XvIswIX56c3iEKgA==
X-Received: by 2002:a17:907:c26:: with SMTP id ga38mr1032320ejc.626.1644579877733;
        Fri, 11 Feb 2022 03:44:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznqvvnq5wXIqGOsU+p8aV3YUjGCSFQ0QQ2p8CHvwjdn3oe9wCw8FEpPx+8TbAPH99rTQcjyA==
X-Received: by 2002:a17:907:c26:: with SMTP id ga38mr1032314ejc.626.1644579877581;
        Fri, 11 Feb 2022 03:44:37 -0800 (PST)
Received: from [192.168.0.99] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v28sm10808602edw.95.2022.02.11.03.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 03:44:37 -0800 (PST)
Message-ID: <bed10d2e-a3eb-ddcb-8b84-9b5ba7f138f1@canonical.com>
Date:   Fri, 11 Feb 2022 12:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/6] dt-bindings: spi: Add compatible for Mediatek IPM IP
 with quad mode
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
 <20220209111938.16137-4-leilk.liu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220209111938.16137-4-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 09/02/2022 12:19, Leilk Liu wrote:
> This commit adds dt-binding documentation for
> Mediatek SPI IPM IP with quad mode.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
>  1 file changed, 1 insertion(+)

Same comments as for patch 1 apply.


Best regards,
Krzysztof
