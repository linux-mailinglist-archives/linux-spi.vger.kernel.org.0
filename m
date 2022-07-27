Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E235B583082
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jul 2022 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiG0Riw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jul 2022 13:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242618AbiG0RiS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Jul 2022 13:38:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B08B87238
        for <linux-spi@vger.kernel.org>; Wed, 27 Jul 2022 09:50:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t17so15706317lfk.0
        for <linux-spi@vger.kernel.org>; Wed, 27 Jul 2022 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rb1FB8S7K+YoHZwnK5lpzdbH9mR1fCmHK8/JCTc6i40=;
        b=zvVoFZ0OHaSCxvfqQ/tBxedkQ+6xY52vCay7aQqTCmOV57kXJGCmpGecBeN5Cyva3q
         tQsjhBeaY+bDnUC0QjNu8mvDMw34FiI3J6rmXWHFZ+9YeIWjqBQAi/t0PSKRNJSQp89R
         psFjSgL/4dGZsyiO8jYkxZrem01Y1RT1Fza5GNXHvbf0KPURmWdXFs1iv1nntSkP5AaX
         C6cW2c2weWcjtKWdEakGmZk+fG+JT/k/94abqQ+5qGgtwowtxOhvLvvmmybv5NcKUM8+
         +CTNiX/YFtQDEGtBYl+zGZEfpfoycLa3YsTef0gxzg03pKlalTnjrf9b9MzRCmviTZet
         /0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rb1FB8S7K+YoHZwnK5lpzdbH9mR1fCmHK8/JCTc6i40=;
        b=YrqUmrVStM5G2zaBvciKCjKWhh9crk5C28G5TDCMr9yZrND0OP454GunEg/hS3NrLU
         enZhwwnWuBicz7ucfSK+2f3dK5jgFFLMGMBHpxrayrDeIqNVMz0KfMchpUiWo4dnXPGP
         /LRr84aWUUw9BWsjhlKmAneV+4tOGmtYv7Eke5meAuxB7wncBFLf/XvPUbsXZdUe0Rqz
         2IQUcxQbFMDw4waJOPGf3JTgM08x119GG8ACtJoWkGkJpdc7EuO8ogHyjQX1UaB/yVFI
         lXuEYLCDOEBUtIjJCByBZqn4FZV0yYZtZzpGkAX61oX2SGivioAbyiApIR4KoDhJhaeY
         63XA==
X-Gm-Message-State: AJIora/gtDE7tDx7lKCe7hNCIblRAC6dimGYhpM9gFOR3y+GWEhmLQ3F
        qYX4+WMKo2ryTE4ngCJLqgEMNA==
X-Google-Smtp-Source: AGRyM1uKN/6CsJ7dRw2kJ7G6Z+87qHHOAOs+37FNzhsjBRnj3nETk9Dnt1PcbTtv0zfAhhvq2Yc3fw==
X-Received: by 2002:a05:6512:16a8:b0:48a:9ba0:606a with SMTP id bu40-20020a05651216a800b0048a9ba0606amr4383326lfb.476.1658940635704;
        Wed, 27 Jul 2022 09:50:35 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id e28-20020ac25cbc000000b00489c5db8bb6sm3856186lfq.176.2022.07.27.09.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:50:35 -0700 (PDT)
Message-ID: <0c3a95fb-a3ee-ba48-1f69-ae9db84cc856@linaro.org>
Date:   Wed, 27 Jul 2022 18:50:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 2/5] spi: dt-bindings: add documentation for
 hpe,gxp-spifi
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220727164736.48619-1-nick.hawkins@hpe.com>
 <20220727164736.48619-3-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727164736.48619-3-nick.hawkins@hpe.com>
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

On 27/07/2022 18:47, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the hpe,gxp-spifi binding to support access to
> the SPI parts
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 

No blank lines between tags.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---



Best regards,
Krzysztof
