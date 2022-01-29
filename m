Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BCA4A2E34
	for <lists+linux-spi@lfdr.de>; Sat, 29 Jan 2022 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiA2L32 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 29 Jan 2022 06:29:28 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60328
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbiA2L31 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 29 Jan 2022 06:29:27 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B1E123F2FF
        for <linux-spi@vger.kernel.org>; Sat, 29 Jan 2022 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643455765;
        bh=mQWIhzfALzmhNvVwAVuvuNXj69s9Y0aV8nVP8i/ovfg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=W3b4Ht/4cyHvn6oQOBk+eEI9msPrFZI9VYd+hfm+ilmrQrV6oRgRPC1Sds+/pLImu
         M6aRk/MmGFw2c7jOAUreBP10a3xp0g0pO51mRwEU1Cso3fuVei3d1Y3Y3UV+1fW+Kb
         YtgXfa2jLdPDDbrlGj9Ro3el43AeeoHUCIYMhgL9HTe/KtvKutVXPtOisdj6Ito0Ph
         ogItWaCXcCqeyztXAvI75s6sWVkGVoQfWed1woqgrodenMVTxHCExspscz/M0O1rrv
         EVPwMc8ScaRPBdtXKwwKEbFeokQSnYhddv1SVIknuav0lh4OMiMYnUll5luJHvvFZF
         lpH6swsDN91QQ==
Received: by mail-ed1-f70.google.com with SMTP id ed6-20020a056402294600b004090fd8a936so4376822edb.23
        for <linux-spi@vger.kernel.org>; Sat, 29 Jan 2022 03:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQWIhzfALzmhNvVwAVuvuNXj69s9Y0aV8nVP8i/ovfg=;
        b=eAvU/Zl1DAdEEjaprxJ5ZSEkHrbALvkl5mGtFHjj1dXNa9J8fDbdWATKjlatFs+aAT
         b11Mn5b/cIzD7BCoLgyQB5IIB3/ge9I4zsN3y2djnC05ocnPs4sDmqg9vXNuQK9qJqc9
         V8LsuKE0m/UqliZBDbVeAi9akVEUAUa2ohEryo1v49cFnbDEf5YoVD/ggikXJ2IXIx0e
         mlTtTGBhmGFyTmnnrrWIUIAhAL2SLdnTEr3e7JK/ZMCozDJZ+iznQQ0Gw5frJ1SoJqxQ
         ELYiZ/8mbsFnxUfJObDTgmBmz4pO5sQaW+sbk374j7kpQyBc5IDopGYhEbzAbrUc7uO/
         d8Cw==
X-Gm-Message-State: AOAM530ohvsxWtd2pEqMI+E/F22iXlejS8v8gMPuCJVkjeYfAZmmjo9P
        SFkX90l54XPJUTL+w/WYfGeI0uJyImSRVJI9zT9O+bEvJGRmN1ispGRX+DL7+9bT0ORl1bVrWx3
        dfq9BPHG8s6uyWFJLpv3LUkz8oRgfzvAtSSSJQw==
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr10190852ejc.588.1643455765341;
        Sat, 29 Jan 2022 03:29:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUWK6qByvVxIBS+9uu2vdLsOAJFd0ApGv7Ogy0hcRemfHrZnMyIWyq6RHHSeL54zf6jeCBQw==
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr10190835ejc.588.1643455765142;
        Sat, 29 Jan 2022 03:29:25 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id jt17sm10943147ejb.161.2022.01.29.03.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 03:29:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linus.walleij@linaro.org, Aswani Reddy <aswani.reddy@samsung.com>,
        linux-fsd@tesla.com, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        pankaj.dubey@samsung.com, devicetree@vger.kernel.org,
        andi@etezian.org, linux-samsung-soc@vger.kernel.org,
        broonie@kernel.org
Subject: Re: (subset) [PATCH v3 3/3] arm64: dts: fsd: Add SPI device nodes
Date:   Sat, 29 Jan 2022 12:29:22 +0100
Message-Id: <164345575829.11115.173136141798893555.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125031604.76009-4-alim.akhtar@samsung.com>
References: <20220125031604.76009-1-alim.akhtar@samsung.com> <CGME20220125032828epcas5p22fbacf42ebfb1b78c1f74f48d37aa381@epcas5p2.samsung.com> <20220125031604.76009-4-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 Jan 2022 08:46:04 +0530, Alim Akhtar wrote:
> From: Aswani Reddy <aswani.reddy@samsung.com>
> 
> Adds device tree node for SPI IPs
> 
> 

Applied, thanks!

[3/3] arm64: dts: fsd: Add SPI device nodes
      commit: bd1e3696a052b9b2bd3c1c72ef4bf800a3a1e286

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
