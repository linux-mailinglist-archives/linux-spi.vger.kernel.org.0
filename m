Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D6D6EF4A3
	for <lists+linux-spi@lfdr.de>; Wed, 26 Apr 2023 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbjDZMsV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Apr 2023 08:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbjDZMsU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Apr 2023 08:48:20 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BAC170D
        for <linux-spi@vger.kernel.org>; Wed, 26 Apr 2023 05:47:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8c51ba511so66427011fa.1
        for <linux-spi@vger.kernel.org>; Wed, 26 Apr 2023 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682513266; x=1685105266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6G7IUulzTfhtoVZrIH1tOX79wjetImDDZbSdg5ac+R0=;
        b=cidVwgUgb+SB0lEhEwIVg8U6ogmocpHfzpZS63CzXPqZhH3jHl/HRSLf6lxXrF47hI
         SJVj598VfLVyKERyW+le9TRY6jCG22CgUyC9gV12JkBBLXxv6c0jHirlJUprWhiJ102G
         9JAgedzUZR955eUUerbCSqfWxZI18Xc+vr8Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682513266; x=1685105266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6G7IUulzTfhtoVZrIH1tOX79wjetImDDZbSdg5ac+R0=;
        b=Cp7csSKYlteT6NB+vh9yENVkU2WHEd0YM5UlHYcAbbGQyv41FejzJQ8RigSPGZJMlw
         NEwGYVuwkMrGP8oQBnz8VSy0tMtCCjilqMbytpPpfV6cw0flNWG/ieMWMQ23pNlOpICP
         pit06Blqd1L5NuCX+oxgIwisPPyITw1AzvJz74kJHScmaoQuNTryqH8+6kaGbMUVryd+
         Bx5KTiVQYMGUbg6Yg7MehbjZKU61C0rV3Ehe1WIP7F1pvp1NMM8yGAP3C5ULddtku9f/
         ilQ5r0vEnQcMLCttMir6mblz8bMsUWezl6mDJgsJox/H5z4GnB4mv+PBQt4HBbKE9qK7
         UdWQ==
X-Gm-Message-State: AAQBX9epZTSZjzH1JRf1VTnUPImCpyXv34FQRaft3ES8z9uvjVlxivd5
        pdrI/shgl8lsDGFrlol3gci/Xw==
X-Google-Smtp-Source: AKy350afV3cJCybPB05LFwljBBHKqqHXBvLD4iZe7owm2yLG2g0nSvChOWgMiUIS88PCZTqioY43kQ==
X-Received: by 2002:a2e:97cc:0:b0:2a8:d021:4121 with SMTP id m12-20020a2e97cc000000b002a8d0214121mr4180598ljj.26.1682513266081;
        Wed, 26 Apr 2023 05:47:46 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a28-20020a2eb17c000000b0029c96178425sm2540381ljm.19.2023.04.26.05.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 05:47:45 -0700 (PDT)
Message-ID: <9f403dd7-1ac8-bebe-1b24-bede61087bba@rasmusvillemoes.dk>
Date:   Wed, 26 Apr 2023 14:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] spi: spi-imx: fix use of more than four chip selects
Content-Language: en-US, da
To:     Mark Brown <broonie@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kevin Groeneveld <kgroeneveld@lenbrook.com>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
 <706c591f-4800-1b96-52c0-37b5f6de7623@rasmusvillemoes.dk>
 <fd22bfc4-b019-4445-acc5-f7902a2386fe@sirena.org.uk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <fd22bfc4-b019-4445-acc5-f7902a2386fe@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 26/04/2023 14.25, Mark Brown wrote:
> On Wed, Apr 26, 2023 at 09:19:29AM +0200, Rasmus Villemoes wrote:
> 
>> I did consider that approach, but rejected it because it wouldn't work
>> with mixing native and gpio chip selects. Say, somebody uses SS0
>> natively, but then also have four additional gpios. Then chipselect 4
>> would end up activating both the SS0 pin as well as the gpio, selecting
>> both devices.
> 
>> I don't know if that's really a realistic scenario. But at least I think
>> the driver should then somehow have a way to indicate to the core that
>> one should either use native or gpio chip selects, but not a mix.
> 
> I'm not sure this is sensible, it'll be a fairly rare situation and we
> don't want to preclude using the built in chip select functionality for
> some of the chip selects.  In a situation like this we only need to have
> a single chip select to be managed as a GPIO rather than all of them,
> which I'd expect to end up handled in the DT by not allocating that chip
> select number.

Sorry, I don't understand what you're saying. What exactly is not
sensible? And what is "a situation like this"?

I described a problem with what is now 87c614175bbf in linux-next: If
one has five spi devices, the first four of which use the four native
chip selects, there is no way to use a gpio for the fifth, because
whichever "channel" you choose in the CHANNEL_SELECT field will cause
the ecspi IP block to drive some SSx pin low, while the spi core is also
driving the gpio low, so two different devices would be selected.

It's not exactly a regression, because any chip_select >= 4 never
actually worked, but what I'm saying is that 87c614175bbf also isn't a
complete fix if one wants to support mixing native and gpio chip
selects. For that, one really needs the unused_native_cs to be used for
all gpio chip selects; in particular, one needs some unused native cs to
exist. IOW, what my series tries to do.

[OK, now that I re-read what I wrote, I didn't exactly describe "four
native CS, one gpio", but "one native CS, four gpios". That scenario
_could_ of course work with my series, but with 87c614175bbf just
masking the chip-select number, we do get the problem that two devices
would be selected at the same time. And I don't think expecting the DT
author to know to use regs 1, 2, 3, 5 for those four gpio chip selects
is reasonable; nor do I think it would actually work, since the missing
gpio phandle at index 4 in cs-gpios would be treated by the spi core as
a "that device, if any, uses native chip select 4", and that
would/should fail.]

Rasmus

