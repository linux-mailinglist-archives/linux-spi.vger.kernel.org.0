Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FF3428555
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 04:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhJKCz4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 10 Oct 2021 22:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhJKCz4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 10 Oct 2021 22:55:56 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3165C061570;
        Sun, 10 Oct 2021 19:53:56 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w8so6005076qts.4;
        Sun, 10 Oct 2021 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pj5HBnFcZA/xKYVwuzYYzAMrAn6DXpDKGRmEk0FzL1U=;
        b=bV7R/FZZMk8LUf2D8rP78AkNTQu1a/LWKbg9vfghopUxI3yg8aVKImXkbK5dDfWy2Q
         ek5KHRhrhGYWYv2Ht/lTyklsdu3XjX7OxOeQD4VUUMIvoGhlvsVABSLIxr+NyMT3jLjx
         oz1USrrNURY5v4jQCqR0mjVLNZS05MEhDnNlrOErPGEzgyBIL+WNX4F90vUINTWzOFJC
         Y+AnQsSmd+4Ub/UY9FTOIzszFuS+s9VhEOm8eF0IgiMI/OoGv4VqI6FKI9yt5HnLrjFX
         BlHIknSOSqeJv5SLN4LeWgLa5UYmpH3p63d1L0/iukIpfFyrthDQgR3T8/iiovtx/Boj
         nPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pj5HBnFcZA/xKYVwuzYYzAMrAn6DXpDKGRmEk0FzL1U=;
        b=ETE8GZFifC6MgM+UlqFuik29CZiMVz1QaOaLWiY9QLQfE9TrPmLF8L2sYKTgITxm4u
         qjShXiAnRdgPlC9Hc5sumBWxgQalfzcHQ0mQYAbOpPgBBxSIrrew5XyiVrdoWJZu6xAe
         wTGjEfaH++RC5K78Bjb0PqvLwNNMeeGdAIiN9M80sDRzjH36afCcF/xLc2HjkM10HR/i
         zH3PDGk6PECNINnoes68MvV5wy+bpViPVu5Cerr92vEXec/HyCqQPrtBBRqUxc80oRl5
         T4XOp1lA55053OLjxxmBwe1YWkZ26o1bnxwR8qhDKs/THuWOF03opyOkFl8+DQe5E5OS
         zLHQ==
X-Gm-Message-State: AOAM533+TDk67eU9rthuxqFp6CFNb8/huscMXl6b+A4IoLsN/Wfw7JBn
        LXKzbOZVlhsJmywzwm1YGcU=
X-Google-Smtp-Source: ABdhPJz9gWjjSosA1E6itNJyRfy/OP60vz/3OT8MJ7aO5iw9jl226ZqvVvbhOpaM4H1DNFK+B/jFdg==
X-Received: by 2002:a05:622a:1a8c:: with SMTP id s12mr2074128qtc.303.1633920835944;
        Sun, 10 Oct 2021 19:53:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:dfe0:49f0:3cb6:937e:609b:a590? ([2600:1700:dfe0:49f0:3cb6:937e:609b:a590])
        by smtp.gmail.com with ESMTPSA id z186sm3610855qke.59.2021.10.10.19.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 19:53:55 -0700 (PDT)
Message-ID: <6a9a6467-f9a3-1412-8063-e51d0e2c0e43@gmail.com>
Date:   Sun, 10 Oct 2021 19:53:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 2/3] spi: bcm-qspi: clear MSPI spifie interrupt during
 probe
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu@broadcom.com>
References: <20211008203603.40915-1-kdasu.kdev@gmail.com>
 <20211008203603.40915-3-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211008203603.40915-3-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/8/2021 1:36 PM, Kamal Dasu wrote:
> From: Kamal Dasu <kdasu@broadcom.com>
> 
> Intermittent Kernel crash has been observed on probe in
> bcm_qspi_mspi_l2_isr() handler when the MSPI spifie interrupt bit
> has not been cleared before registering for interrupts.
> Fix the driver to move SoC specific custom interrupt handling code
> before we register IRQ in probe. Also clear MSPI interrupt status
> resgiter prior to registering IRQ handlers.
> 
> Fixes: cc20a38612db ("spi: iproc-qspi: Add Broadcom iProc SoCs support")
> Signed-off-by: Kamal Dasu <kdasu@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
