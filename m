Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4A62DD84
	for <lists+linux-spi@lfdr.de>; Thu, 17 Nov 2022 15:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiKQOFk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Nov 2022 09:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiKQOFj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Nov 2022 09:05:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985B1FFB7;
        Thu, 17 Nov 2022 06:05:37 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k2so5351038ejr.2;
        Thu, 17 Nov 2022 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=u6c8fBhfPadc8cu0krt5hkpFlG+n4LiTHELzXtnJeR0=;
        b=kRWk6QWNDibLsq2IbAq4If83VQOALIw5xVilUxzS34YjdBCn7F+w2xkgVRLq4DO8+a
         gl/cLqQwm82EwHWDNLqBb9Cb7Zjp2+vupdMC1ZTlnWkihuQvDxEJKOy4eZ/cOyxNeyKD
         +9UXTCAtdAmLJqFMDSJnuBPI0b0xWVcZgHHirImwxGi/qjI0KePyp0M0haL1sXq0foNI
         w9Sa7cxtJUcHNMDDEz9Qeh9mJSzl41jSdavSrS0/5TwFXa5fup2kLpgjuWLykR+bMlNF
         AsqAAbdc814rG+tIBgkci99DXVfF5Xp0yEDnMptkcAxJ2eUbN8CZBufVcpCzNahfjvV5
         2tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6c8fBhfPadc8cu0krt5hkpFlG+n4LiTHELzXtnJeR0=;
        b=RbniygzTbUdVZjFHE/MHr9VX6DzJSSZcEevKzskdOiidVrIs9HsyrZ6QkxxmuL27KV
         i1rMorXjTWs9B9uh9AyxKWaagyQ3e0P+0o32b28OYMxXJavvm3gryX3UygxBJ9uKxjod
         NXXmkX/Ul+cVztD1X5d8YqBdOr2t1LHUTFi/MfVeb28RoLO/dCwGHcCypMEab/f7pcPd
         6TgO0wp7x3b3Fo2oXRzuuGLRsSTQ6vHvp8kVIay7nVMEZtLC4oIsCGdDWU0NE7ioViCe
         wUJrWaSwErzsRlVLIz1ParBfRKkR+MIF6m6ySemKkTOTVjcmneFnhYpsu3NSrfek6SFb
         tPfQ==
X-Gm-Message-State: ANoB5pllu0IUXa9GZlM+8ZWY8hokwyg7bIFbtsc+VmVI4U666/Gj6i45
        Mq2KQuSPaaFINGJ7mKvmO00=
X-Google-Smtp-Source: AA0mqf5eoLeMemC/Xj2W2AaH0lSZZn6rPS8GtVUMR7f1tz2ZshG8CzKSuB65mlB+x22wpyvJ69fmMA==
X-Received: by 2002:a17:906:698f:b0:78d:93b1:b3ba with SMTP id i15-20020a170906698f00b0078d93b1b3bamr2348324ejr.66.1668693936035;
        Thu, 17 Nov 2022 06:05:36 -0800 (PST)
Received: from ?IPV6:2a0e:41a:894f:0:7a60:27eb:954c:5ab1? ([2a0e:41a:894f:0:7a60:27eb:954c:5ab1])
        by smtp.gmail.com with ESMTPSA id u21-20020a170906125500b007a7f9b6318asm415839eja.50.2022.11.17.06.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 06:05:35 -0800 (PST)
Sender: Carlo Caione <carlo.caione@gmail.com>
From:   Carlo Caione <carlo@caione.org>
X-Google-Original-From: Carlo Caione <ccaione@baylibre.com>
Message-ID: <3bfffc60-a4d3-ddc2-7811-f0fbec22ba65@baylibre.com>
Date:   Thu, 17 Nov 2022 15:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] spi: meson-spicc: Lower CS between bursts
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
 <20221116-s905x_spi_ili9486-v1-3-630401cb62d5@baylibre.com>
 <098b923b-ff46-5ef5-9c21-19c974c9274f@linaro.org>
In-Reply-To: <098b923b-ff46-5ef5-9c21-19c974c9274f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/11/2022 09:54, Neil Armstrong wrote:

> I'm afraid this will actually break SPI NORs for example where CS 
> actually splits transactions.
> 
> Isn't Amjad change enough ? The CLK pull-up should avoid this.

It looks like it is not enough unfortunately.

> If it's not the case, then it's an HW issue and the CLK line pull-up 
> is too weak and an external pull should then be added.
	
Alright, I'll drop this patch in the next respin if needed.

Thanks,

--
Carlo Caione
