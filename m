Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDA94B1D71
	for <lists+linux-spi@lfdr.de>; Fri, 11 Feb 2022 05:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244238AbiBKEuJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Feb 2022 23:50:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244157AbiBKEuG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Feb 2022 23:50:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85B9021AE
        for <linux-spi@vger.kernel.org>; Thu, 10 Feb 2022 20:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644555003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTN6FickAcVPgVjW2UUCx0PlKyGKDjTzkZ/0MQ6fTqs=;
        b=Z8i4tThqiQM0z95hsb0AunDuM5bg4X/wlrSmZTeI5ZJ30zcLG+HfpWjIqrdLnCZMkUdHqx
        UBtAG+Rl0P1usA4GNdnJ4Jbd/R2gFxinmha9gAp7oeQtxh9sww9p5QLeBzqbynC8SnfvAK
        Pswz0i4BA9C9Js/++FUG/ghdHw07nHc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-gRHfkos8OWKS1mnhlbch7A-1; Thu, 10 Feb 2022 23:50:02 -0500
X-MC-Unique: gRHfkos8OWKS1mnhlbch7A-1
Received: by mail-qk1-f200.google.com with SMTP id p23-20020a05620a15f700b00506d8ec3749so4994529qkm.4
        for <linux-spi@vger.kernel.org>; Thu, 10 Feb 2022 20:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dTN6FickAcVPgVjW2UUCx0PlKyGKDjTzkZ/0MQ6fTqs=;
        b=q/VuwH/Mm9hFgNHkQZg5jUeDbjQo8VE4t7kOgdxatASHa+SqCJBVP1Fo8e/9czRu/C
         1kGi/weGxWuJr9QJ/GGjfM88vsK7hNUF1qCG558X5lSP3joX2JPsOQXD8t1J2ORN4xoB
         VpQP+mrpsIf7x90HH2jOK32tHK09YtfiSsfTUZQ0Q/WEubQO7A/cjcqlqx0UrvZto/g5
         f3s+i0YmLG6OLNVl4jMd1HZFtNyzQdk7Vpn/BUGengw5qYi2lW8apVko3jz0lowzNeFG
         U6dr7b95WOowfB4WhF4fJCkHSrLQLXpDeV8iqbt6F16U3I15Ovf2g+aN7jqD0mgOnN0/
         ELRg==
X-Gm-Message-State: AOAM530xVpBck/dgVswCibcnf3Xeq5jPaBDZFgDdaZu0Z7DsWtAEbFZx
        Hw67hhLThQNa+8SN+/nkPgOJaUfo7J5t7m5n9eltvhBQbiFPfkg6bsY76TjRrr9Jj2DBMMhOEXv
        uopCzDSJe6VcNs75Clb/N
X-Received: by 2002:a05:622a:5ce:: with SMTP id d14mr7366626qtb.7.1644555001917;
        Thu, 10 Feb 2022 20:50:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7bVqaMXRkOzVf++7UD3m0x4aXle0i8TevJDeQKqz/0UREQhvZ7AVvKjH9oIg1JO06qDwrkA==
X-Received: by 2002:a05:622a:5ce:: with SMTP id d14mr7366622qtb.7.1644555001709;
        Thu, 10 Feb 2022 20:50:01 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bp18sm3323284qtb.72.2022.02.10.20.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 20:50:01 -0800 (PST)
Subject: Re: [PATCH] spi: Fix warning for Clang build
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>,
        Mark Brown <broonie@kernel.org>,
        Li-hao Kuo <lhjeff911@gmail.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
References: <691d52b72f978f562136c587319852f5c65f08fe.1644460444.git.lhjeff911@gmail.com>
 <YgT0LMcDpCEYHFYg@sirena.org.uk>
 <99ab624e2af4414bb2a785f64f35bd95@sphcmbx02.sunplus.com.tw>
From:   Tom Rix <trix@redhat.com>
Message-ID: <aaaefa2b-e043-2bf8-28aa-d89deb3fbc2a@redhat.com>
Date:   Thu, 10 Feb 2022 20:49:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <99ab624e2af4414bb2a785f64f35bd95@sphcmbx02.sunplus.com.tw>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=big5; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2/10/22 7:32 PM, Lh Kuo ���O�� wrote:
>> The return here means that the initialization is now redundant and will stop the compiler spotting any
>> future similar issues which isn't ideal.
> I got it, so do I need to submit a new patch?

Assuming yes, so something else..

Looking again at the function, there are 3 sets of if-check blocks these 
could be combined into the first one.

The later two are variations on is this an rx or a tx, the first check 
does that.

T

>
>

