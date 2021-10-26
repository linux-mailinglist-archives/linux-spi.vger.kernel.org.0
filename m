Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B478E43B4BF
	for <lists+linux-spi@lfdr.de>; Tue, 26 Oct 2021 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhJZOuo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Oct 2021 10:50:44 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38992
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236976AbhJZOuk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Oct 2021 10:50:40 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A2C34027D
        for <linux-spi@vger.kernel.org>; Tue, 26 Oct 2021 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635259696;
        bh=fsVkyjuPYlvrvC5KH9851YDRNpooqzcn8kiRcv7IL+0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=PXmD2gSf9j2Cdde8TY2611jxj8qiQolMJoCBdTijo01bg5+WZJ+/vmoFkMEpEhBWS
         9t6c10q2fycOSYJhAeufuzmwQcQ46OkBAMID1vNrcq/Yj4l/nH+E4fL4vx97ySfhYR
         pelNCXKAs6iFRCLi414uH8wqbAHlIUB4Yzd0mUmp0bEMCi1bzj+lJE1AGK138ls9Ke
         QVKEzjUS7pdmNxa6QnTfhiSyWVGMFyN2ZcW++FyaxErGqQQDg/BVDzgxqzyM/CQDrm
         c0h3iNIYmS730eZ1R2tBrbCR4ItoG2Kp9yPOmGwmEm0ttrWfEa2exrA0KM9chNO+VX
         z2XNv8YxkXHZw==
Received: by mail-lf1-f71.google.com with SMTP id g6-20020a0565123b8600b003ffa7685526so2571607lfv.21
        for <linux-spi@vger.kernel.org>; Tue, 26 Oct 2021 07:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fsVkyjuPYlvrvC5KH9851YDRNpooqzcn8kiRcv7IL+0=;
        b=SmTW3ZncC+E1OUZ1FvlqAzHU/qH9T494HnDXcyo6+y62ePBCW8SFx0utJnk5M73OMe
         /fIGs2xb0TVBoAajriSrybUJ6iy4tIJhTTIL0EwhfHjiiEBqhVUpFsi/vV86qAZH5aKF
         dtSbmBUc26Adzt1M5vG1RaENg/jX693ZKkzf+lcpwhqKaqdKZsd0T66I6h+ZYUrxDmCj
         M39otq4FSr9NzSGCp22+lc+9pRGjsLUwIvKz9csBZeEe6Ft3HvvJuU1ostCCT6ifHPfX
         yBZPCybXUnp59ljXRkbdK+057Mc1vg1WOaSPOnSMIa4pDyfzRqAdMiZtw2RHnbwPJCZM
         iY3A==
X-Gm-Message-State: AOAM532MTktk5sHmKcYoshAkKY6h2nujc7DYheCnMXYpfurgNmFSG7E/
        sA3LtZA1xUcSK9/sAPSt3qRXDp9iGy5T9dicqDxWviuXE6MP51HeBcbBhsm0YPybknwBT4XUqg7
        10lCnwnDexYM1oZaYTnxdxDOGzVQt2iGacVFE4Q==
X-Received: by 2002:a2e:9243:: with SMTP id v3mr27320372ljg.260.1635259695402;
        Tue, 26 Oct 2021 07:48:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2KIUw3dMiASKOb3ipaEef5iAQjyB+RBgmFcPme73HkXcK5y3WPmCpFx0YHsoHJhTU83ZWAg==
X-Received: by 2002:a2e:9243:: with SMTP id v3mr27320346ljg.260.1635259695206;
        Tue, 26 Oct 2021 07:48:15 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id r13sm483731lff.213.2021.10.26.07.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:48:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Add SPI Multi I/O Bus Controller support for
 RZ/G2L
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <02123905-675a-0fda-086e-c2401c202fce@canonical.com>
Date:   Tue, 26 Oct 2021 16:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 25/10/2021 22:56, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series adds a couple of fixes for rpc-if driver and
> adds support for RZ/G2L SoC, where the SPI Multi I/O Bus Controller
> is identical to the RPC-IF block found on R-Car Gen3 SoC's.
> 
> Cheers,
> Prabhakar
> 
> Changes for v2:
> * Rebased the patches on linux-next
> * Split patch 5 from v1
> * Included RB tags
> * Fixed review comments pointed by Wolfram
> 
> v1:
> https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> 20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 

Patches look good but you sent them too late for this cycle. I'll take
the memory controller parts after the merge window.


Best regards,
Krzysztof
