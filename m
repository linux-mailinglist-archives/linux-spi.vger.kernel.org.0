Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF62F1B36
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 17:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbhAKQmG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 11:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388011AbhAKQmF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 11:42:05 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D11DC061786;
        Mon, 11 Jan 2021 08:41:24 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 11so258818pfu.4;
        Mon, 11 Jan 2021 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uv3Cf1Z5wDBVRjdkUzWejQCce+4ctj5gFpl4bvSWCYM=;
        b=lSzVM9PqiSVbqlpmsAk+B0KR8WYTSZR5fmen2TSlqw8dlp+hDUKO2cHRz9ntaRoMD8
         pSP9QJQLhbAd2r67lH6g/1rHdti5J6nn1r2Vbr54QxHsoqXvrVIZuCshybrRoGXuq9K/
         IoEpUALVfcuwWo8Wz2TWSdRCgybSQIcZLRK3C1qEwdOHe+1VTmyGzD+SpGc0f8igLNEH
         AbF+ISr3nn83B3X3+pJWW8tv95kB08FH6q+YkGM+1FpZMek2sIOSvf/tTK8AF58/6qaK
         tPU9HBuLJ8E7KPIAgsa+FDAVLtFG9WApKnuiCCp5MXk4EB0IS/EEiIhTUNFriv3ot5eU
         NFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uv3Cf1Z5wDBVRjdkUzWejQCce+4ctj5gFpl4bvSWCYM=;
        b=gwq7aZG2I3djqau385UQpK/euEv2PVc/E1lZfQyGF5dvFUYbYr/FjgJkYZVbu6VR9W
         RXZIcb5/mf9qptwZlFBZ2yw81ppsO/cde/I3hcSJdZv3e6FUUezjBzI/yYJRobvZxKgE
         YJLovd1XroHIrIlJjSYLAhpl23jeRXn4hnGZU0KQ9pn67kgDMEZFpfiQ/EsaTSgxX49O
         JJK1TTImaeV+3izl/DaGWRnFzwAGTcUfc6Sf5g7QZtzhZZD5OsHAQkVn1T2FI9ueTYTS
         awSyI12Urw8ocw+F2P2hul0m68U+yYxJKF+P+j+dyBY9tPjvnyjhpR4OGrZCAzexuzJ8
         Oebw==
X-Gm-Message-State: AOAM5331B9uQGypKRPyzxt/8jN5ece+X1F0qKi2KNd6HV9PAcV24Awmy
        d5RUzxHGMANK51fwPDWw6pfdKGm4mLA=
X-Google-Smtp-Source: ABdhPJwLUgwTfr4fPF+ZuqJQLAiJ+/Qq+dY2MiT5laB75HvFlUy1kZmfWRR1q0B0a+lBlkh266EYgQ==
X-Received: by 2002:a62:7a43:0:b029:19e:c33b:c498 with SMTP id v64-20020a627a430000b029019ec33bc498mr258787pfc.20.1610383283434;
        Mon, 11 Jan 2021 08:41:23 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gm18sm15971pjb.55.2021.01.11.08.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 08:41:22 -0800 (PST)
Subject: Re: [PATCH] spi: spi-bcm-qspi: style: Simplify bool comparison
To:     Mark Brown <broonie@kernel.org>,
        YANG LI <abaci-bugfix@linux.alibaba.com>, kdasu.kdev@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <1610357189-60031-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <161038255869.32886.11006261963964555197.b4-ty@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ec735a59-0fbd-3d4a-e997-895099a8e534@gmail.com>
Date:   Mon, 11 Jan 2021 08:41:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <161038255869.32886.11006261963964555197.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 1/11/2021 8:29 AM, Mark Brown wrote:
> On Mon, 11 Jan 2021 17:26:29 +0800, YANG LI wrote:
>> Fix the following coccicheck warning:
>> ./drivers/spi/spi-bcm-qspi.c:884:5-34: WARNING: Comparison to bool
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: spi-bcm-qspi: style: Simplify bool comparison
>       commit: 6650ab2a44268af8d24995d28ae199b57b2ebff8

I don't think that "style: " is a subject prefix that is used commonly
and it certainly should not belong in a commit subject. Mark can you
please people at least 10-12 hours to review changes before applying
them? This one is trivial except the commit subject does not match
previous changes done to this file and it should have been fixed.
-- 
Florian
