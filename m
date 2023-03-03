Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA34A6A9D90
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCCRY6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjCCRYw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:24:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E6F4DE31
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:24:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y2so3235018pjg.3
        for <linux-spi@vger.kernel.org>; Fri, 03 Mar 2023 09:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677864291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=Rgb9yXHizvp/HqKe2uFUcK9e2lweS1kO1LSw1MLvLTk5GSH8oGzoKstcAHMxwDNLi9
         g7wrW0Ffin5vXYtpbmZyX+daRGbI0xlX5Nhp78YoVvbQj31rW63Q2GI03EiJ0rmUxaRk
         nKiBSbF4xbh5cYUCmgsMjvPlWn4Dtsa8D2EP7BfltS4kqXb1Ab0WJFKGHApM1hluGqaY
         tommTiQ48Zdr85R1DaHHczwweuMAnp7cnwhYeEbz1mGxGEj2qjxBgerxgEmCe5k6Etwo
         iclBBvVhfGLMCttEJU+rnW9aypEFSk63cP1XQygW2Vd7yVm85dIe2R5XAYMR4ZzgJIGV
         MENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677864291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=bfqIUypGA+E1qjhS3nboSxUmlULjObNMOMzQTeR0okKMhY2ndYBm5yqr92ZZ2LR7Ka
         EZ1BJhgwe9KhI7N5vipszmYZWmv0n3z28E4C6VXYdbleK2pvGSrezcGlH3cPVuQ287f1
         lq4d/DYzXYBrTTjwtsjWU82dvOq5WAa1iuc7cXwi+ZiHyYtBOqlGpNP7FZoFk/Qj58Bs
         gu4S4ngrq8AgKI5IsY26aM9tAvXAoTNfjxFtchRuDXnoVvXPbmsmFVwPBSwNCXwcGn8g
         EJ8YmXkuBM2fGBAD1UkJKX2PCg9OhyQMk7dVodlVSey5vToZxgVof7QMHljdpOxjfaGZ
         a2Vg==
X-Gm-Message-State: AO0yUKUGXtDencXZ/4aRfEVHtB3BmGbrkoE4v/v5TQb1utlt40STL4bX
        WepcdWee/ehkOt81oMuWKtY=
X-Google-Smtp-Source: AK7set9NhleWNBOUJFKGVyS4QRS1NFQM1NSQwa8Lhrm1/AN/w+xlp6iXL2eXy14+BZSfF8B5NU8wiA==
X-Received: by 2002:a05:6a20:548a:b0:cb:e735:65a5 with SMTP id i10-20020a056a20548a00b000cbe73565a5mr3613077pzk.40.1677864291021;
        Fri, 03 Mar 2023 09:24:51 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d13-20020a63ed0d000000b00503006d9b50sm1772574pgi.92.2023.03.03.09.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:24:50 -0800 (PST)
Message-ID: <059df7ce-4d5b-abbe-1630-df775fd52dca@gmail.com>
Date:   Fri, 3 Mar 2023 09:24:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 14/87] spi: brcmstb-qspi: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-15-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230303172041.2103336-15-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/3/23 09:19, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

