Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31C46A9D89
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCCRXx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjCCRXp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:23:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F51A4A8
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:23:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso6846575pjb.2
        for <linux-spi@vger.kernel.org>; Fri, 03 Mar 2023 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677864224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=NrWJxfYPEuVjtZOpNuziiYBwAE8BkvYIkVTWdDxzNhWk7VNgoyMZbKBl4CSfPKjilA
         TVw6vOwtmHfBhuTDdRguROg83S4c3JyFvIf8dLeC3C1PAtvlynlLkgeY+M6CtDNL4igU
         zuNlV/6kTKlI4+tcuOfRm2qertmgPtcG25KLH2UJ4mZvjV0HkbuNnJ3GK3MCtndrfyOk
         J0mB6GosU5elw87XyUvswiXuP622WKGSVUPjHqyI8lfgkW4BaxUIXN5RKUIXavnh4Irp
         aek5OXithOGdfU01ReLSjaGxtbSWg8B+On+1fNka0LMML4YPfZarkzN2j5WqGRaQOyH2
         t/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677864224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=xlY0aGMGrCpDYxlGCysRjx4IBu/XTySaoHNSBlv0talb/uB/5wn0LBJE+T37qoqBSR
         WZgUGIzIueJE1i0leLtzIcj7Ip17oI+zDZviTFpc2AGB/pxWhBCaN6Uy5xU1Y8xUZZg3
         18XdO6ScK2K9mGoDlO8OFOY1JgZMI8PdYDABc6nbeXnhxGzw3FhHu++o5tpttM/YXdUp
         +ZHkFMJCZUZU3yjBJDzMl7isKqvXXOdfh7UfqJENfajnKlCv9G9Nn9Suzl3GVcTLdYqn
         y81Ew6kAmQHr281mTPWRvXTy8KG2vJI29kE4NMDn49M4WYk7m0so45k3LE9ALDsup5bP
         MQ0g==
X-Gm-Message-State: AO0yUKW1FW2FcNxWeRLNR7j4ZOvOBAaHyHd+mJ+tW0MBSlwpvdmGU7FS
        kJLtiCUl+kv5qL4gF7qW2+Q=
X-Google-Smtp-Source: AK7set+d2DAPonRIpZNfBFLtj7/T8Nek/WSAu9tHzPK57hQwk45VwmGs6xkiMFNpNq1BcjuYRWgJ4g==
X-Received: by 2002:a17:90b:1b45:b0:237:c565:7bc6 with SMTP id nv5-20020a17090b1b4500b00237c5657bc6mr2484420pjb.10.1677864223991;
        Fri, 03 Mar 2023 09:23:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id kp11-20020a170903280b00b0019e53dd4f2bsm1748516plb.245.2023.03.03.09.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:23:43 -0800 (PST)
Message-ID: <7f8ae2e7-6700-f7c8-932a-78cbe5b1e0e1@gmail.com>
Date:   Fri, 3 Mar 2023 09:23:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 09/87] spi: bcm2835: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-10-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230303172041.2103336-10-u.kleine-koenig@pengutronix.de>
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

