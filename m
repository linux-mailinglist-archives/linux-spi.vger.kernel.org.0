Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B4B3616CF
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 02:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhDPAcj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 20:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhDPAcj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Apr 2021 20:32:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA79CC061574;
        Thu, 15 Apr 2021 17:32:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso13660534pje.0;
        Thu, 15 Apr 2021 17:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=subrh3SzNUvQ+3siFoS1Q3pvTbkNn7WivtC5eavv2hQ=;
        b=oAW+K1DmLTfI8L0SOhGHF8MWeEosuHI1rO1hUjYvTVu/hlz4i3FdVtvB1yPV7/QKWW
         wiMBy2vaTLOhWi2rI4qLXQdhkdp6B3P5Kc3iaNO9gjJrObuPQ/47jI+2Xsg/LPzMCROn
         PH3hpbKE7yUTMGtENhWYoKJuUPquydfYtRpR5FGMcmJurEXITijXCWtp9f+c8DThCZY8
         mb7Kp0dzxssUQmk/PDiw8yyDhGd8rUtvcDJvXxadZ6E6bXTVZT1mvslxL3F2VvmK8TQV
         2pXWpb0Pp4O73IaRBxMxBS+/RcWuYdfd/iGIHC47JC1SvxpmPJvcBPzVpnG4a4zkSgT3
         mCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=subrh3SzNUvQ+3siFoS1Q3pvTbkNn7WivtC5eavv2hQ=;
        b=PIKpuBaf3g/5DuacSDCXLf/M8g+AWEstkk9wMQ8OhhbmatMzCwXdMzkdiSXwTcfHxQ
         TgC6xCoasoyXO4GddeFZdOLT/L3F93AlU9LNwuL95Jz9JmllUx0i/chIMElk2AKbRKEy
         3AdubC+EUyF1asSZAiaWOBySSoZ3+2gPEyVzh2V0DIEUy8pB9iKERDUAIsTzczk9sJjI
         ENyR90QFAI3VjJ/kN7hh6jsiUh+68VVblmu2vH2BslI9s/RF7v19oN+ZCygBcOqI708E
         41zJAsmWgKgXzyZcKbXt+mDEyF5GL8AGF6gbhzRluwme46qnmpO30zBMeyOdWlPDbAV3
         ikDg==
X-Gm-Message-State: AOAM531c6YnfEzglkkK+Vc4mv28vHwwYBKgJ2ZAbBd5a1RCGK3nQzLPA
        YjzspDDleS6diOUsN81jrf/FI/BUImQ=
X-Google-Smtp-Source: ABdhPJwuqyHdJ6T5Cge4DOc6PZvogJe5hRtK78m/356bhDDUurMfaCO1Qjw0GTIgmL4KbFbB8EMebA==
X-Received: by 2002:a17:90b:3b81:: with SMTP id pc1mr6590644pjb.40.1618533135399;
        Thu, 15 Apr 2021 17:32:15 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3082412pfo.79.2021.04.15.17.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 17:32:14 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the
 json-schema
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20210415220201.16429-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6e5a2693-fc19-efce-5aaa-4712b0dcb802@gmail.com>
Date:   Thu, 15 Apr 2021 17:32:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415220201.16429-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 4/15/2021 3:02 PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Changes that require mentioning:
> 1. reg-names
>    "mspi_regs" and "bspi_regs" were renamed to "mspi" and "bspi" as that
>    is what's used in DTS files and in Linux driver
> 2. interrupt-names
>    Names were reordered. "mspi_done" has to go first as it's always
>    required.
> 3. spi-rx-bus-width
>    Property description was dropped as it's part of the
>    spi-controller.yaml
> 4. Examples:
>    * flash0@0 was a duplicated node and got dropped
>    * regs and interrupts were formatted and reordered to match yaml
>    * <0x1c> was replaced with <&gic>
> 
> This rewritten binding validates cleanly using the  "dt_binding_check".
> Some Linux stored DTS files will require reordering regs and interrupts
> to make dtbs_check happy.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Thanks a lot for doing that, do you mind adding Kamal as a maintainer
for that binding if you have to send a v2?
--
Florian
