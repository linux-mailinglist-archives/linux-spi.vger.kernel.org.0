Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B68065689F
	for <lists+linux-spi@lfdr.de>; Tue, 27 Dec 2022 10:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiL0I75 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Dec 2022 03:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiL0I74 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Dec 2022 03:59:56 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88864FC
        for <linux-spi@vger.kernel.org>; Tue, 27 Dec 2022 00:59:54 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id s25so13175614lji.2
        for <linux-spi@vger.kernel.org>; Tue, 27 Dec 2022 00:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvTNpgCL5uXa6TwKXCetO6h5nnP9ujMVdxuzta2chr4=;
        b=KARqcbnv0d6fxdcr5jNfYWAC36DDVi1WYdyJRJhwoKuLXa8j+x5OJB6cnLNcEa5vS+
         NJgJ9CSeJNRcxrxM2X9tW6bgzZLnOlL3odGL68zWwshGBYgm9QGERpw1iqh6bbDHMS80
         35FbatNiYnWdH3ZGh1qdoiFMpUZqapBSP1OJFzliNt1JSDhmb/2CMZDpSqOojH6UfK4T
         sle/FniuFRZZDKgRzuZotSrMw2V0zNS4qFbizBNpfKe1gLamb4C+QcdNefxEW7OWo83G
         6vJgbVJbMY6Oie/BohXvlXkFaoGLUZqGpCTkbeyV6uFxsD/hUNM75T1R3xz7NxoKBB1o
         jcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvTNpgCL5uXa6TwKXCetO6h5nnP9ujMVdxuzta2chr4=;
        b=680lGlXhmNHsTQUZD3WKoRK1PSpvgKnpMfpWghFQlfTD9j7kotxU+YowOgo7UmbTmz
         diMXgBGi6S+XWKCvMG88LDkSI2sJ6WsmEqQ/IpL3fYxE7x4mOFMc7bnUxwSMIEog3QZ9
         0Ilp8UEOc3uqgvxLNBx9ZExCpWs/KtE7AZsjsEP/7ih3HFN3Y2c7Ktrx/a5YU/z4ofB2
         dUF15B4ksYrWMVm9uqL72tqQlfm8iucO+sA2+YrCsVu2rnmj86bJaWLGUVUfOk8zqlJT
         j1gQR1N5o8Xn20GJggJ1MBqB/lAaYIEdTi2w3vqoOtqzltoalhtRbYPw/wD39kIfS1Rs
         KXQw==
X-Gm-Message-State: AFqh2krD0e8aIpsv2/ouoz/0BTiyMOphDWE62PdeDQ+EqaRtBBKYQNdw
        hxY5C6UeahtFMfV3/S5TpQUHZA==
X-Google-Smtp-Source: AMrXdXtV6v0U0PGx9l5HdKGRGgf72ErVoKNwc1GIhdk/VuOQnmmaZrNC1qRvoFgs23cE5C+Svpl2OQ==
X-Received: by 2002:a2e:2e17:0:b0:27f:ba77:fec3 with SMTP id u23-20020a2e2e17000000b0027fba77fec3mr2284970lju.10.1672131593109;
        Tue, 27 Dec 2022 00:59:53 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c031200b0026bf0d71b1esm1534837ljp.93.2022.12.27.00.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 00:59:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 0/6] memory: renesas-rpc-if: Rebind fixes and misc cleanups
Date:   Tue, 27 Dec 2022 09:59:44 +0100
Message-Id: <167213158107.15520.15699943919910529014.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1669213027.git.geert+renesas@glider.be>
References: <cover.1669213027.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 23 Nov 2022 15:41:16 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> The Renesas RPC-IF provides either HyperFlash or SPI host access.
> To handle this, three drivers are used:
>   1. The RPC-IF core diver,
>   2. An HyperFlash child driver,
>   3. An SPI child driver.
> 
> [...]

Applied, thanks!

[1/6] memory: renesas-rpc-if: Split-off private data from struct rpcif
      https://git.kernel.org/krzk/linux-mem-ctrl/c/f8fa9cb3fb16e06514fec0bac58996015dedc453
[2/6] memory: renesas-rpc-if: Move resource acquisition to .probe()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/9bdb35b864fb92c037b3e441ae8f3a7efc6bc679
[3/6] memory: renesas-rpc-if: Always use dev in rpcif_probe()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/ef1eabee9d97e263e61aa32c961f8c94cb3e6e5c
[4/6] memory: renesas-rpc-if: Improve Runtime PM handling
      https://git.kernel.org/krzk/linux-mem-ctrl/c/f63d7c4d409461aee459c21797a3d7bb6039affd
[5/6] memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/eb66a9971ffddd0dc0640f282768660875445ef1
[6/6] memory: renesas-rpc-if: Remove Runtime PM wrappers
      https://git.kernel.org/krzk/linux-mem-ctrl/c/691f04fc5251f79c71975acf1f69ace87496738b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
