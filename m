Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDEF60E126
	for <lists+linux-spi@lfdr.de>; Wed, 26 Oct 2022 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiJZMsP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Oct 2022 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiJZMsM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Oct 2022 08:48:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2F3F037A
        for <linux-spi@vger.kernel.org>; Wed, 26 Oct 2022 05:48:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so15620569wrq.3
        for <linux-spi@vger.kernel.org>; Wed, 26 Oct 2022 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sE+Z+aKLJBtR9+dUAYPrvxdETqNrnLtSJWEUx86MZUY=;
        b=LgFZ+HsJWkjGEKA11bTVdRFztvzXwO9fKzUQAqIlxHUGul209ZoEGwdHDD1HUDsubN
         mxURJ6DB6lufQtk/JQuM4mQkBkRLVSihiMssJVyBnADDKCR8VS2mqsDJFRl8yO+n+SFa
         4ruiHOfTIYKd3p3YbDfB3sj38wIoG4URoTTBTdoD8iWbwpMkR//mHaqIDzGG2Y0pbaEP
         CpdOBioxo0xDqR3VzspalN+DtOlnFzeIKzXsznYgdmBfSFf+TaAPX9vuPCPGnhVJofQj
         BO0iqSH7FTp1lZsWOh290I3LKbKc2GnRkGH+lAb7iNTToqdAOOrL3Nu/jOy6axNEXX2I
         BXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sE+Z+aKLJBtR9+dUAYPrvxdETqNrnLtSJWEUx86MZUY=;
        b=aeDagCSd/0DbX72xD2/zs/AEVoeBVIJ7QO2DhcWKvS6g1J2vGYOZJ0GfAJhIpSifEo
         ees/ZNSmYx89OCLA+WeqWCeFW11EcqC3jB8U6JdeqNVG3//W4DF7fLwtgAjPrD560pEg
         kMBrE5CkSyaLC8g223FH2FJ+3Zt0+lNVyT3EFhX5Qzlk9PiWxHhf9CzR2lyHio+TxPmK
         DLiLqvhBFU0om4oIxt4D4AouFmtXwvJH6kHYsqD3ejdCCnuSH1272XymbWOUUFNjsIHF
         kEhgTzEX4NDDNSqeZ99glExrCrlJrXl3oumztl4yadPaTasMjYtBZL88+T7OXynimbTj
         7lgQ==
X-Gm-Message-State: ACrzQf32PZSgn5OgyrX8u9MZTF7LG6SN+u0/tfQ78HgXZtYBC2Rm4Rrp
        9H9+heIZjDqSjsi4PfFl18rUiQ==
X-Google-Smtp-Source: AMsMyM6G0WR4Rb+GNc4kV+pKzodpC/zISi+uYoMUyMA4pSMIWBEbJUwfnw3+ujlVLTZAFzYSTCzM2A==
X-Received: by 2002:adf:e94b:0:b0:236:64a5:4038 with SMTP id m11-20020adfe94b000000b0023664a54038mr14561473wrn.321.1666788488542;
        Wed, 26 Oct 2022 05:48:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ce41:a140:b67e:6c4b? ([2a01:e0a:982:cbb0:ce41:a140:b67e:6c4b])
        by smtp.gmail.com with ESMTPSA id n2-20020adfe342000000b0023691d62cffsm62991wrj.70.2022.10.26.05.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:48:08 -0700 (PDT)
Message-ID: <7fb8e635-ef61-0773-eadc-7a5723740df6@linaro.org>
Date:   Wed, 26 Oct 2022 14:48:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] spi: meson-spicc: move wait completion in driver to take
 bursts delay in account
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-spi@vger.kernel.org
References: <20221026-spicc-burst-delay-v1-0-1be5ffb7051a@linaro.org>
 <Y1kql/WwAX+ZV8us@sirena.org.uk>
Organization: Linaro Developer Services
In-Reply-To: <Y1kql/WwAX+ZV8us@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,


On 26/10/2022 14:39, Mark Brown wrote:
> On Wed, Oct 26, 2022 at 09:58:28AM +0200, Neil Armstrong wrote:
> 
>> -		spi_finalize_current_transfer(spicc->master);
>> +		complete(&spicc->done);
> 
> No, you need to call spi_finalize_current_transfer() - you need to block
> inside the transfer function if you want to open code this stuff.

It's the case, I added a wait_for_completion_timeout() + return 0 in meson_spicc_transfer_one.

Neil
