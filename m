Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ED6723C2A
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jun 2023 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbjFFIuG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Jun 2023 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjFFIuE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Jun 2023 04:50:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4565109
        for <linux-spi@vger.kernel.org>; Tue,  6 Jun 2023 01:50:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so8454964a12.1
        for <linux-spi@vger.kernel.org>; Tue, 06 Jun 2023 01:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686041401; x=1688633401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNZJwJJab4riyWzRmpxdXxKEkTNWOTzLRUWxg/pAFSY=;
        b=aLvKZIU5TqSFa1zhPezixfLlsmrQkKNGC3lTXwz0C+RZ9Q6Rbrmo2jh3tl0NWqtZcY
         JrNnUQxZB/UK4mlOdh2zu/rM69SiIfIVyjDw8DyG+pFj3VeFj1WGOcf9fl7eRrZydTpI
         32pZDDkxVaCV8Pd1koFk4yslxsRxCGPc6iXuYBqApBYIrLwsleXXJZ+8Vv+jpnGjDfOm
         QAo+46p3+ZYCcfZFm2lDSFwv9eRXZnc0N4vuMV2/FQEBb6d8StIRC9gvZxKXl+Tqt8X/
         UnK0CuOfgrhthyys29o6eyBeKD1ogvwgmNaF7MArj3kR9m8S9l6RYMiuODX6/vApswT3
         iJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041401; x=1688633401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNZJwJJab4riyWzRmpxdXxKEkTNWOTzLRUWxg/pAFSY=;
        b=lfVjSjXr9gYECAQisYiW92kzrexGijKXWcyoqQ8riHSiMswk7RjL9adwMtv7utWB2y
         Vx3ZLyVial/gqmihRuLr64zy0KUjM1fmbU4Vfa3scTm4SxTtwwtzA6/E34O/bnBRKAV/
         Fs4MceXLSyC/czyFLxyCtAPrLtwg0XIMRohPzFQntKmVYNSZS3ntH2/eU+iB9tfHW2aY
         WUxeNazXwpEBxcoIzBZq+uYSGh6djYX8V/3tiEMkgnoPPTHGHiVClqiGT2BXJ1+yNbNd
         SGAJedcifHAjgyuJKxBuAHSIr5dnxQCnXEqMKcssJj4CirjKenBXtm9RyjPNOxxHE69H
         L4OQ==
X-Gm-Message-State: AC+VfDyf3kaH+jd1PrQXGq0BQiBB+TZtWw60v0Y/+ORdFwNXaBBFd3pv
        gbmj3f6SyQVt3sIphRpnC52Olg==
X-Google-Smtp-Source: ACHHUZ5qfbjnN0Azzp06pyc+xpWkkoFfHsGFQYdoABfaisKDIJy8fV7JRYu+LYE590p8hBCyRIDnkg==
X-Received: by 2002:a05:6402:897:b0:50d:89c9:6387 with SMTP id e23-20020a056402089700b0050d89c96387mr1610786edy.27.1686041401433;
        Tue, 06 Jun 2023 01:50:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b11-20020a05640202cb00b005147f604965sm4840471edx.24.2023.06.06.01.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:50:00 -0700 (PDT)
Message-ID: <66a83118-4f16-a636-4372-95df2570f339@linaro.org>
Date:   Tue, 6 Jun 2023 10:49:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT
 binding
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230605125504.2570158-1-ckeepax@opensource.cirrus.com>
 <20230605125504.2570158-3-ckeepax@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605125504.2570158-3-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/06/2023 14:55, Charles Keepax wrote:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> Add a YAML DT binding document for this device.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

