Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07FF50D0B7
	for <lists+linux-spi@lfdr.de>; Sun, 24 Apr 2022 11:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiDXJJ1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 Apr 2022 05:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiDXJJ0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 Apr 2022 05:09:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46985A158;
        Sun, 24 Apr 2022 02:06:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q7so9188571wrm.5;
        Sun, 24 Apr 2022 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Nv7r/xRUGHwguyXkYCmqmqghuT1NE5yzHjE3f6i/LMg=;
        b=ZVhDU9S5WmmPTCXR4kxee+/C3o4Z3ZwdtmINHqCOjN+3oKVVPMCuZGuFk+LzvEF6Mb
         WdXVQYeIQH4wNaouNJTONrKiDQ31XBKBvlRiWEtVX+4SCKNzZSXsn7Z1JMud0muXJrC6
         DFHYyqv3NX4XqcLRsAw1tfby6rMGuqvrWQX0/o6cNZmp23bl2S6X+TQMxAMLTB/0TYcS
         ZR1VZL2r8QzHu7fu3RI4d3oGBROHoKNzf9wIgtOGr4CT42lV4G2xKjguVNq08jccw5be
         0jHP8TrdDWe1K1gPWw5C+kIR/eXZUJVm6xa/AWGFhzaXt3prmlLjFwJBUX4oovDCSl2M
         ddMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nv7r/xRUGHwguyXkYCmqmqghuT1NE5yzHjE3f6i/LMg=;
        b=UIXX//Yn2GImPbL30sr6n8sbJ6j6T2G9atn4BpMWaii1FcdoTDOtZECKCtUQgCxG92
         m1+mf6ue5YKBzZqH3p2+eXQVOrnuEQ0IxN8ZHmjVRSo3waBgE2MHTwt44AmydhpeKn+1
         c21ewkfO+EnClpT9jjf2ZMHHnp2ks03tSWamaLSXroNpcQK3s3LqwKTD8XBLs87P7mep
         7fmJP3U1+XSrLzygYrHBgvZzHhFIoSmv3zKIh1wgREshZpk9ZijOYhHVdveK8F+KgAp8
         awZg9+e7cB4PzTIzB5z7IpmorV1qv9qm2dKSRDHXvA3XGVrcByHmpvKnAp+IwCpjLar7
         FWvg==
X-Gm-Message-State: AOAM532eLm7niDCECHMAbaJmKLb4jLL+vDW9iuhpd5phCXKf/UVDnGa0
        ImoWbZWb4D0HVCy5c0KDblY=
X-Google-Smtp-Source: ABdhPJy21ZMmMPYkeKcJPoKjZ9cyNADB0FQ2uMsA6brqM3EG5dDW2OkgMgQYVf6yQYf7HRrgwizR9w==
X-Received: by 2002:adf:f943:0:b0:203:e832:129 with SMTP id q3-20020adff943000000b00203e8320129mr10044687wrr.626.1650791185142;
        Sun, 24 Apr 2022 02:06:25 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7675:9d00:50f9:6d67:ac70:5180? (dynamic-2a01-0c22-7675-9d00-50f9-6d67-ac70-5180.c22.pool.telefonica.de. [2a01:c22:7675:9d00:50f9:6d67:ac70:5180])
        by smtp.googlemail.com with ESMTPSA id f4-20020a7bc8c4000000b0038ebbe10c5esm8581477wml.25.2022.04.24.02.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 02:06:24 -0700 (PDT)
Message-ID: <aa97c09e-aa82-e2c4-326e-991330e65de7@gmail.com>
Date:   Sun, 24 Apr 2022 11:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
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
 <CANiq72m+OVcX1gPit94D1hjzkduyVFoCWXKSXTxpUDFtKs8z6g@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CANiq72m+OVcX1gPit94D1hjzkduyVFoCWXKSXTxpUDFtKs8z6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 23.04.2022 22:57, Miguel Ojeda wrote:
> On Fri, Feb 25, 2022 at 10:09 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> This series adds support for the Titanmec TM1628 7 segment display
>> controller. It's based on previous RFC work from Andreas Färber.
> 
> AFAIU the discussion has converged at this point, correct? Is there
> any feedback left to address?
> 
Still open is to define DT bindings that can support also the key input
feature of the chip. Robin picked up this topic and has some ideas.

> Cheers,
> Miguel

Heiner
