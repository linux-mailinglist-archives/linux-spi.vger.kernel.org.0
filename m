Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DCD58059F
	for <lists+linux-spi@lfdr.de>; Mon, 25 Jul 2022 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiGYUaT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Jul 2022 16:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbiGYUaR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 Jul 2022 16:30:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F955B1
        for <linux-spi@vger.kernel.org>; Mon, 25 Jul 2022 13:30:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r14so14442965ljp.2
        for <linux-spi@vger.kernel.org>; Mon, 25 Jul 2022 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=btEaiFtsICTFV/AyaHnx+0yvOMPc7jvU7OaVLP6uyWM=;
        b=iznzw/oKStcOI0bAGS9Xra6SuSxmspEu4Az+bEP/SGfdhmWF//Rd85HVVNgR7U2jHQ
         ZDsLiKOgnm9Y7/NDvVjAPw49N4pTs28dJeHdktjTHVkDswNLoFr7RJTtuaXbUNSsF/Hm
         e7ry4jVjw+WRVdLhJCXM6RDnX8o6Z7mYid/WibhtZ9cAQKsWSxuWMBRmXE38e+DhOgdz
         sU6CH4p9QhGYQMkyEb/NezOzUHFTsCW4EgZBU0kz0RpWgMd34uZf+JJUbyT0/U2OxUhr
         y+PWqD7j8MNOXKa9WRAa4iKiaOHss86oF1i2OJennBVqtSIhV/uv0Ut6sGpYY3CQZHNw
         2I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=btEaiFtsICTFV/AyaHnx+0yvOMPc7jvU7OaVLP6uyWM=;
        b=qDQx+HCK4eCkMiAZ07DDkNsmGvkjy1KkBIteAFXsdmvX1Ps9cHyXPhXvlewiw0KPHL
         iz70OpGCF03YitQ+7McYUedJpRh4jauJOEhGlzEB0qXKexmLoEPiwQLBB0V5kZO4LmDk
         ENRITeJArZwa4iZ1Q+Eqkgpwp4hIW+GUD4wMMbeM0zyT46n5ETH/MC0JhKQr+UqiVjs7
         SDjFKnRZgik76D/OzUt8Qcmws1PeL/lr6bnkOhezSYU5r9r0TcPw2aFpICSGQGYgcQWu
         3Of7BtgUehRv700bT22XH31yXOI6xV/qD8HgBGRYBVi7/v/uQIkQWe3sQLyse92D4+hq
         7nJw==
X-Gm-Message-State: AJIora8tQr3ku4G9o9Z4mKaxH5ecIlmXo6V6FISrAi0phs9ppxphXZ2r
        48MZLR7AEoLulUJykQDXN6E1CQ==
X-Google-Smtp-Source: AGRyM1tbxmNm8XwCIoU51WsIR8IMAhXgQB5jLfTJC+jrrekZqwm3We1fEXUIA+9bwxjz5INhlXwbpA==
X-Received: by 2002:a05:651c:1542:b0:249:a87f:8a34 with SMTP id y2-20020a05651c154200b00249a87f8a34mr4793010ljp.442.1658781012777;
        Mon, 25 Jul 2022 13:30:12 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id bj24-20020a2eaa98000000b0025df34d252dsm1980011ljb.123.2022.07.25.13.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:30:12 -0700 (PDT)
Message-ID: <da6060ba-637e-3733-a489-a1cd7a385150@linaro.org>
Date:   Mon, 25 Jul 2022 22:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP
 SPI driver
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220725201322.41810-1-nick.hawkins@hpe.com>
 <20220725201322.41810-5-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725201322.41810-5-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 25/07/2022 22:13, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Enable the SPI driver on the HPE GXP BMC.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
