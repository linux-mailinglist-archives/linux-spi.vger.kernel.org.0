Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B037A724292
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jun 2023 14:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjFFMoI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Jun 2023 08:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbjFFMoF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Jun 2023 08:44:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3C1707
        for <linux-spi@vger.kernel.org>; Tue,  6 Jun 2023 05:43:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso370111066b.1
        for <linux-spi@vger.kernel.org>; Tue, 06 Jun 2023 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055418; x=1688647418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mK220acPIp0Asjpx7WaUgqj2OH9AJX77DYV3xxqd5iA=;
        b=Cr+0sfqBACoG5qRB689ltZloU3SiTrSDK3yRSMTcaISF7FGdum9egCI2nWA5gxmRaK
         daLOjhx4q2TDLeXael2GAEIpJ3MY6rNaWvlmqQtVlzOuUj52kLeOD/W/1YTEKLcvS7y6
         RxCOX9icXKTpyNMZ5yktWxvMTafFaEOYJStoz17+gOmrKpHS5ThtoVczItCNjcUT/qPH
         Cb8guFYO9ai5gR8ixCbF5WSDIAtUCY7PkM0kqphHq+xAi/xNUzysDaooV54ffoXgmwov
         wd+rmvepiTVyutsV1BhxZfYw+tLcyTNzQlZtP4IHfSLG1YZqWiv9/tfxIEkWWHZibGoO
         eqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055418; x=1688647418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mK220acPIp0Asjpx7WaUgqj2OH9AJX77DYV3xxqd5iA=;
        b=ddtK5xPK7ZEzLgc61VMRmvD5hzmqRtFJUd5H1/pzA5qI1ZuZqNJh8L25mZB68IlpOY
         vQAddajRSkmvtn8/YaY0038mXvA0Kf67zB2+g2rSqE2EcqgFul4kTd5fVB3rHh7QkfYT
         pNoKd/a3hAW8OjMfGOJfJLM8CR6Ph6ZaHtMWMSuKvSI4iVsNxJPh9Ap4U91InY1B9Yzd
         qZ6y4xwyeATZWnz4gZfV9MpZwNtDJ7jymeVtAqtCPMJ9WeeimkF7SuSpyo1iPL7kWFG6
         3kT1F3BHqHI6dOWu/s+RhKoVIPOAgW6YZn32gXr3RZGOcFW0wLYAYliyc3LmiWljUI0z
         fadw==
X-Gm-Message-State: AC+VfDy3D183DG0rJFRpEFyD1AGoXX1RsNIKQFlJ8/8GktGcDLCMC1f9
        jNIN9E7ynW55/SbpzYC2Q0RB2g==
X-Google-Smtp-Source: ACHHUZ5XRAYpRQYNod5PLa/diyi4g2ViUz8nWrxI8quciVUCIMB853yrvygjxAT8AI5273ZGNyDfyg==
X-Received: by 2002:a17:907:7b9b:b0:974:5e14:29c5 with SMTP id ne27-20020a1709077b9b00b009745e1429c5mr2615396ejc.32.1686055418440;
        Tue, 06 Jun 2023 05:43:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906815500b0096ace7ae086sm5589502ejw.174.2023.06.06.05.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:43:38 -0700 (PDT)
Message-ID: <e148c599-8521-3264-f994-529ffc18f836@linaro.org>
Date:   Tue, 6 Jun 2023 14:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230602084925.215411-1-william.qiu@starfivetech.com>
 <20230602084925.215411-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230602084925.215411-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02/06/2023 10:49, William Qiu wrote:
> The QSPI controller needs three clock items to work properly on StarFive
> JH7110 SoC, so there is need to change the maxItems's value to 3. Other
> platforms do not have this constraint.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>



>  
> @@ -69,9 +81,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  clocks:
> -    maxItems: 1

Properties should be defined in top-level properties. Don't remove them
from here.

Best regards,
Krzysztof

