Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271E23DC7F5
	for <lists+linux-spi@lfdr.de>; Sat, 31 Jul 2021 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhGaTVZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 31 Jul 2021 15:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaTVZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 31 Jul 2021 15:21:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ECBC06175F;
        Sat, 31 Jul 2021 12:21:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x8so11972862lfe.3;
        Sat, 31 Jul 2021 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8mCsKkr0voFID3/2Yo33TwUnqK22z5pYuhJVk60zJXk=;
        b=Prfpt+zKTMk7Dh8hv6kF9iFWgz1FQvVTzGlYMXEGsT4tZAVYkiHa10cbkpMdh12WBm
         kM2Jjuyr3CcGmv2JhvG1uMJAPLTlBw9C4p3/yAbJdY091+HudDW7/0IPYZW0N01yUnlV
         ow7inE8lQaEqKvzSAusKN+vkd39MpSeHL9AlC6XlLJ5+U55kpjQlMWEjfgvT44sgrLSw
         X25asqE3o7CcInj5aVCbLjs1V3tXVVqwSNI8lhzDsm5DtwkyzDwGYFFsJRQjvAa/9vea
         hVoVyvGXFKaZy7BFYp089bfjU8s5dlxmBBAz3tRr2F62DxTlGaeRDfULD/SrbbZLRlig
         IZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8mCsKkr0voFID3/2Yo33TwUnqK22z5pYuhJVk60zJXk=;
        b=jln8xp2EgmIlKRjww1xSoTV/ylcgyeDIFsqgJO7CaHI3z6VbsC7ARZ6Ve/fYGmBrQD
         K0Z27vVSTQ/uJfQnCHME1ErXqfe8sPsHMsiQXEXnObyr1A1fqp9yJh4H0JNuSN1j6HxU
         OtD3xnb4k9vF1XKwJEkitknYqlN1IAuFtx60WDY7YeQ64+/pHUYcJc6XZ37hQwePQaZP
         +tBuTjp4J1R0/q793tVuuqu6RhKyQG1hUhI87KdKrpqOiEtxEkDSuxaGEHhJc2/PEv/K
         g1RQ1Fb69SNxcsniEQRE66LSprtqXZzhvmO0FB079AD7NpVhMR1aRdS6ACI3jG2KbScz
         DcrA==
X-Gm-Message-State: AOAM530DQLDCaJXwRNrc7J060xe72lhW70Mj+whH2bad1UxTVmtilkcK
        gqfEnDBv7NakamW8XRnqgiLh7OR/bcQ=
X-Google-Smtp-Source: ABdhPJwUytzwiE1PuQMi7HcoE8cXOMe6BKq7tYUNUY2ftvFSJJ0ZFmRj0sFZQJBWFPw+LJjqS8spzg==
X-Received: by 2002:ac2:4888:: with SMTP id x8mr6322041lfc.19.1627759276701;
        Sat, 31 Jul 2021 12:21:16 -0700 (PDT)
Received: from [192.168.2.145] (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.googlemail.com with ESMTPSA id m4sm423733ljq.96.2021.07.31.12.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 12:21:16 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] spi: tegra20-slink: Don't use resource-managed
 spi_register helper
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210731191458.30535-1-digetx@gmail.com>
 <20210731191458.30535-2-digetx@gmail.com>
Message-ID: <9a8bca7d-ad48-94e8-c37d-2259ced9953f@gmail.com>
Date:   Sat, 31 Jul 2021 22:21:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210731191458.30535-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

31.07.2021 22:14, Dmitry Osipenko пишет:
> Don't use resource-managed spi_register helper to correct the driver
> removal order and fix memory leak of spi_master that is never released.

The "memory leak" isn't correct, I now see where the devm variant
releases memory. I'll make v2 with a changed commit message.

