Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9D6C7D3A
	for <lists+linux-spi@lfdr.de>; Fri, 24 Mar 2023 12:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCXLbx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Mar 2023 07:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjCXLbv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Mar 2023 07:31:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC8B25E29
        for <linux-spi@vger.kernel.org>; Fri, 24 Mar 2023 04:31:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so6715844edd.5
        for <linux-spi@vger.kernel.org>; Fri, 24 Mar 2023 04:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679657475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1rNUx5PH+PaAEWGpJPPP680k3czmX+EawiTbGX+dCs=;
        b=QXr0k0McIYg705LgB46JG1XSCYwYgoRapwcMhK3GCvT8uaBzfpR225arLZFQiYVUVe
         5pdQxyzZGdEWXOrZZheu9Mfonk/pv2L8KbO0i6ipcr5D5tWXJWiXcYmwr4iXcFGK6Afa
         +uifTx4ZySOtqYRn626zPws3+v0twytGLhbwuOt9sPIA9mA5IZfWcREx3uPeSKPm0DS0
         ogr14Wop3rCp2ZHDWkQ/LJXPcXP51ZxEkApk3+Fr7hldEKVIwFnM5uXhRDUQIUbQYYKz
         XNMZCKEtKn0Bq5Ube2LmSArCaPLXGAb8g0Xfl9J2KjA5/2fEMRI/U4lioZ9UIGzFxm8b
         ousQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679657475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1rNUx5PH+PaAEWGpJPPP680k3czmX+EawiTbGX+dCs=;
        b=N6OYM+sddMuCISNBM3+oWciqorfLA/r0ykbKhqugSxua3lni7yEMhExTaJhhzcxbAQ
         q7/1L2mKrdpa0VIWDSeyIKIlabWF+UHYZQYknkgSk20rFW0DqjsN9nAZ7mRkWBT91m45
         wkc9++RtKdNxnsF2hPHPizuo0VDOqOGw6pgfm49fS2ZOFGmt9zMYjLvfysKQDCLZEm6m
         95I69wMF+j2LHsN4iS45nCPRh3uqdfn3F/7/RYVeAyIorI/ro6wpqL9/dbx6g7KTyPfv
         ZjjwEYpxc7hR9m95PpOD33NQ9kPZceYU8ZsJm99astFmCm8QqroLBejcHruSQtx+REa1
         xOSg==
X-Gm-Message-State: AO0yUKUgMIk6J5bQSOjc81mlstGi0hGWkgszHPt3ItHR8ts8z49nXSb4
        eyoQzQkMOG/lVV1OhanGfa5v4A==
X-Google-Smtp-Source: AK7set+epd09sUUlXsOnISckn46QyPnpX3E7bZc6L6A8pdpiSAxNGg4Jn1Vr7jy4OrcZo6o0MB812Q==
X-Received: by 2002:a17:906:57cb:b0:929:e5a8:63f7 with SMTP id u11-20020a17090657cb00b00929e5a863f7mr8781451ejr.28.1679657475167;
        Fri, 24 Mar 2023 04:31:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3027:fb0b:ae08:588? ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906858f00b0093229e527cdsm9665138ejx.42.2023.03.24.04.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 04:31:14 -0700 (PDT)
Message-ID: <0fff1e01-678b-a26a-084b-9aa30a0deea5@linaro.org>
Date:   Fri, 24 Mar 2023 12:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/2] spi: loongson: add bus driver for the loongson spi
 controller
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230324063317.14664-1-zhuyinbo@loongson.cn>
 <20230324063317.14664-3-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324063317.14664-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24/03/2023 07:33, Yinbo Zhu wrote:
> This bus driver supports the Loongson spi hardware controller in the
> Loongson platforms and supports to use DTS and PCI framework to
> register spi device resources.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  MAINTAINERS                     |   4 +
>  drivers/spi/Kconfig             |  31 ++++
>  drivers/spi/Makefile            |   3 +
>  drivers/spi/spi-loongson-core.c | 302 ++++++++++++++++++++++++++++++++
>  drivers/spi/spi-loongson-pci.c  |  89 ++++++++++
>  drivers/spi/spi-loongson-plat.c |  66 +++++++
>  drivers/spi/spi-loongson.h      |  41 +++++
>  7 files changed, 536 insertions(+)
>  create mode 100644 drivers/spi/spi-loongson-core.c
>  create mode 100644 drivers/spi/spi-loongson-pci.c
>  create mode 100644 drivers/spi/spi-loongson-plat.c
>  create mode 100644 drivers/spi/spi-loongson.h

Your patches still have build warnings. Are these false postives or you
forgot to build it? Anyway, please respond to the report.

Best regards,
Krzysztof

