Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8747E254E95
	for <lists+linux-spi@lfdr.de>; Thu, 27 Aug 2020 21:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgH0Tad (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Aug 2020 15:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgH0Taa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Aug 2020 15:30:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA4C06121B
        for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2020 12:30:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g1so4062279pgm.9
        for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2020 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jbkAfuhZAKMTavUGq6kzae8BdLlY/pw7F8TdORnXsqQ=;
        b=RGPVxSi9400bcoNYxMs9hsfmQ4rchGqtdHPGG1HmzfnO/mDEdAuT5tnT9cnXgHUnky
         TVm59Zd6m8r3qRLSdXB4SkR6JL22i1ikeXaD9WMwU1P1CzwLXRnhMhX603ZL+Y0cxYSe
         TfSsX5C/0ae+pAAAQobQNbrfGMxlLm8VNVb94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jbkAfuhZAKMTavUGq6kzae8BdLlY/pw7F8TdORnXsqQ=;
        b=VXFpr5gS5D8eOdV5bqeZLCf1O5awj3Kkkvbv7rawFpHQVWRL9L+WFlSW+qRYUD15S4
         yQF0jaI3/NHFum/u5MWB2bkzfaoqQEfmNrzC33yFr6Fqi5bQ06BR6BgtHhNOl1XM2rhS
         CR+g+yRSNpTRrvqu1Adpxx6IJrLZ9lv5cet8CBB1oqs7raL72NYOFOLnN4eJVXHmQEl5
         nOF2Ml8zufn4sFyGrCIkop1Yb8yUJsQJUwIGqU0OvOKoBo7rNdBpEbzPd5AIYcUomz3Z
         IXQHpMWr5OlJ3fjCoDKbupcyv2XYX8x05q3t47hjx0G2VRNgi1GdtYg/wLWFImUisRIT
         VJkQ==
X-Gm-Message-State: AOAM5302q5aCsFUknsnn6pC5/jUpx8dlq348jG9kd5ZSd8OXHtqnm6NW
        uupFJ9mqaiK3IRA9mihKNC2dnw==
X-Google-Smtp-Source: ABdhPJwCOi62uMlXfcPonmuVECt3/Iv2jH+EgupKyrvs9JK9fe/kDGN2+VGdJJMTP/OzZaxkjeSwnA==
X-Received: by 2002:a05:6a00:228f:: with SMTP id f15mr18055805pfe.222.1598556628896;
        Thu, 27 Aug 2020 12:30:28 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f13sm3633868pfd.215.2020.08.27.12.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 12:30:28 -0700 (PDT)
Subject: Re: [PATCH 0/5] qspi binding and DTS fixes
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        "maintainer:BROADCOM SPI DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <5afe8762-c0a3-ff10-5946-0eb2e7ddc0e5@broadcom.com>
Date:   Thu, 27 Aug 2020 12:30:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827181842.1000451-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Patch series looks good.

Acked-by: Scott Branden <scott.branden@broadcom.com>

On 2020-08-27 11:18 a.m., Florian Fainelli wrote:
> Hi all,
>
> This patch series fixes incorrectly defined compatible strings for the
> Broadcom QSPI controller which resulted in the strings not being
> ordered from most to least compatible.
>
> We will need to apply some changes to the spi-bcm-qspi.c driver in
> the future to assume no revision register exist, and these patches
> are a preliminary step towards that goal.
>
> Florian Fainelli (5):
>   dt-bindings: spi: Fix spi-bcm-qspi compatible ordering
>   ARM: dts: bcm: HR2: Fixed QSPI compatible string
>   ARM: dts: NSP: Fixed QSPI compatible string
>   ARM: dts: BCM5301X: Fixed QSPI compatible string
>   arm64: dts: ns2: Fixed QSPI compatible string
>
>  .../bindings/spi/brcm,spi-bcm-qspi.txt           | 16 ++++++++--------
>  arch/arm/boot/dts/bcm-hr2.dtsi                   |  2 +-
>  arch/arm/boot/dts/bcm-nsp.dtsi                   |  2 +-
>  arch/arm/boot/dts/bcm5301x.dtsi                  |  2 +-
>  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi |  2 +-
>  5 files changed, 12 insertions(+), 12 deletions(-)
>

