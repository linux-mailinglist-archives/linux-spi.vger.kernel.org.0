Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAF452F26
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 11:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhKPKet (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 05:34:49 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41560
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234193AbhKPKes (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 05:34:48 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 399B53F1A2
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637058710;
        bh=92zi+uaozVd3dQpRcG3KZ4gZNNYCSn9kCZHl66TmEQ4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ks2G1AW76fezCOyY+JlrvsDWz/7MBvC5Fcr62Pr6PBypV0tEXQN5y8ydzXhsTFk0E
         xYZmgG7koPd1I2Wlo1vy1XAiUuOjFXUo+Ngv+QwjU9Of5LZ+z8YgRIKMSwBmeAVg7A
         V9RRJ4kBciX6HnR8EmVrckmYb9QeuldAxum3YD1tLlXBPOf4zZV0d2AnOMI8AOB3rU
         1YqB2Yxenyn72PckXMgPJM3aW78fwtzskX4kmJ4krtniUDin3RAX8XmKTacYdSqJH7
         de0Zu12hU0PwmFJdgeuWGjB4BJMY7WTWlnKtVu03qG/4iZfkLfQ/yd4Vi8M0ax/vFa
         OZBDDFKyW+i/A==
Received: by mail-lf1-f71.google.com with SMTP id q26-20020ac2515a000000b0040adfeb8132so2162212lfd.9
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 02:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92zi+uaozVd3dQpRcG3KZ4gZNNYCSn9kCZHl66TmEQ4=;
        b=eylwLjVNn6Ntr+4Wxe6J6M7jcSmsVjEm6VdtakXp2hnezIV3CDyD4CrRL9HGQ4jHW6
         4iia3WtfjbYpgfZwna3sKK9nr70yPJtNa93RoNzxX766+L08s058pj34vlVFIXEW+S3v
         vUoSB8cuKC7UP3dT4k1EuHDIui+HIEKrfmC85HaJpcAbW8RvzJ1newLTuD3E8QMxSCX8
         0OkSMh61d8EscHthj96UHXLNRJcwb703a9Aq4gKTn08VhOZRAS/YA9lGqi4VIvduMJAD
         5zOVGU4Ff3pr56G9ZG1PlH+5c4YqaRvqX2fJYV09ZgH+vjFH6NF2ohmT+ZMO+QB+xISb
         B4DQ==
X-Gm-Message-State: AOAM533fAms+BN7OxhmK57KeFjJFoLmdMxS8jdw5zob4/MkJ4Dch8/Cm
        Fj9t92k/DEe9w2UjSjxfgbKUYAYUXBnd8CJwse10C4Bwj5/EzIFQYH642arLF6l6sCvyj1+t2+Q
        UlvZmm56iQXa1f/mXrwEzqA4Awe6ZbGUDq4KM6g==
X-Received: by 2002:a05:6512:1093:: with SMTP id j19mr5749234lfg.340.1637058706618;
        Tue, 16 Nov 2021 02:31:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFJQ83v72RjqgTGJjKyb8RGySZcPwWRf/nb5XIMU/rZuTUXd/qfX1IRjsZ+BlY4jF7IoGErg==
X-Received: by 2002:a05:6512:1093:: with SMTP id j19mr5749196lfg.340.1637058706395;
        Tue, 16 Nov 2021 02:31:46 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id j5sm1114418lfe.219.2021.11.16.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:31:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 6/7] memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
Date:   Tue, 16 Nov 2021 11:31:05 +0100
Message-Id: <163705866144.26823.8540217279898779126.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025205631.21151-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211025205631.21151-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 25 Oct 2021 21:56:30 +0100, Lad Prabhakar wrote:
> RPCIF_DIRMAP_SIZE may differ on various SoC's. Instead of using
> RPCIF_DIRMAP_SIZE macro use resource size to get dirmap size
> which is already part of struct rpcif.
> 
> 

Applied, thanks!

[6/7] memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
      commit: 5da9b59b23d8112709034a07338e03dcc65fa11f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
