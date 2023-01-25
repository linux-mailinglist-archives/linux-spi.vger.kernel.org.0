Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0067AAEE
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jan 2023 08:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjAYHbs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Jan 2023 02:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjAYHbr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Jan 2023 02:31:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5011E2A4
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 23:31:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t18so3272510wro.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 23:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1Heg0qkvtVQKYMAQh92dkHLnZ6nkSndgk7XA0KOw2Y=;
        b=izLLoNlPy1AYqSm655DVnMSX9cVyFfh5NZR5blD4Kt41CPkFiCHe8lekltUmfzSSTU
         Lxe5lIWihCIRPdp74I5YkpzDOpjYqhFSXyTQ5Tymj2pADsuakSMVSl921R6wB6lTuFQ+
         xwGfklho5fH6mdPMS4K9F6BGrygaNfXz7H61Eowb7VkArXENliL1y96Lwg/2mkf5yM8T
         KpLVchFdZNhpvVovR+HWD90g28/fTsv2O8/jLqNkqTEw+3yNZSW+HiLx3KiCad7rB0jb
         pMSec8JFvqEcewLYEWvz4m1DteDHVU6gT/MZQcXMYM1Yg1B4pOkm43PLVRRlCIsjXl7f
         ZnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1Heg0qkvtVQKYMAQh92dkHLnZ6nkSndgk7XA0KOw2Y=;
        b=EpPefLkZOPMp41aFzVlFoaJyPYfJfoRbRc1NBz2LCaG9afEAseOTm1QEBHDIG4p2fa
         3HqcqysZbcV/yUkrmQ5oEIOAcc88cqjLs7Ir0mqMjjtQXctocaGJb5vdJLbUu1NXyci2
         CiR973GZypcQiweVSDTXZqArZpTbdgjzIeyrs64Syfu4JCirLqGbo+35g0z6UP5fpB0c
         lXmNf7o11euYfHH/w1TD9RNux7UnlRRt344mTCt/sbj/SwQvMHO05A5BUwrtZAvfvTYK
         rt5Xl3yRkkbqQ5kKoT54fpVy74hCMPj+JQQw+5RCn4wM2712sWVOwESb/szbTcrdRzEV
         QIBA==
X-Gm-Message-State: AFqh2koYuLPyAJWnWkppi4vlknGxozUt29y+zkLtvgbkSx2sJ8wBlts9
        vKMNcTvTWCawtS9zLb1Nd0MPSw==
X-Google-Smtp-Source: AMrXdXs7IvJxYrqaViVH7PHdEijBL/2Ap8J0gqK3IfGK/PYgnMGs2mssIOxJHv8mJlvw7W3rROp09g==
X-Received: by 2002:a5d:6a51:0:b0:2bb:e7ac:af73 with SMTP id t17-20020a5d6a51000000b002bbe7acaf73mr27554884wrw.42.1674631904675;
        Tue, 24 Jan 2023 23:31:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z18-20020a056000111200b002366dd0e030sm3593460wrw.68.2023.01.24.23.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:31:44 -0800 (PST)
Message-ID: <6245a63c-8d9b-1bb0-fe8f-43516a17f3a3@linaro.org>
Date:   Wed, 25 Jan 2023 08:31:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 01/14] dt-bindings: spi: Convert bcm63xx-hsspi bindings
 to json-schema
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124221218.341511-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24/01/2023 23:12, William Zhang wrote:
> This is the preparation for updates on the bcm63xx hsspi driver. Convert
> the text based bindings to json-schema per new dts requirement.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

