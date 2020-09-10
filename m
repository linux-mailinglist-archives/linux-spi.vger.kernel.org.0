Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B7264D59
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 20:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIJSkc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 14:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgIJSUx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 14:20:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D46C061756;
        Thu, 10 Sep 2020 11:20:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so5121906pfd.3;
        Thu, 10 Sep 2020 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7f5zfLapjrOeUnEF6tF5o8o5qdLx0mGVKUldOV+8fa8=;
        b=k5athZhXAoz3gKeFZICNXz/zipgsus7YOCsmzF2wDrh5A1n2NinLPf/1OCfylkuzXU
         i+YlXpWZoSHPahi0INB0w512mwllw43YDm6lFlZqOpq5HTGbvJZT2TuapfYe2OGB2LLk
         EU72wO3UqmbkimkB+qxVWTLBrv3aw0SrdZBI9yqWQZItS5zXvTahp8jNyBWgyByAw3xV
         efp/67knPISFJR8LFdwK7pnoaGIzwja039JX8BmphhPfJj15FVJcqD+M2Z6CAlAjmegg
         yne4H2OiStmbnmcXXm4+iY92VISHz4B/kjzl8+ZMbGa63g9NXosOk2CXgtIgqvSdxJ5b
         Nhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7f5zfLapjrOeUnEF6tF5o8o5qdLx0mGVKUldOV+8fa8=;
        b=cuMXMayThYb/kOfW7Tu1teE+wMWV81aMIu5JcPCf6NtkB9T3PlqZChMzF8iZcQdtMe
         UWKZCIZJCkPUwEJ1+a3XOsQT3aJT5tZ970TVq5NlKxh488RrfgeKlzBG3rwSlZ3cnEON
         Bgh6/t1O77BTJvjmnBv6inlJklFQNvIOZ8EXpXWwzgxUorNbS7jY05dT5DJUX5QkrIL2
         xwsIPbgN+6I3DILktCqb7oX2UUkruzZWwTukOYHOHvIHwbh6rmIa4pLc2MswdYVA9Opy
         zEekGIHGsTqXwVtN+Lmme7RJ50T8Gf+n+sVX8alRdzcF/9avnTjq6OC1lvQpo1vQarc3
         cKdA==
X-Gm-Message-State: AOAM5310dYQz2v5sBHd0y4spJiQxMe63MciZUgm66HWZG0fsL3cm+DSh
        W8gh6Sct62D1yQSQiLxC93c=
X-Google-Smtp-Source: ABdhPJwNzmq0uYJ+DXXMAs0kt24uhw3yEYjPTpAhBHvCPtQyzx/uMGCCTTcWyCDba+rytCmT6RCJ/Q==
X-Received: by 2002:a17:902:b188:b029:d1:920c:bf98 with SMTP id s8-20020a170902b188b02900d1920cbf98mr3663834plr.28.1599762038752;
        Thu, 10 Sep 2020 11:20:38 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f6sm6700168pfq.82.2020.09.10.11.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 11:20:38 -0700 (PDT)
Subject: Re: [PATCH 4/4] spi: bcm-qspi: Clean up 7425, 7429, and 7435 settings
To:     Ray Jui <ray.jui@broadcom.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200910152539.45584-1-ray.jui@broadcom.com>
 <20200910152539.45584-4-ray.jui@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b3259f70-2c02-e68a-5207-80da89a23601@gmail.com>
Date:   Thu, 10 Sep 2020 11:20:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200910152539.45584-4-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 9/10/2020 8:25 AM, Ray Jui wrote:
> The Broadcom QSPI driver now falls back to no MSPI_DEV support as the
> default setting in the generic compatible string, explicit settings for
> STB chips 7425, 7429, and 7435 can be removed.
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
