Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7B258131
	for <lists+linux-spi@lfdr.de>; Mon, 31 Aug 2020 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgHaSh3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Aug 2020 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgHaSh0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Aug 2020 14:37:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC6C061575
        for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2020 11:37:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 31so1090090pgy.13
        for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2020 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SveiT/5kj8J/XpkQbrlj1c/DpZ1YRM/MbxFxZwhMGhA=;
        b=DcOqbErvi8FYyI7mmMYwJcPUkX8ek3DMRXZ+XzKVPNnbw9aFKDy6yZxSCgVTc1Q2RN
         JCYWngxEWp27yYY3GDVMwgbdbBhy+IsBo8oaBLBFXOnhctYy/7l80IOFQTmgDwjzZpxk
         P52lPmLJl58ID+urry8EsuKNaIok/Ka9fAGnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SveiT/5kj8J/XpkQbrlj1c/DpZ1YRM/MbxFxZwhMGhA=;
        b=iWdF6oTxtlOOts5p8doYX/IDlShjsdT2Opsz/ur3kDaGbNz60kOtu+bCNDYjRnopSU
         lb+iLKBcWwfUKSITOweSoKfF183CXRXBY/5SyY4V/zXVcL7sbgYiRQkUv0rbzcLAa7Nm
         SMUUI1018yzLhgbc0cB2yfa6U3/jwA3PZdDRmGCHZOE5QPKKiSMOWsRNQi3uZJsXw/FX
         ez3+6giz3I6+V1pKtIXGY0da02pDxiUJSIJUOkpdQsoi7aF1vzG7zADvTSi70Bj3iszi
         0JNQOshGNv7bSDOt5J/i50eXPLimD++epGKTUiCAev5eg8UBVuPBTRbXaxfEQC0Vz+rI
         h6jA==
X-Gm-Message-State: AOAM531DUnD6I2BOoKH1yN0DHm5neHJVD9/q0oYsDMl383wINjbd0xuR
        KCoG0xKUbJQcJUO9bCAyU8Y4kbl03WLvvw==
X-Google-Smtp-Source: ABdhPJwiHXMI3GRZtXeIFfp4uk2QHY5P8pnjJS+ma3vUvGUCC0E7YRgZIy4k5yALgMRKaj1QxXEChQ==
X-Received: by 2002:a65:4208:: with SMTP id c8mr2220936pgq.266.1598899044897;
        Mon, 31 Aug 2020 11:37:24 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u14sm8380290pfm.103.2020.08.31.11.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:37:24 -0700 (PDT)
Subject: Re: [PATCH 0/5] qspi binding and DTS fixes
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        "maintainer:BROADCOM SPI DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200827181842.1000451-1-f.fainelli@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <9c5a7728-a8fa-a6a8-b9fb-c66afebc78f1@broadcom.com>
Date:   Mon, 31 Aug 2020 11:37:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200827181842.1000451-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 8/27/2020 11:18 AM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series fixes incorrectly defined compatible strings for the
> Broadcom QSPI controller which resulted in the strings not being
> ordered from most to least compatible.
> 
> We will need to apply some changes to the spi-bcm-qspi.c driver in
> the future to assume no revision register exist, and these patches
> are a preliminary step towards that goal.

Rob, can I get your tag for this patch series so it can be sent out? Thanks!

> 
> Florian Fainelli (5):
>    dt-bindings: spi: Fix spi-bcm-qspi compatible ordering
>    ARM: dts: bcm: HR2: Fixed QSPI compatible string
>    ARM: dts: NSP: Fixed QSPI compatible string
>    ARM: dts: BCM5301X: Fixed QSPI compatible string
>    arm64: dts: ns2: Fixed QSPI compatible string
> 
>   .../bindings/spi/brcm,spi-bcm-qspi.txt           | 16 ++++++++--------
>   arch/arm/boot/dts/bcm-hr2.dtsi                   |  2 +-
>   arch/arm/boot/dts/bcm-nsp.dtsi                   |  2 +-
>   arch/arm/boot/dts/bcm5301x.dtsi                  |  2 +-
>   arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi |  2 +-
>   5 files changed, 12 insertions(+), 12 deletions(-)
> 

-- 
Florian
