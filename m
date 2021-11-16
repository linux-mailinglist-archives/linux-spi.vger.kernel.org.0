Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BFB452F1A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 11:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhKPKen (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 05:34:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41430
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234155AbhKPKek (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 05:34:40 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 329A33F1A2
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637058703;
        bh=z+K3n14wNxyJpFthL4d/JKrdOFIgfqkYidh/vwHh0o8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Se1cPDujcfh+xmtclW5H1YWTw/u8W21jJim8WQFKyovTVAWBfep4ko14C3/EW/Y7V
         kGLyuA3AHRTcgJMR7cFit2M42pS+/8DG696TvqLyAGCRETrujvI9nglhsRmxu/b0HP
         KGuFOgJGbrYBnOeGtFneMtEK00gbRoWP/afc7TPPBaX4uCod6pOJvpf8yOSxWLEozC
         76hopsUzc3Mcbiq7YD9ydV4R/82g/6Go3AEl8YIkOdjgCrzFY/nItO2rOipssX8Sc6
         HzI1BvpKQT6NjEJvap38KWmdk6savcCzfN7ah2L8pF9aidrmK6GcO7SJV1AMq9xsX8
         FNzgxpYT4Zy3Q==
Received: by mail-lf1-f71.google.com with SMTP id w2-20020a0565120b0200b004036bc9597eso7961785lfu.14
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 02:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+K3n14wNxyJpFthL4d/JKrdOFIgfqkYidh/vwHh0o8=;
        b=sK6Qr68f2nVYJB3GRRMpHn+piLP4pO0tydc6PsaP+XYSc9MiIgm8vmNe6grGWrhIJt
         4vXvuEfcS096pBva9oqY4NxyFH5wA8SohBoQUVU/sxHmKzrHTPtQGtty62IBWRJkX0J6
         9Ufwk5OvBm0rm7vrW9ORJdOsMUEZiMdSsEcWK5+WppwqEE2ay8LKN+x7IJHZFbU+8b4Z
         rxLkmsrXUD7mw2v+izRT1jVEjCE0oUsqMlrY2e+vSpqGZRtVt31IVpTDs0fVN7EYPis0
         ZnSnKBWliIKcpJvu0uXjnFpLjfZzxekO7bfpUmTbXld8dxmJu0SogPvMHJqrX8afF8iA
         INuQ==
X-Gm-Message-State: AOAM530h6TJVCjzR83AnDtbduxBk5+GeeFM5d6bVMOUUQ3fYDirzoCJ7
        +IZpQhjMzwB82krMdA6QHjkfsNJkvCvTsUn0wqOSAShh9/M815YmIdvc3m5n74qtdXbEUJ0cxSO
        PpcFKduUeezTOAI1Hitf8lZ2J/JPz72zekm3aGw==
X-Received: by 2002:a05:6512:2601:: with SMTP id bt1mr5653777lfb.147.1637058702683;
        Tue, 16 Nov 2021 02:31:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVpknv8td/Cxpbi8ipZR258BpylSboXrsot6U5M9i5s8+zkf0/9R+6Q6RjQtFYrAR4CqJBFg==
X-Received: by 2002:a05:6512:2601:: with SMTP id bt1mr5653761lfb.147.1637058702540;
        Tue, 16 Nov 2021 02:31:42 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id j5sm1114418lfe.219.2021.11.16.02.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:31:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/7] dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
Date:   Tue, 16 Nov 2021 11:31:02 +0100
Message-Id: <163705866144.26823.6564269821681639208.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025205631.21151-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211025205631.21151-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 25 Oct 2021 21:56:25 +0100, Lad Prabhakar wrote:
> SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
> the RPC-IF interface found on R-Car Gen3 SoC's.
> 
> This patch adds a new compatible string to identify the RZ/G2L family
> so that the timing values on RZ/G2L can be adjusted.
> 
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
      commit: c271aa1f73515bcb35f977f30825832d41a2f504

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
