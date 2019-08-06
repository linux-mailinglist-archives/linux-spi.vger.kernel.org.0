Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5A82CFB
	for <lists+linux-spi@lfdr.de>; Tue,  6 Aug 2019 09:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfHFHmY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Aug 2019 03:42:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37921 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfHFHmX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Aug 2019 03:42:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so86815927wrr.5
        for <linux-spi@vger.kernel.org>; Tue, 06 Aug 2019 00:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=65xn78LdoxUN3ytgMeno6tvL3rOxnecpzwuw8rPR7eY=;
        b=Wmxoh4Z5s3ECvtsYOvt+a/Ejh3ok/xnZBD/mbsCS7VcWUCDMj0axJXxIaSX+vGBiKe
         HTNiG8/wLWuUZBgz6NX0+mVtQWOJDVup3fua5/eO3WPp+1NFQkTkx+zLqmD40Guxzdtn
         dJM44qUPZur0/SJ2UUCwwmJI7crgHGpYU8QycZj6uaLQQuMMTFNI2uCJVF2HbwXOnYgK
         zfWyPAUPGvNmjrgpxPCAfbV10CIvpX/eFN8B1rQ+7S6fq7xtyEEK9U0LguRWxZObmlGK
         ep3Ib2ly32nSGQYEnTfurwI/djwbpN7QQps4HhYagDcl2UgzxLLMNwLw/7X1iwK1ASR1
         sbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=65xn78LdoxUN3ytgMeno6tvL3rOxnecpzwuw8rPR7eY=;
        b=hrI92PNIgeeisg/QH68Wrv70KeCgfpmac0EKQfUvBcCFq4i7/aDGFwCimUTsTIoW8O
         /Su+oMhpF0JWXzZLq4PYAA1Io0nWQAwzaEMXac1wB+3u5b8o7iJweGInKgDR6y6O1q7m
         6DFzpbadmbF6DQMnNbhG4BRZ+2QlEFRIgxyuraLHt2dHPqQzPjdAqqCLQWEQ/HTD8mm9
         vgQsAYvCr1M4ypJgV081NmaqcY3A3Jq7xjTaov57xCrVoq9ZjBeoU6QIvO8e+AK3ZGRG
         XeIngpIII5wr6lwiqLsI6pusr4c9DKwiYEaL5ynI9g9e1qqAZ9JlP1w78ovgfM67dcUn
         B6+w==
X-Gm-Message-State: APjAAAVg0vH2T88zjU3gTJZsXgtJlyPBZ/zsJY0Dior57BvE17aK0Kmd
        w4+V/r9WVbN44DBXiBOnAJPwMfDF5ogdnQ==
X-Google-Smtp-Source: APXvYqykyzrlBlmQGGkTSLo1okYOFX3pSL4qWuI3BWHb+b7lB728r6th9ldFgXuMJutirO1qbpmP9w==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr2865796wru.195.1565077340695;
        Tue, 06 Aug 2019 00:42:20 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t24sm80564330wmj.14.2019.08.06.00.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 00:42:19 -0700 (PDT)
Subject: Re: [RFCv2 0/9] dt-bindings: first tentative of conversion to yaml
 format
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20190805120320.32282-1-narmstrong@baylibre.com>
 <CAL_JsqJzwtSXX0nrS7RBP8u-e=16SiWOBjLrvy8Amc08PfpXag@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <4e87b12f-ef92-49d8-1e1d-9bc5ba5c3c8d@baylibre.com>
Date:   Tue, 6 Aug 2019 09:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJzwtSXX0nrS7RBP8u-e=16SiWOBjLrvy8Amc08PfpXag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On 05/08/2019 23:51, Rob Herring wrote:
> On Mon, Aug 5, 2019 at 6:03 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> This is a first tentative to convert some of the simplest Amlogic
>> dt-bindings to the yaml format.
>>
>> All have been tested using :
>> $ make ARCH=arm64 dtbs_check
>>
>> Issues with the amlogic arm64 DTs has already been identified thanks
>> to the validation scripts. The DT fixes will be pushed once these yaml
>> bindings are acked.
>>
>> Changes since rfc v1:
>> - Fixed bindings according to Rob's comments
>> - Added commit log
>> - renamed yaml files using amlogic prefix
>>
>> Neil Armstrong (9):
>>   dt-bindings: mailbox: meson-mhu: convert to yaml
>>   dt-bindings: rng: amlogic,meson-rng: convert to yaml
>>   dt-bindings: spi: meson: convert to yaml
>>   dt-bindings: reset: amlogic,meson-reset: convert to yaml
>>   dt-bindings: arm: amlogic: amlogic,meson-gx-ao-secure: convert to yaml
>>   dt-bindings: phy: meson-g12a-usb2-phy: convert to yaml
>>   dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml
>>   dt-bindings: serial: meson-uart: convert to yaml
>>   dt-bindings: watchdog: meson-gxbb-wdt: convert to yaml
> 
> For the series,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> What's your merge plan? Do you want me to take the whole series?

I planned to split them for each subsystem, but it may be much simpler
if you take the whole serie.

Neil

> 
> Rob
> 

