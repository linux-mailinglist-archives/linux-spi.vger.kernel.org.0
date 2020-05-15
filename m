Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922661D5A9D
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 22:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgEOUQy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 16:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgEOUQy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 16:16:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2F2C061A0C
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2020 13:16:53 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g4so3596510ljl.2
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2020 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43o0FGN5Fq1n1m6Sdyu6XN/2q9oPen95HONzGtG8NaI=;
        b=rasFNY6KlPGGakeCYqdBKvuVpmFObIfbsTH8PsjJcVvMBa5zhm9K6BTFVJAtb7awk+
         3yqX0uRkv+T5zsLqojPUDnycXDh5+NvsVRpHqVoJeRIA6t+6atb1t2vCeFzX7cY7ifny
         du2XgSm2pOqgHhxIJP4+L0TYBoppN2GZl5fj+foJRbx4ykI/5TY6HRrwh2Dapx19hHbK
         6SQdy9bl7cbOxhwtWYvDI+YlVQO3+S+9HunxTJULpJ726fcG1indWvBCE/g+C0dNbxsU
         QMBwmrB7yMIBlIzQ7GjE84PsuhgAwwDUsn1iG4rbhTLp6qDe7CzSoyUaU9nLpP2YaROi
         QJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=43o0FGN5Fq1n1m6Sdyu6XN/2q9oPen95HONzGtG8NaI=;
        b=ShdC8In0AsBWrbH3KP7qOZMNDgLZKZx06CY8b5MtvejsvwGKQ/ysNTT3iDoXMUpUHt
         l3Sd5x7/J4NJjGHCWu0k4TGROhUOOaxFJgZzwlN+dTsevkmhotcCRqUZNvCvfAgbjQxh
         kMB3MIylkn8ebnfY6i8+c+UuCPeZRuwWUgJKQb6NSbJB7KNYPlcKSn/2jP3beZYvsTnr
         d1ZhVZ22ilYZRkj4v+OSBw2VasRvWhsLmIFDYy1U8Cxmfz6q7SRaVkRrGp2Pofl8D+Pk
         7bRzS+UiNyugdjfpDaGXhBXRIwooIvVrNavO73xEGBZAIGvet7384V9xsUa2D2sNAfwh
         9ilw==
X-Gm-Message-State: AOAM530zZE6IcxVKvvSTp3/yxBrcVFhsrfHeU7135QYRiSbX7KIVjiH0
        l07hbwhrFObXOeThNA8zfmo8XA==
X-Google-Smtp-Source: ABdhPJzJ0CcrmFTRJgrtQI0QnbyoaIej/mpNW+aorlA8gD+MJtby/F88yLom1QmTf+JS/p+fTH8xog==
X-Received: by 2002:a2e:8807:: with SMTP id x7mr3331329ljh.173.1589573812303;
        Fri, 15 May 2020 13:16:52 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:42eb:aebe:5652:2324:c9fa:fb8])
        by smtp.gmail.com with ESMTPSA id o18sm1623971ljc.73.2020.05.15.13.16.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 13:16:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: document Renesas RPC-IF
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org
References: <812e6e58-d13f-3f44-5f55-22266b690c57@cogentembedded.com>
 <116683d1-d402-4d7f-3357-1c8cde807076@cogentembedded.com>
 <20200501211945.GA15294@bogus>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <52ffabcd-048f-9ba8-a65f-4a22e60866bb@cogentembedded.com>
Date:   Fri, 15 May 2020 23:16:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200501211945.GA15294@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/02/2020 12:19 AM, Rob Herring wrote:

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
>>  Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml |   88 ++++++++++
>>  1 file changed, 88 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml:  while scanning a simple key
>   in "<unicode string>", line 29, column 9
> could not find expected ':'
>   in "<unicode string>", line 30, column 1
> Documentation/devicetree/bindings/Makefile:11: recipe for target 'Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml: ignoring, error parsing file
> warning: no schema found in file: Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml: ignoring, error parsing file
> warning: no schema found in file: Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> Makefile:1300: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1280942
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.

   As I've said on IRC, I have troubles installing from dt-schema.git:

[headless@wasted renesas-devel]$ pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade 
Collecting git+https://github.com/devicetree-org/dt-schema.git@master
  Cloning https://github.com/devicetree-org/dt-schema.git (to master) to /tmp/pip-4f91j8zd-build
Collecting ruamel.yaml>0.15.69 (from dtschema==2020.6.dev4+g6a941d4)
  Using cached https://files.pythonhosted.org/packages/a6/92/59af3e38227b9cc14520bf1e59516d99ceca53e3b8448094248171e9432b/ruamel.yaml-0.16.10-py2.py3-none-any.whl
Collecting jsonschema>=3.0.1 (from dtschema==2020.6.dev4+g6a941d4)
  Using cached https://files.pythonhosted.org/packages/c5/8f/51e89ce52a085483359217bc72cdbf6e75ee595d5b1d4b5ade40c7e018b8/jsonschema-3.2.0-py2.py3-none-any.whl
Collecting rfc3987 (from dtschema==2020.6.dev4+g6a941d4)
  Using cached https://files.pythonhosted.org/packages/65/d4/f7407c3d15d5ac779c3dd34fbbc6ea2090f77bd7dd12f207ccf881551208/rfc3987-1.3.8-py2.py3-none-any.whl
Collecting ruamel.yaml.clib>=0.1.2 (from ruamel.yaml>0.15.69->dtschema==2020.6.dev4+g6a941d4)
  Using cached https://files.pythonhosted.org/packages/92/28/612085de3fae9f82d62d80255d9f4cf05b1b341db1e180adcf28c1bf748d/ruamel.yaml.clib-0.2.0.tar.gz
No files/directories in /tmp/pip-build-fwtgubpx/ruamel.yaml.clib/pip-egg-info (from PKG-INFO)
You are using pip version 8.0.2, however version 20.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.

MBR, Sergei
