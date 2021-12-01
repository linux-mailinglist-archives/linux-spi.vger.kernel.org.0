Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC824656C5
	for <lists+linux-spi@lfdr.de>; Wed,  1 Dec 2021 20:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhLAT6X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Dec 2021 14:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245428AbhLAT6R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Dec 2021 14:58:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA4C061574
        for <linux-spi@vger.kernel.org>; Wed,  1 Dec 2021 11:54:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a9so54795570wrr.8
        for <linux-spi@vger.kernel.org>; Wed, 01 Dec 2021 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TtPfYEGKnVBKt5IfjZCGiZy/FqKXbfwyq+NTL0AED7A=;
        b=NYttOVjz4x97cN5DXGDyKY5oq+S6Sy6IJEgfJDIwv2pqeJnZ8EN8u0gCdPA032w9We
         az6R8DPeYtIuE9q1D2WPulvvfTHKAnmRaQVKppGAoAFNzo+eb47v0xxMKaBgY9mACBm8
         MaEAC7v0Q6k1REGAdpxE/ASEW068s2iFOXhaAQU2FRBhKEh4PW24rSHDf4GtmOzVh+a4
         Uk9UdbrApXZC0Ca82TvZkouZ65Vwk8cXA1NKJpc4QcmRNjUXHSr6LsuXZuBNOzfIL612
         A1jmiUfTNHKH0Up1Rc3k/hw//1gVD0u2RK1URIm9n5FYrKWc6jBhu8RJ/Jb60qyPQku8
         agCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TtPfYEGKnVBKt5IfjZCGiZy/FqKXbfwyq+NTL0AED7A=;
        b=HoPrm9QALug40fMoCi+ajnyFRBM7E1EsPvMAmqwkpseEeCrTekL5U4CagiymGEE3Qo
         O0h9Qlt6ei/D2MdshS6zjKwH8jACIAX7/XBbYFtBi10bto+U/bNK/m4pKMXSR4YvPPv3
         Kgmc3fLdHIbo1FcMVHXzjINg5JhmNX3tGjTbAteO3z0Y3gEfZ8HjJGBiOOnJkW5tz59R
         GhYoZKk9LuDI8XzpnFodnMkTrcSQZng2D5QZDLWqklkRrQwnPC5FNtFcWWn5zfmvTd3G
         xmOVNUXnAylLUYBGGoUUQxgLO9bqCU6RG3jnG8PrKc8IHgsVoHMy1JTdie5GBeasZ2P7
         7nLg==
X-Gm-Message-State: AOAM530+UGoXA/vMLL1PHMCQaQTlERft8QrvK+uzy4mtiMTBt+1TpObN
        M3KOcMR7Oejrwrb1nQM7BLN4PZJKlXw=
X-Google-Smtp-Source: ABdhPJy59vmgdXSuFrznFrje3njjtq9t6+zeJllUsDD2xM/HYY8avs3tVvwO6CNCk8R1fyGs8mi2Hg==
X-Received: by 2002:adf:b35d:: with SMTP id k29mr8793472wrd.466.1638388494359;
        Wed, 01 Dec 2021 11:54:54 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:4055:a69:db9e:1280? (p200300ea8f1a0f0040550a69db9e1280.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:4055:a69:db9e:1280])
        by smtp.googlemail.com with ESMTPSA id p19sm282331wmq.4.2021.12.01.11.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 11:54:53 -0800 (PST)
Message-ID: <292d9bca-f7a2-d460-a34d-48ca17c0911e@gmail.com>
Date:   Wed, 1 Dec 2021 20:54:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] spi: fix erroneous logic inversion in spi_match_id()
 usage
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <44b2ad71-dc4b-801c-237f-9c233f675c0d@gmail.com>
 <YaeXoiFRAcxVG3I3@sirena.org.uk>
 <043b15ea-968c-60cb-dc50-c2081105975a@gmail.com>
 <YafKnpJxhfVLTdJW@smile.fi.intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <YafKnpJxhfVLTdJW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01.12.2021 20:18, Andy Shevchenko wrote:
> On Wed, Dec 01, 2021 at 07:49:19PM +0100, Heiner Kallweit wrote:
>> On 01.12.2021 16:41, Mark Brown wrote:
>>> On Tue, Nov 30, 2021 at 09:13:35PM +0100, Heiner Kallweit wrote:
>>>
>>>> We want to continue in case of a match. Fix the erroneously inverted
>>>> logic.
>>>
>>> We do?  Why?  I can't tell from this changelog what the problem is or
>>> why the patch would fix it.
> 
> Isn't it fixed by b79332ef9d61 ("spi: Fix condition in the
> __spi_register_driver()")?
> 
> 
Indeed, it has been fixed with this commit. I was using linux-next from
Nov 24th that included the first change but not yet the fix.
Sorry for the noise.
