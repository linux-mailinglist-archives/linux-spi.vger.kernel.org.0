Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72F21DB73A
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgETOi1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgETOi1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 May 2020 10:38:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E2AC061A0F
        for <linux-spi@vger.kernel.org>; Wed, 20 May 2020 07:38:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h188so2455533lfd.7
        for <linux-spi@vger.kernel.org>; Wed, 20 May 2020 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=znHUMaP0WqalUm3z5ilzUoUiYdwHWCOzV+xNGyMse2E=;
        b=ZsaZMuyUG/c63T71KQnutZMRMecTwOQ9e+xZo1mwtMXh/HnEKFNpg6iTh0kD/x2p5P
         R+bkxFYJyI7Rb+p865Qe8h6ykpOUJMNvSyu0U3V/pLTMtebveBAZzBJLA2YlswiT/HiW
         3JEGWZi825qVMDTxy3uqUD51ogVTMWXV4IvuxYVsspGIrM68xA5o+KYz3ArvMqW0Ejp+
         Q+fj6ENz3L28xOqXgMxs5JyrVfE4PGh2nI/xLwkHNxbruBYJxETKiI00SYx4eAZZL5CG
         pwLHe19EutHqmeSHTOSnis/KoZgVnrqJ7j07FAeJdcUIsXQEcjZbolyR1Bkbb0uQhsn9
         RMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=znHUMaP0WqalUm3z5ilzUoUiYdwHWCOzV+xNGyMse2E=;
        b=TQWfZ1O+rK791vpszvFybnjZL0Pc2XuppIgoJSSqMAGw5E910toODX1Ixv25KjQThA
         wSPv6e6JyMVNVPjEg+15/Icr6YKdnC+WGTQscaIzFiy12oPN/grLkpvgACbNRTKRZOBm
         gxOd9bwzfMaX0hY5V7IErVJFAXPxdfXKrw0nsCdNIUUD4jclG5jb1L8GGIfDX7rfKY8o
         FxmRa0humOnQt2Yogzw5S5wr4r4TfjD1gcnBc0WJHVrS51k+5lXFJi5d5FexxiSK26rR
         d9Bu3dAAd4k+2vlF9t5utqA1RbUFzrD3kQ/YRD4zjpDdYVNctNb9aLc9h+eY6nrWuk6m
         3ctQ==
X-Gm-Message-State: AOAM5307LVVhIBJYLRORKgLXoICoA5BGuFfevC73yZM/VkPKTUl8Vku3
        JV3nyT3K5YYyPzUoUi+MvQufGQ==
X-Google-Smtp-Source: ABdhPJycRSmEi00KXgljA417fS6M4KKf8K3xhBn/6ZZOQ6UlRRZvGO2YKvURO4P1Mi9nL2IPvfdrUg==
X-Received: by 2002:ac2:414c:: with SMTP id c12mr2685185lfi.47.1589985505282;
        Wed, 20 May 2020 07:38:25 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4e2:ae96:6d06:66d1:d6f1:88dc? ([2a00:1fa0:4e2:ae96:6d06:66d1:d6f1:88dc])
        by smtp.gmail.com with ESMTPSA id s8sm1116394lfc.83.2020.05.20.07.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 07:38:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: document Renesas RPC-IF
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org
References: <812e6e58-d13f-3f44-5f55-22266b690c57@cogentembedded.com>
 <116683d1-d402-4d7f-3357-1c8cde807076@cogentembedded.com>
 <20200501212547.GB15294@bogus>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5359d5a2-5d28-058e-ce37-bc91e1aa7988@cogentembedded.com>
Date:   Wed, 20 May 2020 17:38:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200501212547.GB15294@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02.05.2020 0:25, Rob Herring wrote:

>> Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI flash or
>> HyperFlash connected to the SoC to be accessed via the external address
>> space read mode or the manual mode.
>>
>> Document the device tree bindings for the Renesas RPC-IF found in the R-Car
>> gen3 SoCs.
>>
>> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> Changes in version 2:
>> - rewrote the bindings in YAML.
>>
>>   Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml |   88 ++++++++++
> 
> Not where we normally put SPI flash controllers...

    RPC-IF is not exactly SPI flash controller, it's bimodal.

MBR, Sergei
