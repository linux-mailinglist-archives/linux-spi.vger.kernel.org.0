Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93B81FB13B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgFPMzk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPMzj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 08:55:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E4C061A03
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 05:55:38 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i8so5204110lfo.4
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Datn+viOleu9MknfYNeqDNbA+m3HBOER2JlnejiUEQ=;
        b=dy+cayGqqxh0JvhYSwla0nivVwNGzQlvP4QJr2fRWIaeHuFWOimZaJjWAi0JvTL/Ek
         Rm3+82casS4aV4yflm+8SL2tfAvpeX+fAC71M4juLly4c6yjVsWQ35eIg8kzM+MADxVo
         PYVvDSPqxE1650YwPrzAiRlcIuLtT08N8j/TxpmIH6QSxXxb10es3Dbn7qAeE3eCos+B
         EyueOw9r1S4pnCsc6p7ooMPKlwe7Yk85mWa96g3DuGlxRo3b9UD/CapFtr1uB0cR3JTH
         c7YzfHiYIT2zIwLKAaYWfZGwzMfPz1oz1y0Jbg4pLzqjRssIg2RoAvNA3t5XjI5A85B+
         qwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Datn+viOleu9MknfYNeqDNbA+m3HBOER2JlnejiUEQ=;
        b=RNPMTH4qKtL03flONNU2b6YGbeAvmOcgtmb8qTc4BdYx76BoomX6M3AhksieU4NLkE
         lxrUV5cyNIuZ8qr+3ArCmIKGxxBePGZKFJ9OQBi2dDmpqgXCfPd7i8QAw19QZhLZ35ux
         qdwNv2h1cAyRDyAfxhpIjjNyZJO6cHUYm1cwtCs14ijK/toHIKL/2/LoTX/NjB3BADsF
         aEa3C4hlQ6gI5ghZaP0FRHsH3fpaARhs6lJELGY6poez6YdCUd1LH3EAhenAPalNH97H
         V8mKElj9WhdYqFWh9rWzqaPLei8djDnY7LQg1diAZdP+ElHrt0bnCqUQpblt8n0/FQVh
         SuBA==
X-Gm-Message-State: AOAM5337X0DsqtWvIiOyMxOzjq1pzAtSenbIw1kTHi1nW+TgN94XXb/O
        Fvxv/4ftDrUCfCLeKRr4OFX7xA==
X-Google-Smtp-Source: ABdhPJy3aFfEOkHJSu2DE2oUwPUJUWCgIed4AuBzzv1i7K5LJqk4X9vL1C35CnLTBQrGhdrhs1ZGZg==
X-Received: by 2002:a05:6512:60f:: with SMTP id b15mr1659496lfe.159.1592312133923;
        Tue, 16 Jun 2020 05:55:33 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:653:6173:f86a:f3bf:1caa:fd38? ([2a00:1fa0:653:6173:f86a:f3bf:1caa:fd38])
        by smtp.gmail.com with ESMTPSA id l5sm3506234lfp.9.2020.06.16.05.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 05:55:33 -0700 (PDT)
Subject: Re: [PATCH v4] spi: add Renesas RPC-IF driver
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>
 <159226448570.27735.17453498854310254061.b4-ty@kernel.org>
 <6fd4533e-c548-5d14-2d21-96efa0c58a0b@cogentembedded.com>
 <20200616083856.GF4447@sirena.org.uk>
 <6730033e-c966-d465-9273-75137e7ccbcd@cogentembedded.com>
 <20200616093404.GH4447@sirena.org.uk>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <48df1997-31d8-06b4-7fce-a3b9b5cfaac8@cogentembedded.com>
Date:   Tue, 16 Jun 2020 15:55:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616093404.GH4447@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16.06.2020 12:34, Mark Brown wrote:

>>>>      You realize that the SPI driver won't build alone, w/o the
>>>> drivers/memory/ core driver merged, right?
> 
>>> Those aren't merged yet?  There was no mention of any dependencies in
> 
>>     No. I thought we had an agreement about this (core) driver going in thru
>> the SPI tree (because there's no repo for drivers/memory/ anyway). Looking
>> at the DT patchwork:
> 
>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/4becbd3b-c9b9-070a-5771-48cade6651e5@cogentembedded.com/
> 
> Nobody appears to have ever actually sent me these to me so they're not
> getting applied...

    Ah, you need to be explicitly CCed! I seem to be relying on the patchwork 
too much... OK, I'm going for v5 of the core driver/bindings later today (with 
r8a77970 added to compatibles -- I tested it yesterday).

>> the DT bindings still need to be reviewed -- but by whom? The "Checks"
>> section indicates that they did pass the DT checks this time around).
>> Rob?
> 
> There's a backlog on YAML binding reviews, I'm sure Rob will get to it
> in time.

>>> the patch, no feedback for months on the patch and I've not seen any
>>> ongoing discussion.
> 
>>     Everybody seems to be in a silent agreement. :-)
> 
> Or lost track of things given how long this has been going on :(

    Sorry, there was a lat of hardware issues slowing me down. :-(

MBR, Sergei
