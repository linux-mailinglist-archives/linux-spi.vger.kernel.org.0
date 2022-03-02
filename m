Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93204CA2AD
	for <lists+linux-spi@lfdr.de>; Wed,  2 Mar 2022 12:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbiCBLCT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Mar 2022 06:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241170AbiCBLCR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Mar 2022 06:02:17 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F9B6F48B
        for <linux-spi@vger.kernel.org>; Wed,  2 Mar 2022 03:01:34 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A05A93F602
        for <linux-spi@vger.kernel.org>; Wed,  2 Mar 2022 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646218892;
        bh=Si9sQ7yLz6JK6Nen6lACTBVX2ecHMiwS0ByLXYRxjJA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pLSvMdDulJ05pxvaVpoKjZv/j7P9qWQA3vDXV3M0gXO2ZWu/B8wnzxIXfWR7GhUCK
         uNEeUkggCFsxOtUbDiYQrTnCg0tL9MA34v5qn2otWZ/DTTmc+hz+Ym7Gnz7LOB9Vk4
         IVHFfGKidhRX/RlpDbeH5cSkrUXQldipZcuQa9wI2yfA4ryyn0FqALa8seUPQbfjCA
         ThMiQyDCmLN+o5WYVPDX4wWUYFkNYbsgad8GZX8QSuKe4aJjbGhkk12hyK2p3mKEG0
         kb9DBje4AQueKp0Usjxbo1Jv1V4cin4KuVTg+Ey4mbY/3+8X3/oW9eQ7cTyGJzg9lI
         auHCONcUh9i8g==
Received: by mail-wr1-f72.google.com with SMTP id x15-20020a5d6b4f000000b001ee6c0aa287so498389wrw.9
        for <linux-spi@vger.kernel.org>; Wed, 02 Mar 2022 03:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Si9sQ7yLz6JK6Nen6lACTBVX2ecHMiwS0ByLXYRxjJA=;
        b=DLXRZDwHBzt4QLEIgxbip6+NT+u2fLSlZVmi75KQdB/bh5g6YyIF5R/Y6lb4/vDuuK
         RXOeLOlfNVm40wKSJiFyIGgiy++ZZ6cyWQdiB+Gq2hvoI/5jxq/+BiFObzo+zYFOoH2e
         rYEZBJH8Ss1w0tzU6n3WDzQNkbSy/6h4DRIHyN+OEX1z8Axct75Cff06UTIxizygfmzc
         BdInX2QTHiumc+/aj7YSHBnljxOaNeRt/Gfah8i3hjTFHlRQ+uNmJYh24zIX7IMBU9cS
         sRCrmNQN56kR+CqmfIeAqVycsbENV58r7HV3tAB2ybcSOYKObhRvduL0zMH7qTsoo+fK
         ZWtg==
X-Gm-Message-State: AOAM531gY6wHaBEEL0yyTbaMKzWK7H7IyqCMdtIeoYjwujEyGo2Jwzsz
        hPhVoP7/OA17DpKgow+Cn7djQX1jMrMvMH4NapLl83fnVTtgF2KdXpIIx6G6QA4p1g3DETRXPdI
        JCt0zFoMAu8kZ1D0WFPGsdtERGXSGVybYsr9vdA==
X-Received: by 2002:a05:6402:369a:b0:413:81b5:7b64 with SMTP id ej26-20020a056402369a00b0041381b57b64mr22935816edb.163.1646218881949;
        Wed, 02 Mar 2022 03:01:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaXIpVKlG8abGyix74I9rTqmFoJz7zygw3QnLROE8hwqkRWj9/wBCxZT5ACGsypW51MBpi7Q==
X-Received: by 2002:a05:6402:369a:b0:413:81b5:7b64 with SMTP id ej26-20020a056402369a00b0041381b57b64mr22935729edb.163.1646218881424;
        Wed, 02 Mar 2022 03:01:21 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id et3-20020a170907294300b006d6534ef273sm5617821ejc.156.2022.03.02.03.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 03:01:20 -0800 (PST)
Message-ID: <22099da9-fad0-a5fb-f45a-484635ca485f@canonical.com>
Date:   Wed, 2 Mar 2022 12:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 06/11] s390: cio: Use driver_set_override() instead of
 open-coding
Content-Language: en-US
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135214.145599-7-krzysztof.kozlowski@canonical.com>
 <b2295eba-722a-67e2-baae-20dac9d72625@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <b2295eba-722a-67e2-baae-20dac9d72625@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/03/2022 17:01, Vineeth Vijayan wrote:
> 
> On 2/27/22 14:52, Krzysztof Kozlowski wrote:
>> Use a helper for seting driver_override to reduce amount of duplicated
>> code. Make the driver_override field const char, because it is not
>> modified by the core and it matches other subsystems.
> s/seting/setting/
> 
> Also could you please change the title to start with "s390/cio:"
> instead of "s390 : cio"
> 

Sure, thanks for review!


Best regards,
Krzysztof
