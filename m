Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9C58EF9C
	for <lists+linux-spi@lfdr.de>; Wed, 10 Aug 2022 17:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiHJPvj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Aug 2022 11:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiHJPvi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Aug 2022 11:51:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECAD4B4BC
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 08:51:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so18222189wrs.9
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=de1bfIeCzht/PqANgMdEHr89VgLf+QFh5U3BT1EWLbA=;
        b=BTpT3e1IHvP3qZibGNSre2fvR3R4RZDlEChu2oxdCo8+w163kWUdzxwWt+S6XxwKl0
         fh5l/JAO4Zr3ojSmGQwE/RGhvehU4kerq0S8VN3szDU4JpTxhc5AxIy4OnUthI0WTb3C
         sOzSS5BDklAOGjIeHLdmqQokLG2gd4b7PB8Yv4Zs6yFPnJg0LzierVnzZZoTUNZXtr3F
         sdyswUaVZV9wUZjN/zjcuOeJ8fPO6TxXf5FvNib1kn2sUDKMBn3JEMBMY3GHs50arRXX
         rqImfwqZV+MaGStHCPAeBXcfVVqhK/3RzLlRWKN2iHDtUkugHz2Em2I62nhTArbGDo6d
         z0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=de1bfIeCzht/PqANgMdEHr89VgLf+QFh5U3BT1EWLbA=;
        b=XWE9sl3DmJFgCVHiH5fRwGEDN69kPdC7i/3sOmQFzvPCMstyQLk6JtYunsseMAkMrF
         33MuhwvggayuywlQ0LFgfb6p3nQrrS8K7RWE5NZSHScOKwXMPX2jG61NMIwNM9E1KQ8c
         tjOgRndEl/xR47LzMFYZXsBrnvoAWezrSbcW0pxjBHeATF4z4vlU6fLWemCrKlFNfoLS
         0f2zisuA3jqCOpK0saIRZ2LP0tc4CBEPRmL83uYlz9m+OoRleM87z1E7jyDoXoohfAE3
         GwqJB/iMBHmLtZtPLDmPG9eM8oWtIH0PYniAP7dAZ2Cqw0uhWuGSOo7uZcEnbIKmfP3w
         Q6Rw==
X-Gm-Message-State: ACgBeo0cQV3LMEeiy47tE07Yvy0UFRkyJq0ScqhU1uD+c6USWCLMnltm
        yQjP7pSNF86tUfTCJg2Jpx4CJg==
X-Google-Smtp-Source: AA6agR7Q5Mp3w9f9/hxYT2JWYltgiLUYBmJ093avPRRW1qIQyFWlA5lbd3ieExjR2ZNFGI9kCBxmeQ==
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id m8-20020a5d6248000000b00222cd3b94c8mr9557443wrv.97.1660146695304;
        Wed, 10 Aug 2022 08:51:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bbf0:b69d:fecb:8006? ([2a01:e0a:982:cbb0:bbf0:b69d:fecb:8006])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c4ec900b003a325bd8517sm4164965wmq.5.2022.08.10.08.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 08:51:34 -0700 (PDT)
Message-ID: <c7bfda2e-8135-fd2e-5d2b-5f547215bb18@baylibre.com>
Date:   Wed, 10 Aug 2022 17:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spi: meson-spicc: save pow2 datarate between messages
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
References: <20220809152019.461741-1-narmstrong@baylibre.com>
 <YvJ84qkuXdvVgXRm@sirena.org.uk>
 <39c2f53b-8f53-ceb1-ae0c-81e5e53d01aa@baylibre.com>
 <YvOmnDJA+ov49chC@sirena.org.uk>
 <518f22f4-1582-924c-9eaa-28ebbe53a632@baylibre.com>
 <YvPBX7zJ72RXnrpk@sirena.org.uk>
 <9dabe979-f6b5-329d-f017-a8f0c00adeca@baylibre.com>
 <YvPFZZ2HT2zK9XjQ@sirena.org.uk>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <YvPFZZ2HT2zK9XjQ@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/08/2022 16:49, Mark Brown wrote:
> On Wed, Aug 10, 2022 at 04:40:04PM +0200, Neil Armstrong wrote:
> 
>> I don't think it's worth adding so much code for this since we already
> 
> I don't recall the code for clock providers being that hard?  They're
> generally pretty small, some of the ASoC CODEC drivers did something
> similar.

Seems over-engineering to me, but I can explore this path if it's the best
route to follow.

> 
>> had an open-coded function which perfectly worked before.
> 
> Except in the cases it didn't...

It did but wasn't generic enough to take the new clock path introduced
in the new SoCs.

> 
>> I'm perfectly OK to remove the CCF driver for the legacy clock path
>> and return back to the old open coded calculation since it perfectly
>> worked and stop using the legacy clock path for new SoCs since it would
>> never be selected anyway...
> 
> It does seem better to go the clock provider route TBH.

I'm afraid this won't fix the problem since CCF won't set the clock again
if the rate is already ok in it's cache, we'd still need to save the divider
value and restore it after the reset as I did on this exact patch.

> 
>> ... but GX SoCs are broken so it would need an intermediate fix until
>> I push the refactoring to cleanup all this.
> 
> I'm trying to figure out if this is actually fixing the problem or just
> papering over one case where things happened to go badly.

It does, when clk_set_rate() is called, the datarate field would be the
same as after the previous call.

Neil
