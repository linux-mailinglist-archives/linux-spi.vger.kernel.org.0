Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF758E96B
	for <lists+linux-spi@lfdr.de>; Wed, 10 Aug 2022 11:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiHJJRf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Aug 2022 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiHJJRT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Aug 2022 05:17:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADD7AE208
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 02:17:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso667894wmb.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=tExeQAZyt5MFlaiu4qlfM352z/P0dnZTmeOuugjeqaU=;
        b=mgNyV9c+vdnPv+XFID7oQ0i2tPTJMIASQe9+elnHQ6x1HhRPuzzR4tt/827/Mlgl9h
         3WEzGcqtz/0wKqGez5AkDFx8/VnRMR+qHrG+u8sP7WO8PQKoY5uGONaGPfQnhbeh8woZ
         y1QesoLSVqVOWolv9IoNEL/G9oddJH7ADFI8+RJdvOyeNXxrOXha2P85dhdHR0vvPgJP
         IfkGiEe2PcEC/0/SHfYlO4x15wha4yrxivTJHBVXPueUr6gS567dw4FnXc7jE0rrjJzS
         AQEv1VeD6RCNPg9p6qrqrUx770AgVy9PwY4iHBs4ulcSAD/XA3BO0VelMiSyHrPGLemr
         yaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=tExeQAZyt5MFlaiu4qlfM352z/P0dnZTmeOuugjeqaU=;
        b=AZRsX4PzM8Bdqq6GHcMj+WXUFPISPR+UOcDzq+sfA98AAgaZ/2lxoj3gvO4V2CwGuf
         Im8LLGb9MApmJyKnoj3E/5SV/2hSbHjUU1ymaKCC+F1DchfBGm2S5vqDGNdqn4omqLAp
         TsQKcEkb7JoRi6vV9+13XQ10fxXRAOKo9BZOQeGEz5ZDLYjVjFppyS22P0Ox3dtnLPra
         4mwzn1eyA8WIo7BP4wJ0uuRH72hmv7AlWA9tVbDoBofq/P9sMYzwyLYVLCAILAKFlDzQ
         LafAWQMb7VsMENmtNPPVDHGkZEZcdMzLdIxhkXO21cW8eLEdpWmN3J/ED3fCbJlEzJFX
         z0cA==
X-Gm-Message-State: ACgBeo3yqvL/cJG3Z4rJSpb1ZVL1kBGQGAS5PRiEy6b4snpL1TDoK6M9
        vvG6RCGtbjLNeOMRi+7mGKi3ng==
X-Google-Smtp-Source: AA6agR4t2lBqQNfP4gn3TT6t2Sq965NrqmDFsjDSN0d3zdGdmbD8xjT+TyQYUQ1prRTqyg8x3B0FWQ==
X-Received: by 2002:a1c:4b09:0:b0:3a2:ff2a:e543 with SMTP id y9-20020a1c4b09000000b003a2ff2ae543mr1673853wma.93.1660123036335;
        Wed, 10 Aug 2022 02:17:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cb4c:4cd5:c6b6:8b12? ([2a01:e0a:982:cbb0:cb4c:4cd5:c6b6:8b12])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c028500b003a3278d5cafsm1697658wmk.28.2022.08.10.02.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 02:17:15 -0700 (PDT)
Message-ID: <39c2f53b-8f53-ceb1-ae0c-81e5e53d01aa@baylibre.com>
Date:   Wed, 10 Aug 2022 11:17:14 +0200
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
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <YvJ84qkuXdvVgXRm@sirena.org.uk>
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

On 09/08/2022 17:27, Mark Brown wrote:
> On Tue, Aug 09, 2022 at 05:20:19PM +0200, Neil Armstrong wrote:
>> At the end of a message, the HW gets a reset in meson_spicc_unprepare_transfer(),
>> this resets the SPICC_CONREG register and notably the value set by the
>> Common Clock Framework.
> 
>> This saves the datarate dividor value between message to keep the last
>> set value by the Common Clock Framework.
> 
> When you say the value set by the clock framework does that mean that
> the clock driver is adjusting hardware inside the SPI controller IP
> block which is then getting reset by the SPI driver without the SPI
> driver knowing about it?  That seems like a bad idea as you're finding
> here.

The SPI driver is explicitely triggering a reset at the end of each message
to get back to a clean HW state, but it does reset the content of the "legacy"
registers containing the power of 2 divider value, the new registers configuring
the new clock divider path (only on newer SoCs) doesn't get cleared.

> 
>> This didn't appear before commit 3e0cf4d3fc29 ("spi: meson-spicc: add a linear clock divider support")
>> because we recalculated and wrote the rate for each xfer.
> 
> Note that the rate might change per transfer.

It's taken in account, this case is when the rate doesn't change.
