Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C49F5A6655
	for <lists+linux-spi@lfdr.de>; Tue, 30 Aug 2022 16:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiH3OcV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Aug 2022 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiH3OcU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Aug 2022 10:32:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4992B2CE0
        for <linux-spi@vger.kernel.org>; Tue, 30 Aug 2022 07:32:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p7so4666327lfu.3
        for <linux-spi@vger.kernel.org>; Tue, 30 Aug 2022 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=C9hMrmnRCeOxtJSBU+xDskBEasH7EBMzC7Z87lKYcrk=;
        b=C3y1zxG+qaBopF3ylPypT8F90mDv06KIyA3ct8e05qPAV6oqFEh+T/cKlYXpjIC2v1
         47pSwcytxVOu/yzUhlM6cipUVH19dgIxO2eIimscfr3Mxv3GvRMr5ywhx643sJ/SZ/n/
         uHyaJ/ltJdqcpnaBrLdUl8+cJVKj788odF0hsZTvQiAP4Cu5tQmyjNl0bvteGdgnVUFj
         MyYvD3t2ThHSSzJ9PSLxvXRy/g7dmAQTUMujn+LOHJ7k2D5vYT2SQDbQUlETvVWg6kPU
         k8OLJlDQJ00GWKlJapuwerMSw/S72Q6IhPBghfCCot63BSjlFdzMgK0mFxbHy4TwpPsQ
         DKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=C9hMrmnRCeOxtJSBU+xDskBEasH7EBMzC7Z87lKYcrk=;
        b=zzRGrw9DVvLGFuQvTK/Z7Oc41yThI/8l8uRyCuPgVNLgX9GLwFhrXrOJe+YRkCbDC5
         /iu5TcC9/Saj3uE0NXrriuhslW27UsxrEQfp08FYPcHl1cY0lpG5Gi3m6zsvtS675N4Z
         j65fvKPMzJa/38Iv65/QdwLiBnGjcTW9IANWbyfbCYq/byXV3rQeEMXH3U9yp+rmlAAk
         6tFFfb4QUI160XQ2MN+oKeLqSvnancOXM3ZWvTNrkbgsC7AJXPdqkdzpusiAGfdZsrsT
         94DkWGqS4skp5mYu1p2XEq+TC4Km1xZmGvR6ayN0Wi7s9ex3mqd2jmse90z1L06z9yDH
         7Tuw==
X-Gm-Message-State: ACgBeo2ckyGKJ+Cn2rKPL/K/sJ949UY5cqFyQdY9AyKsAqgkO3oS7qgs
        G69eIPv3Zw0s/TDKfsC3lul92g==
X-Google-Smtp-Source: AA6agR6RrgJXyfpzXFNbCthcWbJ0OhEgloy1Szcy3cQyXNHecr2Pdwq6I15ti8Pop7FAZwJtlo6rHQ==
X-Received: by 2002:a19:e04a:0:b0:492:f96f:85b7 with SMTP id g10-20020a19e04a000000b00492f96f85b7mr7387760lfj.141.1661869937015;
        Tue, 30 Aug 2022 07:32:17 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512348300b0048af2fe78c4sm52684lfr.3.2022.08.30.07.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 07:32:16 -0700 (PDT)
Message-ID: <7ed1a3db-e0de-fd2e-3206-0a95fed3052a@linaro.org>
Date:   Tue, 30 Aug 2022 17:32:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] spi: spi-rockchip: Add rk3588-spi compatible
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20220830124452.33561-1-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830124452.33561-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30/08/2022 15:44, Sebastian Reichel wrote:
> This adds a compatible string for the SPI controller found in
> the RK3588 and RK3588s SoCs.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
