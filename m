Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE083452FFC
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 12:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhKPLPR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 06:15:17 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42766
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234738AbhKPLO4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 06:14:56 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2E6373FFEC
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637061119;
        bh=nrGxaoqv3fyhOTJzGXUVPLJO6wTEQyr0HU27b7o02x0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=hbrn1t+18qDJd0Ge/O1xdaWLb9IKKjALuvT4agR0ZAbYAZ320fKpc/6tiuFH1WgVN
         Fjx8oVunKf1wT25WlWK75vvbxCR8F8t54rOHyJLFC2ymud2kT6LJ4G9tHYWZN0Igof
         N20C5SkcSRJj/QhHpzzUCATRrQivYg2Sqs2mGjontn5bMzeXDb9uHrbjift/BM3muS
         Rzg3x67vaYb7k8B0CMZA+PgCXdLTWFWq1IYA7jJMEsj8ChTlWdxU2rEK87fNnZxb6+
         duy+C0Ja/sW+pSzPYYMdCXfT4EXFgzocfBU9lHmLzGkAUHGWGZCfmMAgAPDvuKuz7t
         CjjyGh5tvMvTA==
Received: by mail-lf1-f71.google.com with SMTP id z1-20020a056512308100b003ff78e6402bso8020236lfd.4
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 03:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrGxaoqv3fyhOTJzGXUVPLJO6wTEQyr0HU27b7o02x0=;
        b=eXimC5YCVIF7uRIb7mUovcD7CHXFlU1Zfl4s5eabjpHuDie3N6eM0v70MOef3uOxfm
         pSgZyvEEG6lJlp1JBkd0d565l/U2yPpk7i8VPpatysZSWscOK3qrExETg38oxIKNjgVQ
         7W7dCGj6KM/6SagMhSxMNgPYhAVdksCrhlt/k5buxrI6Hex/GleBgeW/Z20ZVuJv0Vjo
         xZbcrGBqfBk8yr+zO5tf0ErQVpAI79J8QLYAmSkmFkdM3Uwc1vAxJKM3anuV1LoMPKvc
         w0bq9cPiQv1tAWq0NvQwr9rcBJPKUm4+Wpf2U81h0K9oKsbWjwOkmM63zn8OAS5vaty3
         Qj9Q==
X-Gm-Message-State: AOAM531z2XudCe56P74jrH7sIpPBnOpGLKOo61oB4cbo/EHn5FK3BfNx
        WxqgL2OwUtzV2SNjsflHR6jDnfCGsNy+PtLzbCiuSBZrXeTGh9XPbyk1GmafSczIIzcBQHU90Vv
        MXLanx2CmxDcvSl4ZWuzP0KrhqHNOshciAMK0TA==
X-Received: by 2002:ac2:55a5:: with SMTP id y5mr5719668lfg.468.1637061118565;
        Tue, 16 Nov 2021 03:11:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFB8CGB99pv7Z7UsgUdq1tSHOm4adL/MVMH5OYqBZECJqMcRYQf5zZBqfhkDpckCfM0VsW7A==
X-Received: by 2002:ac2:55a5:: with SMTP id y5mr5719653lfg.468.1637061118424;
        Tue, 16 Nov 2021 03:11:58 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id m8sm1724540lfq.27.2021.11.16.03.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:11:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Richard Weinberger <richard@nod.at>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 7/7] memory: renesas-rpc-if: Add support for RZ/G2L
Date:   Tue, 16 Nov 2021 12:11:21 +0100
Message-Id: <163706107706.69862.835899154165201477.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 25 Oct 2021 21:56:31 +0100, Lad Prabhakar wrote:
> SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
> the RPC-IF interface found on R-Car Gen3 SoC's.
> 
> This patch adds a new compatible string for the RZ/G2L family so
> that the timing values on RZ/G2L can be adjusted.
> 
> 
> [...]

Applied, thanks!

[7/7] memory: renesas-rpc-if: Add support for RZ/G2L
      commit: b04cc0d912eb80d3c438b11d96ca847c3e77e8ab

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
