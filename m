Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090186895A6
	for <lists+linux-spi@lfdr.de>; Fri,  3 Feb 2023 11:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjBCKTm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Feb 2023 05:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjBCKTZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Feb 2023 05:19:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00CC9E9D5
        for <linux-spi@vger.kernel.org>; Fri,  3 Feb 2023 02:18:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a2so3908422wrd.6
        for <linux-spi@vger.kernel.org>; Fri, 03 Feb 2023 02:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odqpSFJ0f+PZ4TN9H2HUGPRDThnkRj1i7Ss7xOqwBxo=;
        b=vZSwxd+i4gYdilxbkPyzz9u5M/wmJE6d5Ed+DcxQEkuCLGebQ2m4EgG17QKAT3QPqv
         k20Lhi0fmw24KDDunYGrQxKW+ByTCG9X8CfB1qi1qazX3jFg+VcCo+j7Mxua4Bleb7Vp
         aVMluIqoPCjZ3tkusKdiBM5hW3LJJMqG/0e57vTn5SSQX3KuOgQlzEQVSpqBC5eI6dbT
         fy6bOPpgVsHQHRqCWwF2WRDozVI2MsBK1YukbBXvePC7qIIYkNHzFqK22oGCi0yXTqfG
         KlVikTD7UtotnfrkV9UF3v76A8yAf1I8pGVPfMgmUi9MO5C8HQuhdYNQc2VxXsMbYwlv
         xXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odqpSFJ0f+PZ4TN9H2HUGPRDThnkRj1i7Ss7xOqwBxo=;
        b=qli05pvyquCKvT9cvxM/Jld7aelAWuFpJUeoVTEkXzisAXviWsR6kbqZW79Z4jEahu
         6vtOJmdQB8ulExuVbDtNy1g+BIqUOwg4VCPYWMd7vdalz7wjGHozp0tLaIU2Qv5Yx5Ul
         35r4pLKu+VcHj5Ck2qiBJjnw/eLe1o2p6FaQbnSfJsf+2nrTPSUbWmZXxXKBmb4NbnLF
         8ugfQqwVEcWjOgzJiLcsg88QB1yTMDyycXmi0jINUCT8XPAlqXhvYg5l/vYbaOIUxYQF
         NVSMCKcFMEbD88R9E2hyup5w3I9ddvDR3wSbrbgTGsbc3WxjqUjBbNJcChQ6wNWeraHn
         w9lQ==
X-Gm-Message-State: AO0yUKWAUi5M4MzbvksXYdhcUbH32f2QxDdIlBq3ZS57DaXQXRbngEy0
        fvLisbcCLrQVrMEAtMFGS3/aPg==
X-Google-Smtp-Source: AK7set/A/7BpKhP+zyNlXDxtrR2vM9hyGoiLQbrQbwKXru552gKjPaug1Z3UaSVGQ6uTHJ0CplbhUQ==
X-Received: by 2002:a05:6000:104:b0:2bd:e547:943a with SMTP id o4-20020a056000010400b002bde547943amr9033416wrx.14.1675419523177;
        Fri, 03 Feb 2023 02:18:43 -0800 (PST)
Received: from [192.168.2.104] ([79.115.63.122])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d4301000000b002c3b2afae00sm1615194wrq.41.2023.02.03.02.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 02:18:42 -0800 (PST)
Message-ID: <5040b424-23a9-5083-6de1-e457b8d5cbb5@linaro.org>
Date:   Fri, 3 Feb 2023 12:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: s/a SPI/an SPI
Content-Language: en-US
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230203081119.69872-1-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230203081119.69872-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Sent a tree wide patch instead, feel free to comment at:
https://lore.kernel.org/all/20230203101624.474611-1-tudor.ambarus@linaro.org/T/#u
