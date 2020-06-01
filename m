Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319D91EAF7F
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 21:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFATS3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 15:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgFATS2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jun 2020 15:18:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43931C061A0E
        for <linux-spi@vger.kernel.org>; Mon,  1 Jun 2020 12:18:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so9591009ljn.2
        for <linux-spi@vger.kernel.org>; Mon, 01 Jun 2020 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/B/vJSdZ4H+DclQbmiiPRhS99BSxRaLniCcxhXNQdaA=;
        b=iwHH84UOoC537MGk6E7us+S+9Zdopz5u3Mz9r49FApyoOZsxNbMpSYkDpYz+aYUmIa
         gtYJ4Nu2LvDhSS9BFKk/dXVwM+V+xJdfWYttpRfsGqdl+mfJLbnevBNm+6jq/a3qu6CS
         79cIP/nF1F5EzENa3hIe43wwl8d/B/SzpYMrgV+aDEoXxYeViLETePnqL6+klDaawcpX
         9Q+NOyq2LouzXifA0UFaf9jIAdeXnxvtv9zoddLb2ACAVvgArDVoDnSfzqzGD6APHcu8
         RWbhRoiDb2muv9dDnZFBL/MccbVhteizvEX7iahC7D4K1DHIFyVP4Ro83iNhRQPi/oNz
         WSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/B/vJSdZ4H+DclQbmiiPRhS99BSxRaLniCcxhXNQdaA=;
        b=BNPbkCyb3tYJ8RsB7iFjkuQ5fep+3wxG//+dwXkywXXfIg67ZvnyoJS+xqFMdpiKBA
         hwqftXI5A+RcemyiY07Akw73DW5UIrPXWOJhcdFCQCSUs7MZpPEQ4bShyc2cIbGKzK/v
         sMGJ40k7H0C3Ezy2BUccRL7UeYM6IDUyARSnoLan79fQqzeMG6bJwszxG/Znmy2LwMz2
         dUBLfRz4TmV7NsT1n5GeYnwHmPVa5o3NFD8tSKhYkp/+unmDRE5KvMKjS1OF+92M+Jcn
         hqAhT58u+4Gq8+oWg14FjQt/rwc6VE4zfvMSCp6E/ium6kqEungSbDSqxtzGIrREmaUv
         T3uw==
X-Gm-Message-State: AOAM5305TksiifEEHOVTxPLCUmJJiE6WocAjm6LaVeF0HuMPCbE65F8R
        lQDVCKCWaLxna6lFUmFI/qHMrA==
X-Google-Smtp-Source: ABdhPJy3cN4yLGJe+/Z+8B7cDMmCco1eIsfE3RnyFphuEUNzt9DcbvqKy/QmOpfmfS39sSO6wln/8A==
X-Received: by 2002:a2e:970c:: with SMTP id r12mr11288156lji.145.1591039106548;
        Mon, 01 Jun 2020 12:18:26 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:42cb:40f3:c0fd:7859:f21:5d63])
        by smtp.gmail.com with ESMTPSA id f12sm118393lfp.8.2020.06.01.12.18.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 12:18:25 -0700 (PDT)
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
Organization: Cogent Embedded
Message-ID: <85e1ebd0-4b27-5382-c591-59d63d5b73de@cogentembedded.com>
Date:   Mon, 1 Jun 2020 22:18:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200501212547.GB15294@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/02/2020 12:25 AM, Rob Herring wrote:

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
[...]
>> Index: linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
>> ===================================================================
>> --- /dev/null
>> +++ linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
>> @@ -0,0 +1,88 @@
[...]
>> +patternProperties:
>> +  "^.*@[0-9a-f]+$":
> 
> ^flash@... if you're that restrictive.
> 
>> +    type: object
>> +    properties:
>> +      compatible:
>> +        oneOf:
>> +          - const: cfi-flash
>> +          - const: jedec,spi-nor
> 
> enum is better than oneOf+const.

        - enum:
          - cfi-flash
          - jedec,spi-nor

causes the build error you encountered while trying to merge the last time.
What was I doing wrong?

[...]

MBR, Sergei
