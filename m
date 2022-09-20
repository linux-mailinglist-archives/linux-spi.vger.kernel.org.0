Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC235BE684
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 14:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiITM5W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 08:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiITM5V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 08:57:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47AB1099
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 05:57:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a8so3571399lff.13
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5ctsLVBC6nzGHPR5T5b6tUNVoSbpufYe/oiWSYXfQVE=;
        b=W4wBX6Ulxs4ZtDW1a/wM3a52FkhnEqjVsdow6GoYwXuS3lb8861/lSmWH4tZhfNZu0
         bwoZf6PghKA1//rHof3HgpQSWxE3ogogQ1yUJ/xIJis9/TAs825UMt6LBcIJ9S79q332
         hLDMMkEKLHBflN4gnWT+MpQGZHBjdFpbwkuMH5agQfgJzOQntY1BvFpZyS7xBXFdAJB0
         pXEsoxYB5syAuUSMPUdSRnqEc640b3ImEkBzCknhLpsc5jTtFP6mynxE1zGXsb0SKuM2
         FfuCWMUkNdrepJhuE+o1KIcV3VPVbIkVvikf5zURmUstJgW4bI2WyCrHYDVnSKTFi20W
         dEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5ctsLVBC6nzGHPR5T5b6tUNVoSbpufYe/oiWSYXfQVE=;
        b=x7BDpt+wxYVjl3TlPFupdeeRzKFPfYCJ9bEblrnLHj70keOZbisevQ/cfe7bGxJe/w
         xKiWRuTLsD8gGkACw+E0ygelVVEgzRl/a4FmWut63scSnSKdLxjQbyVBd93NeJom0AQ1
         mugMEhMsFAApzY2tk56C+hzvTF9QuEQnVjAM19KS95yCdkb/fUBFXqP9RL96FO4GY9KR
         A7e2LOUyzIjJ4U0gTysOz73Hwm9Ckpow/T+Q3ALGF0IGbWTDypSv6Ic1PYXMeo7L94J4
         nIFOjPHyCRKhsbGMKuNwX1MafwlnBzBhu2g6Dk54mw6ziJiKx4uBqEp323BdYlskPiAb
         WGFQ==
X-Gm-Message-State: ACrzQf3fRO9HyE2Ol3FwmKm3YRKd1nMgYW2Qhmd+4kspcm1HCkPAlCaA
        8N2Qcu9KZjCA7hVrj9Hz2xO8/hQZblMaYw==
X-Google-Smtp-Source: AMsMyM4Gk+CTfRGVBCcGTusPV8BnL/zeA3Zx/seoOdjfBJdfbyNJ0TyQItPFndhlKNoRkvciGizV1A==
X-Received: by 2002:a05:6512:3b06:b0:498:fa72:c24d with SMTP id f6-20020a0565123b0600b00498fa72c24dmr8380162lfv.538.1663678639066;
        Tue, 20 Sep 2022 05:57:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a17-20020a05651c011100b0026ab2a04055sm254828ljb.130.2022.09.20.05.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 05:57:18 -0700 (PDT)
Message-ID: <c3aaa5f5-327f-569c-4032-fe72e5dc5fbd@linaro.org>
Date:   Tue, 20 Sep 2022 14:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] spi: s3c24xx: Switch to use devm_spi_alloc_master()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     broonie@kernel.org
References: <20220920114901.2683267-1-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920114901.2683267-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/09/2022 13:49, Yang Yingliang wrote:
> Switch to use devm_spi_alloc_master() to simpify error path.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

One more comment - the patch was not properly addressed.

Use scripts/get_maintainers.pl to CC all maintainers and relevant
mailing lists.


Best regards,
Krzysztof
