Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A97F4E222E
	for <lists+linux-spi@lfdr.de>; Mon, 21 Mar 2022 09:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345240AbiCUIaT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Mar 2022 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbiCUIaS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Mar 2022 04:30:18 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3CF1BE80;
        Mon, 21 Mar 2022 01:28:51 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id dr20so27923662ejc.6;
        Mon, 21 Mar 2022 01:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HcEnlmQ/c9nTewqIhQqcZV4bu3Z7rpqXOTeyXi1ZiTE=;
        b=02VwklxeLGQ6T/MQ/Ygz7G603focViv6JYrM3bhh4sijgcrkESzucGBQRMctRPcdMx
         0rmrOTcKp2h4spb2x1u774cGEr5891uj4Yzc1WKBf/WUraN7Yh8nmehFPWtt8ANa0ycg
         mnCpPYEqOuqYidHHg9PqT4WE/9hAjJaRVDCajFwS10vOjyj5mwMk9NVYY9DOB9/RAtQl
         swXND1dwX8uu15ZyJX+eMnmEeFkSU05zrLCztJjTvW1HjHdzG0lzJRRWpHC5lN2LHr6k
         Mk9x8wT365jBZr02W6pwmlCx3gnemVZ87+TS2eK0NMdZ7ah+UNL0V+jysjcGBwLUhPcP
         Fp9Q==
X-Gm-Message-State: AOAM530zOlrqBWkn8/1jMLdVPZxI3UaVqt0YJEwrP54m9S4oMDUeUO4l
        CJ4kK6JE4SIPtZCqpCeTGvA=
X-Google-Smtp-Source: ABdhPJz1bc2yRucsjFlFqG+ZLQE2pqxqxKBCGdgZURhOXqOXx8d8uTZ5oEOh0scuZ5Wi50lwshifxg==
X-Received: by 2002:a17:907:7244:b0:6df:fb38:1d02 with SMTP id ds4-20020a170907724400b006dffb381d02mr5224559ejc.453.1647851330001;
        Mon, 21 Mar 2022 01:28:50 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id c12-20020a05640227cc00b004192114e521sm2852274ede.60.2022.03.21.01.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:28:49 -0700 (PDT)
Message-ID: <a4836cd6-1b92-8ee6-78aa-a85415e2c1b9@kernel.org>
Date:   Mon, 21 Mar 2022 09:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
 <2671e6e3-8f18-8b70-244b-9e1415bfdf8f@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <2671e6e3-8f18-8b70-244b-9e1415bfdf8f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 25/02/2022 22:13, Heiner Kallweit wrote:
> Add a YAML schema binding for TM1628 auxdisplay
> (7/11-segment LED) controller.
> 
> This patch is partially based on previous work from
> Andreas Färber <afaerber@suse.de>.
> 

(...)

> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led-controller@0 {
> +            compatible = "titanmec,tm1628";
> +            reg = <0>;
> +            spi-3-wire;
> +            spi-lsb-first;
> +            spi-max-frequency = <500000>;
> +            titanmec,grid = /bits/ 8 <4 3 2 1>;
> +            titanmec,segment-mapping = /bits/ 8 <4 5 6 1 2 3 7>;
> +            #address-cells = <2>;
> +            #size-cells = <0>;
> +
> +            alarm@5,4 {

A nit: generic node name, so "led".


Best regards,
Krzysztof
