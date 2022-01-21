Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373B149651B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jan 2022 19:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382138AbiAUSdz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 13:33:55 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56402
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382142AbiAUSdw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 13:33:52 -0500
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 51DAB3F1C4
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642790031;
        bh=v1/ZmZoCSfUTZLAD5km6I/vpYxbMEROGRzZoW4u340I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FgEQv+QXRe4RZHM7LdwxNRotsmfnwydmFWpIv9T9EaLSempTISL2TZ6QkO6mwDCd/
         l6wIrJAMzTZbUx1jutuxpLlJjljT1fAsEGnhjhP3I2iWw+scI4wsCuqXPhVGrNsu7t
         LK8YsOWZ54SblpHS+9ZdU4du4rtsGp8vTO1ML01PWc+CRZs6onJ4WhDv98uNpXPwvo
         8lzx77qCg3zuFnbI27yaJW4hZux7hmAZH1cavkFMsWng267KfdUmV3Coud4hIc1TAT
         0Ll5RJkdP4SaIVsMEFaSeO5vVDJPhBF2semKZ6eFDnDyKGHL5CM23HATRVhWpIcmLE
         x4DXKt03GqpdA==
Received: by mail-ej1-f70.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so409696ejk.16
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 10:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v1/ZmZoCSfUTZLAD5km6I/vpYxbMEROGRzZoW4u340I=;
        b=Z7rtOvlp58tVMwJ3nUtoluzW3KyqmNQE5bHdGJxD6Jy2L+E/Xa0B7DkxXF5oF5qPut
         Ol6fkmzY/7Izl7jv/5BSvj3mKTF7tYDFHH6A3X1Yt8JSxQqQGL0hcdcO2lwIvsS3Vv20
         OJyW+q4bR6sFfqgAEtTqDD4VwfDppdhX5+inohuVM7gDNZFpre9F9RbgU3Wb6HSacmCg
         P2p6K8DYUIAp13p4AyNc5dMd3Y22Ox4Jsmv/QQu7d2YESxr+90YfapRwrYSvvvGiA6p1
         aW0Zkrq5e8wWrZcKoG/oCi4x7H2rNXyUCqbNO2Cf4zac9Jp9Xuc79J8xo3scASJIn9fL
         +LkA==
X-Gm-Message-State: AOAM533BAMr+KcgzWUbEC26GH+BU4s9/Vwcu7nKn5zhoOBZ6qZw3G17X
        b/UOB/91FS6O1Jd6pmCt98i5TH5X2Dz+5o/Omhn6fhZbMIzhEBFkPmFwPu5OkgMBG38hgr07jXW
        Uy4e41YovQyBFEcG2liwWSJUwCDA8SOqrZRlYLQ==
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr4257061ejc.225.1642790030051;
        Fri, 21 Jan 2022 10:33:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUiLoCSnLbb+feIhIvxBFMattSryvmMTgY5adK0i09eglMEN/QYyW33qlmPPUw6iB1mJV4rA==
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr4257044ejc.225.1642790029899;
        Fri, 21 Jan 2022 10:33:49 -0800 (PST)
Received: from [192.168.0.51] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id lf16sm2220182ejc.25.2022.01.21.10.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 10:33:49 -0800 (PST)
Message-ID: <b11b8507-339b-2125-30e6-a927539d7825@canonical.com>
Date:   Fri, 21 Jan 2022 19:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 2/3] spi: s3c64xx: Add spi port configuration for Tesla
 FSD SoC
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, broonie@kernel.org, andi@etezian.org,
        linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        Aswani Reddy <aswani.reddy@samsung.com>
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
 <CGME20220120193618epcas5p45be1db500363072e647bf179623f8e7a@epcas5p4.samsung.com>
 <20220120192438.25555-3-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120192438.25555-3-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/01/2022 20:24, Alim Akhtar wrote:
> Adds compatible and port configuration for spi controller
> for Tesla Full Self-Driving SoC.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
