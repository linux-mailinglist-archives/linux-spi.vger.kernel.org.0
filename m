Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3EC2596F3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Sep 2020 18:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgIAQI4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Sep 2020 12:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbgIAQIu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Sep 2020 12:08:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB476C061244;
        Tue,  1 Sep 2020 09:08:48 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so743871plk.13;
        Tue, 01 Sep 2020 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XCC1MeRo0BRoasyj+5VGbw00gjoW3R7USmRQ2Ubh6Bk=;
        b=gGijq2cvjjnFqOBtVFVOUecKydlvZdUDmdEShkPQtQDERDF4peXrJgChqPs84f9ckP
         b9dFKbatiQXXJdwfBqjlgmu2mdiy6xjOhtUqfe0G/V909ePxhCpK9gRe5baQbfZehm7W
         zWVz+4iD1vAJFTJh9wRVk6cSj8CpV5DUfj4HOSOZl3tCOZN/4hdQVnjor8LnrINRnw6x
         TVVTz1PQ4v6wLqrpKv66juerPGmzJKRbdWniVq+0xnmFe3KXd9X3SA51YaCvc+0b4PAx
         9XqDu2Bg+nZ/EGO3CsDwVmCW9HcbyX07tAn62Vbkq6VX4JguDhyqh4E8aziGpxBusjyN
         xTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XCC1MeRo0BRoasyj+5VGbw00gjoW3R7USmRQ2Ubh6Bk=;
        b=Df2nzwe+1BRnFVVmM3RVPPKa//CTXqDAKP0FZ1/PK5Go15Y1BcEKwJ7W6FxU1U92CF
         vdKnrjUbFflF1PdWPr2VnnFbpLmvu9xJLkD2omFI3SZr84XODZvH4onuXudKnzivBFGR
         ZycAA2ait93F4wkCCtq4T1WJmCIn606BqLKM0oFmUSY3ZFwx6Q1+2OB/wFCiwHgKNOwU
         i368DMgJw4T1SrhlTvCYr/C7vpbGfoJZ0NEt6LLoxVLsxpt3zmKosHB7wY4ZHG/VoJqN
         7CEA7vIDayzBnPDbOeb+qb42n8RzKLjhy/8Eyn025hdaR1ortkKsfOK4yrkyhpxTF1YP
         UJTw==
X-Gm-Message-State: AOAM530jWnYYQdQ7ueSWXrao4gBVsxVCykcm7ZrQedKN01KgoLNrKXvf
        wPgwqcakCPgS9RMe1K4qP8dheCzVih4=
X-Google-Smtp-Source: ABdhPJzMJlB1p6o9YUqwWsudQKNUJlMRUAuSiBfxFfepp8AQHGZU1/+/y1JGrTe2lZw+V7k8QgJFng==
X-Received: by 2002:a17:90b:4a07:: with SMTP id kk7mr2316459pjb.125.1598976527418;
        Tue, 01 Sep 2020 09:08:47 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id d15sm2497723pfr.143.2020.09.01.09.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 09:08:46 -0700 (PDT)
Subject: Re: [PATCH 04/11] spi: bcm2835: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
References: <20200901152713.18629-1-krzk@kernel.org>
 <20200901152713.18629-4-krzk@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2fefe978-c91c-7c87-e342-32287c674a8f@gmail.com>
Date:   Tue, 1 Sep 2020 09:08:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200901152713.18629-4-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 9/1/2020 8:27 AM, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
