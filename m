Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE646EEF33
	for <lists+linux-spi@lfdr.de>; Wed, 26 Apr 2023 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbjDZHUP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Apr 2023 03:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbjDZHUM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Apr 2023 03:20:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9584495
        for <linux-spi@vger.kernel.org>; Wed, 26 Apr 2023 00:19:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1240542066b.0
        for <linux-spi@vger.kernel.org>; Wed, 26 Apr 2023 00:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682493571; x=1685085571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AliyzMG7uX1K8DdktVWAS4ms6p/n8xzZ41dyvI1w1Gg=;
        b=WQj18P7N7/NjxvIrFAlFz2NSMyxiSKL2w+5Au2OAGGYs5hp85t92aNk8J9FgQzrCHA
         mKE/QnIyEp5qlwGivavj9volTnAUmS+BtnGY6TD5FbJMgTKCCdQPHvl29OsG4iemlxYx
         LvdVVSWi5SiS0+n3qkp9l3TXWnWo4LSDQ2fW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682493571; x=1685085571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AliyzMG7uX1K8DdktVWAS4ms6p/n8xzZ41dyvI1w1Gg=;
        b=LHjLT4cjpuEtj8ibYxvBy4xPp2DgyhXzqdQg0P1wi1c1B8oiCWR7ge/AcrbFaMFKim
         A7RQPJiFcgqpk+9w8zpOUuZ5AofHbYApgDtkHVBdhv2GGozQjYZwWdpBpWWL6vz+tGoe
         8QddMDuBzjFno0LRUEGH51hsPmTDSE3uj9i8tA53mB/jLMAcg4iYwELZBe/ZkEW08jCH
         4+h0db1DqHJPklVgUVlVENmdge5/RHTjWLUwGE/Oh8AhAQKLZRrXmIlGFnq6mZfwR04z
         jBgMbKpnjLRtsZMNdt9CiFj7fsGC1/PpU92/VRk7fPXNHk8DINe9Wp8Gm+5X+vG7I7eV
         nqxw==
X-Gm-Message-State: AAQBX9cDx/6z3ORRQBBTLtXid9EC8/qOReGu4R3URF43rN8izjsty7bg
        jcdU586OqUHBvETsPrU9BqG5Bw==
X-Google-Smtp-Source: AKy350axTsWxmLXczY1iG9nRIOTfr9oK5am+DCYWJT070/QHMp9uc514OPQus0ywr5pdvaDeSkD5lw==
X-Received: by 2002:a17:906:dce:b0:94f:4a87:7a77 with SMTP id p14-20020a1709060dce00b0094f4a877a77mr16535586eji.36.1682493571610;
        Wed, 26 Apr 2023 00:19:31 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id gn2-20020a1709070d0200b009545230e682sm7562305ejc.91.2023.04.26.00.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 00:19:31 -0700 (PDT)
Message-ID: <706c591f-4800-1b96-52c0-37b5f6de7623@rasmusvillemoes.dk>
Date:   Wed, 26 Apr 2023 09:19:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] spi: spi-imx: fix use of more than four chip selects
Content-Language: en-US, da
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kevin Groeneveld <kgroeneveld@lenbrook.com>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
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

On 25/04/2023 15.45, Rasmus Villemoes wrote:
> The current spi-imx driver completely fails when used with more than
> four (gpio) chip-selects, since the chip select number is used
> unconditionally as shift amount when updating the control and
> configuration registers, so the code ends up modifying random bits
> outside the intended fields.
> 
> This fixes it by making use of the unused_native_cs variable filled in
> by the spi core, and use that as the "channel number" for all gpiod
> chip selects.

So I obviously hadn't seen
https://lore.kernel.org/lkml/20230318222132.3373-1-kgroeneveld@lenbrook.com/T/#u
when I sent this.

I did consider that approach, but rejected it because it wouldn't work
with mixing native and gpio chip selects. Say, somebody uses SS0
natively, but then also have four additional gpios. Then chipselect 4
would end up activating both the SS0 pin as well as the gpio, selecting
both devices.

I don't know if that's really a realistic scenario. But at least I think
the driver should then somehow have a way to indicate to the core that
one should either use native or gpio chip selects, but not a mix.

Thoughts?

Rasmus

